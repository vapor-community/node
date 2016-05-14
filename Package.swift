import PackageDescription

let package = Package(
    name: "Node",
    dependencies: [
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
