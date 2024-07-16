//
//  CodingKeysGeneration.swift
//  
//
//  Created by Rezo Joglidze on 14.07.24.
//

import Foundation

@attached(member, names: named(CodingKeys))
public macro CodingKeys() = #externalMacro(module: "RJSwiftMacros", type: "CodingKeysMacro")

@attached(peer)
public macro CodingKeyProperty(_ value: String) = #externalMacro(module: "RJSwiftMacros", type: "CodingKeyPropertyMacro")

@attached(peer, names: named(CodingKeyIgnored))
public macro CodingKeyIgnored() = #externalMacro(module: "RJSwiftMacros", type: "CodingKeyIgnoredMacro")
