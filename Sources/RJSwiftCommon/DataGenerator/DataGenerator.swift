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
// MARK: ❗⚠️❗if type isn't supported from MockBuilderItem macro add it to `notSupportedTypesFromMockBuilderProperty`.❗⚠️❗
public enum MockBuilderSupportedType: Equatable {
    case int(Int? = nil)
    case int8(Int8? = nil)
    case int16(Int16? = nil)
    case int32(Int32? = nil)
    case int64(Int64? = nil)
    case uint(UInt? = nil)
    case uint8(UInt8? = nil)
    case uint16(UInt16? = nil)
    case uint32(UInt32? = nil)
    case uint64(UInt64? = nil)
    case float(Float? = nil)
    case float32(Float32? = nil)
    case float64(Float64? = nil)
    case double(Double? = nil)
    case decimal(Decimal? = nil)
    case nsdecimalnumber(NSDecimalNumber? = nil)
    case string(String? = nil)
    case bool(Bool? = nil)
    case date
    case uuid(UUID? = nil)
    case objectidentifier
    case cgpoint
    case cgrect
    case cgsize
    case cgvector
    case cgfloat
    case url(URL? = nil)
    
    // MARK: Initialiazer
    public init?(
        rawValue: String,
        initialValue: AnyObject? = nil
    ) {
        let unwrappedValue = (initialValue as? String ?? .empty).replacingOccurrences(of: "\"", with: "")
        
        switch rawValue.lowercased() {
        case "int": self = .int(Int(unwrappedValue))
        case "int8": self = .int8(Int8(unwrappedValue))
        case "int16": self = .int16(Int16(unwrappedValue))
        case "int32": self = .int32(Int32(unwrappedValue))
        case "int64": self = .int64(Int64(unwrappedValue))
        case "uint": self = .uint(UInt(unwrappedValue))
        case "uint8": self = .uint8(UInt8(unwrappedValue))
        case "uint16": self = .uint16(UInt16(unwrappedValue))
        case "uint32": self = .uint32(UInt32(unwrappedValue))
        case "uint64": self = .uint64(UInt64(unwrappedValue))
        case "float": self = .float(Float(unwrappedValue))
        case "float32": self = .float32(Float32(unwrappedValue))
        case "float64": self = .float64(Float64(unwrappedValue))
        case "double": self = .double(Double(unwrappedValue))
        case "decimal": self = .decimal(Decimal(string: unwrappedValue))
        case "nsdecimalnumber":
            if let decimalValue = Decimal(string: unwrappedValue) {
                self = .nsdecimalnumber(NSDecimalNumber(decimal: decimalValue))
            } else {
                self  = .nsdecimalnumber(nil)
            }
        case "string": self = .string(unwrappedValue)
        case "bool": self = .bool(Bool(unwrappedValue))
        case "date": self = .date
        case "uuid": self = .uuid(UUID(uuidString: unwrappedValue))
        case "objectidentifier": self = .objectidentifier
        case "cgpoint": self = .cgpoint
        case "cgrect": self = .cgrect
        case "cgsize": self = .cgsize
        case "cgvector": self = .cgvector
        case "cgfloat": self = .cgfloat
        case "url": self = .url(URL(string: unwrappedValue))
        default: return nil
        }
    }
    
    // MARK: Properties
    private static var notSupportedTypesFromMockBuilderProperty: [Self] = [
        .date,
        .objectidentifier,
        .cgpoint,
        .cgrect,
        .cgsize,
        .cgvector,
        .cgfloat
    ]
    
    public static func isSupportedFromMockBuilderPropertyMacro(type: Self) -> Bool {
        MockBuilderSupportedType.notSupportedTypesFromMockBuilderProperty.contains(where: {
            $0.rawValue.lowercased() == type.rawValue.lowercased()
        })
    }
    
    public var rawValue: String {
        switch self {
        case .int: "Int"
        case .int8: "Int8"
        case .int16: "Int16"
        case .int32: "Int32"
        case .int64: "Int64"
        case .uint: "UInt"
        case .uint8: "UInt8"
        case .uint16: "UInt16"
        case .uint32: "UInt32"
        case .uint64: "UInt64"
        case .float: "Float"
        case .float32: "Float32"
        case .float64: "Float64"
        case .double: "Double"
        case .decimal: "Decimal"
        case .nsdecimalnumber: "NSDecimalNumber"
        case .string: "String"
        case .bool: "Bool"
        case .date: "Date"
        case .uuid: "UUID"
        case .objectidentifier: "ObjectIdentifier"
        case .cgpoint: "CGPoint"
        case .cgrect: "CGRect"
        case .cgsize: "CGSize"
        case .cgvector: "CGVector"
        case .cgfloat: "CGFloat"
        case .url: "URL"
        }
    }
    
