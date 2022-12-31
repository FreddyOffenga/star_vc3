; Silver Star Level 5
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-09

; 100 bytes

; bit encoded, 0=space, 1=star
; plus some sizecoding tricks
; same as level 4, but now set right margin to get rid of some logic

put_char    = $f2b0   ; OS outchar routine
tmp_x       = $f1
tmp_y       = $f2

            org $80
        
            inc 752

            lda #25
            sta 83

new_line    
            ldx #0
decode_line
            lda bit_stream,x

            ldy #7
decode_byte
            rol
            pha

            lda #%00100000
            bcc plot_space
            ora #%00001010            
plot_space
            stx tmp_x
            sty tmp_y
            jsr put_char
            ldy tmp_y
            ldx tmp_x

            pla

            dey
            bpl decode_byte            
                    
            inx
            cpx #3*17
            bne decode_line
            
loop        bvc loop

; bit encoded
; 17 x 3 bytes
bit_stream
            dta %00001000, %00001000, %00000000
            dta %00001100, %00011000, %00000000
            dta %00001110, %00111000, %00000000
            dta %00001111, %01111000, %00000000
            
            dta %11111111, %11111111, %10000000
            dta %01111111, %11111111, %00000000
            dta %00111111, %11111110, %00000000
            dta %00011111, %11111100, %00000000
            
            dta %00001111, %11111000, %00000000

            dta %00011111, %11111100, %00000000
            dta %00111111, %11111110, %00000000
            dta %01111111, %11111111, %00000000
            dta %11111111, %11111111, %10000000

            dta %00001111, %01111000, %00000000
            dta %00001110, %00111000, %00000000
            dta %00001100, %00011000, %00000000
            dta %00001000, %00001000, %00000000
            