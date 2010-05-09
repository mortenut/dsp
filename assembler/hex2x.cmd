/*-romwidth 16	 /*16 bit adr. og 16 bit data msb,lsb*/
/*-romwidth 8 	/*16 bit adr, 8 bit data i 2 filer */
/*-memwidth 16   /*16 bit adr, data i 2 filer: msb,lsb */

/* D/M325 ordrer*/
-i		/* intel format*/
-memwidth 8	/* 8 bit adr antal byte max 32k, 8 bit data lsb,msb */
-order MS	/* ved 8 bit data: msb,lsb uden -order = LS = lsb,msb */     
   
