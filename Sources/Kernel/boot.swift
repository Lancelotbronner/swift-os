#if arch(arm64)
import AsmSupport

@_cdecl("_start")
func _start() {
	let reg = get_mpidr_el1()
	// read cpu id, stop slave cores
	if reg.Aff0 & 0x3 > 0 {
		hang()
	}

	switch get_el().EL {
	case 2: from_el2()
	case 3: from_el3()
	default: break
	}
	hang()
}
#endif
