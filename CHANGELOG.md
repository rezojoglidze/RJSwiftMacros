# Change Log

### [0.3.4(29)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.3.4) — *10 08 2024*
- Add closure support from `MockBuilderMacro`.

### [0.3.3(28)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.3.3) — *10 08 2024*
- `MockBuilder` macro doesn't work at `SwiftUI` `#Preview` macro. Add warning message and solution at macro description.
  
### [0.3.2(27)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.3.2) — *10 08 2024*
- Change `MockBuilder` behaviour. Make its params optional to create only `mock` variable and skip the `mockArray` variable

### [0.3.1(26)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.3.1) — *10 08 2024*
- Add `Image` type support for `MockBuilderMacro` 

### [0.3.0(25)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.3.0) — *10 08 2024*
- `MockBuilderProperty<T: Any>(value: T)`: This macro sets an initial value to a property within a struct or class.

### [0.2.9(24)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.9) — *03 08 2024*
Fix bug
- Mock Builder macro description issue from "show quick help".

### [0.2.8(23)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.8) — *03 08 2024*
Fix bug
- `MockBuilder` macros generated properties didn't work when properties types were: enum, struct or class.

### [0.2.7(22)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.7) — *02 08 2024*
Add `codingKeyType` param to `CodingKeys` Macro. It has two case `camelCase` and  `snakeCase`.

### [0.2.3(18)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.3) — *01 08 2024*
- Add `mock` variable generation to the `MockBuilder` Macro.

### [0.2.2(17)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.2) — *30 07 2024*
- Add definition to the macros

### [0.2.1(16)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.1) — *30 07 2024*
- `MockBuilder` macro Bug fixing
  
### [0.2.0(15)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.0) — *29 07 2024*
- `MockBuilder(numberOfItems: Int, dataGeneratorType: .random)`: Generates an array of mock data from our models.
  
### [0.1.13(14)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.1.13) — *26 07 2024*
- `CodingKeys()`: Automatically generates CodingKeys for your structs.
- `CodingKeyProperty(:_)`: Allows custom coding keys for specific properties.
- `CodingKeyIgnored()`: Ignores specific properties from the coding process.
