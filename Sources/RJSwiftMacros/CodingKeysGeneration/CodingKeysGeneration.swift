//
//  CodingKeysGeneration.swift
//  
//
//  Created by Rezo Joglidze on 14.07.24.
//

import Foundation

/// - Generate `CodingKeys`  with ``CodingKeys()`` Macro
/// - Adjust coding key with ``CodingKeyProperty(_:)``
/// - To ignore coding key generation at the specific property use ``CodingKeyIgnored()``
///
/// ```
/// @CodingKeys
/// struct Car {
///     let name: String
///     @CodingKeyProperty("second_name") let surname: String
///     @CodingKeyIgnored() let color: String
/// }
/// ```
@attached(member, names: named(CodingKeys))
public macro CodingKeys() = #externalMacro(module: "RJSwiftMacrosImpl", type: "CodingKeysMacro")

@attached(peer)
public macro CodingKeyProperty(_ value: String) = #externalMacro(module: "RJSwiftMacrosImpl", type: "CodingKeyPropertyMacro")

@attached(peer, names: named(CodingKeyIgnored))
public macro CodingKeyIgnored() = #externalMacro(module: "RJSwiftMacrosImpl", type: "CodingKeyIgnoredMacro")
