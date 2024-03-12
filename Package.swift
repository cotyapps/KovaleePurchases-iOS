// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KovaleePurchases",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "KovaleePurchases",
            targets: [
                "KovaleePurchases",
            ]
        ),
    ],
    dependencies: [
        //		.package(url: "https://github.com/cotyapps/Kovalee-iOS-SDK", from: Version(1, 5, 4)),
        .package(url: "https://github.com/cotyapps/Kovalee-iOS-SDK", branch: "web2app"), // TODO: restore to main branch release
        .package(url: "https://github.com/cotyapps/KovaleeAttribution-iOS", from: Version(1, 0, 0)),
        .package(url: "https://github.com/RevenueCat/purchases-ios", from: Version(4, 25, 0)),
    ],
    targets: [
        .target(
            name: "KovaleePurchases",
            dependencies: [
                .product(name: "KovaleeSDK", package: "Kovalee-iOS-SDK"),
                .product(name: "KovaleeAttribution", package: "KovaleeAttribution-iOS"),
                .product(name: "RevenueCat", package: "purchases-ios"),
            ]
        ),
    ]
)
