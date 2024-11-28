# NativeblocksFoundation

**NativeblocksFoundation** is a foundational SwiftUI library that provides essential building blocks for the Nativeblocks ecosystem. It enables developers to easily create flexible and dynamic UIs using pre-configured, server-driven blocks that are highly customizable. Below is an overview of the blocks provided by **NativeblocksFoundation**.

For more comprehensive details about Nativeblocks, please refer to the main [Nativeblocks documentation](https://nativeblocks.io/docs/get-started/introduction/).

---

## Available Blocks

The NativeblocksFoundation library includes several reusable and customizable blocks designed to simplify the UI development process. Here are the components included in this library:

### 1. Native VStack Block

- **Name**: Native VStack
- **Key Type**: `NATIVE_VSTACK`
- **Description**: A flexible vertical stack container for arranging child views.

### 2. Native Button Block

- **Name**: Native Button
- **Key Type**: `NATIVE_BUTTON`
- **Description**: A customizable button with options for text, icons, and actions.

### 3. Native HStack Block

- **Name**: Native HStack
- **Key Type**: `NATIVE_HSTACK`
- **Description**: A horizontal stack container for arranging child views.

### 4. Native ZStack Block

- **Name**: Native ZStack
- **Key Type**: `NATIVE_ZSTACK`
- **Description**: A stack that overlays its child views on top of each other.

### 5. Native Image Block

- **Name**: Native Image
- **Key Type**: `NATIVE_IMAGE`
- **Description**: Displays images with options for placeholders and error views.

### 6. Native ScrollView Block

- **Name**: Native ScrollView
- **Key Type**: `NATIVE_SCROLLVIEW`
- **Description**: A scrollable container for child views with multiple customization options.

### 7. Native Spacer Block

- **Name**: Native Spacer
- **Key Type**: `NATIVE_SPACER`
- **Description**: A flexible spacer for expanding views.

### 8. Native Text Block

- **Name**: Native Text
- **Key Type**: `NATIVE_TEXT`
- **Description**: A text display block with rich formatting options.

### 9. Native TextField Block

- **Name**: Native Text Field
- **Key Type**: `NATIVE_TEXT_FIELD`
- **Description**: A text field for user input with support for multiple keyboard types and editing events.

---

## Getting Started

To integrate **NativeblocksFoundation** into your project, add it via Swift Package Manager (SPM):

1. Add the library in your `Package.swift` file:

```swift
dependencies: [
    .package(
        url: "https://github.com/nativeblocks/nativeblocks-foundation-ios.git",
        .upToNextMajor(from: "1.0.0")
    ),
],
```

2. Import the library in your Swift file:

```swift
import NativeblocksFoundation
```

3. Start using the blocks provided by **NativeblocksFoundation** to create dynamic, server-driven UIs.

- **Sample App Example**:
  ```swift
  import Nativeblocks
  import NativeblocksFoundation
  import SwiftUI

  @main
  struct sampleApp: App {
      @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
      let NATIVEBLOCKS_API_ENDPOINT = "https://api.nativeblocks.io/graphql"
      let NATIVEBLOCKS_API_KEY = ""

      init() {
          NativeblocksManager.initialize(
              edition: .cloud(
                  endpoint: NATIVEBLOCKS_API_ENDPOINT,
                  apiKey: NATIVEBLOCKS_API_KEY,
                  developmentMode: true
              )
          )

          t    }

      var body: some Scene {
          WindowGroup {
              NativeblocksFrame(
                  route: "/",
                  routeArguments: [:],
                  loading: { AnyView(NativeblocksLoading()) },
                  error: { message in AnyView(NativeblocksError(message: message)) }
              )
          }
      }
  }

  class AppDelegate: NSObject, UIApplicationDelegate {
      func applicationWillTerminate(_ application: UIApplication) {
          NativeblocksManager.getInstance().destroy()
      }
  }
  ```

---

## License

**NativeblocksFoundation** is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute this library as per the license terms.

---

## Additional Resources

- [Nativeblocks Documentation](https://nativeblocks.io/docs/get-started/introduction/)
- [Nativeblocks Compiler](https://nativeblocks.io/docs/compiler/swift-block/)
- [Getting Started with Server-Driven UI](https://nativeblocks.io/blog/server-driven-ui-introduction/)

For any questions or issues, feel free to open an issue in this repository. Happy coding!

