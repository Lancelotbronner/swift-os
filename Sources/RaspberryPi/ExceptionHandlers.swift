private import KernelKit
import EmbeddedArch

@c @export(interface)
func handleCurrentELSP0Sync() -> Never {
	print("Exception: handleCurrentELSP0Sync")
	repeat { halt() } while true
}

@c @export(interface)
func handleCurrentELSP0IRQ() -> Never {
	print("Exception: handleCurrentELSP0IRQ")
	repeat { halt() } while true
}

@c @export(interface)
func handleCurrentELSP0FIQ() -> Never {
	print("Exception: handleCurrentELSP0FIQ")
	repeat { halt() } while true
}

@c @export(interface)
func handleCurrentELSP0SError() -> Never {
	print("Exception: handleCurrentELSP0SError")
	repeat { halt() } while true
}

@c @export(interface)
func handleCurrentELSPxSync(esr: ESR, elr: UnsafeMutablePointer<UInt64>) {
	switch esr.EC {
	case 0x3c:  // brk
		print("Exception: handleCurrentELSPxSync: brk #", terminator: "")
		print(esr.ISS.imm16)
		unsafe elr[0] += 4
	case 0x15:  // svc
		print("Exception: handleCurrentELSPxSync: svc #", terminator: "")
		print(esr.ISS.imm16)
	case _:
		print("Exception: handleCurrentELSPxSync: ", terminator: "")
		print(esr.EC)
		repeat { halt() } while true
	}
}

@c @export(interface)
func handleCurrentELSPxIRQ() -> Never {
	print("Exception: handleCurrentELSPxIRQ")
	repeat { halt() } while true
}

@c @export(interface)
func handleCurrentELSPxFIQ() -> Never {
	print("Exception: handleCurrentELSPxFIQ")
	repeat { halt() } while true
}

@c @export(interface)
func handleCurrentELSPxSError() -> Never {
	print("Exception: handleCurrentELSPxSError")
	repeat { halt() } while true
}

@c @export(interface)
func handleLowerELAArch64Sync() -> Never {
	print("Exception: handleLowerELAArch64Sync")
	repeat { halt() } while true
}

@c @export(interface)
func handleLowerELAArch64IRQ() -> Never {
	print("Exception: handleLowerELAArch64IRQ")
	repeat { halt() } while true
}

@c @export(interface)
func handleLowerELAArch64FIQ() -> Never {
	print("Exception: handleLowerELAArch64FIQ")
	repeat { halt() } while true
}

@c @export(interface)
func handleLowerELAArch64SError() -> Never {
	print("Exception: handleLowerELAArch64SError")
	repeat { halt() } while true
}

@c @export(interface)
func handleLowerELAArch32Sync() -> Never {
	print("Exception: handleLowerELAArch32Sync")
	repeat { halt() } while true
}

@c @export(interface)
func handleLowerELAArch32IRQ() -> Never {
	print("Exception: handleLowerELAArch32IRQ")
	repeat { halt() } while true
}

@c @export(interface)
func handleLowerELAArch32FIQ() -> Never {
	print("Exception: handleLowerELAArch32FIQ")
	repeat { halt() } while true
}

@c @export(interface)
func handleLowerELAArch32SError() -> Never {
	print("Exception: handleLowerELAArch32SError")
	repeat { halt() } while true
}
