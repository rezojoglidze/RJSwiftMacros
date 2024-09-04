//
//  MockBuilder.swift
//
//
//  Created by Rezo Joglidze on 27.07.24.
//

import Foundation

/// - ``MockBuilder(numberOfItems: Int)``: This macro generates a mock instance and an array of mock data based on your model. It allows you to specify the number of items. Making it highly flexible for testing and development purposes.
/// > [!WARNING]
/// >`MockBuilder` macro doesn't work at `SwiftUI` `#Preview` macro. Here is a [solution](https://stackoverflow.com/questions/78856674/does-attached-macros-work-in-the-preview-body/78856731#78856731)
///
/// ## Key Features:
/// - **Default Usage**: `@MockBuilder()` generates a one single mock instance.
/// - **Customizable**: You can also specify parameters like `numberOfItems`  if you need to have array of mock items.
///
/// ## MockBuilder(numberOfItems: Int) usage:
/// ```
///  import RJSwiftMacros
///
///  @MockBuilder(numberOfItems: 2)
///  struct Person {
///      let name: String
///      let age: Int
///
///      #if DEBUG
///      static var mock: Person {
///          .init(
///             name: "John",
///             age: 21
///          )
///      }
///
///      static var mockArray: [Person ] {
///          [
///          .init(
///             name: "Tomas",
///             age: 36
///          ),
///          .init(
///             name: "John",
///             age: 25
///          )
///          ]
///      }
///      #endif
///  }
///}
///```
///
/// ## MockBuilder() usage:
/// ```
///  import RJSwiftMacros
///
///  @MockBuilder()
///  struct Person {
///      let name: String
///      let age: Int
///
///      #if DEBUG
///      static var mock: Person {
///          .init(
///              name: "John",
///              age: 32
///           )
///      }
///      #endif
///  }
///}
///```
@attached(member, names: named(mock), named(mockArray))
public macro MockBuilder(
    numberOfItems: Int? = nil
) = #externalMacro(module: "RJSwiftMacrosImpl", type: "MockBuilderMacro")


/// - `MockBuilderProperty<T: Any>(value: T)`: This macro sets an initial value to a property within a struct or class. It is a generic macro, meaning it can accept any type (T) as a parameter.
///  If the provided type is unsupported, a warning message will be displayed. This macro is particularly useful in scenarios where you need to initialize properties with specific values.
/// ```
///  import RJSwiftMacros
///
///  @MockBuilder(numberOfItems: 2)
///  struct Person {
///      @MockBuilderProperty(value: "Luiz") let name: String
///      let surname: String
///
///      #if DEBUG
///      static var mock: Person {
///          .init(
///              name: "Luiz",
///              surname: "Doe"
///              )
///      }
///
///      static var mockArray: [Person ] {
///          [
///              .init(
///                  name: "Jone",
///                  surname: "Carter"
///                  ),
///              .init(
///                  name: "Anderson",
///                  surname: "Lopez"
///                  ),
///          ]
///      }
///      #endif
///  }
///```
@attached(peer)
public macro MockBuilderProperty<T: Any>(value: T) = #externalMacro(module: "RJSwiftMacrosImpl", type: "MockBuilderPropertyMacro")
