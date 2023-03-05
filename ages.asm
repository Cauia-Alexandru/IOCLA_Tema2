
; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

section .data
    i DD 0
    d Dw 0
    m Dw 0
    y DD 0
; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    ;mov [ecx], dword 2
    mov dword [i], 0
startLabel:
    mov dx, [esi + my_date.day]
    mov dword [d], edx
    mov dx, [esi + my_date.month]           ;stochez ziua,luna,anul a timpului prezent in variabile
    mov dword [m], edx
    mov edx, [esi + my_date.year]
    mov dword [y], edx

    mov edx, dword [i]
    mov ebx, [edi + 8 * edx + my_date.year] ;accesez anul de nastere 
    sub dword [y], ebx                      
    cmp dword [y], 0                        ;compar cu anul curent 
    jng caz0                                ;daca rezultatul e negativ sar la un caz aparte

    mov bx, [edi + 8 * edx + my_date.month]
    sub word [m], bx                        ;compar luna in care e nascut cu luna curenta
    cmp word [m], 0
    jl caz1                                 ;daca rezultatul e ngativ
    jg caz2                                 ;daca e pozitiv
    
    mov bx, [edi + 8 * edx + my_date.day]
    sub word [d], bx
    cmp word [d], 0                         ;compar zilele
    jl caz1
    jmp caz2
    mov eax, [ebp + 8]

returnF:
    inc dword [i]                           ;incrementez i
    cmp dword [i], eax                      ;cat timp i va fi mai mic decat len, repet loop-ul
    jle startLabel
    jmp end                                 ;altfel termin functia



caz0:
    mov dword[ecx + 4 * edx], 0             ;afisez 0
    jmp returnF

caz1:

    sub dword [y], 1                        ;scad din varsta un an, pentru ca diferenta lunilor < 0
    push eax
    mov eax, [ebp + 20]
    push ecx
    mov ecx, dword [y]
    mov [eax + 4 *edx], ecx                 ;pun rezultatul in all_ages
    pop ecx
    pop eax
    jmp returnF

caz2:
    push eax
    mov eax, [ebp + 20 ]
    push ecx
    mov ecx, dword [y]
    mov [eax + 4 *edx], ecx                 ;daca la comparatia lunilor si zileleor a dat rez pozitiv
    pop ecx                                 ;pun in all_ages rezultatul scaderii, adica varsta
    pop eax
    jmp returnF

end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
