//
//  MockBuilderMacro+ExprSyntax.swift
//  
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
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
    ) -> ExprSyntax {
        if type.isArray {
            getArrayExprSyntax(
                arrayType: type.as(ArrayTypeSyntax.self)!,
                generatorType: generatorType,
                initialValue: initialValue
            )
        } else if type.isDictionary {
            getDictionaryExprSyntax(
                dictionaryType: type.as(DictionaryTypeSyntax.self)!,
                generatorType: generatorType,
                initialValue: initialValue
            )
        } else if type.isOptional {
            getOptionalExprSyntax(
                optionalType: type.as(OptionalTypeSyntax.self)!,
                generatorType: generatorType,
                initialValue: initialValue
            )
        } else {
            getSimpleExprSyntax(
                simpleType: type.as(IdentifierTypeSyntax.self)!,
                generatorType: generatorType,
                initialValue: initialValue
            )
        }
    }
    
    private static func getArrayExprSyntax(
        arrayType: ArrayTypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?
    ) -> ExprSyntax {
        
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
        
        return ExprSyntax(
            ArrayExprSyntax(
                leftSquare: .leftSquareToken(),
                elements: ArrayElementListSyntax {
                    ArrayElementSyntax(
                        expression: getExpressionSyntax(
                            from: TypeSyntax(arrayType.element),
                            generatorType: generatorType,
                            initialValue: initialValue
                        )
                    )
                },
                rightSquare: .rightSquareToken()
            )
        )
    }
    
    private static func getDictionaryExprSyntax(
        dictionaryType: DictionaryTypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?
    ) -> ExprSyntax {
        ExprSyntax(
            DictionaryExprSyntax {
                DictionaryElementListSyntax {
                    DictionaryElementSyntax(
                        key: getExpressionSyntax(
                            from: dictionaryType.key,
                            generatorType: generatorType,
                            initialValue: initialValue
                        ),
                        value: getExpressionSyntax(
                            from: dictionaryType.value,
                            generatorType: generatorType,
                            initialValue: initialValue
                        )
                    )
                }
            }
        )
    }
    
    private static func getOptionalExprSyntax(
        optionalType: OptionalTypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?
    ) -> ExprSyntax {
        return getExpressionSyntax(
            from: optionalType.wrappedType,
            generatorType: generatorType,
            initialValue: initialValue
        )
    }
    
    private static func getSimpleExprSyntax(
        simpleType: IdentifierTypeSyntax,
        generatorType: DataGeneratorType,
        initialValue: AnyObject?
    ) -> ExprSyntax {
        
        if let supportedType = SupportedType(
            rawValue: simpleType.name.text,
            initialValue: initialValue
        ) {
            return supportedType.exprSyntax(
                elementType: supportedType,
                generatorType: generatorType
            )
        }
        
        // Custom type that attaches MockBuilder in its declaration:
        return ExprSyntax(
            MemberAccessExprSyntax(
                base: DeclReferenceExprSyntax(
                    baseName: simpleType.name
                ),
                period: .periodToken(),
                name: .identifier(Constants.mockIdentifier.rawValue)
            )
        )
    }
}
