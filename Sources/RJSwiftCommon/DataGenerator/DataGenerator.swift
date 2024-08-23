//
//  DataGenerator.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftUI
import SwiftSyntax
import SwiftSyntaxBuilder

fileprivate typealias Provider = MockDataProvider

// MARK: - ❗⚠️❗Keep all cases names in lowercase.❗⚠️❗
// MARK: ❗⚠️❗if type isn't supported from MockBuilderItem macro add it to `notSupportedTypesFromMockBuilderProperty`.❗⚠️❗
public enum MockBuilderSupportedType: Equatable {    
    case int(ExprSyntax? = nil)
    case int8(ExprSyntax? = nil)
    case int16(ExprSyntax? = nil)
    case int32(ExprSyntax? = nil)
    case int64(ExprSyntax? = nil)
    case uint(ExprSyntax? = nil)
    case uint8(ExprSyntax? = nil)
    case uint16(ExprSyntax? = nil)
    case uint32(ExprSyntax? = nil)
    case uint64(ExprSyntax? = nil)
    case float(ExprSyntax? = nil)
    case float32(ExprSyntax? = nil)
    case float64(ExprSyntax? = nil)
    case double(ExprSyntax? = nil)
    case decimal(ExprSyntax? = nil)
    case nsdecimalnumber(ExprSyntax? = nil)
    case character(ExprSyntax? = nil)
    case string(ExprSyntax? = nil)
    case bool(ExprSyntax? = nil)
    case date
    case uuid(ExprSyntax? = nil)
    case objectidentifier
    case cgpoint
    case cgrect
    case cgsize
    case cgvector
    case cgfloat
    case url(ExprSyntax? = nil)
    case image(ExprSyntax? = nil)
    case color(ExprSyntax? = nil)
    
