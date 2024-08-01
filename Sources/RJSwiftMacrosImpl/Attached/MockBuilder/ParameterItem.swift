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
    
    var hasName: Bool {
        identifierName != nil
    }
}
