#
# Usage: ./calculator <op> <arg1> <arg2>
#

# Make `main` accessible outside of this module
.global main

# Start of the code section
.text

# int main(int argc, char argv[][])
main:
  # Function prologue
  enter $0, $0

  # Variable mappings:
  # op -> %r12
  # arg1 -> %r13
  # arg2 -> %r14
  movq 8(%rsi), %r12  # op = argv[1]
  movq 16(%rsi), %r13 # arg1 = argv[2]
  movq 24(%rsi), %r14 # arg2 = argv[3]


  # Hint: Convert 1st operand to long int
  movq %r13, %rdi
  call atol
  movq %rax, %r13
  # Hint: Convert 2nd operand to long int
  movq %r14, %rdi
  call atol
  movq %rax, %r14 
  # Hint: Copy the first char of op into an 8-bit register
  # i.e., op_char = op[0] - something like mov 0(%r12), ???
  mov 0(%r12), %al
  # if (op_char == '+') {
  #   ...
  # }
   cmp %al,plus
   je addition 
   
   cmp %al,minus
   je subtraction

   cmp %al,multiply
   je multiplication

   cmp %al,divide
   je division
 
   movq $string, %rdi
   movq $unknownoperation, %rsi
   mov $0, %al
   call printf

  # else if (op_char == '-') {
  #  ...
  # }
  # ...
  # else {
  #   // print error
  #   // return 1 from main
  # }

  # Function epilogue
  leave
  ret
  

# Start of the data section
.data

string:
  .asciz "%s\n"

format: 
  .asciz "%ld\n"

plus:
  .asciz "+"

minus:
  .asciz "-"

multiply:
 .asciz "*"

divide:
 .asciz "/"

unknownoperation:
 .asciz "Unknown operation"

addition:
 addq %r13,%r14
 movq %r14, %rax
    movq $format, %rdi
    movq %rax, %rsi
    mov $0, %al
    call printf
    leave 
    ret

subtraction:
 subq %r14, %r13
 movq %r13, %rax
    movq $format, %rdi
    movq %rax, %rsi
    mov $0, %al
    call printf
    leave
    ret

multiplication:
 imulq %r13,%r14
 movq %r14, %rax
    movq $format, %rdi
    movq %rax, %rsi
    mov $0, %al
    call printf
    leave 
    ret

division:
 movq $0,%rdx
 movq %r13, %rax
 idivq %r14
    movq $format, %rdi
    movq %rax, %rsi
    mov $0, %al
    call printf
    leave
    ret
