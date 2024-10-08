//
//  MockBuilderMacro.swift
//
//
//  Created by Rezo Joglidze on 27.07.24.
//

import SwiftSyntax
import SwiftCompilerPlugin
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

// MARK: - Mock Builder Macro
public struct MockBuilderMacro: MemberMacro {
    // MARK: Methods
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        
        let numberOfItems = getNumberOfItems(from: node)
        
        if let numberOfItems, numberOfItems <= 0 {
            MockBuilderDiagnostic.report(
                diagnostic: .argumentNotGreaterThanZero,
                node: Syntax(declaration),
                context: context
            )
            return []
        }
                
        if let enumDecl = declaration.as(EnumDeclSyntax.self) {
            return MockBuilderMacroForEnum(
                enumDecl: enumDecl,
                identifierToken: enumDecl.name,
                numberOfItems: numberOfItems,
                context: context
            )
        }
        
        if let structDecl = declaration.as(StructDeclSyntax.self) {
            return MockBuilderMacroForClassActorOrSturct(
                decl: structDecl,
                identifierToken: structDecl.name,
                numberOfItems: numberOfItems,
                context: context
            )
        }
        
        if let classDecl = declaration.as(ClassDeclSyntax.self) {
            return MockBuilderMacroForClassActorOrSturct(
                decl: classDecl,
                identifierToken: classDecl.name,
                numberOfItems: numberOfItems,
                context: context
            )
        }
        
        if let actorDecl = declaration.as(ActorDeclSyntax.self) {
            return MockBuilderMacroForClassActorOrSturct(
                decl: actorDecl,
                identifierToken: actorDecl.name,
                numberOfItems: numberOfItems,
                context: context
            )
        }
        
        return []
    }
}

// MARK: Extension
extension MockBuilderMacro {
    // MARK: Methods
    static func generateMockCodeSyntax(
        identifierToken: TokenSyntax,
        mockArrayData: ArrayElementListSyntax?,
        singleMockItemData: ExprSyntax
    ) -> IfConfigDeclSyntax {
        
        let singleMockItemCodeReturnType = IdentifierTypeSyntax(
            name: identifierToken
        )
        
        let mockArrayCodeReturnType = ArrayTypeSyntax(
            leftSquare: .leftSquareToken(),
            element: IdentifierTypeSyntax(
                name: identifierToken
            ),
            rightSquare: .rightSquareToken()
        )
                
        let singleMockItemCode = VariableDeclSyntax(
            modifiers: DeclModifierListSyntax {
                DeclModifierSyntax(
                    name: .keyword(.public)
                )
                DeclModifierSyntax(
                    name: .keyword(.static)
                )
            },
            bindingSpecifier: .keyword(.var),
            bindings: PatternBindingListSyntax {
                PatternBindingSyntax(
                    pattern: IdentifierPatternSyntax(identifier: .identifier(Constants.mockIdentifier.rawValue)),
                    typeAnnotation: TypeAnnotationSyntax(colon: .colonToken(), type: singleMockItemCodeReturnType),
                    accessorBlock: AccessorBlockSyntax(
                        leftBrace: .leftBraceToken(),
                        accessors: .getter(
                            CodeBlockItemListSyntax {
                                CodeBlockItemSyntax(
                                    item: .expr(
                                        ExprSyntax(singleMockItemData)
                                    )
                                )
                            }
                        ),
                        rightBrace: .rightBraceToken()
                    )
                )
            }
        )
        
        var mockArrayCode: VariableDeclSyntax? {
            if let mockArrayData {
                return VariableDeclSyntax(
                    leadingTrivia: .newline,
                    modifiers: DeclModifierListSyntax {
                        DeclModifierSyntax(
                            leadingTrivia: .newline,
                            name: .keyword(.public)
                        )
                        DeclModifierSyntax(
                            name: .keyword(.static)
                        )
                    },
                    bindingSpecifier: .keyword(.var),
                    bindings: PatternBindingListSyntax {
                        PatternBindingSyntax(
                            pattern: IdentifierPatternSyntax(identifier: .identifier(Constants.mockArrayIdentifier.rawValue)),
                            typeAnnotation: TypeAnnotationSyntax(colon: .colonToken(), type: mockArrayCodeReturnType),
                            accessorBlock: AccessorBlockSyntax(
                                leftBrace: .leftBraceToken(),
                                accessors: .getter(
                                    CodeBlockItemListSyntax {
                                        CodeBlockItemSyntax(
                                            item: .expr(
                                                ExprSyntax(
                                                    ArrayExprSyntax(
                                                        leftSquare: .leftSquareToken(),
                                                        elements: mockArrayData,
                                                        rightSquare: .rightSquareToken(leadingTrivia: .newline)
                                                    )
                                                )
                                            )
                                        )
                                        
                                    }
                                ),
                                rightBrace: .rightBraceToken()
                            )
                        )
                    }
                )
            } else {
                return nil
            }
        }
        
        // This will make the code available only on DEBUG mode
        return IfConfigDeclSyntax(
            clauses: IfConfigClauseListSyntax {
                IfConfigClauseSyntax(
                    poundKeyword: .poundIfToken(),
                    condition: DeclReferenceExprSyntax(
                        baseName: .identifier("DEBUG")
                    ),
                    elements: .decls(
                        MemberBlockItemListSyntax {
                            MemberBlockItemSyntax(decl: singleMockItemCode)
                            if let mockArrayCode {
                                MemberBlockItemSyntax(decl: mockArrayCode);
                            }
                        }
                    )
                )
            }
        )
    }
    
