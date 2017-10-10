// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "animations-spm",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "animations-spm",
            targets: ["animations-spm"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/typelift/Abstract.git", .revision("a6bf1ba0483e2b7fbd222d332b3a8861753f87ae"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "animations-spm",
            dependencies: ["Abstract"]),
        .testTarget(
            name: "animations-spmTests",
            dependencies: ["animations-spm", "Abstract"]),
    ]
)
