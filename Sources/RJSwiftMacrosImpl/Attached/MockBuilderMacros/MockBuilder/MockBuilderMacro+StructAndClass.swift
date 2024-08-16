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
        numberOfItems: Int?,
        generatorType: DataGeneratorType,
        context: MacroExpansionContext
    ) -> [SwiftSyntax.DeclSyntax] {
        let validParameters = getValidParameterList(
            from: decl,
            generatorType: generatorType,
            context: context
        )
        
        let singleMockItemData = generateSingleMockItemData(parameters: validParameters, generatorType: generatorType)
        var mockArrayData: ArrayElementListSyntax? {
            if let numberOfItems {
                return generateMockArrayData(parameters: validParameters, numberOfItems: numberOfItems, generatorType: generatorType)
            } else {
                return nil
            }
        }
        
        let mockCode = generateMockCodeSyntax(
            identifierToken: identifierToken,
            mockArrayData: mockArrayData,
            singleMockItemData: singleMockItemData
        )
        
        return [DeclSyntax(mockCode)]
    }
    
    // MARK: Return the array of mock item each valid parameters
    private static func getValidParameterList<T: DeclSyntaxProtocol>(
        from decl: T,
        generatorType: DataGeneratorType,
        context: MacroExpansionContext
    ) -> [ParameterItem] {
        var storedPropertyMembers: [VariableDeclSyntax] = []
        var initMembers: [InitializerDeclSyntax] = []
        
        
        if let structDecl = decl as? StructDeclSyntax {
            storedPropertyMembers = decl.getStoredProperties(with: structDecl.memberBlock)
            initMembers = decl.getInitMembers(with: structDecl.memberBlock)
            
        } else if let classDecl = decl as? ClassDeclSyntax {
            storedPropertyMembers = decl.getStoredProperties(with: classDecl.memberBlock)
            initMembers = decl.getInitMembers(with: classDecl.memberBlock)
        }
        
        // filtered properties which properties has `@MochBuilderProperty` Peer Macro
        let filteredProperties = getAllPropertiesWithMochBuilderPropertyIdentifier(from: decl)
        
        if initMembers.isEmpty {
            // No custom init around. We use the memberwise initializer's properties:
            return configureProperties(storedPropertyMembers: storedPropertyMembers,
                                       with: filteredProperties).compactMap({ $0 })
        }
        
        let largestParameterList = initMembers.map {
                getParametersFromInit(initSyntax: $0, with: filteredProperties)
            }.max {
                $0.count < $1.count
            } ?? []
        
        return largestParameterList
    }
    
    // Func returns filtered properties which properties has `@MochBuilderProperty` Peer Macro
    private static func getAllPropertiesWithMochBuilderPropertyIdentifier<T: DeclSyntaxProtocol>(from decl: T) -> [MemberBlockItemSyntax] {
        return {
            guard let memberBlockItems = (decl as? StructDeclSyntax)?.memberBlock.members ?? (decl as? ClassDeclSyntax)?.memberBlock.members else {
                return []
            }
            
            return memberBlockItems.filter { member in
                guard let variableDecl = member.decl.as(VariableDeclSyntax.self),
                      let attributes = variableDecl.attributes.as(AttributeListSyntax.self) else {
                    return false
                }
                
                return attributes.contains { attribute in
                    attribute.as(AttributeSyntax.self)?
                        .attributeName.as(IdentifierTypeSyntax.self)?
                        .name.text == Constants.mockBuilderProperyIdentifier.rawValue
                }
            }
        }()
    }

    private static func configureProperties(
        storedPropertyMembers: [VariableDeclSyntax],
        with filteredPropertiesWithMockBuilderMacroIdentifier: [MemberBlockItemSyntax]
    ) -> [ParameterItem?] {
        return storedPropertyMembers.compactMap { storedProperty in
            guard let propertyName = storedProperty.variableName,
                  let propertyType = storedProperty.variableType else {
                return nil
            }
            
            for mockItem in filteredPropertiesWithMockBuilderMacroIdentifier {
                if let variableDecl = mockItem.decl.as(VariableDeclSyntax.self),
                   let mockPropertyName = variableDecl.variableName,
                   let mockPropertyType = variableDecl.variableType,
                   propertyName == mockPropertyName {
                    // Found a match, update the propertyName and propertyType
                    let mockPropertyInitialValue =  variableDecl.variableValue as? AnyObject
                    
                    return ParameterItem(
                        identifierName: mockPropertyName,
                        identifierType: mockPropertyType,
                        initialValue: mockPropertyInitialValue
                    )
                }
            }
            
            // No match found, return the original propertyName and propertyType
            return ParameterItem(
                identifierName: propertyName,
                identifierType: propertyType,
                initialValue: nil
            )

        }
    }
    
    private static func getParametersFromInit(
        initSyntax: InitializerDeclSyntax,
        with filteredPropertiesWithMockBuilderMacroIdentifier: [MemberBlockItemSyntax]
    ) -> [ParameterItem] {
        let parameters = initSyntax.signature.parameterClause.parameters
        
        return parameters.map { item in
            ParameterItem(
                identifierName: item.firstName.text,
                identifierType: item.type,
                initialValue: {
                    let memberBlockItem = filteredPropertiesWithMockBuilderMacroIdentifier.first(where: {
                        $0.decl.as(VariableDeclSyntax.self)?.variableName == item.firstName.text
                    })
                    
                    let attribute = memberBlockItem?.decl.as(VariableDeclSyntax.self)?.attributes.first(where: {
                        $0.as(AttributeSyntax.self)?
                            .attributeName.as(IdentifierTypeSyntax.self)?
                            .name.text == Constants.mockBuilderProperyIdentifier.rawValue
                    })
                    
                    let initialValue  = attribute?.as(AttributeSyntax.self)?.arguments?
                        .as(LabeledExprListSyntax.self)?.first?
                        .expression.as(StringLiteralExprSyntax.self)?
                        .segments.first?.as(StringSegmentSyntax.self)?
                        .content.text
                    
                    return initialValue as AnyObject
                }()
            )
        }
    }
    
    private static func generateSingleMockItemData(
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
    
    private static func generateMockArrayData(
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
