; Silver Star Level 0
; F#READY 2022-12-09

; 504 bytes

; Using CIO to print characters
; Print example from website including all spaces
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

ICCOM = $0342
ICBLL = $0348
ICBLH = $0349
CIOV  = $e456

text_ptr    = $f0

            org $2000
        
            inc 752

            lda #<star_text
            sta text_ptr
            lda #>star_text
            sta text_ptr+1
    
            ldy #0
print_all
            lda (text_ptr),y
            beq loop
            jsr put_char
            
            inc text_ptr
            bne no_hi
            inc text_ptr+1
no_hi
            bne print_all        

loop        jmp loop

; put character using CIO
; the official way, using CIOV

put_char
            pha
            ldx #0
            txa
            sta ICBLL,x
            sta ICBLH,x
            lda #11
            sta ICCOM,x
            pla
            jmp CIOV
        
star_text
            dta 125        
            dta '                *       *',155
            dta '               **     **',155
            dta '               ***   ***',155
            dta '               **** ****',155
            dta '           *****************',155
            dta '            ***************',155
            dta '             *************',155
            dta '              ***********',155
            dta '               *********',155
            dta '              ***********',155
            dta '             *************',155
            dta '            ***************',155
            dta '           *****************',155
            dta '               **** ****',155
            dta '               ***   ***',155
            dta '               **     **',155
            dta '               *       *',155
            dta 0
