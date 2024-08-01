# Change Log

### [0.2.4(19)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.4) — *02 08 2024*
Add `codingKeyType` param to `CodingKeys` Macro. It has two case `camelCase` and  `snakeCase`.

### [0.2.3(18)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.3) — *01 08 2024*
Add `mock` variable generation to the `MockBuilder` Macro.

### [0.2.2(17)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.2) — *30 07 2024*
Add definition to the macros

### [0.2.1(16)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.1) — *30 07 2024*
Macros
- `MockBuilder` macro Bug fixing
  
### [0.2.0(15)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.2.0) — *29 07 2024*
Macros
- `MockBuilder(numberOfItems: Int, dataGeneratorType: .random)`: Generates an array of mock data from our models.
  
### [0.1.13(14)](https://github.com/rezojoglidze/RJSwiftMacros/releases/tag/0.1.13) — *26 07 2024*
Macros
- `CodingKeys()`: Automatically generates CodingKeys for your structs.
- `CodingKeyProperty(:_)`: Allows custom coding keys for specific properties.
- `CodingKeyIgnored()`: Ignores specific properties from the coding process.
