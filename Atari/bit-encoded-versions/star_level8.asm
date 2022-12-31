; Silver Star Level 8
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-11

; 77 bytes

; bit encoded, 0=space, 1=star
; plus some sizecoding tricks
; same as level 6, but data in reverse order to save bytes in loop code
; and some more sizecoding :)

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
            ldx #18*2
            rol bit_stream-1,x

            lda #%00100000
            bcc plot_space
            ora #%00001010            
plot_space
            sty tmp_y
            jsr put_char
            ldy tmp_y

            dey
            bpl decode_byte            
                    
            dec zp_x
            bne decode_line
            
loop        bvc loop

; bit stream encoded
; 17 x 17 bits
; data in reverse order to use decrement loop

bit_stream    
            dta %00001000, %00001000
        
            dta %00110000, %00011000
            dta %11100000, %00111000
            dta %11000000, %01111011
            dta %11111000, %11111111 
            
            dta %11101111, %11111111
            dta %10001111, %11111111
            dta %00001111, %11111110
            dta %00001111, %11111000
            
            dta %00001111, %11111000
            
            dta %00111111, %11111000
            dta %11111111, %11111000
            dta %11111111, %11111011
            dta %11111111, %00001111

            dta %11101111, %00000001  
            dta %10001110, %00000011
            dta %00001100, %00000110
            dta %00001000, %00001000