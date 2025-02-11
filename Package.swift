// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription

let package = Package(
    name: "swift-android",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        .library(name: "SwiftAndroidApp", type: .dynamic, targets: ["SwiftAndroid"]),
        .library(name: "HelloSwiftModel", type: .dynamic, targets: ["HelloSwiftModel"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.2.27"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-fuse.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-model.git", from: "1.0.0"),
        // Own dependencies
        .package(url: "https://github.com/marekpridal/LogKit", from: "3.0.0"),
        .package(url: "https://github.com/marekpridal/SwinjectLight", from: "2.0.0"),
        .package(url: "git@github.com:marekpridal/ExpensesKit.git", from: "5.1.0"),

    ],
    targets: [
        .target(name: "SwiftAndroid", dependencies: [
            "HelloSwiftModel",
            .product(name: "SkipUI", package: "skip-ui"),
            .product(name: "LogKit-dynamic", package: "LogKit")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "SwiftAndroidTests", dependencies: [
            "SwiftAndroid",
            .product(name: "SkipTest", package: "skip")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .target(name: "HelloSwiftModel", dependencies: [
            .product(name: "LogKit-dynamic", package: "LogKit"),
            .product(name: "SwinjectLight-dynamic", package: "SwinjectLight"),
            .product(name: "ExpensesKit-dynamic", package: "ExpensesKit"),
            .product(name: "SkipFuse", package: "skip-fuse"),
            .product(name: "SkipModel", package: "skip-model"),
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "HelloSwiftModelTests", dependencies: [
            "HelloSwiftModel",
            .product(name: "SkipTest", package: "skip")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
