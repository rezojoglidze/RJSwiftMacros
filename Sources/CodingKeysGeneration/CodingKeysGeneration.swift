//
//  CodingKeysGeneration.swift
//  
//
//  Created by Rezo Joglidze on 14.07.24.
//

import Foundation

@attached(member, names: named(CodingKeys))
public macro CodingKeys() = #externalMacro(module: "CodingKeysGenerationMacros", type: "CodingKeysMacro")

@attached(peer)
public macro CodingKeyProperty(_ value: String) = #externalMacro(module: "CodingKeysGenerationMacros", type: "CodingKeyPropertyMacro")

@attached(peer, names: named(CodingKeyIgnored))
public macro CodingKeyIgnored() = #externalMacro(module: "CodingKeysGenerationMacros", type: "CodingKeyIgnoredMacro")
