import os

def copy_gfx_tiles(original, order, size):
    result = bytearray([])
    for x in range(len(order)):
        z = order[x] << size[0]
        result += bytearray([original[z+y] for y in range(size[1])])
    return result

def convert_rgb_snes(original):
    result = bytearray([])
    j = 0
    for i in range(int(len(original)/3)):
        red = original[i*3]>>3
        green = original[1+i*3]>>3
        blue = original[2+i*3]>>3
        color = red | (green<<5) | (blue<<10)
        result += bytearray([color & 0xFF, (color>>8) & 0xFF])
    return result

try:
    with open("./input/GFX32.bin", "rb") as f:
        gfx_32 = f.read()
except:
    gfx_32 = None
    print ("Did not find GFX32.bin, skipping...")

try:
    with open("./input/PlayerGFX.bin", "rb") as f:
        player_gfx = f.read(0x10000)
except:
    player_gfx = None

try:
    with open("./input/GFX33.bin", "rb") as f:
        gfx_33 = f.read()
except:
    gfx_33 = None
    print ("Did not find GFX33.bin, skipping...")

try:
    with open("./input/GFX00.bin", "rb") as f:
        gfx_00 = f.read()
except:
    gfx_00 = None
    print ("Did not find GFX00.bin, skipping...")

try:
    with open("./input/GFX10.bin", "rb") as f:
        gfx_10 = f.read()
except:
    gfx_10 = None
    print ("Did not find GFX10.bin, skipping...")

try:
    with open("./input/GFX28.bin", "rb") as f:
        gfx_28 = f.read()
except:
    gfx_28 = None
    print ("Did not find GFX28.bin, skipping...")

try:
    with open("./input/shared.pal", "rb") as f:
        shared_pal = f.read()
except:
    shared_pal = None
    print ("Did not find shared.pal, skipping...")

try:
    with open("./input/map.pal", "rb") as f:
        map_pal = f.read()
    map_pal = convert_rgb_snes(map_pal)
    map_colors = bytearray([])
    map_colors += bytearray([map_pal[(0x98*2)+(i)] for i in range(16)])
    map_colors += bytearray([map_pal[(0xA8*2)+(i)] for i in range(16)])
    map_colors += bytearray([map_pal[(0xB8*2)+(i)] for i in range(16)])
except:
    map_pal = None
    print ("Did not find map.pal, skipping...")


if not os.path.exists("./output/"):
    os.makedirs("./output/")

if gfx_32 is not None:
    with open("./output/player.bin", "wb") as f:
        f.write(gfx_32)

if player_gfx is not None:
    with open("./output/player_big.bin", "wb") as f:
        f.write(player_gfx)

if gfx_32 is not None and gfx_00 is not None:
    order = [0x80, 0x91, 0x81, 0x90, 0x82, 0x83]
    gfx_00 += copy_gfx_tiles(gfx_32, order, [5, 32])
    order = [0x69, 0x69, 0x0C, 0x69, 0x1A, 0x1B, 0x0D, 0x69, 0x22, 0x23, 0x32, 0x33, 0x0A, 0x0B, 0x20, 0x21,
            0x30, 0x31, 0x7E, 0x69, 0x80, 0x4A, 0x81, 0x5B, 0x82, 0x4B, 0x83, 0x5A, 0x84, 0x69, 0x85, 0x85]
    player_small_tiles = copy_gfx_tiles(gfx_00, order, [5, 32])
    with open("./output/player_extra.bin", "wb") as f:
        f.write(player_small_tiles)

if gfx_10 is not None:
    if player_gfx is not None:
        order = [0x06, 0x07, 0x16, 0x17,
                0x08, 0x09, 0x18, 0x19,
                0x0A, 0x0B, 0x1A, 0x1B,
                0x0C, 0x0D, 0x1C, 0x1D,
                0x0E, 0x0F, 0x1E, 0x1F,
                0x4C, 0x4D, 0x5C, 0x5D,
                0x24, 0x25, 0x34, 0x35,
                0x46, 0x47, 0x56, 0x57,
                0x64, 0x65, 0x74, 0x75,
                0x66, 0x67, 0x76, 0x77,
                0x2E, 0x2F, 0x3E, 0x3F,
                0x40, 0x41, 0x50, 0x51,
                0x42, 0x43, 0x52, 0x53]
    else:
        order = [0x06, 0x07, 0x16, 0x17,
                0x08, 0x09, 0x18, 0x19,
                0x0A, 0x0B, 0x1A, 0x1B,
                0x0C, 0x0D, 0x1C, 0x1D,
                0x0E, 0x0F, 0x1E, 0x1F,
                0x20, 0x21, 0x30, 0x31,
                0x24, 0x25, 0x34, 0x35,
                0x46, 0x47, 0x56, 0x57,
                0x64, 0x65, 0x74, 0x75,
                0x66, 0x67, 0x76, 0x77,
                0x2E, 0x2F, 0x3E, 0x3F,
                0x40, 0x41, 0x50, 0x51,
                0x42, 0x43, 0x52, 0x53]
    player_map_tiles = copy_gfx_tiles(gfx_10, order, [5, 32])
    with open("./output/player_map.bin", "wb") as f:
        f.write(player_map_tiles)

if gfx_33 is not None:
    with open("./output/yoshi+anim.bin", "wb") as f:
        f.write(gfx_33)

if gfx_28 is not None:
    order = [0x30, 0x31, 0x32, 0x33, 0x34]
    player_name_tiles = copy_gfx_tiles(gfx_28, order, [4, 16])
    with open("./output/player_name.bin", "wb") as f:
        f.write(player_name_tiles)

if shared_pal is not None:
    with open("./output/shared.mw3", "wb") as f:
        f.write(shared_pal)

if map_pal is not None:
    with open("./output/map.mw3", "wb") as f:
        f.write(map_colors)