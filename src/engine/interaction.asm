RunInteractionByID:
    push af
    ld c, a
    ld b, 0
    ld hl, RunInteractionTable
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    pop af
    ld de, TextScriptEnd
    push de
    jp hl

RunInteractionTable:
    dw Interact_ObjectEvent
    dw Interact_LegendaryArtifact
    dw Interact_TextboxThenGiveEntry ;2
    dw Interact_TextboxThenGiveEntry ;3
    dw Interact_TextboxThenGiveEntry ;4
    dw Interact_MathGirl
    dw Interact_Get4F
    dw Interact_BallsGuy
    dw Interact_TextboxThenGiveEntry ;8
    dw Interact_Delirian
    dw Interact_GrassGuy
    dw Interact_MysteriousBalls
    dw Interact_WorriedExplorer
    dw Interact_Therapy
    dw Interact_TextboxThenGiveEntry ;14
    dw Interact_TextboxThenGiveEntry ;15
    dw Interact_TextboxThenGiveEntry ;16
    dw Interact_DarkHouse
    dw Interact_CardKeyScientist
    dw Interact_TextboxThenGiveEntry ;19
    dw Interact_GiveHM05
    dw Interact_GiveCardKey
    dw Interact_GiveCoinCase
    dw Interact_PalletResearchGuy
    dw Interact_Dancer
    dw Interact_WhosThatPokemon
    dw Interact_MansionScientist
    dw Interact_MazeGuy
    dw Interact_FlashGuy
    dw Interact_Q
    dw Interact_Amber
    dw Interact_Crackme

Interact_LegendaryArtifact:
    ld a, $05
    call PrintTextVWF
    call YesNoChoice
    ld a, [wCurrentMenuItem]
	and a
    jr nz, .quit
    ld a, $69
    ld [$c215], a
    ld a, [wFunValue]
    cp $20
    jr nc, .tame
    ld hl, .glitchRamScript
    call LoadModificationScriptRAM
    ld a, $09
    jp PrintTextVWF
.tame
    ld a, $16
    jp PrintTextVWF
.quit
    ld a, $07
    jp PrintTextVWF
.glitchRamScript
    ram_entry wJoyIgnore, $f6
    ram_entry wBattleAndStartSavedMenuItem, $02
    ram_entry wMapPalOffset, $0e
    ram_entry wAudioFadeOutControl, $33
    ram_entry wListScrollOffset, $00
    ram_entry wBagSavedMenuItem, $00
    ram_entry wNumBagItems, $99,$5d,$99,$99,$05,
    ram_entry wNumBagItems+5, $99,$99,$99,$99
    ram_entry wPlayerName, $99,$99,$83,$99,$99
    ram_entry wPlayerName+5, $a4,$99,$99,$ff,$99
    ram_entry wPlayerName+10, $99,$04,$99,$99,$50
    ram_entry wBattleType, $03
    ram_entry wMapMusicSoundID, $ff
    ram_entry wPartyCount, $c3, LOW(LegendaryArtifactCallback), HIGH(LegendaryArtifactCallback)
    db 0
Interact_LegendaryArtifact2:
    ld c, 30
    call DelayFrames
    ld hl, GlitchedMusicChan
    call PlayMusicFromRAM
    ld de, 400
.startFill
    ld hl, wTileMap
    ld bc, 18*20
.fillLoop
    inc [hl]
    inc hl
    dec bc
    ld a, b
    or c
    jr nz, .fillLoop
    dec de
    ld a, d
    or e
    jr nz, .startFill
    call ClearScreen
    ld hl, PoketrainerMusicChan
    call PlayMusicFromRAM
    ld de, PoketrainerFlavor1
    call PoketrainerTextWriter
    ld c, 150
    call DelayFrames
    call ClearScreen
    ld de, PoketrainerFlavor2
    call PoketrainerTextWriter
    ld c, 100
    call DelayFrames
    call ClearScreen
    ld de, PoketrainerFlavor3
    call PoketrainerTextWriter
    ld c, 200
    call DelayFrames
    call ClearScreen
    ld de, PoketrainerFlavor4
    call PoketrainerTextWriter
    ld c, 150
    call DelayFrames
    call ClearScreen
    ld de, PoketrainerFlavor5
    call PoketrainerTextWriter
    ld c, 200
    call DelayFrames
    call ClearScreen
    ld a, 1
    call GiveEntry
    call WaitAPress
    ld c, 20
    call DelayFrames
    jp SoftReset

