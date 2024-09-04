//
//  DataProvider.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import SwiftUI

// MARK: - Protocols For Fake Data
protocol StringDataProvider {
    func randomString() -> String
}

protocol BooleanDataProvider {
    func randomBool() -> Bool
}

protocol DateDataProvider {
    func date() -> Date
}

protocol URLDataProvider {
    func url() -> URL
}

protocol NumericDataProvider {
    func randomInt<T: FixedWidthInteger & SignedInteger>(min: T, max: T) -> T
    
    func randomUInt<T: FixedWidthInteger & UnsignedInteger>(min: T, max: T) -> T
    
    func randomDouble(min: Double, max: Double) -> Double
    
    func randomFloat<T: BinaryFloatingPoint & Comparable>(min: T, max: T) -> T where T.RawSignificand: FixedWidthInteger
    
    func randomDecimal(min: Decimal, max: Decimal) -> Decimal
    func randomNSDecimalNumber(min: NSDecimalNumber, max: NSDecimalNumber) -> NSDecimalNumber
}

protocol ImageProvider {
    func randomImageStringName() -> String
}

protocol ColorProvider {
    func randomColorString() -> String
}


// MARK: - Mock Data Provider
struct MockDataProvider: StringDataProvider {
    func randomString() -> String {
        [
            "Lorem ipsum dolor sit amet",
            "consectetur adipiscing elit",
            "sed do eiusmod tempor incididunt",
            "ut labore et dolore magna aliqua",
            "Ut enim ad minim veniam",
            "quis nostrud exercitation ullamco laboris",
            "nisi ut aliquip ex ea commodo consequat",
            "Duis aute irure dolor in reprehenderit",
            "in voluptate velit esse cillum dolore",
            "eu fugiat nulla pariatur",
            "Excepteur sint occaecat cupidatat non proident",
            "sunt in culpa qui officia deserunt mollit",
            "anim id est laborum",
            "Curabitur pretium tincidunt lacus",
            "Nulla gravida orci a odio",
            "Nullam varius, turpis et commodo pharetra",
            "est eros bibendum elit",
            "nec luctus magna felis sollicitudin mauris",
            "Integer in mauris eu nibh euismod gravida",
            "Duis ac tellus et risus vulputate vehicula",
            "Donec lobortis risus a elit",
            "Etiam tempor",
            "Ut ullamcorper",
            "malesuada sapien"
        ].randomElement() ?? "Lorem ipsum"
    }
}

// MARK: Boolean Data Provider
extension MockDataProvider: BooleanDataProvider {
    func randomBool() -> Bool {
        Bool.random()
    }
}

// MARK: Date Data Provider
extension MockDataProvider: DateDataProvider {
    func date() -> Date {
        let years = 5
        let daysInYears = 365.25 // Consider average year including leap years
        let secondsInADay = 24.0 * 60.0 * 60.0
        
        // Current date as the start date
        let startDate = Date()
        
        // Maximum number of seconds in the specified number of years
        let maxSeconds = Int(daysInYears * Double(years) * secondsInADay)
        
        // Generate a random interval
        let randomInterval = TimeInterval(Int.random(in: 0..<maxSeconds))
        
        // Generate the random date
        return startDate.addingTimeInterval(randomInterval)
    }
}

// MARK: URL Data Provider
extension MockDataProvider: URLDataProvider {
    func url() -> URL {
        [
            URL(string: "https://www.google.com")!,
            URL(string: "https://www.youtube.com")!,
            URL(string: "https://www.facebook.com")!,
            URL(string: "https://www.wikipedia.org")!,
            URL(string: "https://www.amazon.com")!,
            URL(string: "https://www.twitter.com")!,
            URL(string: "https://www.instagram.com")!,
            URL(string: "https://www.linkedin.com")!,
            URL(string: "https://www.netflix.com")!,
            URL(string: "https://www.microsoft.com")!,
            URL(string: "https://www.apple.com")!,
            URL(string: "https://www.whatsapp.com")!,
            URL(string: "https://www.tiktok.com")!,
            URL(string: "https://www.ebay.com")!,
            URL(string: "https://www.reddit.com")!,
            URL(string: "https://www.spotify.com")!,
            URL(string: "https://www.airbnb.com")!,
            URL(string: "https://www.zoom.us")!,
            URL(string: "https://www.adobe.com")!,
            URL(string: "https://www.paypal.com")!,
        ].randomElement()!
    }
}

// MARK: Numeric Data Provider
extension MockDataProvider: NumericDataProvider {
    func randomInt<T: FixedWidthInteger & SignedInteger>(min: T, max: T) -> T {
        return T.random(in: min...max)
    }
    
    func randomUInt<T: FixedWidthInteger & UnsignedInteger>(min: T, max: T) -> T {
        return T.random(in: min...max)
    }
    
    func randomDouble(min: Double, max: Double) -> Double {
        Double.random(in: min...max)
    }
    
    func randomFloat<T: BinaryFloatingPoint & Comparable>(min: T, max: T) -> T where T.RawSignificand: FixedWidthInteger {
        let range = max - min
        let randomValue = T.random(in: 0...1) * range + min
        return randomValue
    }
    
    func randomDecimal(min: Decimal, max: Decimal) -> Decimal {
        let range = max - min
        let randomValue = Decimal(Double.random(in: 0...1)) * range + min
        return randomValue
    }
    
    func randomNSDecimalNumber(min: NSDecimalNumber, max: NSDecimalNumber) -> NSDecimalNumber {
        let range = max.subtracting(min)
        let randomValue = NSDecimalNumber(value: Double.random(in: 0...1)).multiplying(by: range).adding(min)
        return randomValue
    }
}

extension MockDataProvider: ImageProvider {
    func randomImageStringName() -> String {
        let name =  [
            "swift",
            "star",
            "calendar",
            "xmark.circle",
            "airplane",
            "house",
            "keyboard",
            "lock",
            "wifi",
            "car.fill"
        ].randomElement() ?? .empty
        
        
        return "Image(systemName: \"\(name)\")"
    }
}

extension MockDataProvider: ColorProvider {
    func randomColorString() -> String {
        // Need To Create as [String] due to the minimum compile time.
        let color = [
            "Color.black",
            "Color.blue",
            "Color.brown",
            "Color.cyan",
            "Color.gray",
            "Color.indigo",
            "Color.mint",
            "Color.orange",
            "Color.pink",
            "Color.purple",
            "Color.yellow",
            "Color.accentColor",
            "Color.primary",
            "Color.gray",
            "Color.red"
        ].randomElement() ?? "Color.black"
        
        return "\(color).opacity(0.6)"
    }
}
