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
        initialValue: ExprSyntax?
    ) -> ExprSyntax? {
        if type.isArray,
           let type = type.as(ArrayTypeSyntax.self) {
            return getArrayExprSyntax(
                arrayType: type,
                initialValue: initialValue
            )
        } else if type.isDictionary,
                  let type = type.as(DictionaryTypeSyntax.self) {
            return getDictionaryExprSyntax(
                dictionaryType: type,
                initialValue: initialValue
            )
        } else if type.as(IdentifierTypeSyntax.self) != nil ||
                    type.as(OptionalTypeSyntax.self) != nil ||
                    type.as(FunctionTypeSyntax.self) != nil {
            return getSimpleExprSyntax(
                simpleTypeSyntax: type,
                initialValue: initialValue,
                typeIsOptional: false
            )
        } else {
            return nil
        }
    }
    
    private static func getArrayExprSyntax(
        arrayType: ArrayTypeSyntax,
        initialValue: ExprSyntax?
    ) -> ExprSyntax? {
        if let simpleType = arrayType.element.as(IdentifierTypeSyntax.self),
           SupportedType(rawValue: simpleType.name.text, exprSyntax: initialValue) == nil {
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
        initialValue: ExprSyntax?
    ) -> ExprSyntax? {
        if let key = getExpressionSyntax(
            from: dictionaryType.key,
            initialValue: initialValue
        ),
           let value = getExpressionSyntax(
            from: dictionaryType.value,
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
        simpleTypeSyntax: T,
        initialValue: ExprSyntax?,
        typeIsOptional: Bool
    ) -> ExprSyntax? {
        // Investigate is in progress, trying to find better solution. TODO: Refactor it
        if initialValue.debugDescription == Constants.nilTypeOptionalDebugDescription.rawValue {
            return ExprSyntax(stringLiteral: "nil")
        } else if let simpleIdentifierType = simpleTypeSyntax.as(IdentifierTypeSyntax.self) {
            return getSimpleExprSyntaxForIdentifierType(
                simpleIdentifierType: simpleIdentifierType,
                initialValue: initialValue,
                typeIsOptional: typeIsOptional
            )
        } else if let simpleIOptionaldentifierType = simpleTypeSyntax.as(OptionalTypeSyntax.self) {
            return getSimpleExprSyntaxForOptionalType(
                simpleOptionalType: simpleIOptionaldentifierType,
                initialValue: initialValue
            )
        } else if let simleFunctionType = simpleTypeSyntax.as(FunctionTypeSyntax.self) {
            return getSimpleExprSyntaxForClosure(
                simpleType: simleFunctionType,
                initialValue: initialValue
            )
        } else {
            return nil
        }
    }
    
    // MARK: Get Simple Expr Syntax For Identifier Type Syntax
    private static func getSimpleExprSyntaxForIdentifierType(
        simpleIdentifierType: IdentifierTypeSyntax,
        initialValue: ExprSyntax?,
        typeIsOptional: Bool
    ) -> ExprSyntax? {
        if let supportedType = SupportedType(
            rawValue: simpleIdentifierType.name.text,
            exprSyntax: initialValue
        ) {
            return supportedType.exprSyntax()
        }
        
        // For example, if we pass enum case `VehicleType.car`, in this case we need string value of its.
        if let initialExprSyntax = initialValue {
            return initialExprSyntax
        } else {
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
        }
    }
    
    // MARK: Get Simple Expr Syntax For Optional Type Syntax
    private static func getSimpleExprSyntaxForOptionalType(
        simpleOptionalType: OptionalTypeSyntax,
        initialValue: ExprSyntax?
    ) -> ExprSyntax? {
        // If unwrapped value is array type return ArrayExprSyntax
        if let arrayTypeSyntax = simpleOptionalType.wrappedType.as(ArrayTypeSyntax.self) {
            return getArrayExprSyntax(
                arrayType: arrayTypeSyntax,
                initialValue: initialValue
            )
        }
        
        guard let type = simpleOptionalType.wrappedType.as(IdentifierTypeSyntax.self) else { return nil }
        
        return getSimpleExprSyntax(
            simpleTypeSyntax: type,
            initialValue: initialValue,
            typeIsOptional: true
        )
    }
    
    // MARK: Get Simple Expr Syntax For Function Type Syntax
    private static func getSimpleExprSyntaxForClosure(
        simpleType: FunctionTypeSyntax,
        initialValue: ExprSyntax?) -> ExprSyntax? {
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
