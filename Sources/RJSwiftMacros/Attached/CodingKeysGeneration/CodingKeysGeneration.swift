//
//  CodingKeysGeneration.swift
//  
//
//  Created by Rezo Joglidze on 14.07.24.
//

import Foundation
import RJSwiftMacrosImplDependencies

/// - The `CodingKeys(codingKeyType: CodingKeyType)`` macro automatically generates `CodingKeys` for a struct based on the specified `CodingKeyType`.
/// - `CodingKeyType` has two options: `.camelCase` and `.snakeCase`.
/// - If the codingKeyType parameter is not provided (nil), the macro defaults to generating coding keys in camelCase.
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


/// - `CodingKeyProperty(_:)` macro allows you to adjust the coding key for a specific property.
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


/// - `CodingKeyIgnored()` macro allows you to exclude specific properties from the coding process when using the `CodingKeys` macro. Properties marked with `CodingKeyIgnored()` will not be included in the generated CodingKeys enum, and therefore, will not be encoded or decoded.
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
