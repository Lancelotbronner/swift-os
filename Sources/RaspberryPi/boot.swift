import KernelKit
public import EmbeddedArch

@c(_start) @section(".text.boot")
func _start() {
	//FIXME: the processor traps on the prologue
	/*
	 stp    fp, lr, [sp, #-0x10]!
	 mov    fp, sp
	 */

	let reg = get_mpidr_el1()
	// read cpu id, stop slave cores
	if reg.Aff0 & 0x3 == 0 {
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

@c
private func jump_to_main() {
	set_sp(ImageLayout.topOfStack)
	RaspberryPi().main()
	hang()
}