PoketrainerTextWriter:
    coord hl, 1, -1
    push hl
.textWriter
    ld a, [de]
    inc de
    cp $4f
    jr z, .advance
    cp $4e
    jr z, .advance2
    cp $50
    jr z, .done
    ld [hli], a
    halt 
    halt 
    halt 
    jr .textWriter
.advance2
    ld a, [wMusicTempo+1]
    add $10
    ld [wMusicTempo+1], a
.advance
    pop hl
    ld bc, 40
    add hl, bc
    push hl
    jr .textWriter
.done
    pop hl
    ret

PoketrainerFlavor1:
    db $4f,$80,$b2,$7f,$a0,$7f,$b5,$a8,$a3,$a4,$ae,$7f,$a6,$a0,$ac,$a4,$4f
    db $a6,$b1,$ae,$b6,$b2,$7f,$ae,$ab,$a3,$f4,$4f
    db $a8,$b3,$b2,$7f,$a2,$ae,$ad,$b3,$a4,$ad,$b3,$7f,$a0,$ad,$a3,$4f
    db $a8,$ad,$b3,$a4,$b1,$ad,$a0,$ab,$7f,$ab,$ae,$a6,$a8,$a2,$4f
    db $a3,$a4,$b3,$a4,$b1,$a8,$ae,$b1,$a0,$b3,$a4,$e8,$50
PoketrainerFlavor2:
    db $4f,$81,$b4,$b3,$7f,$a8,$b3,$bd,$7f,$ad,$ae,$b3,$7f,$a9,$b4,$b2,$b3,$4f
    db $b3,$a7,$a4,$7f,$a6,$a0,$ac,$a4,$7f,$a1,$b1,$a4,$a0,$aa,$a8,$ad,$a6,$4f
    db $a3,$ae,$b6,$ad,$e8,$50
PoketrainerFlavor3:
    db $4f,$88,$b3,$bd,$7f,$b2,$ae,$ac,$a4,$b3,$a7,$a8,$ad,$a6,$4e
    db $a4,$ab,$b2,$a4,$e8,$4e
    db $92,$ae,$ac,$a4,$b3,$a7,$a8,$ad,$a6,$7f,$a0,$ab,$a8,$b5,$a4,$e8,$50
PoketrainerFlavor4:
    db $4f,$0f,$ab,$a4,$a0,$32,$a4,$7f,$32,$ae,$2c,$24,$ae,$2d,$24,$f4,$4e
    db $26,$28,$b5,$a4,$7f,$2c,$24,$7f,$20,$7f,$2c,$a4,$20,$2d,$28,$ad,$26,$68,$50
PoketrainerFlavor5:
    db $4f,$01,$24,$25,$2e,$31,$24,$7f,$33,$27,$24,$38,$7f,$33,$20,$2a,$24,$4e
    db $2c,$24,$7f,$33,$2e,$7f,$33,$27,$24,$4e
    db $24,$2c,$24,$31,$26,$24,$2d,$22,$38,$7f,$31,$2e,$2e,$2c,$68,$50

PoketrainerMusicBlank:
    db $ff
PoketrainerMusicData:
    incbin "includes/poketrainer.bin"
    db $fe,$ff
    dw PoketrainerMusicData+3
PoketrainerMusicChan:
    dw PoketrainerMusicBlank
    dw PoketrainerMusicBlank
    dw PoketrainerMusicData
    dw PoketrainerMusicBlank
