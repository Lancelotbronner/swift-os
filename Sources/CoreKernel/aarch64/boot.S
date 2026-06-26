.section ".text"

.global jump_to_main
jump_to_main:
	// setup the stack
	ldr x0, =__stack_top
	mov sp, x0
	// jump to Swift code, should not return
	bl main
	// for failsafe, halt this core too
hang:
	wfi
	b hang
