SECTION "WRAMPARENT", ROM0[$30C0]
LOAD "WRAM", WRAMX[$DA80], BANK[1]

NumInBox:
    db 20

EntryPoint:
    call SwitchToSRA2
    jp MapScriptLoop

GetCthTextEntry:
    ld a, 3
GetCthTextEntryFromBankA:
    call SwitchToSRA
.count
    ld a, [hli]
    and a
    jr z, .found
    inc a
    jr nz, .count
.found
    dec c
    jr nz, .count
.gotEntry
    ; fall through to SwitchToSRA2

SwitchToSRA2:
    ld a, 2
SwitchToSRA:
    ld [$4000], a
    ld a, $0a
    ld [$0000], a
    ret

ReadFromSRA3:
    ld a, 3
ReadFromSRAX:
    call SwitchToSRA
    ld a, [hl]
    push af
    call SwitchToSRA2
    pop af
    ret

SafeCallHL:
    call .jp_hl
    jr SwitchToSRA2
.jp_hl
    jp hl

_DisplayMonFrontSpriteInBox:
    ld hl, DisplayMonFrontSpriteInBox
    ld b, b_DisplayMonFrontSpriteInBox
    call Bankswitch
    jr SwitchToSRA2

LeaveAndCallOrigMapScript:
    xor a
    call SwitchToSRA
    ld hl, wOrigMapScriptPtr
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp hl

LegendaryArtifactCallback:
    call SwitchToSRA2
    jp Interact_LegendaryArtifact2

Item4FCallback:
    call SwitchToSRA2
    jp Interact_Item4FCallback

MagicTextbox:
    db 8 ; TX_ASM
    ; save text ID
    ldh a, [$ff8c]
    ld b, a
    ; find text entry
    ld hl, wTextPtrShadowCopy
.getShadowCopyEntry
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ldh [$ff95], a
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, c
    cp b
    jr nz, .getShadowCopyEntry
.gotEntry
    ; are we talking to NPC?
    xor a
    ldh [$ff8c], a
    push bc
    push de
    call IsSpriteInFrontOfPlayer
    pop de
    pop bc
    ldh a, [$ff8c]
    ; if not, look for the original text
    and a
    jr z, .talkingToSign
.talkingToNPC
    call SwitchToSRA2
    ; integrity check
    ld hl, CheckForWTW
    call RetSum
    cp $f9
    jp nz, IntegrityFail
    ; run interaction
    ld a, [$ff95]
    bit 7, a
    jp z, RunInteractionByID
    sub $80
    call PrintTextVWF
    jr .textScriptEnd
.talkingToSign
    ld h, d
    ld l, e
    ld a, [wCurMap]
    call SwitchToMapRomBank
    call PrintText_NoCreatingTextBox
.textScriptEnd
    jp TextScriptEnd

PRNG:
    ld a, [wRNGVarX]
    inc a
    ld [wRNGVarX], a
    ld b, a
    ld a, [wRNGVarC]
    xor b
    ld b, a
    ld a, [wRNGVarA]
    xor b
    ld [wRNGVarA], a
    ld b, a
    ld a, [wRNGVarB]
    add b
    ld [wRNGVarB], a
    srl a
    xor b
    ld b, a
    ld a, [wRNGVarC]
    add b
    ld [wRNGVarC], a
    ret

RunJumpMaze:
    ld bc, 0
    ld hl, 0
    xor a
    call SwitchToSRA
    db $cd
wJumpMazeTarget:
    dw 0
    jp SwitchToSRA2

wCurrentSRAMBank:
    ds 1

wTextEngineVarsStart:
wTextEngineCurrentGlyph:
    ds 9
wTextEngineWorkingBlocks:
wTextEngineWorkingBlock1:
    ds 8
wTextEngineWorkingBlock2:
    ds 8
wTextEngineBoldFace:
    ds 1
wTextEngineCurrentXPosition:
    ds 1
wTextEngineCurrentCharIndex:
    ds 1
wTextEngineCurrentTilemapIndex:
    ds 1
wTextEngineCharIndexOffset:
    ds 1
wTextEngineVarsEnd:

wTextBoxBufferPtr:
    ds 2
wTextEngineBankFrom:
    ds 1
wTextEngineOffset:
    db 0
wFirstTime:
    db 0
wOrigMapID:
    db $ff
wHexBuffer:
    ds 4
wFunValue:
    db $69
wBallIndex:
    db $ff
wDanceCounter:
wCorrectCounter:
wNumAttempts:
    db 0
wTalkedToScientist:
    db 0
wMazeBetween:
    dw 0
wMazeHighScoreDigit:
    db 0
wRNGVarX:
    db 0
wRNGVarA:
    db 0
wRNGVarB:
    db 0
wRNGVarC:
    db 0

def wOrigMapScriptPtr equ $DE7E
def wEffectiveTextPtrs equ $DE80
def wTextPtrShadowCopy equ $DE30
def wTextPtrShadowCopySentinel equ $DE2F

def hLoadedROMBank equ $ffb8

def MBC1SRamEnable      EQU $0000
def MBC1RomBank         EQU $2000
def MBC1SRamBank        EQU $4000
def MBC1SRamBankingMode EQU $6000

ds $DE50 - @, 0

DMACallback: ; at $DE50
    ; cur map script is always $DA81
    ld a, $81
    ld [wMapScriptPtr], a
    ld a, $da
    ld [wMapScriptPtr+1], a
    ; prepare regs
    ld a, $c3
    ld c, $46
    ret

ds $DE80 - @, 0

RealEntryPoint:
    jp EntryPoint

ENDL