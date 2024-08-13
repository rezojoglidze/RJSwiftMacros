//
//  String+Extension.swift
//
//
//  Created by Rezo Joglidze on 01.08.24.
//

import Foundation

// MARK: - String Extension
public extension String {
    // MARK: Properties
    static var empty: String { String() }

    func dropBackticks() -> String {
        count > 1 && first == "`" && last == "`" ? String(dropLast().dropFirst()) : self
    }
    
    func snakeCased() -> String {
        reduce(into: "") { $0.append(contentsOf: $1.isUppercase ? "_\($1.lowercased())" : "\($1)") } // result "firstName" -> "first_name"
    }
}
