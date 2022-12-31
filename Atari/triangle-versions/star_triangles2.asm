; Silver Star triangles 2
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-18

; 78 bytes

; other approach, draw four triangles

ROWCRS      = $54       ; byte
y_position  = ROWCRS    ; alias

COLCRS      = $55       ; word
x_position  = COLCRS    ; alias

OLDROW      = $5a       ; byte
y_start     = OLDROW    ; alias

OLDCOL      = $5b       ; word
x_start     = OLDCOL    ; alias

ATACHR      = $2fb      ; drawing color
draw_color  = ATACHR    ; alias

clear_scr   = $f420     ; zero screen memory
draw_to     = $f9c2     ; $f9bf (stx FILFLG)
plot_pixel  = $f1d8
            
            org $80

main
            jsr clear_scr

            lda #42
            sta draw_color   

draw_all
            lda #4
            sta new_x
next_y = *+1            
            lda #0
            sta new_y
plot_four

new_x = *+1
            lda #4
            pha
            sta x_position
new_y = *+1
            lda #0
            sta y_position
            jsr plot_pixel

            lda #16
            sbc x_position
            sta x_position            
            jsr plot_pixel

            lda #16
            sbc y_position
            sta y_position            
            jsr plot_pixel

            pla
            sta x_position
            jsr plot_pixel                        
               
            inc new_x
            inc new_y
            lda new_y
            cmp #13
            bne plot_four
            
            inc next_y
            lda next_y
            cmp #12
            bne draw_all      
               
loop        bvc loop
