; Silver Star Level 2
; F#READY 2022-12-09

; 298 bytes

; Using OS putchar routine directly, no CIO
; Print example from website, removed prefixed spaces
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

put_char    = $f2b0   ; OS outchar routine
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
        
star_text
            dta 125        
            dta '     *       *',155
            dta '    **     **',155
            dta '    ***   ***',155
            dta '    **** ****',155
            dta '*****************',155
            dta ' ***************',155
            dta '  *************',155
            dta '   ***********',155
            dta '    *********',155
            dta '   ***********',155
            dta '  *************',155
            dta ' ***************',155
            dta '*****************',155
            dta '    **** ****',155
            dta '    ***   ***',155
            dta '    **     **',155
            dta '    *       *',155
            dta 0
