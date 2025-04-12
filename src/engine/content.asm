def MOVEMENT_FACE_DOWN equ $d0
def MOVEMENT_FACE_UP equ $d1
def MOVEMENT_FACE_LEFT equ $d2
def MOVEMENT_FACE_RIGHT equ $d3
def MOVEMENT_SPIN equ $ff

def MAP_MOD_ENTRY_SIZE equ 6

ModifyCurrentMap:
    ld a, [wCurMap]
    ld c, a
    ld de, MapModificationTable
.readTable
    ld a, [de]
    inc de
    cp $ff
    ret z
    cp c
    jr z, .found
    inc de
    inc de
    jr .readTable
.found
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    bit 7, a
    jr nz, .spriteTbl
.ramTbl
    or $80
    ld h, a
    inc de
    push de
    push bc
    call LoadModificationScriptRAM
    pop bc
    pop de
    jr .readTable
.spriteTbl
    ld h, a
    inc de
    push de
    push bc
    call LoadModificationScriptSprites
    pop bc
    pop de
    jr .readTable

MapModificationTable:
    ; <mapID><table ptr, hibit=sprite, lobit=ramwr>, term with ff
    ram_table $05, MapModificationsVermilion_RAM
    spr_table $05, MapModificationsVermilion_Sprite
    spr_table $02, MapModificationsPewter_Sprite
    ram_table $02, MapModificationsPewter_RAM
    spr_table $c5, MapModificationsDiglettsCave_Sprite
    ram_table $c5, MapModificationsDiglettsCave_RAM
    spr_table $06, MapModificationsCeladon_Sprite
    spr_table $04, MapModificationsLavender_Sprite
    spr_table $b7, MapModificationsSaffronHouse_Sprite
    ram_table $1f, MapModificationsRoute20_RAM
    spr_table $1f, MapModificationsRoute20_Sprite
    spr_table $03, MapModificationsCerulean_Sprite
    spr_table $23, MapModificationsRoute24_Sprite
    ram_table $23, MapModificationsRoute24_RAM
    ram_table $1d, MapModificationsRoute18_RAM
    spr_table $1d, MapModificationsRoute18_Sprite
    spr_table $07, MapModificationsFuchsia_Sprite
    spr_table $e5, MapModificationsNameRaterHouse_Sprite
    ram_table $8e, MapModificationsLavTower_RAM
    spr_table $8e, MapModificationsLavTower_Sprite
    spr_table $00, MapModificationsPalletTown_Sprite
    ram_table $0f, MapModificationsRoute4_RAM
    spr_table $0f, MapModificationsRoute4_Sprite
    spr_table $13, MapModificationsRoute8_Sprite
    ram_table $0d, MapModificationsRoute2_RAM
    spr_table $0d, MapModificationsRoute2_Sprite
    ram_table $a3, MapModificationsVermilionHouse_RAM
    spr_table $a3, MapModificationsVermilionHouse_Sprite
    ram_table $c7, MapModificationsRocketHideout_RAM
    spr_table $c7, MapModificationsRocketHideout_Sprite
    ram_table $17, MapModificationsRoute12_RAM
    spr_table $17, MapModificationsRoute12_Sprite
    spr_table $21, MapModificationsRoute22_Sprite
    spr_table $01, MapModificationsViridian_Sprite
    spr_table $a5, MapModificationsCinnabarMansion_Sprite
    spr_table $15, MapModificationsRoute10_Sprite
    ram_table $15, MapModificationsRoute10_RAM
    spr_table $22, MapModificationsIndigo_Sprite
    ram_table $01, MapModificationsViridian_RAM
    ram_table $58, MapModificationsBillsHouse_RAM
    spr_table $58, MapModificationsBillsHouse_Sprite
    spr_table $08, MapModificationsCinnabar_Sprite
    db $ff

    ;         Sprite & VRAM index               X    Y    AID   Movement
    ;         --------------------------------- ---- ---- ----- ----------------------
MapModificationsVermilion_Sprite:
    spr_entry SPRITE_YOUNGSTER, 4,              $21, $1b, $02,  MOVEMENT_FACE_RIGHT
    spr_entry SPRITE_GUARD, 7,                  $12, $10, $86,  MOVEMENT_SPIN
    db 0
MapModificationsPewter_Sprite:
    spr_entry SPRITE_HIKER, 5,                  $20, $05, $03,  MOVEMENT_SPIN
    spr_entry SPRITE_COOLTRAINER_M, 10,         $07, $05, $04,  MOVEMENT_SPIN
    spr_entry SPRITE_COOLTRAINER_F, 9,          $18, $14, $cc,  MOVEMENT_SPIN
    db 0
