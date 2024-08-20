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
        numberOfItems: Int?,
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
        
        var mockArrayData: ArrayElementListSyntax? {
            if let numberOfItems {
                return generateMockArrayCases(
                    cases: cases,
                    numberOfItems: numberOfItems
                )
            } else {
                return nil
            }
        }
        
        let singleMockEnumCase = generateSingleMockEnumCase(cases: cases)

        let mockCode = generateMockCodeSyntax(
            identifierToken: identifierToken,
            mockArrayData: mockArrayData,
            singleMockItemData: singleMockEnumCase
        )
        
        return [DeclSyntax(mockCode)]
    }
    
    private static func generateSingleMockEnumCase(
        cases: [EnumCaseDeclSyntax]
    ) -> ExprSyntax {
        guard let caseItem = cases.randomElement() else {
            fatalError("Cases array must not be empty")
        }
        
        let parameters = caseItem.parameters.map {
            ParameterItem(
                identifierName: $0.0?.text,
                identifierType: $0.1,
                initialValue: nil
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
                        parameters: parameters
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
    
    private static func generateMockArrayCases(
        cases: [EnumCaseDeclSyntax],
        numberOfItems: Int
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
                    identifierType: $0.1,
                    initialValue: nil
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
                            parameters: parameters
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
    
    private static func replicateCases(
        cases: [EnumCaseDeclSyntax],
        numberOfItems: Int
    ) -> [EnumCaseDeclSyntax] {
        var totalNumberOfCases: [EnumCaseDeclSyntax] = []
        
        for i in 0..<numberOfItems {
            totalNumberOfCases.append(
                cases[i % cases.count]
            )
        }
        
        return totalNumberOfCases
    }
}