    //MARK: Methods
    public static func generate(
        elementType: MockBuilderSupportedType,
        generatorType: DataGeneratorType? = nil
    ) -> Any {
        let defaultMaxValue = 100000
        
        return switch elementType {
        case .int(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomInt(min: Int.zero, max: Int(defaultMaxValue)))
        case .int8(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomInt(min: Int8.zero, max: Int8.max))
        case .int16(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomInt(min: Int16.zero, max: Int16.max))
        case .int32(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomInt(min: Int32.zero, max: Int32.max))
        case .int64(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomInt(min: Int64.zero, max: Int64(defaultMaxValue)))
        case .uint(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomUInt(min: UInt.zero, max: UInt(defaultMaxValue)))
        case .uint8(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomUInt(min: UInt8.zero, max: UInt8.max))
        case .uint16(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomUInt(min: UInt16.zero, max: UInt16.max))
        case .uint32(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomUInt(min: UInt32.zero, max: UInt32(defaultMaxValue)))
        case .uint64(let value): value ?? (generatorType == .`default` ? 0 : Provider().randomUInt(min: UInt64.zero, max: UInt64(defaultMaxValue)))
        case .float(let value): value ?? (generatorType == .`default` ? 0.0 : Provider().randomFloat(min: Float.leastNonzeroMagnitude, max: Float(defaultMaxValue)))
        case .float32(let value): value ?? (generatorType == .`default` ? 0.0 : Provider().randomFloat(min: Float32.leastNonzeroMagnitude, max: Float32(defaultMaxValue)))
        case .float64(let value): value ?? (generatorType == .`default` ? 0.0 : Provider().randomFloat(min: Float64.leastNonzeroMagnitude, max: Float64(defaultMaxValue)))
        case .double(let value): value ?? (generatorType == .`default` ? 0.0 : Provider().randomDouble(min: Double.leastNonzeroMagnitude, max: Double(defaultMaxValue)))
        case .decimal(let value): value ?? (generatorType == .`default` ? 0.0 : Provider().randomDecimal(min: Decimal.leastNonzeroMagnitude, max: Decimal(defaultMaxValue)))
        case .nsdecimalnumber(let value): value ?? (generatorType == .`default` ? 0.0 : Provider().randomNSDecimalNumber(min: NSDecimalNumber.zero, max: NSDecimalNumber(value: defaultMaxValue)))
        case .string(let value): value ?? (generatorType == .`default` ? "Hello World" : Provider().randomString())
        case .bool(let value): value ?? (generatorType == .`default` ? true : Provider().randomBool())
        case .date: generatorType == .`default` ? Date(timeIntervalSinceReferenceDate: 0) : Provider().date()
        case .uuid: UUID()
        case .objectidentifier: ObjectIdentifier(DummyClass())
        case .cgpoint: CGPoint()
        case .cgrect: CGRect()
        case .cgsize: CGSize()
        case .cgvector: CGVector()
        case .cgfloat: CGFloat()
        case .url(let value): value ?? (generatorType == .`default` ? URL(string: "https://www.apple.com")! : Provider().url())
        }
    }

    public func exprSyntax(
        elementType: MockBuilderSupportedType,
        generatorType: DataGeneratorType
    ) -> ExprSyntax {
        var associatedValue: String?
        
        switch elementType {
        case .int(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .int8(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .int16(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .int32(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .int64(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .uint(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .uint8(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .uint16(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .uint32(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .uint64(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .float(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .float32(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .float64(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .double(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .decimal(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .nsdecimalnumber(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .string(let initialValue):
            associatedValue = initialValue != nil && initialValue?.isEmpty == false ? "\"\(initialValue!)\"" : nil
        case .bool(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .uuid(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .url(let initialValue):
            associatedValue = initialValue != nil ? "\(initialValue!)" : nil
        case .date, .objectidentifier, .cgpoint, .cgrect, .cgsize, .cgvector, .cgfloat:
            associatedValue = nil
        }
        
        var exprString: String {
            if case .url(let url) = elementType,
               let associatedValue = url?.absoluteString {
                return "MockBuilderSupportedType.generate(elementType: .\(elementType.rawValue.lowercased())(URL(string: \"\(associatedValue)\"))) as! \(elementType.rawValue)"
            } else if let associatedValue {
                return "MockBuilderSupportedType.generate(elementType: .\(elementType.rawValue.lowercased())(\(associatedValue))) as! \(elementType.rawValue)"
            } else if Self.isSupportedFromMockBuilderPropertyMacro(type: elementType) {
                return "MockBuilderSupportedType.generate(elementType: .\(elementType.rawValue.lowercased()), generatorType: .\(generatorType.rawValue)) as! \(elementType.rawValue)"
            } else {
                return "MockBuilderSupportedType.generate(elementType: .\(elementType.rawValue.lowercased())(), generatorType: .\(generatorType.rawValue)) as! \(elementType.rawValue)"
            }
        }
        
        return ExprSyntax(stringLiteral: exprString)
    }
}

// MARK: - Dummy Class
fileprivate class DummyClass {}
