; *** vwf.asm

def CHAR_DEFINITION_SIZE equ 9
def CHAR_TILE_BUFFER_SIZE equ 36
def CHAR_SPACE equ $25
def CHAR_NUMCHARS equ 70

InitTextEngine:
    ld bc, wTextEngineVarsEnd - wTextEngineVarsStart
    ld hl, wTextEngineVarsStart
    xor a
    jp FillMemory

ClearWorkingBlocks:
    ld bc, 16
    ld hl, wTextEngineWorkingBlocks
    xor a
    jp FillMemory

PrintTextVWF:
    ld c, a
    ld hl, Text_Data
    ld a, 3
    call GetCthTextEntryFromBankA
    push hl
    call InitTextEngine
    ld a, 1
    ld [wTextBoxID], a
    call DisplayTextBoxID
    pop hl
    ld a, 3
    ld [wTextEngineBankFrom], a
PrintTextVWFCommandProcessor:
    ld a, [wTextEngineBankFrom]
    call ReadFromSRAX
    inc hl
    and a
    jr z, .done
    cp $fb
    jr nc, .command
    cp CHAR_NUMCHARS+1
    jr nc, .dictionary
    call PrintSingleChar
    jr PrintTextVWFCommandProcessor
.done
    jp RotateBlocks
.command
    sub $fb
    ld c, a
    ld b, 0
    push hl
    ld hl, VWFCommandsJumptable
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld d, [hl]
    ld e, a
    pop hl
    push de
    ret
.dictionary
    ; get entry number
    sub CHAR_NUMCHARS
    ld c, a
    ; save current buffer
    ld de, wTextBoxBufferPtr
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ; bank 2
    ld a, 2
    ld [wTextEngineBankFrom], a
    ; get entry at C
    ld hl, Text_Dict
    ld a, 2
    call GetCthTextEntryFromBankA
    ; go read it
    jr PrintTextVWFCommandProcessor

VWFCommandsJumptable:
    dw TextCommandFB ; wait button
    dw TextCommandFC ; cls with prompt
    dw TextCommandFD ; feed with scroll
    dw TextCommandFE ; feed newline
    dw TextCommandFF ; quit dictionary buffer

TextCommandFB:
    push hl
    call RotateBlocks
    call WaitAPress
    pop hl
    jr PrintTextVWFCommandProcessor

TextCommandFC:
    push hl
    call RotateBlocks
    call WaitButtonPress
    call ClearWorkingBlocks
    xor a
    ld [wTextEngineCurrentXPosition], a
    ld [wTextEngineCurrentCharIndex], a
    ld [wTextEngineCurrentTilemapIndex], a
    coord hl, 1, 13
    ld bc, $0412
    call ClearScreenArea
    ld c, 16
    call DelayFrames
    pop hl
    jr PrintTextVWFCommandProcessor

TextCommandFD:
    push hl
    call RotateBlocks
    call WaitButtonPress
    call ScrollTextUpOneLine
    call ScrollTextUpOneLine
    ld a, SCREEN_WIDTH * 2
    ld [wTextEngineCurrentTilemapIndex], a
    xor a
    ld [wTextEngineCurrentXPosition], a
    pop hl
    jp PrintTextVWFCommandProcessor

TextCommandFE:
    push hl
    call RotateBlocks
    call ClearWorkingBlocks
    ld a, SCREEN_WIDTH * 2
    ld [wTextEngineCurrentTilemapIndex], a
    xor a
    ld [wTextEngineCurrentXPosition], a
    pop hl
    jp PrintTextVWFCommandProcessor

TextCommandFF:
    ld a, 3
    ld [wTextEngineBankFrom], a
    ld de, wTextBoxBufferPtr
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    jp PrintTextVWFCommandProcessor

WaitButtonPress:
    push hl
    coord hl, 18, 17
    ld b, 0
