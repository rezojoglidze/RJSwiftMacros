//
//  MockBuilderMacro+StructAndClass.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
import SwiftSyntaxMacros
import RJSwiftMacrosImplDependencies
import RJSwiftCommon

// MARK: - Mock Builder Macro Struct And Class
extension MockBuilderMacro {
    //MARK: Methods
    static func MockBuilderMacroForClassOrSturct<T: DeclSyntaxProtocol>(
        decl: T,
        identifierToken: TokenSyntax, //Class or Struct name
        numberOfItems: Int,
        generatorType: DataGeneratorType,
        context: MacroExpansionContext
    ) -> [SwiftSyntax.DeclSyntax] {
        let validParameters = getValidParameterList(
            from: decl,
            generatorType: generatorType,
            context: context
        )
        
        let singleMockItemData = generateSingleMockItemData(parameters: validParameters, generatorType: generatorType)
        let mockArrayData = generateMockArrayData(parameters: validParameters, numberOfItems: numberOfItems, generatorType: generatorType)
        
        let mockCode = generateMockCodeSyntax(
            identifierToken: identifierToken,
            mockArrayData: mockArrayData,
            singleMockItemData: singleMockItemData
        )
        
        return [DeclSyntax(mockCode)]
    }
    
    // MARK: Return the array of mock item each valid parameters
    static func getValidParameterList<T: DeclSyntaxProtocol>(
        from decl: T,
        generatorType: DataGeneratorType,
        context: MacroExpansionContext
    ) -> [ParameterItem] {
        var storedPropertyMembers: [VariableDeclSyntax] = []
        
        if let structDecl = decl as? StructDeclSyntax {
            storedPropertyMembers = decl.getStoredProperties(with: structDecl.memberBlock)
            
        } else if let classDecl = decl as? ClassDeclSyntax {
            storedPropertyMembers = decl.getStoredProperties(with: classDecl.memberBlock)
        }
        
        // return all memberwise initializer's properties
        return storedPropertyMembers.compactMap {
            if let propertyName = $0.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text,
               let propertyType = $0.bindings.first?.typeAnnotation?.type {
                
                return (propertyName, propertyType)
            }
            
            return nil
        }.map {
            ParameterItem(
                identifierName: $0.0,
                identifierType: $0.1
            )
        }
    }
    
    static func generateSingleMockItemData(
        parameters: [ParameterItem],
        generatorType: DataGeneratorType
    ) -> ExprSyntax {
        let parameterList = getParameterListForMockElement(
            parameters: parameters,
            generatorType: generatorType
        )
        
        let singleItem = FunctionCallExprSyntax(
            calledExpression: MemberAccessExprSyntax(
                period: .periodToken(),
                name: .keyword(.`init`)
            ),
            leftParen: .leftParenToken(),
            arguments: parameterList,
            rightParen: .rightParenToken()
        )
        
        return ExprSyntax(singleItem)
    }
    
    static func generateMockArrayData(
        parameters: [ParameterItem],
        numberOfItems: Int,
        generatorType: DataGeneratorType
    ) -> ArrayElementListSyntax {
        let parameterList = getParameterListForMockElement(
            parameters: parameters,
            generatorType: generatorType
        )
        
        var arrayElementListSyntax = ArrayElementListSyntax()
        
        for _ in 1...numberOfItems {
            arrayElementListSyntax
                .append(
                    ArrayElementSyntax(
                        leadingTrivia: .newline,
                        expression: FunctionCallExprSyntax(
                            calledExpression: MemberAccessExprSyntax(
                                period: .periodToken(),
                                name: .keyword(.`init`)
                            ),
                            leftParen: .leftParenToken(),
                            arguments: parameterList,
                            rightParen: .rightParenToken()
                        ),
                        trailingComma: .commaToken()
                    )
                )
        }
        
        return arrayElementListSyntax
    }
}
