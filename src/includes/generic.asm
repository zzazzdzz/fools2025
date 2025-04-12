def SCREEN_WIDTH equ 20
def SCREEN_HEIGHT equ 18

MACRO coord
    IF _NARG >= 4
        ld \1, \4 + SCREEN_WIDTH * \3 + \2
    ELSE
        ld \1, wTileMap + SCREEN_WIDTH * \3 + \2
    ENDC
ENDM

MACRO spr_table
    db \1
    dw \2 | $8000
ENDM

MACRO ram_table
    db \1
    dw \2 ^ $8000
ENDM

MACRO ram_entry
    db (HIGH(\1) & 0b00011111) | ((_NARG-1) << 5)
    db LOW(\1)
    shift
    rept _NARG
        db \1
        shift
    endr
ENDM

MACRO spr_entry
    db \1, (\4)+4, (\3)+4, \2, \6, \5
    ; <sprite idx><y><x><base offs><movement byte 2><action ID = high bit = textboxID-0x80>
ENDM