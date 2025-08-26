# NativeblocksFoundation

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE) [![GitHub stars](https://img.shields.io/github/stars/nativeblocks/nativeblocks-foundation-ios.svg)](https://github.com/nativeblocks/nativeblocks-foundation-ios/stargazers) [![GitHub issues](https://img.shields.io/github/issues/nativeblocks/nativeblocks-foundation-ios.svg)](https://github.com/nativeblocks/nativeblocks-foundation-ios/issues) [![GitHub forks](https://img.shields.io/github/forks/nativeblocks/nativeblocks-foundation-ios.svg)](https://github.com/nativeblocks/nativeblocks-foundation-ios/network)

**NativeblocksFoundation** is a foundational SwiftUI library that provides essential building blocks for the Nativeblocks ecosystem. It enables developers to create flexible, dynamic UIs with ease using pre-configured, server-driven blocks that are highly customizable. Below is an overview of the blocks available in **NativeblocksFoundation**.

For comprehensive details about Nativeblocks, please refer to the main [Nativeblocks documentation](https://nativeblocks.io/docs/get-started/introduction/).

---

## Getting Started

To integrate **NativeblocksFoundation** into your project, add it via Swift Package Manager (SPM):

1. Add the library to your `Package.swift` file:

    ```swift
    dependencies: [
        .package(url: "https://github.com/nativeblocks/nativeblocks-foundation-ios.git", .upToNextMajor(from: "1.2.0")),
    ],
    ```

2. Import the library in your Swift file:

    ```swift
    import NativeblocksFoundation
    ```

3. Provide nativeblocks foundation: 

    ```swift
    NativeblocksFoundationProvider.provide()
    ```

4. Start using the blocks provided by **NativeblocksFoundation** to create dynamic, server-driven UIs.

### Sample App Example

Here is an example of a basic app using **NativeblocksFoundation**:

```swift
import Nativeblocks
import NativeblocksFoundation
import SwiftUI

@main
struct SampleApp: App {
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
        NativeblocksFoundationProvider.provide() // add foundation provider
    }

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

**NativeblocksFoundation** is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute this library under the license terms.

---

## Additional Resources

- [Nativeblocks Documentation](https://nativeblocks.io/docs/get-started/introduction/)
- [Nativeblocks Compiler](https://nativeblocks.io/docs/compiler/swift-block/)
- [Getting Started with Server-Driven UI](https://nativeblocks.io/blog/server-driven-ui-introduction/)

For any questions or issues, feel free to open an issue in the repository. Happy coding!

