// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "KituraExample",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura", from: "2.6.0"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
        .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", from: "1.11.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CredentialsHTTP.git", from: "2.1.2")
    ],
    targets: [
        .target(
            name: "KituraExample",
            dependencies: ["Kitura", .target(name: "Application"), "HeliumLogger"]),
        .target(
            name: "Application",
            dependencies: ["Kitura", "KituraStencil", "CredentialsHTTP", "HeliumLogger"]),
        .testTarget(
            name: "KituraExampleTests",
            dependencies: ["Kitura", .target(name: "Application"), "HeliumLogger"]),
    ]
)
