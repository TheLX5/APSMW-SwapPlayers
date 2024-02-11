;########################################################################################
;# Swap Players in Archipelago's SMW v2
;#   made by lx5

;# If this define is set to 0 it's going to grab colors from the player.pal file
;# If this define is set to 1 it's going to grab colors from the defines below
!use_patch_colors = 0

;# Those values are HEX colors, grab them from the internet or something
;# The values are then converted to SNES BGR, they're going to lose precision during
;# the conversion
!hud_name_color = $D83818

;########################################################################################
;# DO NOT MODIFY ANYTHING BELOW

function rgb_to_snes(color) = ((color&$FF0000)>>19)|(((color&$00FF00)>>11)<<5)|(((color&$0000FF)>>3)<<10)

lorom

check bankcross off

if canreadfile1("player.bin", 1) == 1
    print "Found player.bin, inserting..."
    if canreadfile1("player_big.bin", 1) == 0
        assert read1($00F636) != $5C, "Please generate a new .sfc file before applying this patch again."
    endif
    assert filesize("player.bin") == 23808, "Don't use a player.bin file that doesn't have a size of 23808 bytes."
    org $1C8000
        incbin "player.bin"
endif

if canreadfile1("player_big.bin", 1) == 1
    print "Found player_big.bin, inserting..."
    assert filesize("player_big.bin") == 65536, "Don't use a player_big.bin file that doesn't have a size of 65536 bytes."
    org $1E8000
        incbin "player_big.bin"
    print "... also inserting additional ASM hacks to get this player to work."
    incsrc "internal/32x32_tilemap.asm"
endif

if canreadfile1("player_extra.bin", 1) == 1
    print "Found player_extra.bin, inserting..."
    assert filesize("player_extra.bin") == 1024, "Don't use a player_extra.bin file that doesn't have a size of 1024 bytes."
    org $1CE000
        incbin "player_extra.bin"
endif

if canreadfile1("player_map.bin", 1) == 1
    print "Found player_map.bin, inserting..."
    assert filesize("player_map.bin") == 1664, "Don't use a player_map.bin file that doesn't have a size of 1664 bytes."
    org $1CE400
        incbin "player_map.bin"
endif

if canreadfile1("player_name.bin", 1) == 1
    print "Found player_name.bin, inserting..."
    assert filesize("player_name.bin") == 80, "Don't use a player_name.bin file that doesn't have a size of 80 bytes."
    org $1CEC00
        incbin "player_name.bin"
endif

if canreadfile1("shared.mw3", 1) == 1
    print "Found shared.mw3, inserting..."
    assert filesize("shared.mw3") >= 2016, "Don't use a shared.mw3 file that doesn't have a size of 2016 or 2018 bytes."
    assert filesize("shared.mw3") <= 2018, "Don't use a shared.mw3 file that doesn't have a size of 2016 or 2018 bytes."
    org $00B0A0
        incbin "shared.mw3":0-7E0
endif

if canreadfile1("map.mw3", 1) == 1
    print "Found map.mw3, inserting..."
    assert filesize("map.mw3") == 48, "Don't use a map.mw3 file that doesn't have a size of 48 bytes."
    org $10FF00
        incbin "map.mw3"
    print "... also inserting additional ASM hacks to get this palette to work."
    incsrc "internal/upload_gfx.asm"
endif

if canreadfile1("yoshi+anim.bin", 1) == 1
    print "Found yoshi+anim.bin, inserting..."
    assert filesize("yoshi+anim.bin") == 12288, "Don't use a player_name.bin file that doesn't have a size of 12288 bytes."
    org $1D8000
        incbin "yoshi+anim.bin"
endif