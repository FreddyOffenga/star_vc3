; Silver Star Level 10
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-13

; 68 bytes

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
            lda #18*8-1
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

            pha
            pha
            pha

copy_stack
zp_copy = *+1            
            ldx #18*8
            pla
            jsr put_char
            dec zp_copy
            bne copy_stack

loop        beq loop

; bit stream encoded
; 17 x 17 bits
; data in reverse order to use decrement loop

bit_stream                    
            dta %00001111, %11111000
            dta %00111111, %11111000
            dta %11111111, %11111000
            dta %11111111, %11111011
            dta %11111111, %00001111

            dta %11101111, %00000001  
            dta %10001110, %00000011
            dta %00001100, %00000110
            dta %00001000, %00001000
