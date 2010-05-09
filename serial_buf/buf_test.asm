    .width 100          ;Page width in lst file
    .mmregs             ;Choose reserved names for internal registers
IMASK   .set    19h     ;Enable INT0 and RINT


********************************************************************************
*                   Serial interrupt vector setup                              *
********************************************************************************
* Da der kommer to kanaler laves der to forskellige interrupt routiner hhv. en *
* til den venstre og en til den højre. Første kanal der kommer er venstre så   *
* vectoren skal sættes til venstre routine.                                    *
********************************************************************************
    .sect   "RINT_VEC"  ;RINT_VEC = 1058h in linker command file
    B       RINTL       ;Interrupt routine for serial port recive


    .text
********************************************************************************
*                               VARS                                           *
********************************************************************************


********************************************************************************
*                           Main Program                                       *
********************************************************************************
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
    .sect   "VARS"
*           !!!Do not change order for the following vars!!!                   *
Head    .word    512    ;HeadPtr to serial in buffer
Sout    .word    0      ;Ptr to adr for serial out data
    .data
Stmp1   .word    511    ;Value to and with AC
Stmp2   .word    512    ;Value to add to AC

    .text
RINTR                   ;Interrupt routine for serial port recive (Right)
    LDPK    0           ;Serial req DRR and DXR on page 0               PAGE = 0
    LRLK    AR7,Head    ;
    LRLK    AR5,Stmp1   ;
    LARP    AR7         ;                                                ARP = 7
    LAR     AR6,*,6     ;AR6 = Headptr                                   ARP = 6
    LAC     DRR         ;Read serial in
    SACL    *+,0,7      ;*AR6 = ACL, AR6++                               ARP = 7
    SAR     AR6,*       ;*AR7 = AR6
******** Update headerPtr ********
    LAC     *,0,5       ;Load LAC with *AR7                              ARP = 5
    AND     *+          ;AC & 511, AR5++
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
    LALK    RINTL       ;Load adr for RINTL in AC
    SACL    1059h       ;Save adr for RINTL i vec tabel
    EINT
    RET

********************************************************************************
*           Interrupt routine for serial port recive (Left channel)           *
********************************************************************************
RINTL                   ;Interrupt routine for serial port recive (Left)
******** End RINTL ********
    LALK    RINTR       ;Load adr for RINTR in AC
    SACL    1059h       ;Save adr for RINTR i vec tabel
    EINT
    RET