MapModificationsDiglettsCave_Sprite:
    spr_entry SPRITE_POKE_BALL, 2,              $0c, $14, $01,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsCeladon_Sprite:
    spr_entry SPRITE_LITTLE_GIRL, 2,            $2d, $17, $05,  MOVEMENT_FACE_RIGHT
    spr_entry SPRITE_MIDDLE_AGED_MAN, 6,        $17, $1e, $14,  MOVEMENT_SPIN
    spr_entry SPRITE_GRAMPS, 7,                 $25, $0a, $d5,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsLavender_Sprite:
    spr_entry SPRITE_HIKER, 5,                  $01, $0e, $06,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsSaffronHouse_Sprite:
    spr_entry SPRITE_GENTLEMAN, 2,              $02, $03, $07,  MOVEMENT_FACE_RIGHT
    db 0
MapModificationsRoute20_Sprite:
    spr_entry SPRITE_YOUNGSTER, 2,              $2c, $07, $08,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsCerulean_Sprite:
    spr_entry SPRITE_COOLTRAINER_F, 9,          $22, $19, $cd,  MOVEMENT_SPIN
    spr_entry SPRITE_COOLTRAINER_M, 10,         $11, $08, $09,  MOVEMENT_SPIN
    db 0
MapModificationsRoute24_Sprite:
    spr_entry SPRITE_SUPER_NERD, 4,             $09, $05, $0a,  MOVEMENT_SPIN
    db 0
MapModificationsRoute18_Sprite:
    spr_entry SPRITE_POKE_BALL, 11,             $1e, $0d, $0b,  MOVEMENT_FACE_DOWN
    spr_entry SPRITE_POKE_BALL, 11,             $22, $0e, $0b,  MOVEMENT_FACE_DOWN
    spr_entry SPRITE_POKE_BALL, 11,             $1f, $0f, $0b,  MOVEMENT_FACE_DOWN
    spr_entry SPRITE_COOLTRAINER_M, 3,          $29, $08, $ce,  MOVEMENT_FACE_RIGHT
    db 0
MapModificationsFuchsia_Sprite:
    spr_entry SPRITE_COOLTRAINER_M, 3,          $0f, $14, $15,  MOVEMENT_SPIN
    spr_entry SPRITE_YOUNGSTER, 10,             $24, $09, $1b,  MOVEMENT_SPIN
    db 0
MapModificationsNameRaterHouse_Sprite:
    spr_entry SPRITE_WARDEN, 2,                 $02, $03, $0c,  MOVEMENT_FACE_RIGHT
    db 0
MapModificationsLavTower_Sprite:
    spr_entry SPRITE_DAISY, 6,                  $0a, $01, $0d,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsPalletTown_Sprite:
    spr_entry SPRITE_GAMBLER, 7,                $10, $0b, $17,  MOVEMENT_FACE_LEFT
    db 0
MapModificationsRoute4_Sprite:
    spr_entry SPRITE_ROCKET, 3,                 $2f, $0b, $a2,  MOVEMENT_SPIN
    spr_entry SPRITE_ROCKET, 3,                 $30, $04, $0e,  MOVEMENT_SPIN
    db 0
MapModificationsRoute8_Sprite:
    spr_entry SPRITE_LITTLE_GIRL, 2,            $18, $08, $0f,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsRoute2_Sprite:
    spr_entry SPRITE_YOUNGSTER, 3,              $01, $33, $c7,  MOVEMENT_SPIN
    spr_entry SPRITE_MONSTER, 6,                $06, $1b, $10,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsVermilionHouse_Sprite:
    spr_entry SPRITE_SUPER_NERD, 3,             $02, $04, $11,  MOVEMENT_FACE_RIGHT
    db 0
MapModificationsRocketHideout_Sprite:
    spr_entry SPRITE_SCIENTIST, 3,              $0c, $08, $12,  MOVEMENT_FACE_DOWN
    spr_entry SPRITE_POKE_BALL, 11,             $0a, $0c, $13,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsRoute12_Sprite:
    spr_entry SPRITE_ROCKER, 9,                 $0f, $25, $16,  MOVEMENT_FACE_DOWN
    spr_entry SPRITE_POKE_BALL, 11,             $0d, $08, $b1,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsRoute22_Sprite:
    spr_entry SPRITE_GIRL, 4,                   $1f, $09, $18,  MOVEMENT_SPIN
    db 0
MapModificationsViridian_Sprite:
    spr_entry SPRITE_FISHER, 5,                 $22, $0b, $19,  MOVEMENT_SPIN
    spr_entry SPRITE_BLUE, 2,                   $0e, $10, $c6,  MOVEMENT_FACE_UP
    db 0
