import PackageDescription

let package = Package(
    name: "Node",
    targets: [
        Target(name: "Node", dependencies: ["PathIndexable"]),
        Target(name: "PathIndexable")
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/core.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/bits.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/debugging.git", majorVersion: 1),
    ]
)
