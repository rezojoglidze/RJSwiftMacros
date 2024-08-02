//
//  MockBuilderMacro+ExprSyntax.swift
//  
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

// MARK: - Mock Builder Macro Expr Syntax
extension MockBuilderMacro {
    // MARK: Methods
    static func getExpressionSyntax(
        from type: TypeSyntax,
        generatorType: DataGeneratorType
    ) -> ExprSyntax {
        if type.isArray {
            getArrayExprSyntax(
                arrayType: type.as(ArrayTypeSyntax.self)!,
                generatorType: generatorType
            )
        } else if type.isDictionary {
            getDictionaryExprSyntax(
                dictionaryType: type.as(DictionaryTypeSyntax.self)!,
                generatorType: generatorType
            )
        } else if type.isOptional {
            getOptionalExprSyntax(
                optionalType: type.as(OptionalTypeSyntax.self)!,
                generatorType: generatorType
            )
        } else {
            getSimpleExprSyntax(
                simpleType: type.as(IdentifierTypeSyntax.self)!,
                generatorType: generatorType
            )
        }
    }
    
    static func getArrayExprSyntax(
        arrayType: ArrayTypeSyntax,
        generatorType: DataGeneratorType
    ) -> ExprSyntax {
        
        if let simpleType = arrayType.element.as(IdentifierTypeSyntax.self),
           SupportedType(rawValue: simpleType.name.text) == nil {
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
                            generatorType: generatorType
                        )
                    )
                },
                rightSquare: .rightSquareToken()
            )
        )
    }
    
    static func getDictionaryExprSyntax(
        dictionaryType: DictionaryTypeSyntax,
        generatorType: DataGeneratorType
    ) -> ExprSyntax {
        ExprSyntax(
            DictionaryExprSyntax {
                DictionaryElementListSyntax {
                    DictionaryElementSyntax(
                        key: getExpressionSyntax(
                            from: dictionaryType.key,
                            generatorType: generatorType
                        ),
                        value: getExpressionSyntax(
                            from: dictionaryType.value,
                            generatorType: generatorType
                        )
                    )
                }
            }
        )
    }
    
    static func getOptionalExprSyntax(
        optionalType: OptionalTypeSyntax,
        generatorType: DataGeneratorType
    ) -> ExprSyntax {
        return getExpressionSyntax(
            from: optionalType.wrappedType,
            generatorType: generatorType
        )
    }
    
    static func getSimpleExprSyntax(
        simpleType: IdentifierTypeSyntax,
        generatorType: DataGeneratorType
    ) -> ExprSyntax {
        
        if let supportedType = SupportedType(rawValue: simpleType.name.text) {
            return supportedType.exprSyntax(
                dataGeneratorType: generatorType
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
