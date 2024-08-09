//
//  Constants.swift
//
//
//  Created by Rezo Joglidze on 02.08.24.
//

import Foundation

// MARK: - Constants
public enum Constants: String {
    // MARK: Mock Builder Macro
    case mockIdentifier = "mock" // Generated single param name name
    case mockArrayIdentifier = "mockArray" // Generated array param name
    case numberOfItemsLabelIdentifier = "numberOfItems"
    case dataGeneratorTypeLabelIdentifier = "dataGeneratorType"
    
    // MARK: Mock Builder Property Macro
    case mockBuilderProperyIdentifier = "MockBuilderProperty"
    case mockBuilderPropertyMacroValueParamIdentifier = "value"
    
    // MARK: Coding Key Macros
    case codingKeyTypeIdentifier = "codingKeyType"
    case codingKeyPropertyIdentifier = "CodingKeyProperty"
    case codingKeyIgnoredIdentifier = "CodingKeyIgnored"
}