MapModificationsCinnabarMansion_Sprite:
    spr_entry SPRITE_SCIENTIST, 2,              $07, $06, $1a,  MOVEMENT_FACE_UP
    db 0
MapModificationsRoute10_Sprite:
    spr_entry SPRITE_HIKER, 5,                  $07, $26, $c3,  MOVEMENT_FACE_DOWN
    spr_entry SPRITE_SUPER_NERD, 4,             $05, $2a, $1c,  MOVEMENT_SPIN
    db 0
MapModificationsIndigo_Sprite:
    spr_entry SPRITE_GYM_GUIDE, 3,              $0f, $24, $1d,  MOVEMENT_SPIN
    spr_entry SPRITE_COOLTRAINER_F, 6,          $0e, $0a, $cf,  MOVEMENT_FACE_DOWN
    db 0
MapModificationsBillsHouse_Sprite:
    spr_entry SPRITE_SILPH_PRESIDENT, 2,        $07, $05, $d0,  MOVEMENT_FACE_RIGHT
    spr_entry SPRITE_OLD_AMBER, 3,              $0b, $05, $1e,  MOVEMENT_FACE_DOWN
    spr_entry SPRITE_SILPH_PRESIDENT, 2,        $03, $03, $1f,  MOVEMENT_FACE_DOWN
    spr_entry SPRITE_SILPH_PRESIDENT, 2,        $01, $05, $d2,  MOVEMENT_FACE_UP
    db 0
MapModificationsCinnabar_Sprite:
    spr_entry SPRITE_FISHER, 5,                 $0a, $07, $d4,  MOVEMENT_FACE_DOWN
    db 0

MapModificationsVermilion_RAM:
    ram_entry $c8b5, $78
    ram_entry $c89b, $54
    db 0
MapModificationsDiglettsCave_RAM:
    ram_entry $c877, $ff
    ram_entry $c828, $ff
    ram_entry $c841, $ff, $01, $01, $ff
    ram_entry $c80f, $ff
    db 0
MapModificationsPewter_RAM:
    ram_entry $c755, $ff, $fe
    ram_entry $c78a, $fd
    db 0
MapModificationsRoute20_RAM:
    ram_entry $c7d0+7*0, $43,$43,$0f,$0f,$0f,$6c,$6c
    ram_entry $c7d0+7*1, $6c,$6c,$0f,$0f,$0f,$51,$0c
    ram_entry $c7d0+7*2, $0e,$0f,$0f,$6c,$33,$36,$7a
    ram_entry $c808+7*0, $54,$54,$7b,$7a,$59,$54,$3e
    ram_entry $c808+7*1, $3b,$54,$47,$47,$47,$7b,$37
    ram_entry $c808+7*2, $7e,$1e,$33,$60,$33,$60,$7a
    ram_entry $c840+7*0, $78,$78,$7a,$7b,$59,$54,$24
    ram_entry $c840+7*1, $25,$54,$51,$51,$51,$50,$59
    ram_entry $c840+7*2, $59,$42,$34,$36,$35,$13,$7a
    ram_entry $c878+7*0, $43,$43,$0f,$0f,$0f,$6f,$6f
    ram_entry $c878+7*1, $6f,$0f,$61,$61,$61,$13,$13
    ram_entry $c878+7*2, $13,$7b,$6e,$34,$34,$13,$7a
    ram_entry $c8b0+7*0+2,       $1f,$1f,$1f,$1f,$1f
    ram_entry $c8b0+7*1, $1f,$1f,$1f,$1f,$1f,$1f,$1f
    ram_entry $c8b0+7*2, $1f,$1f,$1f,$1f,$1f,$1f,$1f
    ram_entry $c2a4, $69
    ram_entry $c284, $69
    ram_entry $c274, $69
    ram_entry $c234, $69
    db 0
MapModificationsRoute24_RAM:
    ram_entry $c73d, $0b,$0b,$0b,$0b
    ram_entry $c75d, $0b,$0b,$0b
    db 0
MapModificationsRoute18_RAM:
    ram_entry $c7f1, $13,$13,$13,$13
    ram_entry $c810, $4e,$0a,$0a,$0a
    ram_entry $c82f, $4e,$0a,$0a,$0a
    ram_entry $c84e, $50,$52,$52,$52
    ram_entry $c76a, $0f,$0f,$0f,$0f
    ram_entry $c7d8, $1b
    ram_entry $c215, $69
    ram_entry $c235, $69
    db 0
MapModificationsLavTower_RAM:
    ram_entry $c71f, 2,99,2
    ram_entry $c72f, 75,51,69
    db 0