GlitchedMusicChan:
    dw $0fad
    dw $1cff
    dw $2a95
    dw $3199

Interact_TextboxThenGiveEntry:
    ; reg a still contains the ID
    push af
    call PrintTextVWF
    ; display the code
    pop af
    jp GiveEntry

GiveEntry:
    push af
    ld hl, MapScriptLoop
    call RetSum
    cp $eb
    jp nz, IntegrityFail
    ; fade out music
    ld hl, wAudioFadeOutCounter
    ld [hl], $06
    dec hl
    ld [hl], $06
    dec hl
    ld [hl], $ff
    ld c, 60
    call DelayFrames
    ; clear code buffer
    ld hl, wHexBuffer
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ; draw border
    coord hl, 5, 9
    ld bc, $0108
    call TextBoxBorder
    call UpdateSprites
    pop af
    ; get code and display it
    ld hl, $1f3c
    ld b, 0
    ld c, a
    add hl, bc
    add hl, bc
    add hl, bc
    ld c, 20
.numberAnim
    push bc
    ld de, wHexBuffer
    ld c, 4
.xorNewData
    ld a, [de]
    xor [hl]
    ld [de], a
    inc de
    inc hl
    dec c
    jr nz, .xorNewData
    push hl
    coord hl, 6, 10
    call PrintHex4
    ld a, SFX_WITHDRAW_DEPOSIT
    call PlaySound
    ld c, 5
    call DelayFrames
    pop hl
    pop bc
    dec c
    jr nz, .numberAnim
.showCode
    ld a, SFX_GET_ITEM_2
    call PlaySound
    call WaitForSoundToFinish
    ld c, 30
    call DelayFrames
    call PlayDefaultMusic
    coord hl, 0, 0
    ld bc, $0312
    call TextBoxBorder
    call UpdateSprites
    ld hl, EnterCodeText
    ld de, wTileMap+20
    ld bc, EnterCodeTextEnd - EnterCodeText
    call CopyData
    ld c, 30
    jp DelayFrames

EnterCodeText:
    db $7c,$84,$ad,$b3,$a4,$b1,$7f,$b3,$a7,$a4,$7f,$a2,$ae,$a3,$a4,$7f,$ae,$ad,$9c,$7c
    db $7c,$b9,$b9,$a0,$b9,$b9,$a3,$b9,$b9,$e8,$a6,$a8,$b3,$a7,$b4,$a1,$e8,$a8,$ae,$7c
    db $7c,$7f,$7f,$7f,$7f,$f3,$a5,$ae,$ae,$ab,$b2,$f8,$f6,$f8,$fb
EnterCodeTextEnd:

Interact_MathGirl:
    ld a, $0a
    call PrintTextVWF
    call YesNoChoice
    ld a, [wCurrentMenuItem]
	and a
    jr nz, .quit
    ld a, $0c
    call PrintTextVWF
    ld a, 50
    ld [wMaxItemQuantity], a
    call DisplayChooseQuantityMenu
    inc a
    jr z, .incorrect
    ld a, [wItemQuantity]
    cp 36
    jr nz, .incorrect
    ld a, $23
    call PrintTextVWF
    ld a, 5
    jp GiveEntry
.incorrect
    ld a, $0d
    jr .prnt
.quit
    ld a, $0b
.prnt
    jp PrintTextVWF

Interact_Get4F:
    ld b, $59
    call IsItemInBag
    call z, .obtain
    ld a, $25
    jp PrintTextVWF
.obtain
    ld c, 1
    ld b, $59
    call GiveItem
    ld a, $24
    call PrintTextVWF
    ld a, SFX_GET_ITEM_2
    call PlaySoundWaitForCurrent
	jp WaitForSoundToFinish

