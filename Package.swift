// swift-tools-version: 6.3

import PackageDescription

let swiftSettings: [SwiftSetting] = [
	.enableExperimentalFeature("Embedded"),
	.enableExperimentalFeature("Extern"),
	.enableExperimentalFeature("Lifetimes"),
	.enableExperimentalFeature("SafeInteropWrappers"),
	.enableExperimentalFeature("Volatile"),
	.enableUpcomingFeature("ExistentialAny"),
	.enableUpcomingFeature("ImmutableWeakCaptures"),
	.enableUpcomingFeature("InternalImportsByDefault"),
	.enableUpcomingFeature("InferIsolatedConformances"),
	.enableUpcomingFeature("MemberImportVisibility"),
	.enableUpcomingFeature("NonisolatedNonsendingByDefault"),
	.strictMemorySafety(),
	.treatAllWarnings(as: .error),
]

let cSettings: [CSetting] = [
	.enableWarning("all"),
	.enableWarning("extra"),
	.disableWarning("unused-command-line-argument"),
	.treatAllWarnings(as: .error),
]

let package = Package(
	name: "swift_os",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.executable(name: "Kernel", targets: ["Kernel"]),
		.library(name: "KernelKit", targets: ["KernelKit"]),
	],
	traits: [
		.default(enabledTraits: ["VIRT"]),
		.trait(name: "RASPI4", enabledTraits: ["RASPI"]),
		.trait(name: "RASPI3", enabledTraits: ["RASPI"]),
		.trait(name: "RASPI2", enabledTraits: ["RASPI"]),
		.trait(name: "RASPI1", enabledTraits: ["RASPI"]),
		.trait(name: "RASPI"),
		.trait(name: "VIRT"),
	],
	dependencies: [
		.package(url: "https://github.com/Lancelotbronner/swift-embedded-arch.git", branch: "main"),
		.package(url: "https://github.com/Lancelotbronner/swift-embedded-graphics.git", branch: "main"),
	],
	targets: [
		// Universal Kernel
		.target(name: "CoreKernel"),
		.target(
			name: "KernelKit",
			dependencies: [
				.product(name: "EmbeddedArch", package: "swift-embedded-arch"),
//				.product(name: "EmbeddedGraphics", package: "swift-embedded-graphics"),
				"CoreKernel",
			],
			swiftSettings: swiftSettings,
		),
		.executableTarget(name: "Kernel", dependencies: [
			.product(name: "EmbeddedArch", package: "swift-embedded-arch"),
			.target(name: "RaspberryPi", condition: .when(traits: ["RASPI"])),
			.target(name: "RaspberryPi", condition: .when(traits: ["VIRT"])),
		]),
		// Platforms
		.target(
			name: "RaspberryPi",
			dependencies: [
				.product(name: "EmbeddedArch", package: "swift-embedded-arch"),
				"KernelKit"
			],
			swiftSettings: swiftSettings,
		),
		.executableTarget(
			name: "Virt",
			dependencies: [
				.product(name: "EmbeddedArch", package: "swift-embedded-arch"),
			],
			swiftSettings: swiftSettings,
		),
		// Userland
		.target(name: "libc", swiftSettings: swiftSettings),
	],
	swiftLanguageModes: [.v6],
	cLanguageStandard: .c2x,
	cxxLanguageStandard: .cxx2b
)
