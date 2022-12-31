; Silver Star Level 6
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-10

; 91 bytes

; bit encoded, 0=space, 1=star
; plus some sizecoding tricks
; same as level 4/5, but this uses 17x2 data instead of 17x3
; pokes 2 missing stars directly to screen.memory

put_char    = $f2b0   ; OS outchar routine
tmp_x       = $f1
tmp_y       = $f2

            org $80
        
            inc 752

            lda #17
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
            cpx #2*17
            bne decode_line
            
; plot missing stars            
            lda #10
            sta $bc40+(40*4)+18
            sta $bc40+(40*12)+18
            
loop        bvc loop

; bit encoded
; 17 x 2 bytes, missing 2 stars will be printed separately
bit_stream
            dta %00001000, %00001000
            dta %00001100, %00011000
            dta %00001110, %00111000
            dta %00001111, %01111000
            
            dta %11111111, %11111111
            dta %01111111, %11111111
            dta %00111111, %11111110
            dta %00011111, %11111100
            
            dta %00001111, %11111000

            dta %00011111, %11111100
            dta %00111111, %11111110
            dta %01111111, %11111111
            dta %11111111, %11111111

            dta %00001111, %01111000
            dta %00001110, %00111000
            dta %00001100, %00011000
            dta %00001000, %00001000
            