Interact_Item4FCallback:
    ld c, 20
    call DelayFrames
    ld a, SFX_SWITCH
    call PlaySound
    ld a, $11
    call PrintTextVWF
    ld hl, wOverworldMap
    ld bc, 750
.loop
    ld a, [hl]
    cp $7f
    jr c, .nope
    ld [hl], 1
.nope
    inc hl
    dec bc
    ld a, c
    or b
    jr nz, .loop
.fin
    ld a, SFX_CUT
    call PlaySound
RedrawMapAndGoBackToOverworld:
    ld c, 40
    call DelayFrames
    call ReturnFromTextboxToOverworld
    ld hl, RedrawMapView
    ld b, b_RedrawMapView
    call Bankswitch
	; meow
    xor a
    ld [wLetterPrintingDelayFlags], a
    ld sp, $dfff
    jp OverworldLoop

Interact_BallsGuy:
    ld a, $12
    call PrintTextVWF
    call YesNoChoice
    ld a, [wCurrentMenuItem]
	and a
    jr nz, .quit
    ld b, $01
    call IsItemInBag
    jr z, .noBalls
    ld a, $14
    call PrintTextVWF
    ld a, 6
    jp GiveEntry
.noBalls
    ld a, $15
    jr .prnt
.quit
    ld a, $2a
.prnt
    jp PrintTextVWF

Interact_MysteriousBalls:
    ld a, [wBallIndex]
    cp 5
    jr z, .win
    jr nc, .reset
    ld hl, .steps
    ld c, a
    ld b, 0
    add hl, bc
    ld c, [hl]
    ld a, [wStepCounter]
    cp c
    jr nz, .reset
    ld a, $1b
    call PrintTextVWF
    ld a, SFX_SWITCH
    call PlaySound
    call WaitForSoundToFinish
    ld hl, wBallIndex
    inc [hl]
    xor a
    ld [wStepCounter], a
    ret
.win
    ld a, [wStepCounter]
    inc a
    jr nz, .reset
    ld a, $1c
    ld [wBallIndex], a
    call PrintTextVWF
    ld c, 1
    ld b, 1
    call GiveItem
    ld a, SFX_GET_ITEM_2
    call PlaySoundWaitForCurrent
	jp WaitForSoundToFinish
.reset
    ld a, $1a
    call PrintTextVWF
    coord hl, 6, 9
    ld bc, $0106
    call TextBoxBorder
    call UpdateSprites
    coord de, 7, 10
    ld hl, .numbers
    ld bc, 6
    call CopyData
    xor a
    ld [wStepCounter], a
    ld [wBallIndex], a
    ret
.numbers
    db $f8,$f9,$fc,$f9,$ff,$f7
.steps
    db -2, -3, -6, -3, -9, -1

Interact_ObjectEvent:
    ld hl, .text
    jp PrintText
.text
    db $00,$8e,$a1,$a9,$a4,$a2,$b3,$7f,$a4,$b5,$a4,$ad,$b3,$e8,$57

Interact_Delirian:
    xor a
    ld [$c04e], a
    ld [$c04f], a
    ld [$c06e], a
    ld [$c06f], a
    dec a
    ld [$c056], a
    ld [$c057], a
    ld a, $46
    ld [wTextEngineOffset], a
    ld a, $17
    call PrintTextVWF
    xor a
    ld [wTextEngineOffset], a
    ld a, 7
    jp GiveEntry

Interact_GrassGuy:
    call .checkGrass
    jr z, .degrassed
    ld a, $18
    jp PrintTextVWF
.degrassed
    ld a, $19
    call PrintTextVWF
    ld a, 22
    jp GiveEntry
.checkGrass
    ld b, $ac
    ld hl, wOverworldMap
.loop
    ld a, l
    cp $46
    jr z, .skip
    ld a, [hli]
    cp $0b
    jr z, .no
    dec b
    jr nz, .loop
.done
    xor a
    ret
.skip
    inc hl
    inc hl
    jr .loop
.no
    inc b
    ret

