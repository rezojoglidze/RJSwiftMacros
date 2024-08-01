//
//  CodingKeysGeneration.swift
//  
//
//  Created by Rezo Joglidze on 14.07.24.
//

import Foundation
import RJSwiftMacrosImplDependencies

/// - Generate `CodingKeys`  with ``CodingKeys(codingKeyType: CodingKeyType)`` Macro.
/// - `CodingKeyType` has two case `camelCase` and  `snakeCase`.
/// - Passing `codingKeyType` param with `nil` caused coding keys generation with camel cased.
/// ```
/// @CodingKeys()
/// struct Person {
///     let firstName: String
///     let surname: String
///
///     enum CodingKeys: String, CodingKey {
///        case firstName = "firstName"
///        case surname
///     }
/// }
/// ```
///
/// - CodingKeys generation by `snakeCase`.
/// ```
/// @CodingKeys(codingKeyType: .snakeCase)
/// struct Person {
///     let firstName: String
///     let surname: String
///
///     enum CodingKeys: String, CodingKey {
///        case firstName = "first_name"
///        case surname
///     }
/// }
/// ```
@attached(member, names: named(CodingKeys))
public macro CodingKeys(codingKeyType: CodingKeyType? = nil) = #externalMacro(module: "RJSwiftMacrosImpl", type: "CodingKeysMacro")


/// - Adjust coding key with ``CodingKeyProperty(_:)``
///
/// ```
/// @CodingKeys
/// struct Person {
///     @CodingKeyProperty("second_name") let surname: String
///
///     enum CodingKeys: String, CodingKey {
///        case surname = "second_name
///     }
/// }
///```
@attached(peer)
public macro CodingKeyProperty(_ value: String) = #externalMacro(module: "RJSwiftMacrosImpl", type: "CodingKeyPropertyMacro")

/// - To Ignore specific properties from the coding process``CodingKeyIgnored()``
///
/// ```
/// @CodingKeys
/// struct Person {
///     let name: String
///     CodingKeyIgnored() let surname: String
///
///     enum CodingKeys: String, CodingKey {
///        case name
///     }
/// }
/// ```
@attached(peer, names: named(CodingKeyIgnored))
public macro CodingKeyIgnored() = #externalMacro(module: "RJSwiftMacrosImpl", type: "CodingKeyIgnoredMacro")
