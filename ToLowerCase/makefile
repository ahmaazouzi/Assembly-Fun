tolowercase:	tolowercase.o
	ld -melf_i386 -o tolowercase tolowercase.o

tolowercase.o:	tolowercase.s
	as --32 -o tolowercase.o tolowercase.s

clean:
	rm tolowercase.o tolowercase