MapModificationsRoute4_RAM:
    ram_entry $c908, $ff
    ram_entry $c829, $4f
    db 0
MapModificationsRoute2_RAM:
    ram_entry $c901, $6f
    ram_entry $c7ed, $6d,$0a
    ram_entry $c7fd, $6d,$0a,$0a,$0a,$0a
    db 0
MapModificationsVermilionHouse_RAM:
    ram_entry $d35d, $05
    ram_entry $c215, $69
    db 0
MapModificationsRocketHideout_RAM:
    ram_entry $c782, $50,$58,$2d,$52,$0e
    ram_entry $c79a, $0c
    db 0
MapModificationsRoute12_RAM:
    ram_entry $c841, $78
    ram_entry $c831, $54
    ram_entry $c771, $78
    ram_entry $c761, $54
    db 0
MapModificationsRoute10_RAM:
    ram_entry $c89b, $29,$66,$3e
    ram_entry $c88c, $1d
    ram_entry $c8ab, $29,$66,$28
    ram_entry $c8bb, $29,$66,$24
    ram_entry $c82c, $74,$74,$0c,$0e
    ram_entry $c83c, $6e,$4c,$3c,$3d
    ram_entry $c84c, $6e,$0f,$4c,$0b
    ram_entry $c85c, $0a,$6c,$0a,$0b
    ram_entry $c86c, $36,$4c,$0a,$0b
    ram_entry $c87c, $74,$6c,$0a,$0b,$0f
    ram_entry $c215, $69
    db 0
MapModificationsViridian_RAM:
    ram_entry $c7f5, $30,$03
    ram_entry $c810, $0a
    db 0
MapModificationsBillsHouse_RAM:
    ram_entry $c235, $69
    ram_entry $c722, $0e
    db 0

LoadModificationScriptRAM:
    ld a, [hli]
    and a
    ret z
    ld c, a
    ; 16bit ram addr in de
    and $1f
    add $c0
    ld d, a
    ld e, [hl]
    inc hl
    ; length in c
    ld a, c
    and $e0
    swap a
    rrca
    ld c, a
.writeCmd
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .writeCmd
    ; go next
    jr LoadModificationScriptRAM

LoadModificationScriptSprites:
    ld a, [hl]
    and a
    ret z
    cp SPRITE_MONSTER
    jr nz, .notFun
    ld a, [wFunValue]
    add $33
    ret nc
.notFun
    push hl
    call LoadSingleSpriteEntry
    ldh a, [hLoadedROMBank]
    ld hl, wNumSprites
    inc [hl]
    pop hl
    ld bc, MAP_MOD_ENTRY_SIZE
    add hl, bc
    jr LoadModificationScriptSprites
LoadSingleSpriteEntry:
    ld d, h
    ld e, l
    ld a, [wNumSprites]
    inc a
    swap a
    ld l, a
    ld h, $c1
    push hl
    ; sprite attributes #1
    ; image index
    ld a, [de]
    inc de
    ld [hli], a
    ; movement state
    ld a, 1
    ld [hli], a
    ; move to sprite attributes #2
    ld h, $c2
    ; y,x displacements
    ld a, 8
    ld [hli], a
    ld [hli], a
    ; map y,x
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ; movement byte
    ld [hl], $ff
    ; image base offset
    ld a, l
    add 8
    ld l, a
    ld a, [de]
    inc de
    ld [hl], a
    ; movement byte 2
    ld a, [wNumSprites]
    add a
    ld hl, wMapSpriteData
    add l
    ld l, a
    ld a, [de]
    inc de
    ld [hl], a
    ; save action ID in c
    ld a, [de]
    ld c, a
    ; repoint text
    ld a, [wNumSprites]
    ld b, a
    add a
    ld hl, wEffectiveTextPtrs
    add l
    ld l, a
    ; save the orig text pointer to de
    ld a, [hli]
    ld e, a
    ld a, [hld]
    ld d, a
    ; overwrite the pointer
    ld a, LOW(MagicTextbox)
    ld [hli], a
    ld a, HIGH(MagicTextbox)
    ld [hl], a
    ; save the orig text pointer in the shadow copy
    ; start by looking for a free slot
    ld hl, wTextPtrShadowCopy+31
.slotSearch
    ld a, [hld]
    inc a
    jr z, .slotSearch
.slotFound
    inc hl
    inc hl
    ; free shadow copy slot in hl
    inc b
    ld [hl], b
    inc hl
    ld [hl], c
    inc hl
    ld [hl], e
    inc hl
    ld [hl], d
    pop hl
    ret

