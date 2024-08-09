//
//  MockBuilder.swift
//
//
//  Created by Rezo Joglidze on 27.07.24.
//

import Foundation
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

/// - `MockBuilder(numberOfItems: Int, dataGeneratorType: .random)`: Generates an mock item and array of mock data from our models.
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


/// - `MockBuilderProperty<T: Any>(value: T)`: This macro is used to set an initial value to a property within a struct or class. It is a generic macro, meaning it can accept any type (T) as a parameter. If the provided type is unsupported, a warning message will be displayed. This macro is particularly useful in scenarios where you need to initialize properties with specific values.
/// ```
///  import RJSwiftMacros
///
///  @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
///  struct Person {
///      @MockBuilderProperty(value: "John") let name: String
///      let surname: String
///
///      #if DEBUG
///      static var mock: Person {
///          .init(
///              name: MockBuilderSupportedType.generate(elementType: .string("John")) as! String,
///              surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
///              )
///      }
///
///      static var mockArray: [Person ] {
///          [
///              .init(
///                  name: MockBuilderSupportedType.generate(elementType: .string("John")) as! String,
///                  surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
///                  ),
///              .init(
///                  name: MockBuilderSupportedType.generate(elementType: .string("John")) as! String,
///                  surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
///                  ),
///          ]
///      }
///      #endif
///  }
///```
@attached(peer, names: named(MockBuilderPropertyMacro))
public macro MockBuilderProperty<T: Any>(value: T) = #externalMacro(module: "RJSwiftMacrosImpl", type: "MockBuilderPropertyMacro")
