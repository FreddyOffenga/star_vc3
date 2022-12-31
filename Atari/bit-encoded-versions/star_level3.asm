; Silver Star Level 3
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-09

; 133 bytes

; simple RLE encoded star/space/end-of-line

put_char    = $f2b0   ; OS outchar routine
char_on     = $f0
tmp_x       = $f1
tmp_y       = $f2

            org $2000
        
            inc 752
    
            ldx #0
            stx char_on
decode_all
            lda encoded,x
            beq loop
            tay             ; y = repeat count
            bpl plot_line
            
; next line
            lda #155
            jsr save_plot

            jmp more

plot_line
            lda char_on
            and #1
            beq plot_space
            lda #%00001010
plot_space  ora #%00100000

plot_char
            jsr save_plot
            
            dey
            bne plot_char
            
skip_hi2
            inc char_on
more        
            inx
            bne decode_all

loop        jmp loop
                    
save_plot
            stx tmp_x
            sty tmp_y
            jsr put_char
            ldy tmp_y
            ldx tmp_x
            rts

; run-length encoded
; 5 spaces, 1 star, 7 spaces, 1 star, end-of-line
; total data below 256 bytes (1 page)

encoded
            dta 5,1,7,1,128
            dta 5,2,5,2,128
            dta 5,3,3,3,128
            dta 5,4,1,4,128
            dta 1,17,128
            dta 2,15,128
            dta 3,13,128
            dta 4,11,128
            dta 5,9,128
            dta 4,11,128
            dta 3,13,128
            dta 2,15,128
            dta 1,17,128
            dta 5,4,1,4,128
            dta 5,3,3,3,128
            dta 5,2,5,2,128
            dta 5,1,7,1,128
            dta 0   ; end of text
