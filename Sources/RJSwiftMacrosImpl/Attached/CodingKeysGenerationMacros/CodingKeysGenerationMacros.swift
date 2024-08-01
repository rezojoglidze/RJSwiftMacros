//
//  CodingKeysGenerationMacros.swift
//
//
//  Created by Rezo Joglidze on 14.07.24.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

    /*
     enum CodingKeys: String, CodingKey {
         case name
         case surname = "second_name"
     }
     
     struct Car {
         let color: String
         var model: String
         
         var calculatedName: String {
             "Doodge"
         }
         static var allAccounts: [String] = []
         
         var friendlyName: String {
             get {
                 return ""
             }
             set {
                 self.model = newValue
             }
         }
         
         func getModel() {
             
         }
     */

// MARK: - Coding Keys Macro
public struct CodingKeysMacro: MemberMacro {
    // MARK: Methods
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let cases: [String] = try declaration.memberBlock.members.compactMap { member in
            guard let codingKeyType = getCodingKeyType(from: node),
                  let variableDecl = member.decl.as(VariableDeclSyntax.self),
                  let property = variableDecl.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else { return nil }
            
            if let element = attributesElement(withIdentifier: Constants.codingKeyPropertyIdentifier.rawValue, in: variableDecl.attributes) {
                guard let customKeyName = customKey(in: element) else {
                    let diagnostic = Diagnostic(node: Syntax(node), message: CodingKeysDiagnostic())
                    throw DiagnosticsError(diagnostics: [diagnostic])
                }
                return "case \(property) = \(customKeyName)"
            } else if needToSkipCodingKeyCase(variableDecl: variableDecl) == false {
                return nil
            } else {
                let raw = property.dropBackticks()
                let snakeCase = raw.snakeCased()
                
                switch codingKeyType {
                case .camelCase:
                    return "case \(property)"
                case .snakeCase:
                    return "case \(property) = \"\(snakeCase)\""
                }
            }
        }
        guard !cases.isEmpty else { return [] }
        
        let casesDecl: DeclSyntax = """
enum CodingKeys: String, CodingKey {
    \(raw: cases.joined(separator: "\n    "))
}
"""
        return [casesDecl]
    }
    
    static func needToSkipCodingKeyCase(variableDecl: VariableDeclSyntax) -> Bool {
        if attributesElement(withIdentifier: Constants.codingKeyIgnoredIdentifier.rawValue, in: variableDecl.attributes) != nil ||
           variableDecl.isStatic ||
           !variableDecl.isStoredProperty {
            return false
        }
        
        return true
    }
    
    static func getCodingKeyType(from node: SwiftSyntax.AttributeSyntax) -> CodingKeyType? {
        guard let argumentTuple = node.arguments?.as(LabeledExprListSyntax.self),
              let generatorArgument = argumentTuple.first(where: { $0.label?.text == Constants.codingKeyTypeIdentifier.rawValue }),
              let argumentValue = generatorArgument.expression.as(MemberAccessExprSyntax.self)?.declName.baseName,
              let generatorType = CodingKeyType(rawValue: argumentValue.text) else { return nil }
        
        return generatorType
    }
}
