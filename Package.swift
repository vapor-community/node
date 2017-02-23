import PackageDescription

let alpha = Version(2, 0, 0, prereleaseIdentifiers: ["alpha"])

let package = Package(
    name: "Node",
    targets: [
        Target(name: "Node"),
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/path-indexable.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/polymorphic.git", alpha),
        .Package(url: "https://github.com/vapor/bits.git", majorVersion: 0)
    ]
)
