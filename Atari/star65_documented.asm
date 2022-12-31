; Star65, By F#READY 2022-12-19

; 64 bytes intro for the Vintage Computing Christmas Challenge 2022
; https://logiker.com/Vintage-Computing-Christmas-Challenge-2022

; bit encoded, 0=space, 1=star
; decode first half, copy second half
; sizecoded like crazy! :)

put_char    = $f2b0   ; OS outchar routine

; put code on zeropage to get fewer bytes for addressing            
            org $80
        
; hide cursor        
            inc 752
            
; set text right margin to 18 (left is default 2)            
            lda #18
            sta $53
            
decode
zp_x = *+1
            lda #18*8
            lsr
            lsr
            lsr
; byte offset = bit count / 8
            tax
            rol bit_stream,x

; 32 = space
            lda #%00100000
            bcc plot_space
; set bits to change space into star
            ora #%00001010            
plot_space
            jsr put_char

; put current char on stack
            pha    
            dec zp_x
            bne decode

copy_stack
; print extra char in middle of star
            jsr put_char
; copy rest from stack
            pla
            dec zp_copy
            bne copy_stack

loop        beq loop

; counter for stack copy
zp_copy     dta 18*8

; bit encoded data
; 18 x 8 bits
; data in reverse order to use decrement loop

bit_stream
            dta %00011111
            dta %11110000
            dta %01111111
            dta %11110000
            dta %11111111
            dta %11110001
            dta %11111111 
            dta %11110111
            dta %11111111

            dta %00011111
            dta %11011110
            dta %00000011  
            dta %00011100 
            dta %00000111
            dta %00011000 
            dta %00001100
            dta %00010000
            dta %00010000                 
