//
//  MockBuilderDiagnostic.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros

enum MockBuilderDiagnostic: String, DiagnosticMessage {
    case notAnStructOrEnum
    case argumentNotGreaterThanZero
    case enumWithEmptyCases
    
    var severity: DiagnosticSeverity {
        switch self {
        case .notAnStructOrEnum:
            return .error
        case .argumentNotGreaterThanZero:
            return .error
        case .enumWithEmptyCases:
            return .error
        }
    }
    
    var message: String {
        switch self {
        case .notAnStructOrEnum:
            return "@MockBuilder can only be applied to Structs and Enums"
        case .argumentNotGreaterThanZero:
            return "'numberOfitems' argument must be greater than zero"
        case .enumWithEmptyCases:
            return "Enum must contain at least one case"
        }
    }
    
    var diagnosticID: MessageID {
        return MessageID(domain: "RJSwiftMacros", id: rawValue)
    }
    
    static func report(
        diagnostic: Self,
        node: Syntax,
        context: some SwiftSyntaxMacros.MacroExpansionContext
    ) {
        
        let fixIts = getFixIts(for: diagnostic, node: node)
        let diagnostic = Diagnostic(
            node: Syntax(node),
            message: diagnostic,
            fixIts: fixIts
        )
        context.diagnose(diagnostic)
    }
    
    static func getFixIts(
        for diagnostic: Self,
        node: Syntax
    ) -> [FixIt] {
        switch diagnostic {
        case .enumWithEmptyCases:
            return [
                .init(
                    message: MockBuilderFixIt.addNewEnumCase,
                    changes: [
                        .replace(
                            oldNode: Syntax(
                                fromProtocol: node.as(EnumDeclSyntax.self)?.memberBlock ?? node
                            ),
                            newNode: Syntax(
                                MemberBlockSyntax(
                                    leftBrace: .leftBraceToken(),
                                    members: MemberBlockItemListSyntax {
                                        MemberBlockItemSyntax(
                                            decl: EnumCaseDeclSyntax(
                                                leadingTrivia: .newline,
                                                caseKeyword: .keyword(.case),
                                                elements: EnumCaseElementListSyntax {
                                                    EnumCaseElementSyntax(
                                                        leadingTrivia: .space,
                                                        name: .identifier("<#your case#>")
                                                    )
                                                },
                                                trailingTrivia: .newline
                                            )
                                        )
                                    },
                                    rightBrace: .rightBraceToken()
                                )
                            )
                        )
                    ]
                )
            ]
        case .argumentNotGreaterThanZero, .notAnStructOrEnum:
            return [] // No suggestion to provide
        }
    }
    
}
