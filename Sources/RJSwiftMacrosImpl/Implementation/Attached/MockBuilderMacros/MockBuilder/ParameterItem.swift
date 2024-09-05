//
//  ParameterItem.swift
//  
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax

// MARK: Parameter Item
struct ParameterItem {
    let identifierName: String?
    let identifierType: TypeSyntax
    var initialValue: ExprSyntax?
    
    init(
        identifierName: String?,
        identifierType: TypeSyntax,
        initialValue: ExprSyntax?
    ) {
        self.identifierName = identifierName
        self.identifierType = identifierType
        self.initialValue = initialValue
    }
    
    var hasName: Bool {
        identifierName != nil
    }
}
