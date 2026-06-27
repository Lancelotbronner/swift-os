import _Volatile
import EmbeddedArch
import CoreKernel

let uart = unsafe VolatileMappedRegister<UInt8>(unsafeBitPattern: 0x0900_0000)

@c @section(".text.boot")
func _start() {
	set_sp(ImageLayout.topOfStack)
	let reg = get_mpidr_el1()
	// read cpu id, stop slave cores
	if reg.Aff0 == 0 {
		primary()
	}
	hang()
}

@inline(never)
private func primary() {
//	let elr = get_CurrentEL()
//	switch elr.el {
//	case 2:
//		var hcr = HCR()
//		hcr.rw = true
//		set_hcr_el2(hcr)
//
//		zero_cntvoff_el2()
//
//		var spsr = SPSR()
//		// EL1h
//		spsr.m_4_0_ = 5
//		// mask DAIF
//		spsr.e = true
//		spsr.a = true
//		spsr.i = true
//		spsr.f = true
//		// set return level to EL1
//		set_spsr_el2(spsr)
//
//		// disable SIMD/FP traps
//		set_cptr_el2(CPTR_EL2())
//
//		set_elr_el2(_main)
//		isb_eret()
//	case 3:
//		var hcr = HCR()
//		hcr.rw = true
//		set_hcr_el2(hcr)
//
//		var scr = SCR_EL3()
//		// disable trapping of timer control registers
//		scr.rw = true
//		// next lower EL in aarch64
//		scr.st = true
//		set_scr_el3(scr)
//
//		var spsr = SPSR()
//		// EL1h
//		spsr.m_4_0_ = 5
//		// mask DAIF
//		spsr.e = true
//		spsr.a = true
//		spsr.i = true
//		spsr.f = true
//		// set return level to EL1
//		set_spsr_el3(spsr)
//
//		set_elr_el3(_main)
//		isb_eret()
//	default:
//		break
//	}
	register_vector_table()
	_main()
}

@c  @inline(never)
func _main() {
	print("Hello, world!")
	hang()
}

@c
func putchar(_ c: UInt8) {
	uart.store(c)
}