Interact_WorriedExplorer:
    ld b, $01
    call IsItemInBag
    jr z, .noBalls
    ld a, $1e
    call PrintTextVWF
    ld a, 9
    jp GiveEntry
.noBalls
    ld a, $1d
    jp PrintTextVWF

Interact_Therapy:
    ld a, $1f
    call PrintTextVWF
    call YesNoChoice
    ld a, [wCurrentMenuItem]
	and a
    jr nz, .quit
    ld a, MUSIC_LAVENDER + 1
    call PlaySound
    ld c, 120
    call DelayFrames
    ld hl, wTileMap
    ld bc, 5*18
.erasure
    ld a, $1f
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    halt
    dec bc
    ld a, c
    or b
    jr nz, .erasure
    ld c, 80
    call DelayFrames
    ld a, $21
    call PrintTextVWF
    call PlayDefaultMusic
    call Random
    ld [wFunValue], a
    ld c, 80
    jp DelayFrames
.quit
    ld a, $20
    jp PrintTextVWF

Interact_DarkHouse:
    ld a, [wMapPalOffset]
    cp $05
    jr z, .dark
    ld a, $27
    call PrintTextVWF
    ld a, 10
    jp GiveEntry
.dark
    ld a, $26
    jp PrintTextVWF

Interact_CardKeyScientist:
    ld b, $30
    call IsItemInBag
    jr z, .noKey
    ld a, $29
    call PrintTextVWF
    ld a, SFX_GET_ITEM_1
    call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
    ld a, $0e
    ld [$c784], a
    jp RedrawMapAndGoBackToOverworld
.noKey
    ld a, $28
    jp PrintTextVWF

Interact_GiveHM05:
    ld b, $c8
    call IsItemInBag
    jr z, .obtain
    ld a, $2c
    jp PrintTextVWF
.obtain
    ld c, 1
    ld b, $c8
    call GiveItem
    ld a, $2b
    call PrintTextVWF
    ld a, SFX_GET_ITEM_2
    call PlaySoundWaitForCurrent
	jp WaitForSoundToFinish

Interact_GiveCardKey:
    ld b, $30
    call IsItemInBag
    jr z, .obtain
    ld a, $2e
    jp PrintTextVWF
.obtain
    ld c, 1
    ld b, $30
    call GiveItem
    ld a, $2d
    call PrintTextVWF
    ld a, SFX_GET_ITEM_2
    call PlaySoundWaitForCurrent
	jp WaitForSoundToFinish

Interact_GiveCoinCase:
    ld b, $45
    call IsItemInBag
    jr z, .obtain
    ld a, $30
    jp PrintTextVWF
.obtain
    ld c, 1
    ld b, $45
    call GiveItem
    ld a, $2f
    call PrintTextVWF
    ld a, SFX_GET_ITEM_2
    call PlaySoundWaitForCurrent
	jp WaitForSoundToFinish

Interact_PalletResearchGuy:
    ld b, $45
    call IsItemInBag
    jr z, .noCase
    ld a, $33
    call PrintTextVWF
    ld a, 1
    ld [wTalkedToScientist], a
    ld a, 11
    jp GiveEntry
.noCase
    ld a, $32
    jp PrintTextVWF

Interact_Dancer:
    ld a, $34
    call PrintTextVWF
    call YesNoChoice
    ld a, [wCurrentMenuItem]
	and a
    jp nz, .quit
    ld a, $35
    call PrintTextVWF
    call SlowFade
    ld c, 80
    call DelayFrames
    call ReturnFromTextboxToOverworld
    xor a
    ld [$c102], a
    ld a, $30
    ld [$c132], a
    ld c, 120
    call DelayFrames
    ld a, $ec
    call PlaySound
    ld b, 0
    ld hl, .danceMoves
    ld de, 0
.dance
    ld a, [hl]
    cp b
    jr nz, .no
    inc hl
    ld a, [hli]
    add $30
    ld [$c132], a
