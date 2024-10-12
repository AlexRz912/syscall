bits 64

section .data
    message db 'Type a number', 10
    buffer db 0
    len equ 10

section .text
    global _start

    _start:
        mov rax, 1 ; code de la fonction sys_write placé dans le registre de retour pour le faire retourner par syscall
        mov rdi, 1 ; prends la sortie standard
        mov rsi, message ; ecrit message
        mov rdx, 13+1 ; qui prends tel espace (1 octet par caractère)
        syscall ; prends en paramètre rdi, rsi et rdx et retourne rax

        ; On appelle le noyau linux pour lui demander de 
        ; retourner la fonction sys_write (pointé par rax) avec les args passés 
        ; de la ligne 13 à la ligne 15 "ecrit sur la sortie 
        ; standard (rdi) la variable message (rsi), tu as besoin de 12 caractères (1 octet par caractère)"

        mov rax, 0 ; code de la fonction sys_read placé dans le registre de retour pour le faire retourner par syscall
        mov rdi, 0 ; prends l'entrée standard
        mov rsi, buffer ; tu écrira dans la variable buffer stocké dans rsi ce que l'utilisateur écrira sur l'entrée standard
        mov rdx, len ; qui prends tel espace (len = 10 donc 10 octets possible)
        syscall ; prends en paramètre rdi, rsi, rdx et retourne rax

        ; On appelle le noyau linux pour lui demander de 
        ; retourner la fonction sys_read (pointé par rax) avec les args passés 
        ; de la ligne 24 à la ligne 26 "lit depuis l'entrée standard pour écrire dans buffer
        ; tu as le droit a maximum 10 caractères (1 octet par caractère)"

        mov rax, 60 ; sys_exit
        mov rdi, 0 ; error_code (nombre)
        syscall ; bye bye :)