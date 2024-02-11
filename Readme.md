# Swap Players
  Made by lx5
  For Archipelago SMW v2

This patch + script bundle allows you to change the looks of the player, yoshi
and some animated tiles with ease as long you provide the necessary files.

You can use both GFX32-based players and 32x32 Player Tilemap Kit-based players
with this patch. Just create a package with the necessary files and you'll be
ready to go.

---

## Requirements

The patch file requires Asar 1.81 to be assembled into your ROM.

Asar 1.81: https://github.com/RPGHacker/asar/releases/tag/v1.81
Files used:
* `player.bin`
* `player_big.bin`
* `player_extra.bin`
* `player_map.bin`
* `player_name.bin`
* `shared.mw3`
* `map.mw3`
* `yoshi+anim.bin`

`player.bin` is the main graphics file for the player in GFX32 format. It's also
used for players in the 32x32 Player Tilemap Kit format as it's the source of
the cape sprites.
Its size should be exactly 32768 bytes and in 4bpp format.

`player_big.bin` is the main graphics file for the player, in 32x32 Player Tilemap
Kit format.
Its size should be exactly 32768 bytes and in 4bpp format.
This also adds a bunch of ASM hacks to make those graphics actually useable in
the game.

`player_extra.bin` is an auxiliary graphics file for the player. Only used by
players in GFX32 format.
Its size should be exactly 1024 bytes and in 4bpp format.

`player_map.bin` is the graphics file for the small player walking in the map's
paths.
Its size should be exactly 1664 bytes and in 4bpp format.

`player_name.bin` is the graphics file for the player's name in the HUD. 
Its size should be exactly 80 bytes and in 2bpp format.

`shared.mw3` is the palette data for everything in the game. It's mostly used
to pull player and the HUD palettes.
Its size should be between 2016 and 2018 bytes.

`map.mw3` is the palette data for extra colors in the map for the walking player.
Its size should be exactly 48 bytes.
This also adds a bunch of ASM hacks to make those colors actually useable in
the game.

`yoshi+anim.bin` is the graphics file where the game pulls Yoshi sprites AND
mostly every animated graphic in the game.
Its size should be exactly 12288 bytes and in 4bpp format.

---

## Script usage

You can generate ALL of the necessary files if you use the `formatter.py` script.

The script expects the following files in the `/input/` folder, none are required,
you can skip any that the player sprite doesn't expect you to use:
* `GFX32.bin`
* `PlayerGFX.bin`
* `GFX00.bin`
* `GFX10.bin`
* `GFX28.bin`
* `GFX33.bin`
* `shared.pal`
* `map.pal`

`GFX32.bin` is used to build player.bin and player_extra.bin
`PlayerGFX.bin` is used to build player_big.bin
`GFX00.bin` is used to build player_extra.bin
`GFX10.bin` is used to build player_map.bin
`GFX28.bin` is used to build player_name.bin
`shared.pal` is used to build shared.mw3
`map.pal` is used to build map.mw3
`GFX33.bin` is used to build yoshi+anim.bin

The result of the script running will be in the /output/ folder, which you
can copy around and use it for your own purposes.

Most files in SMWC have similar-ish names. You're expected to rename them
to fit the script's expected input.

---

## Patch usage

1) Generate your patched ROM file (`.sfc`) by opening the `.apsmw` file once
2) Open asar.exe via double click
3) Drag and drop into the console the patch file (`swap_player.asm`)
4) Drag and drop into the console the patched ROM file (`.sfc`)
5) Enjoy!

---

## Notes

DO NOT OPEN THE `.apsmw` FILE AGAIN, IT WILL REPLACE YOUR `.sfc` FILE AND YOU
WILL NEED TO PATCH AGAIN. Instead, open the .sfc with your preferred emulator
and then manually open the SNI Client

You can get player graphics that fit into the previous requirements by
visiting SMWCentral's Graphics section, then filter by player and grab sprites
from there.

---

Enjoy! Feel free to report bugs and suggestions.