.no
    ld c, 8
.inputLoop
    ld a, [$fff8]
    rlca
    call c, .down
    rlca
    call c, .up
    rlca
    call c, .left
    rlca
    call c, .right
    ld a, [$c132]
    sub $30
    push hl
    ld hl, $c102
    cp [hl]
    jr nz, .noMatch
    inc de
.noMatch
    pop hl
    halt 
    dec c
    jr nz, .inputLoop
    inc b
    ld a, b
    cp $c0
    jr nz, .dance
.finished
    push de
    ld a, $ff
    call PlaySound
    ld c, 30
    call DelayFrames
    call TextboxEnable
    call PlayDefaultMusic
    ld a, 1
	ld [wTextBoxID], a
	call DisplayTextBoxID
    pop de
    dec de
    ld a, d
    cp 5
    jr nz, .badDance
.goodDance
    ld a, $37
    call PrintTextVWF
    ld a, 12
    jp GiveEntry
.badDance
    ld a, $36
    jr .prnt
.quit
    ld a, $0b
.prnt
    jp PrintTextVWF
.right
    ld a, _R
    ld [$c102], a
    ret
.left
    ld a, _L
    ld [$c102], a
    ret
.up
    ld a, _U
    ld [$c102], a
    ret
.down
    ld a, _D
    ld [$c102], a
    ret
.danceMoves
def _D equ 0
def _U equ 4
def _L equ 8
def _R equ 12
    db $04-2,_U,$07-2,_L,$0a-2,_R
    db $10-2,_U,$13-2,_L,$16-2,_R
    db $1d-2,_U,$20-2,_L,$23-2,_R,$28-2, _D
    db $34-2,_U,$37-2,_L,$3a-2,_R
    db $40-2,_U,$43-2,_L,$46-2,_R
    db $4c,_U,$4f,_L,$52,_R,$57, _D
    db $5f-2,_L
    db $65-2,_U,$68-2,_L,$6b-2,_R
    db $70-2,_U,$73-2,_L,$76-2,_R
    db $7c-2,_U,$80-2,_L,$83-2,_R,$88-2, _D
    db $94-2,_L,$97-2,_R,$9a-2,_L,$9e-2,_R,$a1-2,_L,$a4-2,_R,$a7-2,_L,$a9-2,_R
    db $ac-2,_U,$b3-2,_D,$b6-2,_L,$b9-2,_R

Interact_WhosThatPokemon:
    xor a
    ld [wCorrectCounter], a
    ld a, $38
    call PrintTextVWF
    call YesNoChoice
    ld a, [wCurrentMenuItem]
	and a
    jp nz, .quit
.question
    call ReturnFromTextboxToOverworld
    call Random
    and $7f
    ld [$d11e], a
    ld b, b_PokedexToIndex
    ld hl, PokedexToIndex
    call Bankswitch
    ld a, [$d11e]
    ld [$cf91], a
    push af
    call _DisplayMonFrontSpriteInBox
    call TextboxEnable
    call Random
    and 1
    ld b, a
    pop af
    push bc
    add b
    ld [$d11e], a
	; todo this can pick invalid stuff like missingno
    call GetMonName
    ld hl, .wasIt
    call PrintText
    call YesNoChoice
    pop bc
    ld a, [wCurrentMenuItem]
    cp b
    jr z, .correct
.incorrect
    call WaitForSoundToFinish
    ld a, SFX_DENIED
    call PlaySound
    ld a, $39
    jr .prnt
.correct
    call WaitForSoundToFinish
    ld a, SFX_SAFARI_ZONE_PA
    call PlaySound
    ld hl, wCorrectCounter
    inc [hl]
    ld a, 5
    cp [hl]
    jr z, .allCorrect
    ld a, $3a
    call PrintTextVWF
    call WaitAPress
    jr .question
