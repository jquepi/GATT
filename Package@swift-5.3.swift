// swift-tools-version:5.3
import PackageDescription

#if os(Linux)
let libraryType: PackageDescription.Product.Library.LibraryType = .dynamic
#else
let libraryType: PackageDescription.Product.Library.LibraryType = .static
#endif

let package = Package(
    name: "GATT",
    products: [
        .library(
            name: "GATT",
            type: libraryType,
            targets: ["GATT"]
        ),
        .library(
            name: "DarwinGATT",
            type: libraryType,
            targets: ["DarwinGATT"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/Bluetooth.git",
            .branch("master")
        )
    ],
    targets: [
        .target(
            name: "GATT",
            dependencies: [
                "Bluetooth",
                "BluetoothGATT",
                "BluetoothGAP",
                "BluetoothHCI"
            ]
        ),
        .target(
            name: "DarwinGATT",
            dependencies: [
                "GATT",
                "BluetoothGATT"
            ]
        ),
        .testTarget(
            name: "GATTTests",
            dependencies: [
                "GATT",
                "Bluetooth",
                "BluetoothGATT",
                "BluetoothGAP",
                "BluetoothHCI"
            ]
        )
    ]
)
