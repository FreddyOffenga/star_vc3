; Silver Star Level 4
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-09

; 116 bytes

; bit encoded, 0=space, 1=star
; plus some sizecoding tricks

put_char    = $f2b0   ; OS outchar routine
char_on     = $f0
tmp_x       = $f1
tmp_y       = $f2
tmp_byte    = $f3

            org $80
        
            inc 752

new_line    
            ldx #0
decode_line
            lda bit_stream,x
            sta tmp_byte
            cmp #%10101010
            beq loop

            ldy #7
decode_byte
            rol
            pha

            lda #%00100000
            bcc plot_space
            ora #%00001010            
plot_space
            jsr save_plot

            pla

            dey
            bpl decode_byte            
                    
            inx

            lda tmp_byte
            and #%01111111
            bne decode_line

            lda #155
            jsr save_plot
            bne decode_line
            
loop        bvc loop
                    
save_plot
            stx tmp_x
            sty tmp_y
            jsr put_char
            ldy tmp_y
            ldx tmp_x
            rts

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
            
            dta %10101010
            