import EmbeddedArch

@c @export(interface)
func handleCurrentELSP0Sync() -> Never {
	print("Exception: handleCurrentELSP0Sync")
	hang()
}

@c @export(interface)
func handleCurrentELSP0IRQ() -> Never {
	print("Exception: handleCurrentELSP0IRQ")
	hang()
}

@c @export(interface)
func handleCurrentELSP0FIQ() -> Never {
	print("Exception: handleCurrentELSP0FIQ")
	hang()
}

@c @export(interface)
func handleCurrentELSP0SError() -> Never {
	print("Exception: handleCurrentELSP0SError")
	hang()
}

@c @export(interface)
func handleCurrentELSPxSync(esr: ESR, elr: UnsafeMutablePointer<UInt64>) {
	putchar(UInt8(truncatingIfNeeded: 0x30 + esr.EC))
	switch esr.EC {
	case 0x3c:  // brk
		print(" brk #", terminator: "")
		print(esr.ISS.imm16)
		unsafe elr[0] += 4
	case 0x15:  // svc
		print(" svc #", terminator: "")
		print(esr.ISS.imm16)
	default: break
	}
	hang()
}

@c @export(interface)
func handleCurrentELSPxIRQ() -> Never {
	print("Exception: handleCurrentELSPxIRQ")
	hang()
}

@c @export(interface)
func handleCurrentELSPxFIQ() -> Never {
	print("Exception: handleCurrentELSPxFIQ")
	hang()
}

@c @export(interface)
func handleCurrentELSPxSError() -> Never {
	print("Exception: handleCurrentELSPxSError")
	hang()
}

@c @export(interface)
func handleLowerELAArch64Sync() -> Never {
	print("Exception: handleLowerELAArch64Sync")
	hang()
}

@c @export(interface)
func handleLowerELAArch64IRQ() -> Never {
	print("Exception: handleLowerELAArch64IRQ")
	hang()
}

@c @export(interface)
func handleLowerELAArch64FIQ() -> Never {
	print("Exception: handleLowerELAArch64FIQ")
	hang()
}

@c @export(interface)
func handleLowerELAArch64SError() -> Never {
	print("Exception: handleLowerELAArch64SError")
	hang()
}

@c @export(interface)
func handleLowerELAArch32Sync() -> Never {
	print("Exception: handleLowerELAArch32Sync")
	hang()
}

@c @export(interface)
func handleLowerELAArch32IRQ() -> Never {
	print("Exception: handleLowerELAArch32IRQ")
	hang()
}

@c @export(interface)
func handleLowerELAArch32FIQ() -> Never {
	print("Exception: handleLowerELAArch32FIQ")
	hang()
}

@c @export(interface)
func handleLowerELAArch32SError() -> Never {
	print("Exception: handleLowerELAArch32SError")
	hang()
}
