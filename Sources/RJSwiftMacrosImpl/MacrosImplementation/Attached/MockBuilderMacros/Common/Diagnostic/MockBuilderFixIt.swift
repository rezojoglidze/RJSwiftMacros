//
//  MockBuilderFixIt.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftDiagnostics

// MARK: - Mock Builder Fix It
public struct MockBuilderFixIt: FixItMessage {
    // MARK: Properties
    public let message: String
    private let messageID: String

    public var fixItID: MessageID {
      MessageID(
        domain: "RJSwiftMacros",
        id: "\(type(of: self)).\(messageID)"
      )
    }
    
    fileprivate init(_ message: String, messageID: String = #function) {
      self.message = message
      self.messageID = messageID
    }
}

// MARK: - Extension
public extension FixItMessage where Self == MockBuilderFixIt {
    static var addNewEnumCase: Self {
      .init("add a new enum case") //TODO: Check it
    }
}
