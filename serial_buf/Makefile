TARGET         = dspprog
ASRC           = buf_test.asm
DSP_TARGET     = 26

OBJ            = $(ASRC:.asm=.obj)
ABS            = $(ASRC:.asm=.abs)

sti            = ../assembler/

ASMFLAGS       = -v$(DSP_TARGET)
LNKFLAGS       = $(sti)doall2x.cmd
HEXFLAGS       = $(sti)hex2x.cmd

dsphex         = $(sti)dsphex.exe
dsplnk         = $(sti)dsplnk.exe
dspa           = $(sti)dspa.exe
dspabs         = $(sti)dspabs.exe

all: hex lst
hex : $(TARGET).out
	$(dsphex) $(TARGET).out -o $(TARGET).hex -map $(TARGET).map $(HEXFLAGS)

$(TARGET).out : $(OBJ)
	$(dsplnk) -v0 $< -o $@ -o $(TARGET).out -m $(TARGET).map $(LNKFLAGS)

%.obj : 
	$(dspa) $(ASRC) $(ASMFLAGS) -l

abs : $(TARGET).out
	echo dspabs.exe $(TARGET).out  > abs.bat
	cp $(dspabs) dspabs.exe
	dosbox -exit abs.bat
	rm dspabs.exe
	rm abs.bat

lst: abs
	$(dspa) -a $(ABS) $(ASMFLAGS) -x

.PHONY : clean
clean :
	rm *.ABS *.lst *.out *.hex *.map *.obj

