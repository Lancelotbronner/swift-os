.section ".text"

.global jump_to_main
jump_to_main:
	// enable SIMD/FP access
	mrs x0, cpacr_el1
	orr x0, x0, #(3 << 20)
	msr cpacr_el1, x0
	isb
	// setup the stack
	ldr x0, =__stack_top
	mov sp, x0
	// jump to Swift code, should not return
	bl main
	// for failsafe, halt this core too
hang:
	wfi
	b hang
