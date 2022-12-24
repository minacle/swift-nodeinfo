// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-nodeinfo",
    products: [
        .library(
            name: "NodeInfo",
            targets: ["NodeInfo"]),
    ],
    targets: [
        .target(name: "NodeInfo"),
        .testTarget(
            name: "NodeInfoTests",
            dependencies: ["NodeInfo"]),
    ]
)
