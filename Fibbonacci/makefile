fibbonacci:	fibbonacci.o
	ld -melf_i386 -o fibbonacci fibbonacci.o

fibbonacci.o:	fibbonacci.s
	as -g --32 -o fibbonacci.o fibbonacci.s

clean:
	rm fibbonacci.o fibbonacci
