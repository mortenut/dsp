    .width 100          ;Page width in lst file
    .mmregs             ;Choose reserved names for internal registers
********************************************************************************
*   +-----------------------------------+
*   |  5  |  4  |  3  |  2  |  1  |  0  |
*   +-----------------------------------+
*   | XINT| RINT| TINT| INT2| INT1| INT1|
*   +-----------------------------------+
********************************************************************************
*IMASK   .set    19h     ;Enable INT0, RINT amd TINT
IMASK   .set    1h     ;Enable INT0

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

******** ALU setup ********


******** Set B0 to program and move hanning values ********
    LRLK    AR1,600h    ;
    LARP    AR1         ;
    RPTK    159         ;
    BLKP    datatest,*+ ;
*    CONF    1          ;

******** Interrupt enable ********
    EINT				;Enable interrupt

LOOP
*    CALL MOVHANN
    CALL    MoveBuf
    NOP
    NOP
    B       LOOP

    .sect "data"
datatest
test0 .word 07FFh
test1 .word 07FFh
test2 .word 07FFh
test3 .word 07FFh
test4 .word 07FFh
test5 .word 07FFh
test6 .word 07FFh
test7 .word 07FFh
test8 .word 07FFh
test9 .word 07FFh
test10 .word 07FFh
test11 .word 07FFh
test12 .word 07FFh
test13 .word 07FFh
test14 .word 07FFh
test15 .word 07FFh
test16 .word 07FFh
test17 .word 07FFh
test18 .word 07FFh
test19 .word 07FFh
test20 .word 07FFh
test21 .word 07FFh
test22 .word 07FFh
test23 .word 07FFh
test24 .word 07FFh
test25 .word 07FFh
test26 .word 07FFh
test27 .word 07FFh
test28 .word 07FFh
test29 .word 07FFh
test30 .word 07FFh
test31 .word 07FFh
test32 .word 07FFh
test33 .word 07FFh
test34 .word 07FFh
test35 .word 07FFh
test36 .word 07FFh
test37 .word 07FFh
test38 .word 07FFh
test39 .word 07FFh
test40 .word 07FFh
test41 .word 07FFh
test42 .word 07FFh
test43 .word 07FFh
test44 .word 07FFh
test45 .word 07FFh
test46 .word 07FFh
test47 .word 07FFh
test48 .word 07FFh
test49 .word 07FFh
test50 .word 07FFh
test51 .word 07FFh
test52 .word 07FFh
test53 .word 07FFh
test54 .word 07FFh
test55 .word 07FFh
test56 .word 07FFh
test57 .word 07FFh
test58 .word 07FFh
test59 .word 07FFh
test60 .word 07FFh
test61 .word 07FFh
test62 .word 07FFh
test63 .word 07FFh
test64 .word 07FFh
test65 .word 07FFh
test66 .word 07FFh
test67 .word 07FFh
test68 .word 07FFh
test69 .word 07FFh
test70 .word 07FFh
test71 .word 07FFh
test72 .word 07FFh
test73 .word 07FFh
test74 .word 07FFh
test75 .word 07FFh
test76 .word 07FFh
test77 .word 07FFh
test78 .word 07FFh
test79 .word 07FFh
test80 .word 07FFh
test81 .word 07FFh
test82 .word 07FFh
test83 .word 07FFh
test84 .word 07FFh
test85 .word 07FFh
test86 .word 07FFh
test87 .word 07FFh
test88 .word 07FFh
test89 .word 07FFh
test90 .word 07FFh
test91 .word 07FFh
test92 .word 07FFh
test93 .word 07FFh
test94 .word 07FFh
test95 .word 07FFh
test96 .word 07FFh
test97 .word 07FFh
test98 .word 07FFh
test99 .word 07FFh
test100 .word 07FFh
test101 .word 07FFh
test102 .word 07FFh
test103 .word 07FFh
test104 .word 07FFh
test105 .word 07FFh
test106 .word 07FFh
test107 .word 07FFh
test108 .word 07FFh
test109 .word 07FFh
test110 .word 07FFh
test111 .word 07FFh
test112 .word 07FFh
test113 .word 07FFh
test114 .word 07FFh
test115 .word 07FFh
test116 .word 07FFh
test117 .word 07FFh
test118 .word 07FFh
test119 .word 07FFh
test120 .word 07FFh
test121 .word 07FFh
test122 .word 07FFh
test123 .word 07FFh
test124 .word 07FFh
test125 .word 07FFh
test126 .word 07FFh
test127 .word 07FFh
test128 .word 07FFh
test129 .word 07FFh
test130 .word 07FFh
test131 .word 07FFh
test132 .word 07FFh
test133 .word 07FFh
test134 .word 07FFh
test135 .word 07FFh
test136 .word 07FFh
test137 .word 07FFh
test138 .word 07FFh
test139 .word 07FFh
test140 .word 07FFh
test141 .word 07FFh
test142 .word 07FFh
test143 .word 07FFh
test144 .word 07FFh
test145 .word 07FFh
test146 .word 07FFh
test147 .word 07FFh
test148 .word 07FFh
test149 .word 07FFh
test150 .word 07FFh
test151 .word 07FFh
test152 .word 07FFh
test153 .word 07FFh
test154 .word 07FFh
test155 .word 07FFh
test156 .word 07FFh
test157 .word 07FFh
test158 .word 07FFh
test159 .word 07FFh


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
*       Move data from tmp buffer and shape with hanning window                *
********************************************************************************
MOVHANN
    .newblock
    LRLK    AR0,303
    LRLK    AR1,400h        ;Change adr to adr 400h
    LRLK    AR2,hanning
    LRLK    AR3,1024+161
    LARK    AR4,15
    LARP    AR1
    SPM     0
