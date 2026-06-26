import EmbeddedArch
import _Volatile

let uart = unsafe VolatileMappedRegister<UInt8>(unsafeBitPattern: 0x09000000)

@c(_start) @section(".text.boot")
func _start() {
	set_sp(ImageLayout.topOfStack)
	print("Hello, World!")
}

@c @export(interface)
private func putchar(_ c: UInt8) {
	uart.store(c)
}
