// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-nodeinfo",
    products: [
        .library(
            name: "NodeInfo",
            targets: ["NodeInfo"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sinoru/swift-json-value.git", from: "0.0.5")
    ],
    targets: [
        .target(
            name: "NodeInfo",
            dependencies: [.product(name: "JSONValue", package: "swift-json-value")]),
        .testTarget(
            name: "NodeInfoTests",
            dependencies: ["NodeInfo"]),
    ]
)
