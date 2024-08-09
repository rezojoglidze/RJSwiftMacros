//
//  MockBuilderDiagnostic.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros

// MARK: - Mock Builder Diagnostic
public enum MockBuilderDiagnostic: DiagnosticMessage {
    case argumentNotGreaterThanZero
    case enumWithEmptyCases
    case mockBuilderPropertyNotSupported(String)
    
    var rawValue: String {
        switch self {
        case .argumentNotGreaterThanZero: "argumentNotGreaterThanZero"
        case .enumWithEmptyCases: "enumWithEmptyCases"
        case .mockBuilderPropertyNotSupported: "mockBuilderPropertyNotSupported"
        }
    }
    
    // MARK: Properties
    public var severity: DiagnosticSeverity {
        switch self {
        case .argumentNotGreaterThanZero: .error
        case .enumWithEmptyCases: .error
        case .mockBuilderPropertyNotSupported: .warning
        }
    }
    
    public var message: String {
        switch self {
        case .argumentNotGreaterThanZero: "'numberOfitems' argument must be greater than zero"
        case .enumWithEmptyCases: "Enum must contain at least one case"
        case .mockBuilderPropertyNotSupported(let type): "Type \(type) isn't supported from MockBuilderProperty"
        }
    }
    
    public var diagnosticID: MessageID {
        return MessageID(domain: "RJSwiftMacros", id: rawValue) //TODO: Check this hard coded
    }
    
    // MARK: Methods
    public static func report(
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
    
    public static func getFixIts(
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
        case .argumentNotGreaterThanZero, .mockBuilderPropertyNotSupported:
            return [] // No suggestion to provide
        }
    }
    
}
