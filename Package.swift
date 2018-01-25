import PackageDescription

let package = Package(
    name: "imServer",
    targets: [
        Target(name: "App"),
        ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 2),
        .Package(url: "https://github.com/apple/swift-protobuf",Version(1,0,2)),
        ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        ]
)

