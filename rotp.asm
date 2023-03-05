
section .text
    global rotp

section .data
    i DD 0

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE
    mov dword [i], 0
verify:
    xor eax, eax
    xor ebx, ebx

    mov ah, byte [esi + ecx - 1]    ;incep a lua de la sfarsit cate un byte din plaintext

    push eax

    mov eax, [i]

    mov bh, byte [edi + eax]        ;mut in bh cate un byte din key

    pop eax

    xor eax, ebx                    ;xor intre bytes(plaintext[i] ^ key[len-i-1])
    ;rezultatul il pun la sfarsit de ciphertext(byte cu byte de la sfarsit spre inceput)
    mov byte [edx + ecx - 1], ah    

    inc dword [i]
    loop verify

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY