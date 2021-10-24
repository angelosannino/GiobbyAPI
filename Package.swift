// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let moduleName = "GiobbyAPI"
let testModuleName = "GiobbyAPITests"

let remoteDependancies = false

let constants = "Constants"
var constantsPath: String {
    if remoteDependancies {
        return "https://github.com/angelosannino/Constants.git"
    }
    return "../Constants"
}
let extensions = "Extensions"
var extensionsPath: String {
    if remoteDependancies {
        return "https://github.com/angelosannino/Extensions.git"
    }
    return "../Extensions"
}

var packageDependancies: [Package.Dependency] {
    if remoteDependancies {
        return [
            .package(name: constants, url: constantsPath, from: "0.1.0"),
            .package(name: extensions, url: extensionsPath, from: "0.1.0")
        ]
    }
    return [
        .package(path: constantsPath),
        .package(path: extensionsPath)
    ]
}
var targetDependancies: [Target.Dependency] {
    if remoteDependancies {
        return [
            .product(name: constants, package: constants),
            .product(name: extensions, package: extensions)
        ]
    }
    return [
        .byName(name: constants),
        .byName(name: extensions)
    ]
}

let package = Package(
    name: moduleName,
    products: [
        .library(
            name: moduleName,
            targets: [moduleName]),
    ],
    dependencies: packageDependancies,
    /* *** LOCAL DEPENDANCIES
     [
        .package(path: constantsPath),
        .package(path: extensionsPath)
     ],
    */
    /* *** REMOTE DEPENDANCIES ***
     [
        .package(name: constants, url: remoteConstantsPath, from: "0.1.0"),
        .package(name: extensions, url: remoteExtensionsPath, from: "0.1.0")
     ],
    */
    targets: [
        .target(
            name: moduleName,
            dependencies: targetDependancies),
                /* *** LOCAL DEPENDANCIES ***
                [
                .byName(name: constants),
                .byName(name: extensions)
                 ]),
                 */
                /* *** REMOTE DEPENDANCIES ***
                 [
                .product(name: constants, package: constants),
                .product(name: extensions, package: extensions)
                 ]),
                 */
        .testTarget(
            name: testModuleName,
            dependencies: [
                .byName(name: moduleName)
            ]),
    ],
    swiftLanguageVersions: [
        .version("5.5")
    ]
)
