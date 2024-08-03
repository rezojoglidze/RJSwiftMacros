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
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

// MARK: - Mock Builder Macro
public struct MockBuilderMacro: MemberMacro {
    // MARK: Methods
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        
        let numberOfItems = try getNumberOfItems(from: node)
        
        if numberOfItems <= 0 {
            MockBuilderDiagnostic.report(
                diagnostic: .argumentNotGreaterThanZero,
                node: Syntax(declaration),
                context: context
            )
            return []
        }
        
        let generatorType = getDataGeneratorType(from: node)
        
        if let enumDecl = declaration.as(EnumDeclSyntax.self) {
            return MockBuilderMacroForEnum(
                enumDecl: enumDecl,
                identifierToken: enumDecl.name,
                numberOfItems: numberOfItems,
                generatorType: generatorType,
                context: context
            )
        }
        
        if let structDecl = declaration.as(StructDeclSyntax.self) {
            return MockBuilderMacroForClassOrSturct(
                decl: structDecl,
                identifierToken: structDecl.name,
                numberOfItems: numberOfItems,
                generatorType: generatorType,
                context: context
            )
        }
        
        if let classDecl = declaration.as(ClassDeclSyntax.self) {
            return MockBuilderMacroForClassOrSturct(
                decl: classDecl,
                identifierToken: classDecl.name,
                numberOfItems: numberOfItems,
                generatorType: generatorType,
                context: context
            )
        }
        
        MockBuilderDiagnostic.report(
            diagnostic: .notAnStructOrEnum,
            node: Syntax(declaration),
            context: context
        )
        return []
    }
}

// MARK: Extension
extension MockBuilderMacro {
    // MARK: Methods
    static func generateMockCodeSyntax(
        identifierToken: TokenSyntax,
        mockArrayData: ArrayElementListSyntax,
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
        
        let mockArrayCode = VariableDeclSyntax(
            leadingTrivia: .newline,
            modifiers: DeclModifierListSyntax {
                DeclModifierSyntax(
                    leadingTrivia: .newline,
                    name: .keyword(.static)
                )
            },
            bindingSpecifier: .keyword(.var),
            bindings: PatternBindingListSyntax {
                PatternBindingSyntax(
                    pattern: IdentifierPatternSyntax(identifier: .identifier(Constants.mockArrayIdentifier.rawValue)),
                    typeAnnotation: TypeAnnotationSyntax(colon: .colonToken(),type: mockArrayCodeReturnType),
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
                            MemberBlockItemSyntax(decl: mockArrayCode);
                        }
                    )
                )
            }
        )
    }
    
    private static func getDataGeneratorType(from node: SwiftSyntax.AttributeSyntax) -> DataGeneratorType {
        guard let argumentTuple = node.arguments?.as(LabeledExprListSyntax.self) else {
            fatalError("Compiler bug: Argument must exist")
        }

        guard let generatorArgument = argumentTuple.first(where: { $0.label?.text == Constants.dataGeneratorTypeLabelIdentifier.rawValue }),
              let argumentValue = generatorArgument.expression.as(MemberAccessExprSyntax.self)?.declName.baseName,
              let generatorType = DataGeneratorType(rawValue: argumentValue.text) else {
            // return random generator type
            return .random
        }
        
        return generatorType
    }
    
    private static func getNumberOfItems(from node: SwiftSyntax.AttributeSyntax) throws -> Int {
        guard let arguments = node.arguments?.as(LabeledExprListSyntax.self),
              let argumentTuple = arguments.first(where: { $0.label?.text == Constants.numberOfItemsLabelIdentifier.rawValue }) else {
            fatalError("Compiler bug: Argument must exist")
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
    static func getParameterListForMockElement(
        parameters: [ParameterItem],
        generatorType: DataGeneratorType
    ) -> LabeledExprListSyntax {
        
        var parameterList = LabeledExprListSyntax()
        
        for parameter in parameters {
            
            let expressionSyntax = getExpressionSyntax(
                from: parameter.identifierType,
                generatorType: generatorType
            )
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
        
        return parameterList
    }
}
