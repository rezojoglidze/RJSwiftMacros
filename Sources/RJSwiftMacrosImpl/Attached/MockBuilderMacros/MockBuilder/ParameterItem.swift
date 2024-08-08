//
//  File.swift
//  
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax

// MARK: Parameter Item
struct ParameterItem {
    let identifierName: String?
    let identifierType: TypeSyntax
    var initialValue: AnyObject?
    
    init(
        identifierName: String?,
        identifierType: TypeSyntax,
        initialValue: AnyObject?
    ) {
        self.identifierName = identifierName
        self.identifierType = identifierType
        self.initialValue = initialValue
    }
    
    var hasName: Bool {
        identifierName != nil
    }
}
