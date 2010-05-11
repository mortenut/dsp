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
    B       RINTR       ;Interrupt routine for serial port recive


    .text
********************************************************************************
*                               VARS                                           *
********************************************************************************


********************************************************************************
*                           Main Program                                       *
********************************************************************************
	LALK	IMASK		;Interrupt mask
	SACL	IMR			;Adress for IMR

******** Serial setup ********
	FORT	0			;Set serial word size to 16 bit
	RTXM				;Set FSX as an input
	RFSM				;Burst-Mode Operation

******** Set B0 to program and move hanning values ********
*    LRLK    AR1,200h    ;
*    LARP    AR1         ;
*    RPTK    15          ;
*    BLKP    hanning,*+  ;
*    CONF    1           ;

******** Interrupt enable ********
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
*       Values for hanning window                                              *
********************************************************************************
    .data
hanning
H0  .word    1106
H1  .word    4276
H2  .word    9081
H3  .word   14872
H4  .word   20867
H5  .word   26257
H6  .word   30313
H7  .word   32484
H8  .word   32484
H9  .word   30313
H10 .word   26257
H11 .word   20867
H12 .word   14872
H13 .word    9081
H14 .word    4276
H15 .word    1106



********************************************************************************
*       Move data from buffer and shape with hanning window                    *
********************************************************************************
MOVHANN



********************************************************************************
*           Interrupt routine for serial port recive (Right channel)           *
********************************************************************************
    .sect   "VARS"
*           !!!Do not change order for the following vars!!!                   *
Head    .word    600h    ;HeadPtr to serial in buffer
Sout    .word    0      ;Ptr to adr for serial out data
    .data
Stmp1   .word    511    ;Value to and with AC
Stmp2   .word    1536    ;Value to add to AC

    .text
RINTR                   ;Interrupt routine for serial port recive (Right)
******** Set page and ARP ********
    LDPK    0           ;Serial req DRR and DXR on page 0               PAGE = 0
    LRLK    AR7,Head    ;
    LRLK    AR5,Stmp1   ;
    LARP    AR7         ;                                                ARP = 7
******** Serial in ********
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
    LAC     *,0,2       ;AC = * AR6                                      ARP = 2
    SACL    DXR         ;Serial out
******** End RINTR ********
    LRLK    AR2,1059h
    LALK    RINTL       ;Load adr for RINTL in AC
    SACL    *       ;Save adr for RINTL i vec tabel
    EINT
    RET

********************************************************************************
*           Interrupt routine for serial port recive (Left channel)           *
********************************************************************************
RINTL                   ;Interrupt routine for serial port recive (Left)
    LDPK    0           ;Serial req DRR and DXR on page 0               PAGE = 0
    LAC     DRR         ;Read serial in
    SACL    DXR         ;Serial out
******** End RINTL ********
    LRLK    AR2,1059h
    LARP    AR2
    LALK    RINTR       ;Load adr for RINTR in AC
    SACL    *           ;Save adr for RINTR i vec tabel
    EINT
    RET
