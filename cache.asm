
section .data
    i DD 0
    j DD 0
    k DD 0

;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS


section .text
    global load

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY
    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    shr edx, 3                  ;calculez tagul

    xor eax, eax
    xor ecx, ecx
comp_tag:
    
    mov eax, dword [i]
    mov ecx, [ebx + eax * 4]   ;pun in ecx un tag din vector(tags)
    sub ecx, edx
    cmp ecx, 0                  ;compar cu 0 dupa ce am scazut tagurile
    je calc_offset              ;daca sunt egale trec la alta etapa
    inc dword [i]
    cmp eax, CACHE_LINES
    jle comp_tag
    jg put_tag_value            ;cazul cand nu a gasit tagul

calc_offset:
    mov eax, dword[i]           ;indexul unde am gasit tagul
    add eax, 1
    mov ebx, 8
    mul ebx                     ;in eax este i*8
    
    mov edx, [ebp + 20]         ;adresa
    shl edx, 29                 ;offsetul
    shr edx, 29

    add eax, edx                ;i*8+offset
    
    mov ebx, eax                

    mov ecx, [ebp + 16]         ;cache
    mov eax, 0
    mov al, byte [ecx + ebx]    ;iau un byte de la cache[i][offset]
    mov ecx, [ebp + 8]          ;registru
    mov byte [ecx], al          ;pun in registru byte-ul
    
    jmp end

put_tag_value:
    
    mov ecx, [ebp + 12]         ;tags
    mov ebx, edi                ;to_replace
    mov [ecx + ebx * 4 - 4], edx;pun tagul in tags
cache_miss:
    mov edx, [ebp + 20] ;adresa
    shr edx, 3
    shl edx, 3                  ;ultimele 3 cifre le fac zerouri
    mov ecx, 7
    mov dword[j], ecx

cache_miss2:
    push edx 
    mov eax, 8
    mov ebx, 0
    mov bl, byte [edx]          ;iau un byte de la prima adresa din cele 8
    
    mul edi                     ;to_replace * 8

    
    mov ecx, 0                  

    mov ecx, dword [k]          ;counter
    add eax, ecx                ;to_replace*8+k
    mov ecx, [ebp + 16]             ;cache
    mov byte [ecx + eax], bl    ;pun un byte in cache[to_replace][k]
    pop edx
    add edx, 1                  ;adaug 1 la adresa
    inc dword [k]               ;incrementez counterul
    mov eax, dword [j]
    cmp dword [k], eax          ;daca nu a ajuns la 7, repet loop-ul
    jle cache_miss2

final:
    mov eax, [ebp + 8]          ; address of reg
    mov edx, [ebp + 20]         ; address
    mov ebx, 0
    mov bh, byte [edx]
    mov byte [eax], bh          ;iau un byte de la adresa si il pun un registru
    jmp end

end:
    mov dword[i], 0
    mov dword[j], 0
    mov dword[k], 0



    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


