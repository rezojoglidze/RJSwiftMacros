//
//  TypeSyntax+Extension.swift
//  
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax

public extension TypeSyntax {
    var isArray: Bool {
        self.as(ArrayTypeSyntax.self) != nil
    }
    
    var isSimpleType: Bool {
        self.as(IdentifierTypeSyntax.self) != nil
    }
    
    var isDictionary: Bool {
        self.as(DictionaryTypeSyntax.self) != nil
    }
    
    var isClass: Bool {
        self.as(ClassRestrictionTypeSyntax.self) != nil
    }
    
    var isOptional: Bool {
        self.as(OptionalTypeSyntax.self) != nil
    }
}
