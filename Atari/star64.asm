pl=$f2b0
 org $80
 inc 752
 lda #18
 sta 83
z lda #144
 :3 lsr
 tax
 rol s,x
 lda #32
 bcc w
 ora #10
w jsr pl
 pha
 dec z+1
 bne z
c jsr pl
 pla
 dec k
 bne c
l beq l
k .he 90
s .he 1F F0 7F F0 FF F1 FF F7 FF 1F DE 3 1C 7 18 C 10 10