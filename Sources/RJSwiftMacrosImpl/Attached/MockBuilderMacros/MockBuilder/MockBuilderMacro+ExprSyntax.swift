//
//  MockBuilderMacro+ExprSyntax.swift
//  
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

fileprivate typealias SupportedType = MockBuilderSupportedType

// MARK: - Mock Builder Macro Expr Syntax
extension MockBuilderMacro {
    // MARK: Methods
    static func getExpressionSyntax(
        from type: TypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?
    ) -> ExprSyntax? {
        if type.isArray,
           let type = type.as(ArrayTypeSyntax.self) {
            return getArrayExprSyntax(
                arrayType: type,
                generatorType: generatorType,
                initialValue: initialValue
            )
        } else if type.isDictionary,
                  let type = type.as(DictionaryTypeSyntax.self) {
            return getDictionaryExprSyntax(
                dictionaryType: type,
                generatorType: generatorType,
                initialValue: initialValue
            )
        } else if type.as(IdentifierTypeSyntax.self) != nil ||
                  type.as(OptionalTypeSyntax.self) != nil ||
                  type.as(FunctionTypeSyntax.self) != nil {
            return getSimpleExprSyntax(
                simpleType: type,
                generatorType: generatorType,
                initialValue: initialValue, 
                typeIsOptional: false
            )
        } else {
            return nil
        }
    }
    
    private static func getArrayExprSyntax(
        arrayType: ArrayTypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?
    ) -> ExprSyntax? {
        if let simpleType = arrayType.element.as(IdentifierTypeSyntax.self),
           SupportedType(rawValue: simpleType.name.text, initialValue: initialValue) == nil {
            // Custom array type that attaches MockBuilder in its declaration:
            return ExprSyntax(
                MemberAccessExprSyntax(
                    base: DeclReferenceExprSyntax(
                        baseName: simpleType.name
                    ),
                    period: .periodToken(),
                    name: .identifier(Constants.mockArrayIdentifier.rawValue)
                )
            )
        }
        
        if let expresion = getExpressionSyntax(
            from: TypeSyntax(arrayType.element),
            generatorType: generatorType,
            initialValue: initialValue
        ) {
            return ExprSyntax(
                ArrayExprSyntax(
                    leftSquare: .leftSquareToken(),
                    elements: ArrayElementListSyntax {
                        ArrayElementSyntax(
                            expression: expresion
                        )
                    },
                    rightSquare: .rightSquareToken()
                )
            )
        }
        
        return nil
    }
    
    private static func getDictionaryExprSyntax(
        dictionaryType: DictionaryTypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?
    ) -> ExprSyntax? {
        if let key = getExpressionSyntax(
            from: dictionaryType.key,
            generatorType: generatorType,
            initialValue: initialValue
        ),
           let value = getExpressionSyntax(
            from: dictionaryType.value,
            generatorType: generatorType,
            initialValue: initialValue
           ) {
            
            return ExprSyntax(
                DictionaryExprSyntax {
                    DictionaryElementListSyntax {
                        DictionaryElementSyntax(
                            key: key,
                            value: value
                        )
                    }
                }
            )
        }
        
        return nil
    }
    
    // MARK: Simple Expr Syntax Methods
    private static func getSimpleExprSyntax<T: TypeSyntaxProtocol>(
        simpleType: T,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?,
        typeIsOptional: Bool
    ) -> ExprSyntax? {
        if let simpleIdentifierType = simpleType.as(IdentifierTypeSyntax.self) {
            if let supportedType = SupportedType(
                rawValue: simpleIdentifierType.name.text,
                initialValue: initialValue
            ) {
                return supportedType.exprSyntax(
                    elementType: supportedType,
                    generatorType: generatorType,
                    typeIsOptional: typeIsOptional
                )
            }
            
            // Custom type that attaches MockBuilder in its declaration:
            return ExprSyntax(
                MemberAccessExprSyntax(
                    base: DeclReferenceExprSyntax(
                        baseName: simpleIdentifierType.name
                    ),
                    period: .periodToken(),
                    name: .identifier(Constants.mockIdentifier.rawValue)
                )
            )
        } else if let simpleIOptionaldentifierType = simpleType.as(OptionalTypeSyntax.self) {
            return getSimpleExprSyntaxForOptionalType(
                simpleOptionalType: simpleIOptionaldentifierType,
                generatorType: generatorType,
                initialValue: initialValue
            )
        } else if let simleFunctionType = simpleType.as(FunctionTypeSyntax.self) {
            return getSimpleExprSyntaxForClosure(
                simpleType: simleFunctionType,
                generatorType: generatorType,
                initialValue: initialValue
            )
        } else {
            return nil
        }
    }
    
    // MARK: Get Simple Expr Syntax For Optional Type
    private static func getSimpleExprSyntaxForOptionalType(
        simpleOptionalType: OptionalTypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?
    ) -> ExprSyntax? {
        // If unwrapped value is array type return ArrayExprSyntax
        if let arrayTypeSyntax = simpleOptionalType.wrappedType.as(ArrayTypeSyntax.self) {
           return getArrayExprSyntax(
                arrayType: arrayTypeSyntax,
                generatorType: generatorType,
                initialValue: initialValue
           )
        }
        
        guard let type = simpleOptionalType.wrappedType.as(IdentifierTypeSyntax.self) else { return nil }
        
        return getSimpleExprSyntax(
            simpleType: type,
            generatorType: generatorType,
            initialValue: initialValue,
            typeIsOptional: true
        )
    }
    
    // MARK: Get Simple Expr Syntax For Closure
    private static func getSimpleExprSyntaxForClosure(
        simpleType: FunctionTypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?) -> ExprSyntax? {
            let closerParameters = simpleType.parameters.map { _ in "_" }.joined(separator: ", ")
            var closureString: String {
                if closerParameters.isEmpty {
                    return " {}"
                } else {
                    return " { \(closerParameters) in }"
                }
            }
            
            let closureExpresion = ClosureExprSyntax(
                leadingTrivia: .init(stringLiteral: closureString),
                leftBrace: .endOfFileToken(),
                statements: CodeBlockItemListSyntax(),
                rightBrace: .endOfFileToken()
            )
            
            return ExprSyntax( closureExpresion)
        }
}