    // MARK: Initialiazer
    public init?(
        rawValue: String,
        exprSyntax: ExprSyntax? = nil
    ) {
        switch rawValue.lowercased() {
        case "int": self = .int(exprSyntax)
        case "int8": self = .int8(exprSyntax)
        case "int16": self = .int16(exprSyntax)
        case "int32": self = .int32(exprSyntax)
        case "int64": self = .int64(exprSyntax)
        case "uint": self = .uint(exprSyntax)
        case "uint8": self = .uint8(exprSyntax)
        case "uint16": self = .uint16(exprSyntax)
        case "uint32": self = .uint32(exprSyntax)
        case "uint64": self = .uint64(exprSyntax)
        case "float": self = .float(exprSyntax)
        case "float32": self = .float32(exprSyntax)
        case "float64": self = .float64(exprSyntax)
        case "double": self = .double(exprSyntax)
        case "decimal": self = .decimal(exprSyntax)
        case "nsdecimalnumber": self = .nsdecimalnumber(exprSyntax)
        case "character": self = .character(exprSyntax)
        case "string": self = .string(exprSyntax)
        case "bool": self = .bool(exprSyntax)
        case "date": self = .date
        case "uuid": self = .uuid(exprSyntax)
        case "objectidentifier": self = .objectidentifier
        case "cgpoint": self = .cgpoint
        case "cgrect": self = .cgrect
        case "cgsize": self = .cgsize
        case "cgvector": self = .cgvector
        case "cgfloat": self = .cgfloat
        case "url": self = .url(exprSyntax)
        case "image": self = .image(exprSyntax)
        case "color" : self = .color(exprSyntax)
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
    
    public static func notSupportedFromMockBuilderPropertyMacro(type: Self) -> Bool {
        MockBuilderSupportedType.notSupportedTypesFromMockBuilderProperty.contains(where: {
            $0.rawValue.lowercased() == type.rawValue.lowercased()
        })
    }
    
    // MARK: RawValue
    public var rawValue: String {
        func getName(of type: Any) -> String {
            return String(describing: type.self)
        }
        
        return switch self {
        case .int: getName(of: Int.self)
        case .int8: getName(of: Int8.self)
        case .int16: getName(of: Int16.self)
        case .int32: getName(of: Int32.self)
        case .int64: getName(of: Int64.self)
        case .uint: getName(of: UInt.self)
        case .uint8: getName(of: UInt8.self)
        case .uint16: getName(of: UInt16.self)
        case .uint32: getName(of: UInt32.self)
        case .uint64: getName(of: UInt64.self)
        case .float: getName(of: Float.self)
        case .float32: "Float32"
        case .float64: "Float64"
        case .double: getName(of: Double.self)
        case .decimal: "Decimal"
        case .nsdecimalnumber: getName(of: NSDecimalNumber.self)
        case .character: getName(of: Character.self)
        case .string: getName(of: String.self)
        case .bool: getName(of: Bool.self)
        case .date: getName(of: Date.self)
        case .uuid: getName(of: UUID.self)
        case .objectidentifier: getName(of: ObjectIdentifier.self)
        case .cgpoint: getName(of: CGPoint.self)
        case .cgrect: getName(of: CGRect.self)
        case .cgsize: getName(of: CGSize.self)
        case .cgvector: getName(of: CGVector.self)
        case .cgfloat: getName(of: CGFloat.self)
        case .url: getName(of: URL.self)
        case .image: getName(of: Image.self)
        case .color: getName(of: Color.self)
        }
    }
    
    // MARK: Expr Syntax
    public func exprSyntax() -> ExprSyntax {
        let defaultMaxValue = 100000
        
        return switch self {
        case .int(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomInt(min: Int.zero, max: Int(defaultMaxValue)))")
        case .int8(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomInt(min: Int8.zero, max: Int8.max))")
        case .int16(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomInt(min: Int16.zero, max: Int16.max))")
        case .int32(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomInt(min: Int32.zero, max: Int32.max))")
        case .int64(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomInt(min: Int64.zero, max: Int64(defaultMaxValue)))")
            
        case .uint(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomUInt(min: UInt.zero, max: UInt(defaultMaxValue)))")
        case .uint8(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomUInt(min: UInt8.zero, max: UInt8.max))")
        case .uint16(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomUInt(min: UInt16.zero, max: UInt16.max))")
        case .uint32(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomUInt(min: UInt32.zero, max: UInt32(defaultMaxValue)))")
        case .uint64(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomUInt(min: UInt64.zero, max: UInt64(defaultMaxValue)))")
            
        case .float(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\( Provider().randomFloat(min: Float.leastNonzeroMagnitude, max: Float(defaultMaxValue)))")
        case .float32(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomFloat(min: Float32.leastNonzeroMagnitude, max: Float32(defaultMaxValue)))")
        case .float64(let exprSyntax):exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomFloat(min: Float64.leastNonzeroMagnitude, max: Float64(defaultMaxValue)))")
            
        case .double(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomDouble(min: Double.leastNonzeroMagnitude, max: Double(defaultMaxValue)))")
        case .decimal(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomDecimal(min: Decimal.leastNonzeroMagnitude, max: Decimal(defaultMaxValue)))")
        case .nsdecimalnumber(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomNSDecimalNumber(min: NSDecimalNumber.zero, max: NSDecimalNumber(value: defaultMaxValue)))")
            
        case .character(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\((Provider().randomString().first ?? "R"))")
        case .string(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\"\(Provider().randomString())\"")
            
        case .bool(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "\(Provider().randomBool())")
            
        case .date: {
            let timeInterval = Provider().randomInt(min: Int.zero, max: Int(defaultMaxValue))
            return ExprSyntax(stringLiteral: "Date(timeInterval: \(timeInterval), since: Date())")
        }()
            
        case .uuid(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "UUID()")
        case .objectidentifier: ExprSyntax(stringLiteral: "{\n class DummyClass { } \n return ObjectIdentifier(DummyClass()) \n}()")
        case .cgpoint: ExprSyntax(stringLiteral: "CGPoint()")
        case .cgrect: ExprSyntax(stringLiteral: "CGRect()")
        case .cgsize: ExprSyntax(stringLiteral: "CGSize()")
        case .cgvector: ExprSyntax(stringLiteral: "CGVector()")
        case .cgfloat: ExprSyntax(stringLiteral: "CGFloat()")
            
        case .url(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: "URL(string: \"\(Provider().url().absoluteString)\")!")
        case .image(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: Provider().randomImageStringName())
        case .color(let exprSyntax): exprSyntax ?? ExprSyntax(stringLiteral: Provider().randomColorString())
        }
    }
}