.loop
    push bc
    call DelayFrame
    call JoypadLowSensitivity
    pop bc
    ldh a, [$ffb5]
    and 3
    jr nz, .finish
    inc b
    ld a, b
    and $10
    jr z, .arrow
    ld [hl], $7a
    jr .loop
.arrow
    ld [hl], $ee
    jr .loop
.finish
    ld [hl], $7a
    pop hl
    ld a, $90
    jp PlaySound

PrintSingleChar:
    push hl
    dec a
    cp $24
    jr z, .space
    ld b, a
    ld a, [wTextEngineOffset]
    add b
.space
    ld bc, CHAR_DEFINITION_SIZE
    ld hl, CharacterSet
    call AddNTimes
    ld de, wTextEngineCurrentGlyph
    ld bc, 9
    call CopyData
    ld hl, wTextEngineCurrentGlyph
    call CopyCharToWorkingBlocks
    pop hl
    ret

CopyCharToWorkingBlocks:
    ld a, [hli]
    push af
    ld a, [wTextEngineBoldFace]
    and a
    jr z, .noBold
    pop af
    inc a
    push af
.noBold
    ld a, 8
    ld de, wTextEngineWorkingBlock1
.eachByte
    call RotateAndCopySingleLine
    inc hl
    inc de
    dec a
    jr nz, .eachByte
    ld a, [wTextEngineCurrentXPosition]
    ld b, a
    pop af
    add b
    inc a
    cp 8
    call nc, RotateBlocks
    and 7
    ld [wTextEngineCurrentXPosition], a
    ret

RotateBlocks:
    push af
    ld hl, $8bb0
    ld bc, $0010
    ld a, [wTextEngineCurrentCharIndex]
    inc a
    cp CHAR_TILE_BUFFER_SIZE
    jr c, .noOverflow
    sub CHAR_TILE_BUFFER_SIZE
.noOverflow
    ld [wTextEngineCurrentCharIndex], a
    call AddNTimes
    ld de, wTextEngineWorkingBlocks
    call UpdateVRAMAndDelayFrame
    ld bc, 8
    ld hl, wTextEngineWorkingBlock2
    ld de, wTextEngineWorkingBlock1
    call CopyData
    ld bc, 8
    ld hl, wTextEngineWorkingBlock2
    xor a
    call FillMemory
    ld hl, wTextEngineCurrentTilemapIndex
    inc [hl]
    pop af
    ret

RotateAndCopySingleLine:
    push af
    push de
    push hl
    ld b, [hl]
    ld a, [wTextEngineBoldFace]
    and a
    ld a, b
    jr z, .noBold
    srl b
    or b
.noBold
    ld b, a
    ld c, 0
    ld a, [wTextEngineCurrentXPosition]
.shiftATimes
    and a
    jr z, .isZero
    rr b
    rr c
    dec a
    jr .shiftATimes
.isZero
    ld h, d
    ld l, e
    ld de, 8
    ld a, b
    or [hl]
    ld [hl], a
    add hl, de
    ld [hl], c
    pop hl
    pop de
    pop af
    ret

UpdateVRAMAndDelayFrame:
    di
    ld c, 8
.waitHblank
    ldh a, [rSTAT]
    and %00000011
    jr nz, .waitHblank
    ld a, [de]
    ld [hli], a
    ld [hli], a
    inc de
.waitNoHblank
    ldh a, [rSTAT]
    and %00000011
    jr z, .waitNoHblank
    dec c
    jr nz, .waitHblank
.recalc
    coord hl, 1, 14
    ld a, [wTextEngineCurrentTilemapIndex]
    ld b, 0
    ld c, a
    add hl, bc
    ld a, h
    cp $c5
    jr c, .ok
    xor a
    ld [wTextEngineCurrentTilemapIndex], a
    jr .recalc
.ok
    ld a, [wTextEngineCurrentCharIndex]
    add $bb
    ld [hl], a
    ld a, $7c
    ld [$c4f3], a
    ld [$c4cb], a
    ei
    jp DelayFrame

CharacterSet:
    include "includes/charset.asm"