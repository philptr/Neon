// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "Neon",
	platforms: [.macOS(.v12), .iOS(.v12), .tvOS(.v12), .watchOS(.v6)],
	products: [
		.library(name: "Neon", targets: ["Neon"]),
	],
	dependencies: [
		.package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.9.0"),
		.package(url: "https://github.com/ChimeHQ/Rearrange", from: "1.6.0"),
	],
	targets: [
		.target(
			name: "Neon",
			dependencies: ["SwiftTreeSitter", "Rearrange", "TreeSitterClient"],
			swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
		),
		.target(name: "TreeSitterClient", dependencies: ["Rearrange", "SwiftTreeSitter"]),
		.target(name: "TestTreeSitterSwift",
				path: "tree-sitter-swift",
				sources: ["src/parser.c", "src/scanner.c"],
				publicHeadersPath: "bindings/swift",
				cSettings: [.headerSearchPath("src")]),
		.testTarget(name: "NeonTests", dependencies: ["Neon"]),
		.testTarget(name: "TreeSitterClientTests", dependencies: ["TreeSitterClient", "TestTreeSitterSwift"])
	]
)
