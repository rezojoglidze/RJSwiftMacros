# RJSwiftMacros

RJSwiftMacros is a Swift package that provides macros for generating coding keys and handling coding key properties and ignored keys. These macros help simplify the process of creating and managing `CodingKeys` in your Swift structs.

## Features

- **CodingKeys Macro**: Automatically generates `CodingKeys` for your structs.
- **CodingKeyProperty Macro**: Allows custom coding keys for specific properties.
- **CodingKeyIgnored Macro**: Ignores specific properties from the coding process

## Installation
**Swift Package Manager**

You can add `RJSwiftMacros` as a dependency in your Project file


## Usage

Import the RJSwiftMacros module and apply the macros to your structs and properties:

```
import RJSwiftMacros

@CodingKeys
struct Person {
    let name: String
    @CodingKeyProperty("second_name") let surname: String
    @CodingKeyIgnored() let color: String
}
```


## Contributing
Contributions are welcome! Please open an issue or submit a pull request on GitHub.


## Contact
For questions or feedback, feel free to reach out to rezojoglidze7@gmail.com.
