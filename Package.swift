import PackageDescription

let package = Package(
    name: "Node",
    dependencies: [
      .Package(url: "https://github.com/qutheory/path-indexable.git", majorVersion: 0, minor: 2),
      .Package(url: "https://github.com/qutheory/polymorphic.git", majorVersion: 0, minor: 3)
    ],
    targets: [
        Target(
            name: "Node",
            dependencies: [
            ]
        ),
        Target(
            name: "NodeFoundation",
            dependencies: [
                 .Target(name: "Node")
            ]
        )
    ]
)
