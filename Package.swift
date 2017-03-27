import PackageDescription

let beta1 = Version(1, 0, 0, prereleaseIdentifiers: ["beta"])
let beta2 = Version(2, 0, 0, prereleaseIdentifiers: ["beta"])

let package = Package(
    name: "Node",
    targets: [
        Target(name: "Node"),
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/path-indexable.git", beta2),
        .Package(url: "https://github.com/vapor/core.git", beta2),
        .Package(url: "https://github.com/vapor/bits.git", beta1),
        .Package(url: "https://github.com/vapor/debugging.git", beta1),
    ]
)
