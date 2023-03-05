
section .data
    extern len_cheie, len_haystack
    i DD 0      ;utilizez pentru incrementeare in primul loop
    j DD 0      ;in al 2 loop
    c DD 0      ;il utilizez ca si counter pentru a pune cate un byte la [ebp+16] la pozitia potrivita

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    mov edx, 0
    mov ebx, 0
    mov eax, [len_haystack]
    mov ebx, [len_cheie]
    div ebx                 ;aflu daca impartirea are rest
    cmp edx, 0
    jg ceil1
    je ceil0
                            ;daca impartirea are rest adun inca o unitate, conform functiei ceil
ceil1:
    add eax, 2              ;numarul de linii
    jmp function1

ceil0:
    add eax, 1
    jmp function1

start:
    inc dword [i]
    mov dword[j], 0

function1:
    mov ebx, [len_cheie]
    cmp ebx, dword [i]      ;cand se termina vectorul de caractere din cheie, inchei programul
    je end
    

    mov edx, dword [i]      ;indice din primul loop
    mov ecx, [edi + edx * 4];ordinea caracterului din cheie 
    
    

function2:

    push edx                    ;formula pentru a lua cate un byte potrivit la fiecre iteratie din haystack este
    push eax                    ;[esi + ordinea_cheii + j * len_cheie]
    mov ebx, 0
    mov edx, dword [j]
    mov eax, [len_cheie]
    mul edx
                                ;in eax e rezultatul inmultirii j cu len_cheie
    add ecx, eax                ;adun eax cu ecx(ordinea carcaterului cheii), stocand rez in ecx
    pop eax
    pop edx
    cmp ecx, dword[len_haystack]
    jge start
          
    mov esi, [ebp + 12]         ;la fiecare intoarcere in loop resetez esi
    add esi, ecx

    push edx

    mov dh, byte [esi]          ; de la esi iau un byte si il stochezi in registrul dh

    mov ebx, [ebp + 16]
    

    mov ecx, [c]
    mov byte [ebx + ecx], dh    ; La pozitia potrivita din ebx trebuie sa pui byte-ul luat anterior
    inc dword [c]

    
    pop edx

    mov ecx, [edi + edx * 4]

    
    inc dword [j]
    cmp eax, dword [j]          ;daca j e mai mic ca nr de linii, intru iarasi in loop
    jle start
    jg function2



end:
    mov dword[i], 0
    mov dword[j], 0
    mov dword[c], 0
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY