
global main
extern printf
extern atoi
section .text
main:
	;Prompt1
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, msg1len
	int 0x80
	;END


	;Prompt2
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, msg2len
	int 0x80
	;END


	;Get Op Type
	mov eax, 3
	mov ebx, 0
	mov ecx, optype
	mov edx, 5
	int 0x80
	;END


	;Prompt3
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, msg3len
	int 0x80
	;END
	
	;Get First Num
	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 5
	int 0x80
	;END
	
	;Prompt3
	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, msg4len
	int 0x80
	;END
	
	;Get Second Num
	mov eax, 3
	mov ebx, 0
	mov ecx, num2
	mov edx, 5
	int 0x80
	;END

	;Convert OPTYPE to INT
	mov eax, 0
	mov eax, optype
  	push eax
  	call atoi
  	add esp, 4


	;Compare and jump equal
	cmp eax,1
	je SumFunc
	cmp eax,2
	je SubFunc
	cmp eax,3
	je MultFunc
	cmp eax,4
	je DivFunc


	;EXIT
	mov eax, 1
	mov ebx, 0
	int 0x80


getNum1:
	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 5
	int 0x80
	ret

SumFunc:
;Convert num1 to int (store in num2int)
	mov eax, 0
	mov eax, num1
  	push eax
  	call atoi
  	add esp, 4
	mov dword [num2int],eax
;Convert num2 to int and add num1+num2
	mov eax, 0
	mov eax, num2
  	push eax
  	call atoi
  	add esp, 4
	add dword[num2int], eax
;Push num2int to stack and call printf
	push dword[num2int]
  	push msgres
  	call printf
  	add esp, 8
;End program with code 0
	mov eax, 1
	mov ebx, 0
	int 0x80

SubFunc:
;Convert num1 to int (store in num2int)
	mov eax, 0
	mov eax, num1
  	push eax
  	call atoi
  	add esp, 4
	mov dword [num2int],eax
;Convert num2 to int and subtract num1-num2
	mov eax, 0
	mov eax, num2
  	push eax
  	call atoi
  	add esp, 4
	sub dword[num2int], eax
;Push num2int to stack and call printf
	push dword[num2int]
  	push msgres
  	call printf
  	add esp, 8
;End program with code 0
	mov eax, 1
	mov ebx, 0
	int 0x80




MultFunc:
;Convert num1 to int (store in num2int)
	mov eax, 0
	mov eax, num1
  	push eax
  	call atoi
  	add esp, 4
	mov dword [num2int],eax
;Convert num2 to int and multiple num1xnum2
	mov eax, 0
	mov eax, num2
  	push eax
  	call atoi
  	add esp, 4
	mul dword[num2int]
;Push num2int to stack and call printf
	push eax
  	push msgres
  	call printf
  	add esp, 8
;End program with code 0
	mov eax, 1
	mov ebx, 0
	int 0x80



DivFunc:
;Convert num1 to int (store in num2int)
	mov eax, 0
	mov eax, num1
  	push eax
  	call atoi
  	add esp, 4
	mov dword [num2int],eax
;Convert num2 to int and divide num1/num2
	mov eax, 0
	mov eax, num2
  	push eax
  	call atoi
  	add esp, 4
	;Dividing
    mov edx, 0
	mov ecx,eax
	mov eax,dword[num2int]
	div ecx
	mov dword[rem],edx
;Push num2int to stack and call printf
	push eax
  	push msgres
  	call printf
  	add esp, 8
;Get Remainder
	push dword[rem]
	push remtxt
  	call printf
  	add esp, 8
;End program with code 0
	mov eax, 1
	mov ebx, 0
	int 0x80
	



section .data
msg1 db "Select the operation type.",10
msg1len equ $-msg1

msg2 db "1-Sum 2-Sub 3-Mult 4-Div",10
msg2len equ $-msg2

msg3 db "Enter the first number",10
msg3len equ $-msg3

msg4 db "Enter the second number",10
msg4len equ $-msg4

remtxt db "Remainder:%i",10,0
remtxtlen equ $-remtxt

msgres db "Result:%i",10,0
msgreslen equ $-msgres



section .bss
optype resb 5
num1 resb 5
num2 resb 5
num2int resb 5
rem resb 5
