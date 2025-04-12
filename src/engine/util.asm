
TextboxEnable:
    ; Show a textbox in the overworld.
    call SaveScreenTilesToBuffer1
    call SaveScreenTilesToBuffer2
    call SpriteClearAnimCounters
    call LoadFontTilePatterns
TextboxEnable_NoLoadFont:
    ; Show a textbox in the overworld, but skip loading font graphics
    ld b, $9c
    ld hl, CopyScreenTileBufferToVRAM
    call SafeCallHL
    xor a
    ldh [$ffb0], a
    inc a
    ldh [$ffba], a
    ret

ReturnFromTextboxToOverworld:
    ; Return to overworld after showing a textbox.
    ld a, $90
    ldh [$ffb0], a
    call DelayFrame
    call LoadGBPal
    xor a
    ldh [$ffba], a
    call SwitchToMapRomBank
    ldh a, [$fff8]
    ld h, a
    ld l, 0
    push hl
    call LoadWalkingPlayerSpriteGraphics
    ld a, 1
    ld [wFontLoaded], a
    jp $2a0b

SpriteClearAnimCounters:
    ; Clear the player's sprite animation counters.
    xor a
    ld [wPlayerMovingDirection], a
    ld a, [$c102]
    and %11111100
    ld [$c102], a
    ld hl, $c107
    xor a
    ld [hli], a
    ld [hl], a
    jp UpdateSprites

WaitAPress:
    ; Wait until A is fully released and then pressed.
    ; An A press actually has three parts to it. When A is pressed, when
    ; A is held, and when A is released. And together, this forms one complete
    ; A press.
    ldh a, [$fff8]
    and a
    jr nz, WaitAPress
.waitInput
    ldh a, [$fff8]
    and a
    jr z, .waitInput
    ret

PrintHex4:
    ; Print 4-byte hex string from wHexBuffer to HL
    ld c, 4
    ld de, wHexBuffer
.loop
    ld a, [de]
    swap a
    call PrintHexDigit
    ld a, [de]
    call PrintHexDigit
    inc de
    dec c
    jr nz, .loop
    ret
PrintHexDigit:
    ; Helper function for PrintHex.
    and $0f
    add $f6
    jr nc, .noAdd
    add $60
.noAdd
    ld [hli], a
    ret

PlayUnusedTheme:
    ; Play the R/B/Y unused trade theme.
    ld a, MUSIC_VERMILION
    ld c, 2
    call PlayMusic
    xor a
    ld hl, $c006
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], $13
    inc hl
    ld [hl], $69
    inc hl
    ld [hli], a
    ld [hl], a
    ret

SlowFade:
    ; Slowly fade out the music.
    ld hl, wAudioFadeOutCounter
    ld a, $10
    ld [hld], a
    ld [hld], a
    ld [hl], $ff
    ret

BlackOutPals:
    ; Set a fully black palette (effectively blacking out the screen).
    ld a, %11111111
WriteAToPals:
    ld [rBGP], a
    ld [rOBP0], a
    ld [rOBP1], a
    ret

PlayMusicFromRAM:
    ld bc, $0008
    ld de, $C006
    call CopyData
    ld a, $00
    ld bc, $0004
    ld hl, $C016
    call FillMemory
    ld a, $01
    ld bc, $0004
    ld hl, $C0B6
    call FillMemory
    ld a, $e0
    ld bc, $0004
    ld hl, $C026
    jp FillMemory
