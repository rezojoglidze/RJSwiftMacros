//
//  MockBuilderFixIt.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftDiagnostics

struct MockBuilderFixIt: FixItMessage {
    public let message: String
    private let messageID: String

    /// This should only be called within a static var on FixItMessage, such
    /// as the examples below. This allows us to pick up the messageID from the
    /// var name.
    fileprivate init(_ message: String, messageID: String = #function) {
      self.message = message
      self.messageID = messageID
    }

    public var fixItID: MessageID {
      MessageID(
        domain: "RJSwiftMacros",
        id: "\(type(of: self)).\(messageID)"
      )
    }
}


extension FixItMessage where Self == MockBuilderFixIt {
    static var addNewEnumCase: Self {
      .init("add a new enum case")
    }
}