    private static func getNumberOfItems(from node: SwiftSyntax.AttributeSyntax) -> Int? {
        guard let arguments = node.arguments?.as(LabeledExprListSyntax.self),
              let argumentTuple = arguments.first(where: { $0.label?.text == Constants.numberOfItemsLabelIdentifier.rawValue }) else {
            return nil
        }
        
        if let prefixExpression = argumentTuple
            .expression
            .as(PrefixOperatorExprSyntax.self) {
            return negativeNumberOfItems(expression: prefixExpression)
        } else if let integerExpression = argumentTuple
                .expression
                .as(IntegerLiteralExprSyntax.self),
                  let numberOfItems = Int(integerExpression.literal.text) {
            return numberOfItems
        }
        
        return 0 // Will throw .argumentNotGreaterThanZero in Xcode
    }
    
    private static func negativeNumberOfItems(expression: PrefixOperatorExprSyntax) -> Int {
        let prefixOperator = expression.operator.text
        
        guard let integerExpression = expression
                .expression
                .as(IntegerLiteralExprSyntax.self),
            let numberOfItems = Int(prefixOperator + integerExpression.literal.text)
        else {
            return 0 // Will throw .argumentNotGreaterThanZero in Xcode
        }
        
        return numberOfItems
    }
    
    //Used for both Structs and Enums
    static func getParameterListForMockElement(parameters: [ParameterItem]) -> LabeledExprListSyntax {
        
        var parameterList = LabeledExprListSyntax()
        
        for parameter in parameters {
            
            if let expressionSyntax = getExpressionSyntax(
                from: parameter.identifierType,
                initialValue: parameter.initialValue
            ) {
                let isFirst = parameter.identifierName == parameters.first?.identifierName
                let isLast = parameter.identifierName == parameters.last?.identifierName
                
                let parameterElement = LabeledExprSyntax(
                    leadingTrivia: isFirst ? .newline : nil,
                    label: parameter.hasName ? .identifier(parameter.identifierName!) : nil,
                    colon: parameter.hasName ? .colonToken() : nil,
                    expression: expressionSyntax,
                    trailingComma: isLast ? nil : .commaToken(),
                    trailingTrivia: .newline
                )
                
                parameterList.append(parameterElement)
            }
        }
        
        return parameterList
    }
}
