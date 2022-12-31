; Silver Star Level 11
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-19

; 65 bytes

; bit encoded, 0=space, 1=star
; decode top half, copy to bottom

put_char    = $f2b0   ; OS outchar routine
            
            org $80
        
            inc 752
            
            lda #18
            sta $53
            
decode_line
decode_byte
zp_x = *+1
            lda #18*8+1
            lsr
            lsr
            lsr
            tax

            rol bit_stream,x

            lda #%00100000
            bcc plot_space
            ora #%00001010            
plot_space
            jsr put_char

            pha    
            dec zp_x
            bne decode_line
            
            pla

copy_stack
            pla
            jsr put_char
            dec zp_copy
            bne copy_stack

loop        beq loop

zp_copy     dta 18*8

; bit stream encoded
; 17 x 17 bits
; data in reverse order to use decrement loop

bit_stream
            dta %00111110
            dta %11100000
            dta %11111111
            dta %11100000
            dta %11111111
            dta %11100011
            dta %11111111 
            dta %11101111
            dta %11111111

            dta %00111111
            dta %10111100
            dta %00000111  
            dta %00111000 
            dta %00001110
            dta %00110000 
            dta %00011000
            dta %00100000
            dta %00100000                  
