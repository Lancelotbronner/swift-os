@_extern(c, "__kernel_start") @usableFromInline
nonisolated(unsafe) var kernelStartHead: UInt8
@_extern(c, "__kernel_end") @usableFromInline
nonisolated(unsafe) var kernelEndHead: UInt8
@_extern(c, "__bss_start") @usableFromInline
nonisolated(unsafe) var bssStartHead: UInt8
@_extern(c, "__bss_end") @usableFromInline
nonisolated(unsafe) var bssEndHead: UInt8
@_extern(c, "__stack_top") @usableFromInline
nonisolated(unsafe) var __stack_top: UInt8
@_extern(c, "__stack_bottom") @usableFromInline
nonisolated(unsafe) var __stack_bottom: UInt8
@_extern(c, "__kernel_image_end") @usableFromInline
nonisolated(unsafe) var kernelImageEndHead: UInt8

public enum ImageLayout {}

public extension ImageLayout {
	@_transparent
	static var kernelStart: UInt {
		unsafe withUnsafePointer(to: &kernelStartHead, UInt.init(bitPattern:))
	}
	@_transparent
	static var kernelEnd: UInt {
		unsafe withUnsafePointer(to: &kernelEndHead, UInt.init(bitPattern:))
	}
	@_transparent
	static var bssStart: UInt {
		unsafe withUnsafePointer(to: &bssStartHead, UInt.init(bitPattern:))
	}
	@_transparent
	static var bssEnd: UInt {
		unsafe withUnsafePointer(to: &bssEndHead, UInt.init(bitPattern:))
	}
	@_transparent
	static var topOfStack: UInt {
		unsafe withUnsafePointer(to: &__stack_top, UInt.init(bitPattern:))
	}
	@_transparent
	static var bottomOfStack: UInt {
		unsafe withUnsafePointer(to: &__stack_bottom, UInt.init(bitPattern:))
	}
	@_transparent
	static var kernelImageEnd: UInt {
		unsafe withUnsafePointer(to: &kernelImageEndHead, UInt.init(bitPattern:))
	}
}
