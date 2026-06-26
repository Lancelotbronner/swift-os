@_extern(c, "__kernel_start") @usableFromInline
nonisolated(unsafe) var kernelStartHead: UInt8
@_extern(c, "__kernel_end") @usableFromInline
nonisolated(unsafe) var kernelEndHead: UInt8
@_extern(c, "__bss_start") @usableFromInline
nonisolated(unsafe) var bssStartHead: UInt8
@_extern(c, "__bss_end") @usableFromInline
nonisolated(unsafe) var bssEndHead: UInt8
@_extern(c, "__stack_start") @usableFromInline
nonisolated(unsafe) var stackStartHead: UInt8
@_extern(c, "__stack_end") @usableFromInline
nonisolated(unsafe) var stackEndHead: UInt8
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
	static var stackStart: UInt {
		unsafe withUnsafePointer(to: &stackStartHead, UInt.init(bitPattern:))
	}
	@_transparent
	static var stackEnd: UInt {
		unsafe withUnsafePointer(to: &stackEndHead, UInt.init(bitPattern:))
	}
	@_transparent
	static var kernelImageEnd: UInt {
		unsafe withUnsafePointer(to: &kernelImageEndHead, UInt.init(bitPattern:))
	}
}
