; Silver Star triangles 1
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; F#READY 2022-12-10

; 165 bytes

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

open_mode   = $ef9c     ; A=mode
clear_scr   = $f420     ; zero screen memory
draw_to     = $f9c2     ; $f9bf (stx FILFLG)
plot_pixel  = $f1d8

tmp_y       = $30
tmp_x       = $31
dir_x1      = $32
dir_y1      = $33
dir_x2      = $34
dir_y2      = $35
            
            org $2000

main
            jsr clear_scr

            lda #42
            sta draw_color   

            ldx #0

next_triangle
            
            lda x_starts,x
            sta x1
            sta x2
            lda y_starts,x
            sta y1
            sta y2

            lda x1_dirs,x
            sta dir_x1
            lda y1_dirs,x
            sta dir_y1
            lda x2_dirs,x
            sta dir_x2
            lda y2_dirs,x
            sta dir_y2
            
            ldy #13

draw_triangle

x1  = *+1            
            lda #0
            sta x_start
            sta x_position            
y1  = *+1
            lda #0
            sta y_start
            sta y_position
            
            sty tmp_y
            stx tmp_x

            jsr plot_pixel

x2  = *+1
            lda #0
            sta x_position
y2  = *+1
            lda #0
            sta y_position

            jsr draw_to

            ldx tmp_x
            ldy tmp_y
            
            lda x1
            clc            
            adc dir_x1
            sta x1
            
            lda y1
            clc
            adc dir_y1
            sta y1
            
            lda x2
            clc
            adc dir_x2
            sta x2
            
            lda y2
            clc
            adc dir_y2
            sta y2
            
            dey
            bne draw_triangle            

            inx
            cpx #4
            bne next_triangle
            
loop        jmp loop

            org $80
            
x_starts    
            dta  4
            dta 12
            dta  4
            dta 12

y_starts    
            dta 12
            dta  4
            dta  4
            dta 12

x1_dirs     
            dta  0
            dta -1
            dta  1
            dta -1

y1_dirs     
            dta -1
            dta  0
            dta  0
            dta  0

x2_dirs     
            dta  1
            dta  0
            dta  0
            dta  0

y2_dirs     
            dta  0
            dta  1
            dta  1
            dta -1

            run main