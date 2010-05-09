IMASK	.set	19h			;Enable INT0 and RINT

	.sect	"RINT_VEC"	;RINT_VEC = 1058h in linker command file
	B    	RINTR		;Interrupt routine for serial port recive


	.text
	.mmregs				;Choose reserved names for internal registers
	LALK	IMASK		;Interrupt mask
	SACL	IMR			;Adress for IMR
	FORT	0			;Set serial word size to 16 bit
	RTXM				;Set FSX as an input
	RFSM				;Burst-Mode Operation
	EINT				;Enable interrupt
LOOP
	NOP
	B   	LOOP

*	Interrupt routine for serial port recive								   *
********************************************************************************
RINTR					;Interrupt routine for serial port recive
	LDPK	0			;PAGEPOINTER = 0
	LAC		DRR,0
	SACL	DXR			;Move serial in to serial out
	EINT				;Enable interrupt and
	RET 				;return from interrupt
