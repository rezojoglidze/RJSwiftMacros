//
//  File.swift
//  
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftSyntax
import RJSwiftCommon

// MARK: Supported Type
public enum SupportedType: String {
    case int = "Int"
    case int8 = "Int8"
    case int16 = "Int16"
    case int32 = "Int32"
    case int64 = "Int64"
    case uInt8 = "UInt8"
    case uInt16 = "UInt16"
    case uInt32 = "UInt32"
    case uInt64 = "UInt64"
    case float = "Float"
    case double = "Double"
    case string = "String"
    case bool = "Bool"
    case data = "Data"
    case date = "Date"
    case uuid = "UUID"
    case objectIdentifier = "ObjectIdentifier"
    case cgPoint = "CGPoint"
    case cgRect = "CGRect"
    case cgSize = "CGSize"
    case cgVector = "CGVector"
    case cgFloat = "CGFloat"
    case url = "URL"

    // MARK: Methods
    public func exprSyntax(dataGeneratorType: DataGeneratorType) -> ExprSyntax {
        switch dataGeneratorType {
        case .default: // TODO: fix it
            return ExprSyntax(stringLiteral: "\(DataGenerator.name).\(dataGeneratorType).\(self.rawValue.lowercased())()")
        case .random:
            return ExprSyntax(stringLiteral: "\(DataGenerator.name).\(dataGeneratorType)().\(self.rawValue.lowercased())()")
        }
    }
}
