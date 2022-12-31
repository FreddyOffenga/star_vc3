; Silver Star Level 7
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-10

; 83 bytes

; bit encoded, 0=space, 1=star
; plus some sizecoding tricks
; same as level 6, but data in reverse order to save bytes in loop code
; and some more sizecoding :)

put_char    = $f2b0   ; OS outchar routine
tmp_y       = $f2
            
            org $80
        
            inc 752
   
            lda #17
            sta $53
            
decode_line
            ldy #7
decode_byte
zp_x = *+1
            ldx #17*2
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
            
; plot missing stars            
            lda #10
            sta $bc40+(40*4)+18
            sta $bc40+(40*12)+18
            
loop        bvc loop

; bit encoded
; 17 x 2 bytes, missing 2 stars will be printed separately
; data in reverse order to use decrement loop

bit_stream            
            dta %00001000, %00001000
            dta %00011000, %00001100
            dta %00111000, %00001110
            dta %01111000, %00001111  
            
            dta %11111111, %11111111
            dta %11111111, %01111111
            dta %11111110, %00111111
            dta %11111100, %00011111
            
            dta %11111000, %00001111
            
            dta %11111100, %00011111
            dta %11111110, %00111111
            dta %11111111, %01111111
            dta %11111111, %11111111

            dta %01111000, %00001111  
            dta %00111000, %00001110
            dta %00011000, %00001100
            dta %00001000, %00001000