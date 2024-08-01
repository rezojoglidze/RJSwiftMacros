//
//  VariableDeclSyntax+Extension.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax

// MARK: - Variable Decl Syntax Extension
public extension VariableDeclSyntax {
    // MARK: Properties
    var isStoredProperty: Bool {
        // Stored properties cannot have more than 1 binding in its declaration.
        guard bindings.count == 1 else { return false }
        
        guard let accesor = bindings.first?.accessorBlock else {
            // Nothing to review. It's a valid stored property
            return true
        }
        
        switch accesor.accessors {
        case .accessors(let accesorBlockSyntax):
            // Observers are valid accesors only
            let validAccesors = Set<TokenKind>([
                .keyword(.willSet), .keyword(.didSet)
            ])
            
            let hasValidAccesors = accesorBlockSyntax.contains {
                // Other kind of accesors will make the variable a computed property
                validAccesors.contains($0.accessorSpecifier.tokenKind)
            }
            return hasValidAccesors
        case .getter:
            // A variable with only a getter is not valid for initialization.
            return false
        }
        
    }
    
    var isPublic: Bool {
        modifiers.contains {
            $0.name.tokenKind == .keyword(.public)
        }
    }
    
    var isPrivate: Bool {
        modifiers.contains {
            $0.name.tokenKind == .keyword(.private)
        }
    }
    
    var isStatic: Bool {
        modifiers.contains {
            $0.name.tokenKind == .keyword(.static)
        }
    }
    
    var typeName: String {
        self.bindings.first?.typeAnnotation?.type.as(IdentifierTypeSyntax.self)?.name.text ?? ""
    }
}
