org $10F000
    upload_score_sprite_gfx:
        lda $0100
        cmp #$13
        beq .check_level
        jmp .check_map
    .check_level
        lda $7C
        beq ..perform
        jmp .skip
    ..perform
        inc $7C
        rep #$20
        ldy #$80
        sty $2115
        lda #$1801
        sta $4320
        ldy.b #$1C
        sty $4324
        lda.w #$F000
        sta $4322
    .nums_01
        lda #$64A0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .nums_35
        lda #$65A0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .plus_coin
        lda #$61A0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .egg_mushroom
        lda #$60A0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .flower_feather
        lda #$67E0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .token
        lda #$6380
        sta $2116
        lda #$0020
        sta $4325
        stx $420B
    .layer_3
        lda.w #$EC00
        sta $4322
        lda #$4180
        sta $2116
        lda #$0050
        sta $4325
        stx $420B
        sep #$20
    .skip 
        rtl 
    .check_map
        cmp #$0E
        beq .map_pal
        cmp #$0D
        bne .skip
        lda $7C
        bne .skip
        inc $7C
        rep #$20
        ldy #$80
        sty $2115
        lda #$1801
        sta $4320
        ldy.b #$1C
        sty $4324
        lda.w #$E400
        sta $4322
        phx 
        txy 
        ldx.b #$18
    ..loop
        lda #$0040
        sta $4325
        lda.l .map_targets,x
        sta $2116
        sty $420B
        lda.l .map_targets,x
        clc 
        adc #$0100
        sta $2116
        lda #$0040
        sta $4325
        sty $420B
        dex #2
        bpl ..loop
        plx 
        sep #$20
    .map_pal
        lda #$A3
        sta $2121
        phx 
        ldx #$00
    -   
        lda $00B59C,x
        sta $2122
        lda $00B59D,x
        sta $2122
        inx 
        inx 
        cpx.b #10
        bne -

    ..pal_9
        lda #$98
        sta $2121
        ldx #$00
    -   
        lda $10FF00,x
        sta $2122
        lda $10FF01,x
        sta $2122
        inx 
        inx 
        cpx.b #16
        bne -
    ..pal_A
        lda #$A8
        sta $2121
        ldx #$00
    -   
        lda $10FF10,x
        sta $2122
        lda $10FF11,x
        sta $2122
        inx 
        inx 
        cpx.b #16
        bne -
    ..pal_B
        lda #$B8
        sta $2121
        ldx #$00
    -   
        lda $10FF20,x
        sta $2122
        lda $10FF21,x
        sta $2122
        inx 
        inx 
        cpx.b #16
        bne -

        plx
        rtl 

    
org $10FF80
    .map_targets