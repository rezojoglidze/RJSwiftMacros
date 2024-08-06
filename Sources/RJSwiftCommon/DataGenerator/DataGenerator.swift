//
//  DataGenerator.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

fileprivate typealias Provider = FakeDataProvider
// MARK: - Data Generator Type
public enum DataGeneratorType: String {
    case `default`
    case random
}

// MARK: ❗⚠️❗Keep all cases names in lowercase.❗⚠️❗
public enum MockBuilderSupportedType: String {
    case int = "Int"
    case int8 = "Int8"
    case int16 = "Int16"
    case int32 = "Int32"
    case int64 = "Int64"
    case uint = "UInt"
    case uint8 = "UInt8"
    case uint16 = "UInt16"
    case uint32 = "UInt32"
    case uint64 = "UInt64"
    case float = "Float"
    case float32 = "Float32"
    case float64 = "Float64"
    case double = "Double"
    case string = "String"
    case bool = "Bool"
    case data = "Data"
    case date = "Date"
    case uuid = "UUID"
    case objectidentifier = "ObjectIdentifier"
    case cgpoint = "CGPoint"
    case cgrect = "CGRect"
    case cgsize = "CGSize"
    case cgvector = "CGVector"
    case cgfloat = "CGFloat"
    case url = "URL"
    
    //MARK: Methods
    public static func generate(model: DataGeneratorModel) -> Any {
        switch model.elementType {
        case .int: model.generatorType == .`default` ? 0 : Provider().randomInt(min: 0, max: 1000)
        case .int8: model.generatorType == .`default` ? 0 : Int8(Provider().randomInt(min: 0, max: 1000))
        case .int16: model.generatorType == .`default` ? 0 : Int16(Provider().randomInt(min: 0, max: 1000))
        case .int32: model.generatorType == .`default` ? 0 : Int32(Provider().randomInt(min: 0, max: 1000))
        case .int64: model.generatorType == .`default` ? 0 : Int64(Provider().randomInt(min: 0, max: 1000))
        case .uint: model.generatorType == .`default` ? 0 : UInt(Provider().randomInt(min: 0, max: 1000))
        case .uint8: model.generatorType == .`default` ? 0 : UInt8(Provider().randomInt(min: 0, max: 1000))
        case .uint16: model.generatorType == .`default` ? 0 : UInt(Provider().randomInt(min: 0, max: 1000))
        case .uint32: model.generatorType == .`default` ? 0 : UInt32(Provider().randomInt(min: 0, max: 1000))
        case .uint64: model.generatorType == .`default` ? 0 : UInt64(Provider().randomInt(min: 0, max: 1000))
        case .float: model.generatorType == .`default` ? 0 : Float(Provider().randomFloat(min: 0, max: 1000))
        case .float32: model.generatorType == .`default` ? 0 : Float32(Provider().randomFloat(min: 0, max: 1000))
        case .float64: model.generatorType == .`default` ? 0 : Float64(Provider().randomFloat(min: 0, max: 1000))
        case .double: model.generatorType == .`default` ? 0 : Provider().randomDouble(min: 0, max: 1000)
        case .string: model.generatorType == .`default` ? "Hello World" : Provider().randomString()
        case .bool: model.generatorType == .`default` ? true : Provider().randomBool()
        case .data: Data()
        case .date: model.generatorType == .`default` ? Date(timeIntervalSinceReferenceDate: 0) : Provider().date()
        case .uuid: UUID()
        case .objectidentifier: ObjectIdentifier(DummyClass())
        case .cgpoint: CGPoint()
        case .cgrect: CGRect()
        case .cgsize: CGSize()
        case .cgvector: CGVector()
        case .cgfloat: CGFloat()
        case .url: model.generatorType == .`default` ? URL(string: "https://www.apple.com")! : Provider().url()
        }
    }
    
    // MARK: Methods
    public func exprSyntax(model: DataGeneratorModel) -> ExprSyntax {
        ExprSyntax(stringLiteral: "MockBuilderSupportedType.generate(elementType: .\(model.elementType.rawValue.lowercased()), model.generatorType: .\(model.generatorType.rawValue)) as! \(model.elementType.rawValue)")
    }
}

// MARK: - Dummy Class
fileprivate class DummyClass {}
