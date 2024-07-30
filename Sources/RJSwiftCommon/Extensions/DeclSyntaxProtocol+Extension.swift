//
//  DeclSyntaxProtocol+Extension.swift
//  
//
//  Created by Rezo Joglidze on 31.07.24.
//

import SwiftSyntax

public extension DeclSyntaxProtocol {    
    func getStoredProperties(with memberBlock: MemberBlockSyntax) -> [VariableDeclSyntax] {
        memberBlock.members
            .compactMap { $0.decl.as(VariableDeclSyntax.self) }
            .filter { $0.isStoredProperty }
    }
    
    func getInitMembers(with memberBlock: MemberBlockSyntax) -> [InitializerDeclSyntax] {
        memberBlock.members
            .compactMap { $0.decl.as(InitializerDeclSyntax.self) }
    }
}
