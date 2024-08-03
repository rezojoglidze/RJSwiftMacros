//
//  MockBuilderMacro+Enum.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
import SwiftSyntaxMacros
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

// MARK: - Mock Builder Macro Enum
extension MockBuilderMacro {
    // MARK: Methods
    static func MockBuilderMacroForEnum(
        enumDecl: EnumDeclSyntax,
        identifierToken: TokenSyntax, //enum name
        numberOfItems: Int,
        generatorType: DataGeneratorType,
        context: some SwiftSyntaxMacros.MacroExpansionContext
    ) -> [SwiftSyntax.DeclSyntax] {
        
        let cases = enumDecl.memberBlock.members.compactMap {
            $0.decl.as(EnumCaseDeclSyntax.self)
        }
        
        if cases.isEmpty {
            MockBuilderDiagnostic.report(
                diagnostic: .enumWithEmptyCases,
                node: Syntax(enumDecl),
                context: context
            )
            return []
        }
        
        let mockArrayData = generateMockArrayCases(
            cases: cases,
            numberOfItems: numberOfItems,
            generatorType: generatorType
        )
        
        let singleMockEnumCase = generateSingleMockEnumCase(cases: cases, generatorType: generatorType)

        let mockCode = generateMockCodeSyntax(
            identifierToken: identifierToken,
            mockArrayData: mockArrayData,
            singleMockItemData: singleMockEnumCase
        )
        
        return [DeclSyntax(mockCode)]
    }
    
    static func generateSingleMockEnumCase(
        cases: [EnumCaseDeclSyntax],
        generatorType: DataGeneratorType
    ) -> ExprSyntax {
        guard let caseItem = cases.randomElement() else {
            fatalError("Cases array must not be empty")
        }
        
        let parameters = caseItem.parameters.map {
            ParameterItem(
                identifierName: $0.0?.text,
                identifierType: $0.1
            )
        }
        
        let caseExpression =
        if caseItem.hasAssociatedValues {
            ExprSyntax(
                FunctionCallExprSyntax(
                    calledExpression: MemberAccessExprSyntax(
                        period: .periodToken(),
                        name: .identifier(caseItem.name)
                    ),
                    leftParen: .leftParenToken(),
                    arguments: getParameterListForMockElement(
                        parameters: parameters,
                        generatorType: generatorType
                    ),
                    rightParen: .rightParenToken()
                )
            )
        } else {
            ExprSyntax(
                MemberAccessExprSyntax(
                    period: .periodToken(),
                    name: .identifier(caseItem.name)
                )
            )
        }
        
        return caseExpression
    }
    
    static func generateMockArrayCases(
        cases: [EnumCaseDeclSyntax],
        numberOfItems: Int,
        generatorType: DataGeneratorType
    ) -> ArrayElementListSyntax {
        var arrayElementListSyntax = ArrayElementListSyntax()
        
        let totalNumberOfCases = replicateCases(
            cases: cases,
            numberOfItems: numberOfItems
        )
        
        for caseItem in totalNumberOfCases {
            let parameters = caseItem.parameters.map {
                ParameterItem(
                    identifierName: $0.0?.text,
                    identifierType: $0.1
                )
            }
            
            let caseExpression =
            if caseItem.hasAssociatedValues {
                ExprSyntax(
                    FunctionCallExprSyntax(
                        calledExpression: MemberAccessExprSyntax(
                            period: .periodToken(),
                            name: .identifier(caseItem.name)
                        ),
                        leftParen: .leftParenToken(),
                        arguments: getParameterListForMockElement(
                            parameters: parameters,
                            generatorType: generatorType
                        ),
                        rightParen: .rightParenToken()
                    )
                )
            } else {
                ExprSyntax(
                    MemberAccessExprSyntax(
                        period: .periodToken(),
                        name: .identifier(caseItem.name)
                    )
                )
            }
            
            arrayElementListSyntax.append(
                ArrayElementSyntax(
                    leadingTrivia: .newline,
                    expression: caseExpression,
                    trailingComma: .commaToken()
                )
            )
        }
        
        return arrayElementListSyntax
    }
    
    static func replicateCases(
        cases: [EnumCaseDeclSyntax],
        numberOfItems: Int
    ) -> [EnumCaseDeclSyntax] {
        var totalNumberOfCases: [EnumCaseDeclSyntax] = []
        
        /*
         we will extend the cases according to the number of items.
         for example, if cases are [case1, case2, case3]
         and numberOfItems = 2, the result should be [case1, case2].
         
         If cases are [case1, case2] and numberOfItems = 7, the result
         should be [case1, case2, case1, case2, case1, case2, case1]
         */
        for i in 0..<numberOfItems {
            totalNumberOfCases.append(
                cases[i % cases.count]
            )
        }
        
        return totalNumberOfCases
    }
}
