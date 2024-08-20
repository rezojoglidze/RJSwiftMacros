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
    public static func == (lhs: MockBuilderSupportedType, rhs: MockBuilderSupportedType) -> Bool {
        switch (lhs, rhs) {
        case (.int(let lhsValue), .int(let rhsValue)):
            return lhsValue == rhsValue
        case (.int8(let lhsValue), .int8(let rhsValue)):
            return lhsValue == rhsValue
        case (.int16(let lhsValue), .int16(let rhsValue)):
            return lhsValue == rhsValue
        case (.int32(let lhsValue), .int32(let rhsValue)):
            return lhsValue == rhsValue
        case (.int64(let lhsValue), .int64(let rhsValue)):
            return lhsValue == rhsValue
        case (.uint(let lhsValue), .uint(let rhsValue)):
            return lhsValue == rhsValue
        case (.uint8(let lhsValue), .uint8(let rhsValue)):
            return lhsValue == rhsValue
        case (.uint16(let lhsValue), .uint16(let rhsValue)):
            return lhsValue == rhsValue
        case (.uint32(let lhsValue), .uint32(let rhsValue)):
            return lhsValue == rhsValue
        case (.uint64(let lhsValue), .uint64(let rhsValue)):
            return lhsValue == rhsValue
        case (.float(let lhsValue), .float(let rhsValue)):
            return lhsValue == rhsValue
        case (.float32(let lhsValue), .float32(let rhsValue)):
            return lhsValue == rhsValue
        case (.float64(let lhsValue), .float64(let rhsValue)):
            return lhsValue == rhsValue
        case (.double(let lhsValue), .double(let rhsValue)):
            return lhsValue == rhsValue
        case (.decimal(let lhsValue), .decimal(let rhsValue)):
            return lhsValue == rhsValue
        case (.nsdecimalnumber(let lhsValue), .nsdecimalnumber(let rhsValue)):
            return lhsValue == rhsValue
        case (.character(let lhsValue), .character(let rhsValue)):
            return lhsValue == rhsValue
        case (.string(let lhsValue), .string(let rhsValue)):
            return lhsValue == rhsValue
        case (.bool(let lhsValue), .bool(let rhsValue)):
            return lhsValue == rhsValue
        case (.date, .date):
            return true
        case (.uuid(let lhsValue), .uuid(let rhsValue)):
            return lhsValue == rhsValue
        case (.objectidentifier, .objectidentifier):
            return true
        case (.cgpoint, .cgpoint):
            return true
        case (.cgrect, .cgrect):
            return true
        case (.cgsize, .cgsize):
            return true
        case (.cgvector, .cgvector):
            return true
        case (.cgfloat, .cgfloat):
            return true
        case (.url(let lhsValue), .url(let rhsValue)):
            return lhsValue == rhsValue
        case (.image(let lhsValue), .image(let rhsValue)):
            return lhsValue as? Image == rhsValue as? Image
        case (.color(let lhsValue), .color(let rhsValue)):
            return lhsValue as? Color == rhsValue as? Color
        default:
            return false
        }
    }
    
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
    case character(Character? = nil)
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
    case image(Any? = nil)
    case color(Any? = nil)
    
    // MARK: Initialiazer
    public init?(
        rawValue: String,
        initialValue: AnyObject? = nil
    ) {
        let wrappedInitialValue = (initialValue as? String ?? .empty).replacingOccurrences(of: "\"", with: "")
        
        switch rawValue.lowercased() {
        case "int": self = .int(Int(wrappedInitialValue))
        case "int8": self = .int8(Int8(wrappedInitialValue))
        case "int16": self = .int16(Int16(wrappedInitialValue))
        case "int32": self = .int32(Int32(wrappedInitialValue))
        case "int64": self = .int64(Int64(wrappedInitialValue))
        case "uint": self = .uint(UInt(wrappedInitialValue))
        case "uint8": self = .uint8(UInt8(wrappedInitialValue))
        case "uint16": self = .uint16(UInt16(wrappedInitialValue))
        case "uint32": self = .uint32(UInt32(wrappedInitialValue))
        case "uint64": self = .uint64(UInt64(wrappedInitialValue))
        case "float": self = .float(Float(wrappedInitialValue))
        case "float32": self = .float32(Float32(wrappedInitialValue))
        case "float64": self = .float64(Float64(wrappedInitialValue))
        case "double": self = .double(Double(wrappedInitialValue))
        case "decimal": self = .decimal(Decimal(string: wrappedInitialValue))
        case "nsdecimalnumber":
            if let decimalValue = Decimal(string: wrappedInitialValue) {
                self = .nsdecimalnumber(NSDecimalNumber(decimal: decimalValue))
            } else {
                self = .nsdecimalnumber(nil)
            }
        case "character": self = .character(wrappedInitialValue.first)
        case "string": self = .string(wrappedInitialValue)
        case "bool": self = .bool(Bool(wrappedInitialValue))
        case "date": self = .date
        case "uuid": self = .uuid(UUID(uuidString: wrappedInitialValue))
        case "objectidentifier": self = .objectidentifier
        case "cgpoint": self = .cgpoint
        case "cgrect": self = .cgrect
        case "cgsize": self = .cgsize
        case "cgvector": self = .cgvector
        case "cgfloat": self = .cgfloat
        case "url": self = .url(URL(string: wrappedInitialValue))
        case "image": self = .image(initialValue as? String)
        case "color" : self = .color(initialValue as? String)
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
    
    // MARK: Methods
    func exprStringLiteral(
        with associatedValue: String?,
        typeIsOptional: Bool
    ) -> String {
        let firstPart = "MockBuilderSupportedType.generate(elementType: "
        let lastPart = typeIsOptional ? " as? \(rawValue)" : " as! \(rawValue)"
        
        // MARK: If type has associated value
        if let associatedValue {
            switch self {
            case .string, .character:
                return firstPart + ".\(rawValue.lowercased())(\("\"\(associatedValue.removeQuotes())\"")))" + lastPart
                
            case .url:
                return firstPart + ".\(rawValue.lowercased())(URL(string: \"\(associatedValue)\")))" + lastPart
                
            default:
                return firstPart + ".\(rawValue.lowercased())(\(associatedValue))) as! \(rawValue)"
            }
        } else {
            switch self {
            case .int, .int8, .int16, .int32, .int64, .uint, .uint8, .uint16, .uint32, .uint64,
                    .float, .float32, .float64, .double, .decimal, .nsdecimalnumber, .bool, .uuid, .url, .color, .image:
                return firstPart + ".\(rawValue.lowercased())())" + lastPart
                
            case .string, .character:
                return firstPart + ".\(rawValue.lowercased())())" + lastPart
                
            case .date, .objectidentifier, .cgpoint, .cgrect, .cgsize, .cgvector, .cgfloat:
                return firstPart + ".\(rawValue.lowercased()))" + lastPart
            }
        }
    }
    
    public static func generate(
        elementType: MockBuilderSupportedType
    ) -> Any {
        let defaultMaxValue = 100000
        
        return switch elementType {
        case .int(let int): int ?? Provider().randomInt(min: Int.zero, max: Int(defaultMaxValue))
        case .int8(let int): int ?? Provider().randomInt(min: Int8.zero, max: Int8.max)
        case .int16(let int): int ?? Provider().randomInt(min: Int16.zero, max: Int16.max)
        case .int32(let int): int ?? Provider().randomInt(min: Int32.zero, max: Int32.max)
        case .int64(let int): int ?? Provider().randomInt(min: Int64.zero, max: Int64(defaultMaxValue))
        case .uint(let uint): uint ?? Provider().randomUInt(min: UInt.zero, max: UInt(defaultMaxValue))
        case .uint8(let uint): uint ?? Provider().randomUInt(min: UInt8.zero, max: UInt8.max)
        case .uint16(let uint): uint ?? Provider().randomUInt(min: UInt16.zero, max: UInt16.max)
        case .uint32(let uint): uint ?? Provider().randomUInt(min: UInt32.zero, max: UInt32(defaultMaxValue))
        case .uint64(let uint): uint ?? Provider().randomUInt(min: UInt64.zero, max: UInt64(defaultMaxValue))
        case .float(let float): float ?? Provider().randomFloat(min: Float.leastNonzeroMagnitude, max: Float(defaultMaxValue))
        case .float32(let float): float ?? Provider().randomFloat(min: Float32.leastNonzeroMagnitude, max: Float32(defaultMaxValue))
        case .float64(let float): float ?? Provider().randomFloat(min: Float64.leastNonzeroMagnitude, max: Float64(defaultMaxValue))
        case .double(let double): double ?? Provider().randomDouble(min: Double.leastNonzeroMagnitude, max: Double(defaultMaxValue))
        case .decimal(let decimal): decimal ?? Provider().randomDecimal(min: Decimal.leastNonzeroMagnitude, max: Decimal(defaultMaxValue))
        case .nsdecimalnumber(let nsDecimalBumber): nsDecimalBumber ?? Provider().randomNSDecimalNumber(min: NSDecimalNumber.zero, max: NSDecimalNumber(value: defaultMaxValue))
        case .character(let character): character ?? (Provider().randomString().first ?? "R")
        case .string(let string): string ?? Provider().randomString()
        case .bool(let bool): bool ?? Provider().randomBool()
        case .date: Provider().date()
        case .uuid: UUID()
        case .objectidentifier: ObjectIdentifier(DummyClass())
        case .cgpoint: CGPoint()
        case .cgrect: CGRect()
        case .cgsize: CGSize()
        case .cgvector: CGVector()
        case .cgfloat: CGFloat()
        case .url(let url): url ?? Provider().url()
        case .image(let image): image ?? Provider().randomImage()
        case .color(let color): color ?? Provider().randomColor()
        }
    }

    public func exprSyntax(
        elementType: MockBuilderSupportedType,
        typeIsOptional: Bool
    ) -> ExprSyntax {
        var associatedValue: String?
        
        switch elementType {
        case .int(let intValue):
            associatedValue = intValue != nil ? "\(intValue!)" : nil
        case .int8(let intValue):
            associatedValue = intValue != nil ? "\(intValue!)" : nil
        case .int16(let intValue):
            associatedValue = intValue != nil ? "\(intValue!)" : nil
        case .int32(let intValue):
            associatedValue = intValue != nil ? "\(intValue!)" : nil
        case .int64(let intValue):
            associatedValue = intValue != nil ? "\(intValue!)" : nil
        case .uint(let uint):
            associatedValue = uint != nil ? "\(uint!)" : nil
        case .uint8(let uint):
            associatedValue = uint != nil ? "\(uint!)" : nil
        case .uint16(let uint):
            associatedValue = uint != nil ? "\(uint!)" : nil
        case .uint32(let uint):
            associatedValue = uint != nil ? "\(uint!)" : nil
        case .uint64(let uint):
            associatedValue = uint != nil ? "\(uint!)" : nil
        case .float(let float):
            associatedValue = float != nil ? "\(float!)" : nil
        case .float32(let float):
            associatedValue = float != nil ? "\(float!)" : nil
        case .float64(let float):
            associatedValue = float != nil ? "\(float!)" : nil
        case .double(let double):
            associatedValue = double != nil ? "\(double!)" : nil
        case .decimal(let decimal):
            associatedValue = decimal != nil ? "\(decimal!)" : nil
        case .nsdecimalnumber(let nsDecimalNumber):
            associatedValue = nsDecimalNumber != nil ? "\(nsDecimalNumber!)" : nil
        case .character(let character):
            associatedValue = character != nil ? "\(character!)" : nil
        case .string(let string):
            associatedValue = string != nil && string?.isEmpty == false ? "\"\(string!)\"" : nil
        case .bool(let bool):
            associatedValue = bool != nil ? "\(bool!)" : nil
        case .uuid(let uuid):
            associatedValue = uuid != nil ? "\(uuid!)" : nil
        case .url(let urlString):
            associatedValue = urlString != nil ? "\(urlString!)" : nil
        case .image(let image):
            associatedValue = image != nil ? "\(image!)" : nil
        case .color(let color):
            associatedValue = color != nil ? "\(color!)" : nil
        case .date, .objectidentifier, .cgpoint, .cgrect, .cgsize, .cgvector, .cgfloat:
            associatedValue = nil
        }
        
        return ExprSyntax(
            stringLiteral: exprStringLiteral(
                with: associatedValue,
                typeIsOptional: typeIsOptional
            )
        )
    }
}

// MARK: - Dummy Class
fileprivate class DummyClass {}
