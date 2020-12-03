masm
SONSG SEGMENT PARA 'Code'
code_seg segment
assume cs:code_seg, ds:code_seg
org 100h
start:

mov ah,0fh
int 10h
mov old_video, al
mov ah,0
mov al, 10h
int 10h
call box
mov ah,8
int 21h
mov ah,0
mov al,old_video
int 10h
ret
box proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize1
metka1:
push cx
mov ax,x
mov xcrnt, ax
mov cx,xsize1
metka2:
push cx
mov ah,0ch
mov al,colors
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka2
inc ycrnt
pop cx
loop metka1
box endp

box1 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize
metka3:
push cx
mov ax,x1
mov xcrnt, ax
mov cx,xsize
metka4:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka4
inc ycrnt
pop cx
loop metka3
box1 endp

box2 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize
metka5:
push cx
mov ax,x2
mov xcrnt, ax
mov cx,xsize
metka6:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka6
inc ycrnt
pop cx
loop metka5
box2 endp

box3 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize1
metka7:
push cx
mov ax,x3
mov xcrnt, ax
mov cx,xsize2
metka8:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka8
inc ycrnt
pop cx
loop metka7
box3 endp

box4 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize
metka9:
push cx
mov ax,x4
mov xcrnt, ax
mov cx,xsize
metka10:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka10
inc ycrnt
pop cx
loop metka9
box4 endp
box5 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize
metka11:
push cx
mov ax,x5
mov xcrnt, ax
mov cx,xsize
metka12:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka12
inc ycrnt
pop cx
loop metka11
box5 endp
box6 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize
metka13:
push cx
mov ax,x6
mov xcrnt, ax
mov cx,xsize
metka14:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka14
inc ycrnt
pop cx
loop metka13
box6 endp

box8 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize1
metka18:
push cx
mov ax,x8
mov xcrnt, ax
mov cx,xsize2
metka17:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka17
inc ycrnt
pop cx
loop metka18
box8 endp
box9 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize1
metka19:
push cx
mov ax,x9
mov xcrnt, ax
mov cx,xsize2
metka20:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka20
inc ycrnt
pop cx
loop metka19
box9 endp
box10 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize1
metka21:
push cx
mov ax,x10
mov xcrnt, ax
mov cx,xsize2
metka22:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka22
inc ycrnt
pop cx
loop metka21
box10 endp
box11 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize1
metka23:
push cx
mov ax,x11
mov xcrnt, ax
mov cx,xsize2
metka24:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka24
inc ycrnt
pop cx
loop metka23
box11 endp
box12 proc
mov ax,word ptr y
mov ycrnt,ax
mov cx,ysize1
metka25:
push cx
mov ax,x12
mov xcrnt, ax
mov cx,xsize2
metka26:
push cx
mov ah,0ch
mov al,colors1
mov bh,0
mov cx,xcrnt
mov dx,ycrnt
int 10h
inc xcrnt
pop cx
loop metka26
inc ycrnt
pop cx
loop metka25
box12 endp
JMP SHORT MAIN  
;---------------------------------------------------------------
DUR DW  20h       ; время звучания
TON DW  2048H        ; высота звука
db 17,17,255,13,13,255,17,17,255,13,13,255,18,18,255
db 17,17,255,15,15,15,15,255,255
db 8,8,255,8,8,255,8,8,255,10,255,12,255
db 13,13,255,13,13,255,13,13,13,13
db 0 
;---------------------------------------------------------------
MAIN PROC NEAR
    IN  AL,61H  ; получение и сохранение
    PUSH    AX      ;   данных порта
    CLI         ; запрет прерываний
    CALL    PHON        ; генерация звука
    POP AX      ; восстановление значения порта
    OUT 61H,AL
    STI         ; разрешение прерываний
    mov ah,4ch
    int 21h
    RET
MAIN ENDP
 
PHON PROC NEAR
P20:    MOV DX,DUR      ; установка времени звучания
P30:    AND AL,11111100B    ; очистка битов 0 и 1
    OUT 61H,AL      ; передача на динамик
    MOV CX,TON      ; установка частоты
P40:    LOOP    P40         ; задержка времени
    OR  AL,00000010B    ; установка бита 1
    OUT 61H,AL      ; передача на динамик
    MOV CX,TON      ; установка частоты
P50:    LOOP    P50         ; задержка времени
                ; уменьшение времени звучания
    DEC DX
    JNZ P30         ; продолжение?
    SHL DUR,1           ;   нет - увеличение времени,
    SHR TON,1           ;   уменьшение частоты
    JNZ P20         ; нулевая частота?
    RET             ;   да - выход
PHON ENDP
ret
old_video db ?
x dw 170
x1 dw 200
x2 dw 250
x3 dw 320
x4 dw 350
x5 dw 400
x6 dw 450
x7 dw 525
x8 dw 220
x9 dw 270
x10 dw 370
x11 dw 420
x12 dw 470
y dw 100
xcrnt dw 0
ycrnt dw 0
xsize1 dw 350
xsize2 dw 4
xsize dw 40
ysize dw 150
ysize1 dw 200
colors db 15
colors1 db 0
code_seg ends
SONSG ENDS
end start