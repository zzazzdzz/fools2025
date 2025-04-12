SECTION "SRA2PARENT", ROMX[$4000], BANK[1]
LOAD "SRA2", SRAM[$A000], BANK[2]

_SRA2Checksum:
    ds 1

include "engine/util.asm"
include "engine/vwf.asm"
include "engine/hook.asm"
include "engine/interaction.asm"
include "engine/anticheat.asm"
include "engine/content.asm"
include "engine/maze.asm"
include "engine/crackme.asm"

MapScriptLoop:
    ; if entered new map, hook the map
    ld a, [wCurMap]
    ld b, a
    ld a, [wOrigMapID]
    cp b
    call nz, HookNewMap
    ; if dma hijacking not in effect, apply it
    ldh a, [$ff80]
    cp $cd
    call nz, HookDMA
    ; show intro if loading the file for the first time
    ld a, [wFirstTime]
    and a
    jr z, FirstTimeTextbox
    ; no wild encounters
    ld a, $ff
    ld [wRepelRemainingSteps], a
    ; prevent PC usage
    call DisableAButtonWhenInFrontOfPC
    ; check for wtw
    call CheckForWTW
    ; check integrity of tile check funcywunks owo
    ld hl, $0c18
    call RetSum
    cp $bf
    jp nz, IntegrityFail
    ; call orig map script
    jp LeaveAndCallOrigMapScript

DisableAButtonWhenInFrontOfPC:
    ; no change if not in pokemon center map
    ld a, [wCurMapTileset]
    cp $06
    ret nz
    ; default to all enabled
    xor a
    ld [wJoyIgnore], a
    ; if x=$0d & y=$04
    ld hl, wXCoord
    ld a, [hld]
    cp $0d
    ret nz
    ld a, [hl]
    cp $04
    ret nz
    ; disable if match
    ld a, 1
    ld [wJoyIgnore], a
	; btw i know there's a pc in silph co and celadon condominium
	; if ppl specifically look for that and try to switch boxes, then
	; they're probably just bored nerds trying to break the save on
	; purpose, and they get what they deserve (xkcd insurance moment)
    ret 

FirstTimeTextbox:
    ; set some initial vars
    ld a, $36
    ld [wBagItems], a
    ld a, 1
    ld [wFirstTime], a
    ld a, 4
    ld [wSpritePlayerStateData1FacingDirection], a
    ld hl, wNumBoxItems
    xor a
    ld [hli], a
    dec a
    ld [hl], a
    ; prepare for textbox
    call TextboxEnable
    ld c, 80
    call DelayFrames
    ; check ROM
    call CheckROM
    cp $30
    jr nz, .wrongROM
    ; show intro message
    ld a, 1
    call PrintTextVWF
    call Random
    ld [wFunValue], a
    jp ReturnFromTextboxToOverworld
.wrongROM
    ld a, $4b
    call PrintTextVWF
.forever
    jr .forever

FirstTimeRotatePlayerOneStep:
    ld [wSpritePlayerStateData1FacingDirection], a
    ld c, 20
    jp DelayFrames

Text_Dict:
    incbin "text_dictionary.bin"

SRA2_End:

ENDL