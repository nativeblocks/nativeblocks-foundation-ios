// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NativeblocksFoundation",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(
            name: "NativeblocksFoundation",
            targets: ["NativeblocksFoundation"]),
    ],
    targets: [
        .target(
            name: "NativeblocksFoundation"),
        .testTarget(
            name: "NativeblocksFoundationTests",
            dependencies: ["NativeblocksFoundation"]),
    ]
)
