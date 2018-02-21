palindrome:	palindrome.o
	ld -melf_i386 -o palindrome palindrome.o

palindrome.o:	palindrome.s
	as --32 -o palindrome.o palindrome.s

clean:
	rm palindrome.o palindrome
