// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Node",
    products: [
        .library(name: "Node", targets: ["Node"]),
        .library(name: "PathIndexable", targets: ["PathIndexable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/core.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/vapor/bits.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/vapor/debugging.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(name: "Node", dependencies: ["Bits", "Core", "PathIndexable"]),
        .testTarget(name: "NodeTests", dependencies: ["Node"]),
        .target(name: "PathIndexable"),
        .testTarget(name: "PathIndexableTests", dependencies: ["PathIndexable"])
    ]
)
