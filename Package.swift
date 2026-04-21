// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MaterialComponents",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "MaterialComponents",
            targets: ["MaterialComponents"]
        ),
    ],
    targets: [
        .target(
            name: "MaterialComponents",
            path: "Sources/MaterialComponents",
            resources: [
                .copy("Resources/MaterialActionSheet.bundle"),
                .copy("Resources/MaterialActivityIndicator.bundle"),
                .copy("Resources/MaterialAppBar.bundle"),
                .copy("Resources/MaterialCollectionCells.bundle"),
                .copy("Resources/MaterialCollections.bundle"),
                .copy("Resources/MaterialDialogs.bundle"),
                .copy("Resources/MaterialPageControl.bundle"),
                .copy("Resources/MaterialProgressView.bundle"),
                .copy("Resources/MaterialSnackbar.bundle"),
                .copy("Resources/MaterialTextFields.bundle"),
                .process("Resources/MaterialIcons_ic_arrow_back.xcassets"),
                .process("Resources/MaterialIcons_ic_check.xcassets"),
                .process("Resources/MaterialIcons_ic_check_circle.xcassets"),
                .process("Resources/MaterialIcons_ic_chevron_right.xcassets"),
                .process("Resources/MaterialIcons_ic_color_lens.xcassets"),
                .process("Resources/MaterialIcons_ic_feedback.xcassets"),
                .process("Resources/MaterialIcons_ic_help_outline.xcassets"),
                .process("Resources/MaterialIcons_ic_info.xcassets"),
                .process("Resources/MaterialIcons_ic_more_horiz.xcassets"),
                .process("Resources/MaterialIcons_ic_radio_button_unchecked.xcassets"),
                .process("Resources/MaterialIcons_ic_reorder.xcassets"),
                .process("Resources/MaterialIcons_ic_settings.xcassets"),
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .headerSearchPath("include/MaterialComponents"),
            ]
        ),
    ]
)
