/*************************************************************/
/*    linker command file til TMS320c26 9/4-97 sbn           */
/*    Foruds‘tter program-filer i samme direktorie som doall */
/*************************************************************/

MEMORY
{
    PAGE 0 :            /* PROGRAM MEMORY fra 01000h - 0FFFFh*/
/*	 INTS      : origin = 01052h , length  =  0Ch */
/*	 TINT	   : origin = 01056h , length  =  02h */
	 RINT      : origin = 01058h , length  =  02h
/*	 SINT	   : origin = 0105Ch , length  =  02h */
	 Prog_RAM  : origin = 01100h , length  =  06000h

    
    PAGE 1 :            /*DATA MEMORY*/
	 Regs      : origin =    0h  , length  =     06h
	 Block_B2  : origin =  060h  , length  =    020h
	 Int_RAM   : origin = 0200h  , length  =   0600h
     Ext_RAM1  : origin = 06000h , length  =   1000h
	 Ext_RAM2  : origin = 07000h , length  =  08000h

}

SECTIONS
{
/*    INT_VEC        :  > INTS        PAGE 0*/
/*	TINT_VEC	   :  > TINT        PAGE 0 */
    RINT_VEC       :  > RINT        PAGE 0
/*	SINT_VEC	   :  > SINT        PAGE 0 */
    .text          :  > Prog_RAM    PAGE 0
    .data          :  > Prog_RAM    PAGE 0
    .bss           :  > Ext_RAM2    PAGE 1
    VARS           :  > Ext_RAM1    PAGE 1
}      

