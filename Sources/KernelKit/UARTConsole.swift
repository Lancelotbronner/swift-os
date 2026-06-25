public struct UARTConsole<T: ~Copyable & UART> : ~Copyable, Console {
	public let uart: T

	@inlinable @_transparent
	public init(uart: consuming T) {
		self.uart = uart
	}
}

public extension UARTConsole where T: ~Copyable {
	@inlinable @_transparent
	func write(_ c: UInt8) {
		self.uart.putchar(c)
	}
}