.allCorrect
    ld a, $3b
    call PrintTextVWF
    ld a, 13
    jp GiveEntry
.quit
    ld a, $0b
.prnt
    jp PrintTextVWF
.wasIt
    db $00,$96,$a0,$b2,$7f,$b3,$a7,$a0,$b3,$4f,$50 ; "Was that\n"
    db $01,$6d,$cd ; tx_ram wNameBuffer
    db $00,$e6,$57 ; "?"

Interact_MansionScientist:
    ld a, [wTalkedToScientist]
    cp 1
    jr z, .talked
    ld a, $3c
    jp PrintTextVWF
.talked
    ld a, $3d
    call PrintTextVWF
    ld a, 17
    jp GiveEntry

Interact_MazeGuy:
    ld a, $3e
    call PrintTextVWF
    call YesNoChoice
    ld a, [wCurrentMenuItem]
	and a
    jp nz, .quit
    call SlowFade
    ld c, 90
    call DelayFrames
    call SaveScreenTilesToBuffer2
    call MazeGame
    call LoadScreenTilesFromBuffer2
    call LoadTextBoxTilePatterns
    ld a, 1
	ld [wTextBoxID], a
	call DisplayTextBoxID
    call UpdateSprites
    ld c, 10
    call DelayFrames
    call LoadGBPal
    call PlayDefaultMusic
    ld c, 10
    call DelayFrames
    ld a, [wMazeHighScoreDigit]
    cp $f6
    jr z, .highScore
    cp $f7
    jr z, .highScore
    ld a, $3f
    jr .prnt
.highScore
    ld a, $40
    call PrintTextVWF
    ld a, 18
    jp GiveEntry
.quit
    ld a, $0b
.prnt
    jp PrintTextVWF

Interact_FlashGuy:
    ld a, $41
    call PrintTextVWF
    ld b, $c8
    call IsItemInBag
    jr nz, .gotIt
    ret
.gotIt
    call WaitAPress
    ld a, $42
    call PrintTextVWF
    ld a, 20
    jp GiveEntry

Interact_Q:
    ld a, $44
    call PrintTextVWF
    ld hl, wPartyMonNicks
.search
    ld a, [hli]
    cp $50
    ret z
    cp $90
    jr nz, .search
.gotIt
    call WaitAPress
    ld a, $45
    call PrintTextVWF
    ld a, 21
    jp GiveEntry

Interact_Amber:
    ld hl, .outs
    ld de, $cb00
    ld c, 10
    xor a
    ld [de], a
    inc de
.cpy
    ld a, [hli]
    add $80
    ld [de], a
    inc de
    inc a
    jr nz, .cpy
.term
    ld a, $57
    ld [de], a
    ld hl, $cb00
    jp PrintText
.outs
    db $8f-$80,$a0-$80,$b2-$80,$b2-$80,$b6-$80,$ae-$80,$b1-$80,$a3-$80,$9c-$80,$4f-$80
    db $8e-$80,$8e-$80,$81-$80,$e8-$80,$80-$80,$a3-$80,$b5-$80,$a4-$80,$ad-$80,$b3-$80,$b4-$80,$b1-$80,$a4-$80,$e8-$80,$fd-$80,$f7-$80
    db $7f

Interact_Crackme:
    ld a, $51
    call PrintTextVWF
    call YesNoChoice
    ld a, [wCurrentMenuItem]
	and a
    jp nz, .quit
    call SlowFade
    ld c, 90
    call DelayFrames
    call SaveScreenTilesToBuffer2
    call CrackMe
    call LoadScreenTilesFromBuffer2
    call LoadTextBoxTilePatterns
    ld a, 1
	ld [wTextBoxID], a
	call DisplayTextBoxID
    call UpdateSprites
    ld c, 10
    call DelayFrames
    call LoadGBPal
    call PlayDefaultMusic
    ld a, $53
    jp PrintTextVWF
.quit
    ld a, $0b
    jp PrintTextVWF