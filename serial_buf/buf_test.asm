	.width 80
IMASK	.set	19h			;Enable INT0 and RINT

	.sect	"RINT_VEC"	;RINT_VEC = 1058h in linker command file
	B    	RINTR		;Interrupt routine for serial port recive


	.text

HEAD    .word    512
Tail    .word    0
Atmp    .word    511
tmp2    .word    512

	.mmregs				;Choose reserved names for internal registers
	LALK	IMASK		;Interrupt mask
	SACL	IMR			;Adress for IMR
	FORT	0			;Set serial word size to 16 bit
	RTXM				;Set FSX as an input
	RFSM				;Burst-Mode Operation
	EINT				;Enable interrupt

LOOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    B       LOOP

********************************************************************************
*           Interrupt routine for serial port recive (Right channel)           *
********************************************************************************
RINTR                   ;Interrupt routine for serial port recive
    LDPK    0           ;Serial req DRR and DXR on page 0               PAGE = 0
    LRLK    AR7,HEAD    ;
    LRLK    AR5,Atmp    ;
    LARP    AR7         ;                                                ARP = 7
    LAR     AR6,*,6     ;AR6 = Headptr                                   ARP = 6
    LAC     DRR         ;Read serial in
    SACL    *+,0,7      ;*AR6 = ACL, AR6++                               ARP = 7
    SAR     AR6,*       ;*AR7 = AR6
******** Update headerPtr ********
    LAC     *,0,5       ;Load LAC with *AR7                              ARP = 5
    AND     *+          ;AC & 511, AR5++
    NOP
    NOP
    NOP
    NOP
    ADD     *-,0,7      ;AC += 512, AR5--                                ARP = 7
******** HeadPtr save ********
    SACL    *+,0,5      ;*AR7 = AC AR7++                                 ARP = 5
******** Output ADR calc ********
    ADLK    351         ;AC += 352
    AND     *+          ;AC & 511, AR5++
    ADD     *-,0,7      ;AC += 512, AR5--                                ARP = 7
******** Output ADR save ********
    SACL *              ;Save output ADR at 2001h
******** Load and output data ********
    LAR     AR6,*,6     ;AR6 = *AR7 (Output ptr)                         ARP = 6
    LAC     *           ;AC = * AR6
    SACL    DXR         ;Serial out
******** End RINTR ********
    EINT
    RET
