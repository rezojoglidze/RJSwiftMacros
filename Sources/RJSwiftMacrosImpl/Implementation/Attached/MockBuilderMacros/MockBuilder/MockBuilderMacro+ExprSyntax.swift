//
//  MockBuilderMacro+ExprSyntax.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
import SwiftSyntaxBuilder

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
        } else if type.isSet {
            return getSetExprSyntax(
                from: type,
                initialValue: initialValue
            )
        } else {
            return getSimpleExprSyntax(
                simpleTypeSyntax: type,
                initialValue: initialValue
            )
        }
    }
    
    // MARK: Get Array Expr Syntax
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
        
        return ExprSyntax(
            ArrayExprSyntax(
                leftSquare: .leftSquareToken(),
                elements: generateArrayElementList(arrayType: arrayType, initialValue: initialValue),
                rightSquare: .rightSquareToken()
            )
        )
    }
    
    static func generateArrayElementList(
        arrayType: ArrayTypeSyntax,
        initialValue: ExprSyntax?
    ) -> ArrayElementListSyntax {
        var arrayElementListSyntax = ArrayElementListSyntax()
       
        let arrayLength = (2..<(Int(Constants.mockObjectArrayArrayMaxCount.rawValue) ?? 2)).randomElement() ?? 2
        
        (0..<arrayLength).forEach { _ in
            if let expresion = getExpressionSyntax(
                from: TypeSyntax(arrayType.element),
                initialValue: initialValue
            ) {
                arrayElementListSyntax.append(ArrayElementSyntax(
                    expression: expresion,
                    trailingComma: .commaToken(trailingTrivia: .newline)
                ))
            }
        }
        
        return arrayElementListSyntax
    }
    
    // MARK: Get Dictionary Expr Syntax
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
    
    // MARK: Get Set Expr Syntax
    private static func getSetExprSyntax(
        from type: TypeSyntax,
        initialValue: ExprSyntax?
    ) -> ExprSyntax {
        let setExprSyntax = FunctionCallExprSyntax(
            calledExpression: ExprSyntax(stringLiteral: type.description),
            leftParen: .leftParenToken(),
            arguments: [],
            rightParen: .rightParenToken()
        )
        
        return initialValue ?? ExprSyntax(setExprSyntax)
    }
    
    // MARK: - Get Simple Expr Syntax
    private static func getSimpleExprSyntax<T: TypeSyntaxProtocol>(
        simpleTypeSyntax: T,
        initialValue: ExprSyntax?
    ) -> ExprSyntax? {
        if checkIfInitialValueIsNil(initialValue: initialValue) {
            return ExprSyntax(
                DeclReferenceExprSyntax(
                    baseName: .init(stringLiteral: "nil")
                )
            )
        } else if let simpleIdentifierType = simpleTypeSyntax.as(IdentifierTypeSyntax.self) {
            return getSimpleExprSyntaxForIdentifierType(
                simpleIdentifierType: simpleIdentifierType,
                initialValue: initialValue
            )
        } else if let simpleIOptionaldentifierType = simpleTypeSyntax.as(OptionalTypeSyntax.self) {
            return getSimpleExprSyntaxForOptionalType(
                simpleOptionalType: simpleIOptionaldentifierType,
                initialValue: initialValue
            )
        } else if let simleFunctionType = simpleTypeSyntax.as(FunctionTypeSyntax.self) {
            return getSimpleExprSyntaxForClosure(
                simpleType: simleFunctionType
            )
        } else if let tupleTypeSyntax = simpleTypeSyntax.as(TupleTypeSyntax.self) {
            return getSimpleExprSyntaxForTupleTypeSyntax(
                tupleTypeSyntax: tupleTypeSyntax,
                initialValue: initialValue
            )
        } else {
            return nil
        }
    }
    
    // MARK: Check If Initial Value Is Nil
    private static func checkIfInitialValueIsNil(
        initialValue: ExprSyntax?
    ) -> Bool {
        guard let initialValue else { return false }
        
        if initialValue
            .as(MemberAccessExprSyntax.self)?.base?
            .as(GenericSpecializationExprSyntax.self)?.expression
            .as(DeclReferenceExprSyntax.self)?.baseName.text == "Optional" &&
            
            initialValue
            .as(MemberAccessExprSyntax.self)?.period.tokenKind == .period &&
            
            initialValue
            .as(MemberAccessExprSyntax.self)?.declName.baseName.text == "none" {
            
            return true
        }
        
        return false
    }
    
    // MARK: Get Simple Expr Syntax For Tuple Type Syntax
    private static func getSimpleExprSyntaxForTupleTypeSyntax(
        tupleTypeSyntax: TupleTypeSyntax,
        initialValue: ExprSyntax?
    ) -> ExprSyntax? {
        var labeledExprItems: [LabeledExprSyntax] = []
        
        getElements(
            tupleTypeSyntax: tupleTypeSyntax
        )
        
        func getElements(
            tupleTypeSyntax: TupleTypeSyntax,
            firstPartOfExprItems: [LabeledExprSyntax] = [],
            lastPartOfExprItems: [LabeledExprSyntax] = []
        ) {
            for (index, item) in tupleTypeSyntax.elements.enumerated() {
                if let type = item.type.as(TupleTypeSyntax.self) {
                    getElements(
                        tupleTypeSyntax: type,
                        firstPartOfExprItems: [LabeledExprSyntax(expression: ExprSyntax(stringLiteral: "("))],
                        lastPartOfExprItems: [LabeledExprSyntax(expression: ExprSyntax(stringLiteral: "),"))]
                    )
                } else if let expression = getSimpleExprSyntax(
                    simpleTypeSyntax: item.type,
                    initialValue: initialValue
                ) {
                    let isFirst = index == .zero
                    let isLast = index == tupleTypeSyntax.elements.count - 1
                    
                    if isFirst {
                        labeledExprItems.append(contentsOf: firstPartOfExprItems)
                    }
                    
                    labeledExprItems.append(
                        contentsOf: LabeledExprListSyntax(
                            arrayLiteral: LabeledExprSyntax(
                                expression: expression,
                                trailingComma: isLast ? nil : .commaToken()
                            )
                        )
                    )
                    
                    if isLast {
                        labeledExprItems.append(contentsOf: lastPartOfExprItems)
                    }
                }
            }
        }
        
        return ExprSyntax(
            TupleExprSyntax(
                leftParen: .leftParenToken(),
                elements: LabeledExprListSyntax(labeledExprItems),
                rightParen: .rightParenToken()
            )
        )
    }
    
    // MARK: Get Simple Expr Syntax For Identifier Type Syntax
    private static func getSimpleExprSyntaxForIdentifierType(
        simpleIdentifierType: IdentifierTypeSyntax,
        initialValue: ExprSyntax?
    ) -> ExprSyntax? {
        if let supportedType = SupportedType(
            rawValue: simpleIdentifierType.name.text,
            exprSyntax: initialValue
        ) {
            return supportedType.exprSyntax(
                with: getPropertyInitializationForSimpleExprSyntax(
                    supportedType: supportedType,
                    propertyIdentifierType: simpleIdentifierType
                )
            )
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
    
    // MARK: Get Property Initialization For Simple Expr Syntax
    private static func getPropertyInitializationForSimpleExprSyntax(
        supportedType: SupportedType,
        propertyIdentifierType: IdentifierTypeSyntax
    ) -> ExprSyntax? {
        func addArgumentsExpSyntaxsToInitialization() {
            argumentsExpSyntaxs?.forEach {
                propertyInitializationExpSyntaxString += $0.description
            }
        }
        
        let argumentsExpSyntaxs = propertyIdentifierType.genericArgumentClause?.arguments.compactMap {
            if let mockBuilderType = SupportedType(rawValue: $0.argument.as(IdentifierTypeSyntax.self)?.name.text ?? .empty) {
                
                return mockBuilderType.exprSyntax()
            } else if let tupleTypeSyntax = $0.argument.as(TupleTypeSyntax.self) {
                
                return getSimpleExprSyntaxForTupleTypeSyntax(tupleTypeSyntax: tupleTypeSyntax, initialValue: nil)
            }
            
            return nil
        }
        
        var propertyInitializationExpSyntaxString: String = propertyIdentifierType.description
        
        switch supportedType {
        case .passthroughSubject:
            propertyInitializationExpSyntaxString += "()"
            
        case .currentValueSubject:
            propertyInitializationExpSyntaxString += "("
            
            if argumentsExpSyntaxs?.isEmpty == true {
                propertyInitializationExpSyntaxString += "()" // For Void
            } else {
                addArgumentsExpSyntaxsToInitialization()
            }
            
            propertyInitializationExpSyntaxString += ")"
            
        default: return nil
        }
        
        return ExprSyntax(stringLiteral: propertyInitializationExpSyntaxString)
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
        } else {
            return getSimpleExprSyntax(
                simpleTypeSyntax:  simpleOptionalType.wrappedType,
                initialValue: initialValue
            )
        }
    }
    
    // MARK: Get Simple Expr Syntax For Function Type Syntax
    private static func getSimpleExprSyntaxForClosure(
        simpleType: FunctionTypeSyntax
    ) -> ExprSyntax? {
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
        
        return ExprSyntax(closureExpresion)
    }
}
