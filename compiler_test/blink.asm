**********************************************************
*
*       Dette er et lille demoprogram til brug af
*       TMS32025 Assambler/Linker/simulator mm.
*       Samt D/M32025  funktion: Lysdioden blinker
*
*       Programmer gemmes under <BLINK.ASM>
*       Oversæt programmet med: doall2x.bat <filnavn.asm>
*       Indtast:doall2x.bat blink.asm[ENTER]
*       doall2x kalder/udfører:
*                Kopierer <filnavn>      til test.asm
*                kopierer gamle test.*   til bak.*
*                
*                Kalder:
*
*                Assembler der genererer test.obj        objekt-fil
*                                        test.lst        listfil
*
*                Linker   -------------- test.out        linket objekt-fil
*                                        test.map        linker map-fil
*                Dsphex   -------------- test.hex        Intel hex fil download
*
*        Herefter kan programmet downloades vha. et terminalprogram f.eks Terminal
*		[Alt]v
*		 Send tekstfil
*		  find det direktorie hvor programmet findes
*		   i filnavn skrives:  test.hex[CR] ;programmet nedlæses
*	
*
*                       indtast: ? (se om download gik godt => 	#OK 
*								1100 (1. adresse nedlæst til)
*                       G1100[enter] (starter programmet)
*                               lysdioden skal nu blinke 
*
*
**********************************************************

	 .text
DELAY    .set      00CFFH    ;DELAY TID
LED      .set      060H      ;ADR FOR OUTPUT

INIT	LDPK      0         ;PAGEPOINTER = 0
		LALK      0FFFFH    ;
		SACL      LED       ;
		OUT       LED,15    ;
		CALL      LOOP      ;
		LALK      08000H    ;
		SACL      LED       ;DAC:=0
		OUT       LED,15    ;
		CALL      LOOP      ;
		B         INIT      ;START FORFRA

LOOP     LALK      DELAY,5   ;
LOOP1    SUBK      1         ;DELAY RUTINE
	 BNZ       LOOP1
	 RET
	 .end
