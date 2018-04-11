.data
  # System call codes
  SYS_EXIT = 1
  SYS_WRITE = 4
  STDOUT = 1
  # Text to reverse
  text: .ascii "Hello World!\n"
  textLength: .long .-text

.text
  .globl _start

_start:

prepare_counters:
  # Counter for start
  movl $0, %edi
  # Counter for end
  movl textLength, %esi
  # Decrement to get rid of end character
  decl %esi
  # Decrement again to skip new line character
  decl %esi

reverse_loop:
  # Move byte from start to %al
  movb text(,%edi,1), %al
  # Move byte from end to %ah
  movb text(,%esi,1), %ah
  # Put both bytes to reversed places
  movb %ah, text(,%edi,1)
  movb %al, text(,%esi,1)
  # Increment start counter
  incl %edi
  # Decrement end counter
  decl %esi
  # Compare both counters
  cmp %edi, %esi
  # Loop it they are equal or greater
  jge reverse_loop

print_reversed:
  # Put write command
  movl $SYS_WRITE, %eax
  # Specify output destination
  movl $STDOUT, %ebx
  # Put content to print
  movl $text, %ecx
  # Put length of original text
  movl textLength, %edx
  int $0x80

end:
  # Put exit command
  movl $SYS_EXIT, %eax
  # Set exit code to 0 (no errors)
  movl $0, %ebx
  int $0x80