$1  LT      *+,AR2
    MPY     *+,AR3
    SPH     *+,AR4
    BANZ    $2,*-
        LARK    AR4,15
        LARP    AR1
        SBRK    8
        LARP    AR2
        SBRK    16
$2  LARP    AR0
    BANZ    $1,*-,AR1
        SPM 0
        RET

********************************************************************************
*       Move data from input buffer to tmp buffer                              *
********************************************************************************
MoveBuf
    .sect "VARS"
Tail    .word   0       ;Var to store ptr to buffer end read adr
MoveTmp .word   0       ;Var to store tmp data
    .text
    .newblock
    LRLK    AR1,Head    ;Load AR1 with ptr to in buffer head
    LRLK    AR2,Tail    ;Load AR2 with Tail adr
    LRLK    AR3,400h    ;Load AR3 with B1 start adr
    LRLK    AR4,MoveTmp ;Load AR4 with adr MoveTmo adr
******** Calculate tail adr ********
    LARP    AR1         ;                                                ARP = 1
    LALK    352         ;AC = 352
    ADD     *,0,AR2     ;AC = 352 + Head                                 ARP = 2
    ANDK    Stmp1       ;AC &= Stmp1 (511)
    ADDK    Stmp2       ;AC +0 Stmp2 (1536)
    SACL    *,0,AR1     ;*AR2 = Tail adr                                 ARP = 1
******** Test Tail < Head ********
    SUB     *,0,AR3     ;AC = Tail - Head                                ARP = 3
    BGEZ    $1
******** If tail < head ********
        RPTK    159     ;Rpt 160 times to move from in buf to tmp buf
        BLKD    Tail,*+ ;
        RET             ;Done return
******** Else ********
******** Calc distance to buffer end from tail ********    
$1      LALK    2047    ;End adr in buffer - 1 do to RPTK (1536+512-1)
        LARP    AR2     ;AR2 = Tail                                      ARP = 2
        SUB     *,0,AR4 ;AC -= Tail                                      ARP = 4
        SACL    *       ;Save distance from tail to buf end
******** Move data from tail to buf end ********
        RPT     *,AR3   ;Rpt data copy from tail to buf end              ARP = 3
        BLKD    Tail,*+,AR1;Move data                                    ARP = 1
******** Calc distance from buf start to head minus one do to RPTK *******
        LAC     *,0,AR4 ;Load AC with Head                               ARP = 4
        SUB     1       ;AC -= 1
        SACL    *       ;Save Rpt times at *AR4
        RPT     *,AR3   ;                                                ARP = 2
        BLKD    600h,*+ ;Move data from in buf 0 to in buf head to tmp buf
        RET             ;Done return


********************************************************************************
*           Interrupt routine for serial port recive (Right channel)           *
********************************************************************************
    .sect   "VARS"
*           !!!Do not change order for the following vars!!!                   *
Head    .word    6A5h   ;HeadPtr to serial in buffer (tmp 600 = 6A5)
Sout    .word    0      ;Ptr to adr for serial out data
    .data
Stmp1   .word    511    ;Value to and with AC
Stmp2   .word    1536   ;Value to add to AC

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
    AND     *+          ;AC & 511, AR5++ (AR5 = Stmp2)
    ADD     *-,0,7      ;AC += 1536, AR5-- (AR5 = Stmp1)                 ARP = 7
******** HeadPtr save ********
    SACL    *+,0,5      ;*AR7 = AC AR7++                                 ARP = 5
******** Output ADR calc ********
    ADLK    351         ;AC += 352
    AND     *+          ;AC & 511, AR5++ (AR5 = Stmp2)
    ADD     *-,0,7      ;AC += 1536, AR5-- (AR5 = Stmp1)                 ARP = 7
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
