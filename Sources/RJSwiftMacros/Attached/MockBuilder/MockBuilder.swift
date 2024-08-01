//
//  MockBuilder.swift
//
//
//  Created by Rezo Joglidze on 27.07.24.
//

import Foundation
import RJSwiftMacrosImplDependencies

/// `MockBuilder(numberOfItems: Int, dataGeneratorType: .random)`: Generates an mock item and array of mock data from our models.
///
/// ```
///  import RJSwiftMacros
///
///  @MockBuilder(numberOfItems: 3, dataGeneratorType: .random)
///  struct Person {
///      let name: String
///      let surname: String
///
///      #if DEBUG
///      static var mock: Person {
///          .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string())
///      }
///
///      static var mockArray: [Person ] {
///          [
///              .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string()),
///              .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string()),
///          ]
///      }
///      #endif
///  }
///}
///```
@attached(member, names: named(mock), named(mockArray))
public macro MockBuilder(
    numberOfItems: Int,
    dataGeneratorType: DataGeneratorType
) = #externalMacro(module: "RJSwiftMacrosImpl", type: "MockBuilderMacro")
