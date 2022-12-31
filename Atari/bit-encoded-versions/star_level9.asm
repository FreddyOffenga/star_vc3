; Silver Star Level 9
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-11

; 71 bytes

; bit encoded, 0=space, 1=star
; decode top half, copy to bottom

put_char    = $f2b0   ; OS outchar routine
tmp_y       = $f2
            
            org $80
        
            inc 752
   
            lda #18
            sta $53
            
decode_line
            ldy #7
decode_byte
zp_x = *+1
            ldx #18
            rol bit_stream-1,x

            lda #%00100000
            bcc plot_space
            ora #%00001010            
plot_space
            sty tmp_y
            jsr put_char
            ldy tmp_y

            pha
            
            dey
            bpl decode_byte            
                    
            dec zp_x
            bne decode_line

            pha
copy_stack
zp_copy = *+1            
            ldx #8*17+5
            pla
            jsr put_char
            dec zp_copy
            bne copy_stack

            rts
;loop        bvc loop

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