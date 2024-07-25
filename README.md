# RJSwiftMacros

RJSwiftMacros is a Swift package that provides macros. Such as generating coding keys and handling coding key properties and ignored keys.

## Features

- ``CodingKeys()``: Automatically generates `CodingKeys` for your structs.
- ``CodingKeyProperty(:_)``: Allows custom coding keys for specific properties.
- ``CodingKeyIgnored()``: Ignores specific properties from the coding process

## Requirements

- Swift 5.10 or later
- macOS 10.15 or later
- iOS 13 or later
- tvOS 13 or later
- watchOS 6 or later

  
## Installation
**Swift Package Manager**

You can add `RJSwiftMacros` as a dependency in your Project file


## Usage

Import the RJSwiftMacros module and apply the macros to your structs and properties:

```swift
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
