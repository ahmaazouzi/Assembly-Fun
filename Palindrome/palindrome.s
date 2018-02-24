.data
  # System call codes
  SYS_EXIT = 1
  SYS_WRITE = 4
  SYS_READ = 3
  # STD codes
  STDIN = 0
  STDOUT = 1
  # Exit code
  EXIT_SUCCES = 0
  # Size of a buffer that will hold text input
  bufferSize = 2048
  # Simple strings with their sizes
  palindromeConfirmed: .ascii "Palindrom\n"
  palindromeConfirmedSize: .long .-palindromeConfirmed
  palindromeFailed: .ascii "Nie palindrom\n"
  palindromeFailedSize: .long .-palindromeFailed

# Buffers to hold text and it's reversed verison
.bss
  .comm input, bufferSize
  .comm reversed, bufferSize

.text
  .global _start

# Main function jumps to 1st label
_start:
  jmp _read_word

# Reads text from user
# Text is later stored in 'input' buffer
# and it's lenght is stored in 'EAX'
# SYSREAD(input, text holder, holder size)
_read_word:
  # Code for SYSREAD
  movl $SYS_READ, %eax
  # Code for STD IN
  movl $STDIN, %ebx
  # Input buffer
  movl $input, %ecx
  # Input buffer size
  movl $bufferSize, %edx
  # SYSCALL
  int $0x80

# Stores text length, reversed text length (XD, sorry), and index of currently checked letter
_store_input:
  # Decrease length by one, cause we start counting from 0
  decl %eax
  # Move length of text to register 'EBX'
  movl %eax, %ebx
  # Move length of reversed text to 'ECX'
  # As You can guess, it's fucking the same as normal text
  # You didn't see that coming, did You?
  movl %eax, %ecx
  # Move index currently checked letter to 'EDI'
  # Starting from 1st letter, so I'm moving 0
  movl $0, %edi
  # Decrease length of reversed text by one
  decl %ebx

# Loop reverses text and stores it in 'reversed' buffer
_reverse_loop:
  # Move single character to register 'AL' from buffer 'input'
  movb input(, %edi, 1), %al
  # Move the same character from register to buffer 'reversed'
  movb %al, reversed(, %ebx, 1)
  # Compare index of current letter and desired tekst length
  # Loop will continue if those are different
  cmp %edi, %ecx
  # Increment index counting from start
  incl %edi
  # Decrement index counting from end
  decl %ebx
  # Do the loop again if comparison was greater or equal
  jge _reverse_loop

# After finishing reverse, set starting index to 0 again
_clear_index:
  movl $0, %edi

# This loop compares letters one by one
# Each iteration increases index counters
# If they are finally equal, we have a palindrome
# Loop is broken as soon as we find a different letter
_compare_loop:
  # Compare counters
  cmp %edi, %ecx
  # If they are equal, jump to solution
  je _solution_correct
  # Else, continue with the loop
  # Move letters of the same index from buffers to registers
  movb input(, %edi, 1), %ah
  movb reversed(, %edi, 1), %al
  # Compare registers
  cmp %al, %ah
  # If they are not equal, word is not a palindrome :-(
  # So jump to solution if not equal
  jne _solution_failure
  # If they are equal, we need to check another letter
  # So lets increase the index counter
  inc %edi
  # And jump to the top of the loop
  jmp _compare_loop

# Label is called when out word is a palindrome
# A simple print of text value
_solution_correct:
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  movl $palindromeConfirmed, %ecx
  movl palindromeConfirmedSize, %edx
  int $0x80
  jmp _end

# Label is called when out word is NOT a palindrome
# A simple print of text value
_solution_failure:
  movl $SYS_WRITE, %eax
  movl $STDOUT, %ebx
  movl $palindromeFailed, %ecx
  movl palindromeFailedSize, %edx
  int $0x80
  jmp _end


_end:
  movl $SYS_EXIT, %eax
  movl $EXIT_SUCCES, %ebx
  int $0x80
