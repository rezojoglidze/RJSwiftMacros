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

public struct MockBuilderMacro: MemberMacro {
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
                numberOfItems: numberOfItems,
                generatorType: generatorType,
                context: context
            )
        }
        
        if let structDecl = declaration.as(StructDeclSyntax.self) {
            return MockBuilderMacroForStruct(
                structDecl: structDecl,
                numberOfItems: numberOfItems,
                generatorType: generatorType,
                context: context
            )
        }
        
        if let classDecl = declaration.as(ClassDeclSyntax.self) {
            return []
        }
        
        MockBuilderDiagnostic.report(
            diagnostic: .notAnStructOrEnum,
            node: Syntax(declaration),
            context: context
        )
        return []
    }
}

extension MockBuilderMacro {
    
    static func generateMockCodeSyntax(
        mockData: ArrayElementListSyntax
    ) -> IfConfigDeclSyntax {
        let returnType = ArrayTypeSyntax(
            leftSquare: .leftSquareToken(),
            element: IdentifierTypeSyntax(
                name: .keyword(.Self)
            ),
            rightSquare: .rightSquareToken()
        )
        
        let mockCode = VariableDeclSyntax(
            modifiers: DeclModifierListSyntax {
                DeclModifierSyntax(name: .keyword(.static))
            },
            bindingSpecifier: .keyword(.var),
            bindings: PatternBindingListSyntax {
                PatternBindingSyntax(
                    pattern: IdentifierPatternSyntax(identifier: .identifier("mock")
                                                    ),
                    typeAnnotation: TypeAnnotationSyntax(
                        colon: .colonToken(),
                        type: returnType
                    ),
                    accessorBlock: AccessorBlockSyntax(
                        leftBrace: .leftBraceToken(),
                        accessors: .getter(
                            CodeBlockItemListSyntax {
                                CodeBlockItemSyntax(
                                    item: .expr(
                                        ExprSyntax(
                                            ArrayExprSyntax(
                                                leftSquare: .leftSquareToken(),
                                                elements: mockData,
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
                            MemberBlockItemSyntax(decl: mockCode)
                        }
                    )
                )
            }
        )
    }
    
    static func getDataGeneratorType(
        from node: SwiftSyntax.AttributeSyntax
    ) -> DataGeneratorType {
        guard let argumentTuple = node.arguments?.as(LabeledExprListSyntax.self) else {
            fatalError("Compiler bug: Argument must exist")
        }

        guard let generatorArgument = argumentTuple.first(
            where: { $0.label?.text == "dataGeneratorType" }
        ),
              let argumentValue = generatorArgument.expression.as(MemberAccessExprSyntax.self)?.declName.baseName,
              let generatorType = DataGeneratorType(rawValue: argumentValue.text) else {
            // return default generator type
            return .random
        }
        
        return generatorType
    }
    
    static func getNumberOfItems(
        from node: SwiftSyntax.AttributeSyntax
    ) throws -> Int {
        guard let argumentTuple = node.arguments?.as(LabeledExprListSyntax.self)?.first
        else {
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
    
    static func negativeNumberOfItems(
        expression: PrefixOperatorExprSyntax
    ) -> Int {
        let operatorToken = expression
            .operator
            .text
        
        guard
            let integerExpression = expression
                .expression
                .as(IntegerLiteralExprSyntax.self),
            let numberOfItems = Int(operatorToken + integerExpression.literal.text)
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
            
            let isNotLast = parameter.identifierType != parameters.last?.identifierType
            let parameterElement = LabeledExprSyntax(
                label: parameter.hasName ? .identifier(parameter.identifierName!) : nil,
                colon: parameter.hasName ? .colonToken() : nil,
                expression: expressionSyntax,
                trailingComma: isNotLast ? .commaToken() : nil
            )
            
            parameterList.append(parameterElement)
        }
        
        return parameterList
    }
}
