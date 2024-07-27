//
//  EnumCaseDeclSyntax+Extension.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax

public extension EnumCaseDeclSyntax {
    var hasAssociatedValues: Bool {
        self.elements.first?.parameterClause != nil
    }
    
    var name: String {
        guard let caseName = self.elements.first?.name.text
        else {
            fatalError("Compiler Bug: Case name not found")
        }
        
        return caseName
    }
    
    var parameters: [(TokenSyntax?, TypeSyntax)] {
        self.elements.first?.parameterClause?.parameters.map {
            ($0.firstName, $0.type)
        } ?? []
    }
}
