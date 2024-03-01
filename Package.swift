// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "OpenMultitouchSupport",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "OpenMultitouchSupport",
            targets: ["OpenMultitouchSupport"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "OpenMultitouchSupportXCF",
            path: "Framework/Product/OpenMultitouchSupportXCF.xcframework"
        ),
        .target(
            name: "OpenMultitouchSupport",
            dependencies: ["OpenMultitouchSupportXCF"]
        )
    ]
)
