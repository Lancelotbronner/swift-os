import KernelKit
import EmbeddedArch

@c(_start) @section(".text.boot")
func _start() {
	let reg = get_mpidr_el1()
	// read cpu id, stop slave cores
	if reg.Aff0 == 0 {
		primary()
	}
	hang()
}

@_transparent
private func primary() {
	let elr = get_CurrentEL()
	switch elr.el {
	case 2:
		var hcr = HCR()
		hcr.rw = true
		set_hcr_el2(hcr)

		zero_cntvoff_el2()

		var spsr = SPSR()
		// EL1h
		spsr.m_4_0_ = 5
		// mask DAIF
		spsr.e = true
		spsr.a = true
		spsr.i = true
		spsr.f = true
		// set return level to EL1
		set_spsr_el2(spsr)

		// disable SIMD/FP traps
		set_cptr_el2(CPTR_EL2())

		set_elr_el2(jump_to_main)
		isb_eret()
	case 3:
		var hcr = HCR()
		hcr.rw = true
		set_hcr_el2(hcr)

		var scr = SCR_EL3()
		// disable trapping of timer control registers
		scr.rw = true
		// next lower EL in aarch64
		scr.st = true
		set_scr_el3(scr)

		var spsr = SPSR()
		// EL1h
		spsr.m_4_0_ = 5
		// mask DAIF
		spsr.e = true
		spsr.a = true
		spsr.i = true
		spsr.f = true
		// set return level to EL1
		set_spsr_el3(spsr)

		set_elr_el3(jump_to_main)
		isb_eret()
	default:
		break
	}
}

/*
 @c
 private func jump_to_main() {
 //FIXME: the processor traps on the prologue
 // That's because it uses @c, I can't not use @c because I need it to be an address
 /*
  stp    fp, lr, [sp, #-0x10]!
  mov    fp, sp
  */

 set_sp(ImageLayout.topOfStack)
 RaspberryPi().main()
 hang()
 }
 */

public func main() {
	// enable SIMD/FP access
	var cpacr = get_cpacr_el1()
	cpacr.FPEN = 0b11
	set_cpacr_el1(cpacr)
	isb()

	register_vector_table()
	zeroBSS()

	let _ = UARTConsole(uart: UART0())

	// Initialise the GIC-400 interrupt controller before enabling
	// any device interrupts.
	initGIC()
	// Enable the UART0 SPI in the GIC Distributor so receive
	// interrupts can reach the CPU.
	gicEnableIRQ(gicUART0SPI)

	print("Hello Swift!")

	let memoryManager = MemoryManager()
	print("RAM:", terminator: " ")
	print(memoryManager.total / 1024 / 1024, terminator: " ")
	print("MiB")

	let fb = RPiFramebuffer<UInt32>(width: 1920, height: 1080, pixelOrder: .rgb)
	var g = Graphics(target: fb)
	g.fillRect(x0: 0, y0: 0, x1: 100, y1: 100, color: 0xffffff)
	g.drawString("Hello Swift!", x: 0, y: 100, color: 0xffffff)

	let elr = get_CurrentEL()
	let elLabel: StaticString = "Exception Level:"
	print(elLabel, terminator: " ")
	print(elr.el)
	g.drawString(elLabel, x: 0, y: 108, color: 0xffffff)
	for i in 0..<Int(elr.el) {
		g.drawString("I", x: (elLabel.utf8CodeUnitCount + i) * 8, y: 108, color: 0xffffff)
	}

	repeat { halt() } while true
}

