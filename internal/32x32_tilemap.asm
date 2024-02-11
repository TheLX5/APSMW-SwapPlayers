@asar 1.70
;32×32 player tilemap patch
;by Ladida

math	pri	on	;\ Asar defaults to Xkas settings instead
math	round	off	;/ of proper math rules, this fixes that.

!addr	= $0000			; $0000 if LoROM, $6000 if SA-1 ROM.
!bank	= $800000		; $80:0000 if LoROM, $00:0000 if SA-1 ROM.
!sa1	= 0

;;;;;;;;;
;Hijacks;
;;;;;;;;;

org $00E370|!bank
BEQ +
org $00E381|!bank
BNE +
org $00E385|!bank
NOP #6
+
LDA #$F8

org $00E3B0|!bank
TAX
LDA.l excharactertilemap,x
STA $0A
STZ $06
BRA +
NOP #5
+

org $00E3E4|!bank
BRA +
org $00E3EC|!bank
+

org $00F636|!bank
JML tilemapmaker

org $00A169|!bank
LDA #$F0
STA $3F

incsrc "hexedits.asm"
incsrc "ow_mario.asm"


;;;;;;;;;;;;;;;;;
;MAIN CODE START;
;;;;;;;;;;;;;;;;;

org $0FF800

MarioGFXDMA:
LDY $0D84|!addr
BNE +
JMP .skipall
+

REP #$20
LDY #$04

;;
;Mario's Palette
;;

LDX #$86
STX $2121
LDA #$2200
STA $4320
LDA $0D82|!addr
STA $4322
LDX #$00
STX $4324
LDA #$0014
STA $4325
STY $420B


LDX #$80
STX $2115
LDA #$1801
STA $4320
LDX #$1C
STX $4324


;;
;Misc top tiles (cape)
;;

LDA #$6040
STA $2116
LDX #$04
LDA $0D89
STA $4322
LDA #$0040
STA $4325
STY $420B

;;
;Misc bottom tiles (cape)
;;

LDA #$6140
STA $2116
LDA $0D93
STA $4322
LDA #$0040
STA $4325
STY $420B

ldx #$06
cpx $0D84
bcs +

LDX #$1D
STX $4324


;;
;Misc top tiles (yoshi, podoboo)
;;

LDA #$6060
STA $2116
LDX #$06
-
LDA $0D85|!addr,x
STA $4322
LDA #$0040
STA $4325
STY $420B
INX #2
CPX $0D84|!addr
BCC -

;;
;Misc bottom tiles (yoshi, podoboo)
;;

LDA #$6160
STA $2116
LDX #$06
-
LDA $0D8F|!addr,x
STA $4322
LDA #$0040
STA $4325
STY $420B
INX #2
CPX $0D84|!addr
BCC -

+ 
;;
;New player GFX upload
;;

LDX $0D87|!addr
STX $4324
LDA $0D86|!addr : PHA
LDX #$06
-
LDA.l .vramtbl,x
STA $2116
LDA #$0080
STA $4325
LDA $0D85|!addr
STA $4322
STY $420B
INC $0D86|!addr
INC $0D86|!addr
DEX #2 : BPL -
PLA : STA $0D86|!addr
SEP #$20

.skipall
RTL

.vramtbl
dw $6300,$6200,$6100,$6000


tilemapmaker:
REP #$20
LDX #$00
LDA $09
AND #$0300
SEC : ROR
PHA
LDA $09
AND #$3C00
ASL
ORA $01,s
STA $0D85|!addr
LDY.b #$1E
BIT $09
BPL +
INY #$02
+
BVC +
INY
+
STY $0D87|!addr
PLA
JML $00F674|!bank

incsrc "excharactertilemap.asm"

org $10FF80
    .map_targets
    ..yoshi
        dw $6420,$6400,$62E0
    ..mario
        dw $6660,$6640
        dw $6460
        dw $6240,$64C0
        dw $60E0,$60C0,$60A0,$6080,$6060
    ..end


	