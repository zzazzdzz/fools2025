CreateJumpMaze:
    ; init rng
    ld hl, wRNGVarX
    ld [hl], 227
    inc hl
    ld [hl], 52
    inc hl
    ld [hl], 173
    inc hl
    ld [hl], 48
    ld hl, CreateJumpMaze_RAMRoutine
    ld de, $c800
    ld bc, 256
    call CopyData
    jp $c800

CreateJumpMaze_RAMRoutine:
    xor a
    call SwitchToSRA
.makeTransitionNodes
    ld hl, $a000
    ld de, 1024
.singleNode
    ld [hl], $0e
    inc hl
.regen
    call PRNG
    and a
    jr z, .regen
    ld [hli], a
    ld [hl], $09
    inc hl
    ld [hl], $15
    inc hl
    ld [hl], $c8
    inc hl
    ld [hl], $1d
    inc hl
    ld [hl], $20
    inc hl
.reroll
    call PRNG
    and %11111000
    jr z, .reroll
    cp $08
    jr z, .reroll
    cp $f8
    jr z, .reroll
    ld [hli], a
    dec de
    ld a, e
    or d
    jr nz, .singleNode
.fixStartingNodes
    ld hl, $a007
    ld de, 8
    ld c, 20
.changeToPositive
    ld a, [hl]
    and $7f
    ld [hl], a
    add hl, de
    dec c
    jr nz, .changeToPositive
.fixFinalNodes
    ld hl, $bfff
    ld de, -7
    ld c, 20
.changeToNegative
    ld a, [hl]
    and $7f
    add $80
    ld [hld], a
    ld [hl], $18
    add hl, de
    dec c
    jr nz, .changeToNegative
.done
    jp SwitchToSRA2

RunJumpMazeInHL:
    ld a, h
    and %11100000
    jr nz, .nope
    push de
    ld de, $a000
    add hl, de
    ld de, wJumpMazeTarget
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    pop de
    jp RunJumpMaze
.nope
    ld hl, $6969
    ret

CrackMe:
    call ClearScreen
    call PlayUnusedTheme
    call UpdateSprites
    coord hl, 1, 1
    ld de, PasswordEntryString
    call PutString
    coord hl, 1, 8
.inputLoop
    ld a, [$fff8]
    rrca 
    jr c, .pressedA
    rrca
    jr c, .pressedB
    ld a, [$fff8]
    rlca
    jr c, .down
    rlca
    jr c, .up
    rlca
    jr c, .left
    rlca
    jr c, .right
.waitNoInput
    ld a, [$fff8]
    and a
    jr nz, .waitNoInput
.waitForInput
    ld a, [$fff8]
    and a
    jr z, .waitForInput
.waitFrame
    halt
    jr .inputLoop
.pressedA
    ld a, $ff
    call PlaySound
    ld c, 10
    call DelayFrames
    call VerifyPassword
    jr z, CorrectPassword
    jr IncorrectPassword
.pressedB
    jp QuitPasswordChall
.down
    ld a, [hl]
    call GetCharVal
    dec a
    and %00111111
    call ValToChar
    ld [hl], a
    jr .waitNoInput
.up
    ld a, [hl]
    call GetCharVal
    inc a
    and %00111111
    call ValToChar
    ld [hl], a
    jr .waitNoInput
.left
    ld a, l
    cp $41
    jr z, .waitNoInput
    ld bc, -20
    add hl, bc
    ld [hl], $7f
    ld bc, 20
    add hl, bc
    dec hl
    ld bc, -20
    add hl, bc
    ld [hl], $ee
    ld bc, 20
    add hl, bc
    jr .waitNoInput
.right
    ld a, l
    cp $4f
    jr z, .waitNoInput
    ld bc, -20
    add hl, bc
    ld [hl], $7f
    ld bc, 20
    add hl, bc
    inc hl
    ld bc, -20
    add hl, bc
    ld [hl], $ee
    ld bc, 20
    add hl, bc
    jr .waitNoInput

CorrectPassword:
    coord hl, 1, 11
    ld de, PasswordSuccessString
    call PutString
    ld a, SFX_GET_ITEM_2
    call PlaySound
    jr QuitPasswordChall
IncorrectPassword:
    coord hl, 1, 11
    ld de, PasswordFailString
    call PutString
    ld a, SFX_DENIED
    call PlaySound
    ; fall through to QuitPasswordChall
QuitPasswordChall:
    call WaitForSoundToFinish
    ld c, 20
    call DelayFrames
    ld a, $ff
    call PlaySound
    ld c, 100
    jp DelayFrames

VerifyPassword:
    call CreateJumpMaze
    coord hl, 1, 8
    call DecodeSingleSetOfParams
    ld a, l
    and %00000111
    ret nz
    call RunJumpMazeInHL
    ld de, $adaa
    call CompareDEtoHL
    ret nz
    coord hl, 1+5, 8
    call DecodeSingleSetOfParams
    ld a, l
    and %00000111
    ret nz
    call RunJumpMazeInHL
    ld de, $ac39
    call CompareDEtoHL
    ret nz
    coord hl, 1+5+5, 8
    call DecodeSingleSetOfParams
    ld a, l
    and %00000111
    ret nz
    call RunJumpMazeInHL
    ld de, $002f
    jp CompareDEtoHL

CompareDEtoHL:
    ; Check if DE == HL.
    ld a, h
    cp d
    jr nz, .nope
    ld a, l
    cp e
.nope
    ret

DecodeSingleSetOfParams:
    ; decode params from PW
    ld bc, 0
    ld a, [hli]
    call GetCharVal
    call AddSixBits
    ld a, [hli]
    call GetCharVal
    call AddSixBits
    ld e, c
    ld c, 0
    ld a, [hli]
    call GetCharVal
    call AddSixBits
    ld a, [hli]
    call GetCharVal
    call AddSixBits
    ld d, c
    ld a, [hli]
    call GetCharVal
    ; de is populated with 16 read bits
    ; a has 6 bits
    ; b has 8 bits
    ; use them to form hl
    ld l, b
    ld h, a
    ret

AddSixBits:
    ; 4 lower bits to c
    swap c
    ld d, a
    and $0f
    add c
    ld c, a
    ; 2 higher bits to b
    sla b
    sla b
    ld a, d
    swap a
    and $03
    add b
    ld b, a
    ret

PutString:
    push bc
    push hl
    ld bc, 20
.printchr
    ld a, [de]
    inc de
    cp $50
    jr z, .finished
    cp $4f
    jr z, .nextline
    ld [hli], a
    jr .printchr
.nextline
    pop hl
    add hl, bc
    push hl
    jr .printchr
.finished
    pop hl
    pop bc
    ret

GetCharVal:
    push hl
    push bc
    ld c, a
    ld b, 0
    ld hl, PasswordCharset
.checkChr
    inc b
    ld a, [hli]
    cp c
    jr nz, .checkChr
.found
    dec b
    ld a, b
    pop bc
    pop hl
    ret

ValToChar:
    push hl
    ld hl, PasswordCharset
    ld b, 0
    ld c, a
    add hl, bc
    ld a, [hl]
    pop hl
    ret

PasswordCharset:
    db $80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$8f,$90,$91
    db $92,$93,$94,$95,$96,$97,$98,$99,$a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$a8,$a9,$aa
    db $ab,$ac,$ad,$ae,$af,$b0,$b1,$b2,$b3,$b4,$b5,$b6,$b7,$b8,$b9,$f6,$f7,$f8
    db $f9,$fa,$fb,$fc,$fd,$fe,$ff,$e6,$e7

PasswordEntryString:
    db $84,$ad,$b3,$a4,$b1,$7f,$a0,$7f,$af,$a0,$b2,$b2,$b6,$ae,$b1,$a3,$e8,$4f,$4f
    db $94,$83,$8b,$91,$7f,$b3,$ae,$7f,$a4,$ad,$b3,$a4,$b1,$e8,$4f
    db $80,$7f,$b3,$ae,$7f,$a2,$ae,$ad,$a5,$a8,$b1,$ac,$e8,$4f
    db $81,$7f,$b3,$ae,$7f,$a4,$b7,$a8,$b3,$e8,$4f,$4f
    db $ee,$4f
    db $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$50

PasswordFailString:
    db $8e,$ae,$af,$b2,$a8,$a4,$e7,$4f
    db $93,$a7,$a8,$b2,$7f,$af,$a0,$b2,$b2,$b6,$ae,$b1,$a3,$7f,$a8,$b2,$4f
    db $b6,$b1,$ae,$ad,$a6,$e8,$e8,$e8,$50

PasswordSuccessString:
    db $98,$a4,$b2,$e7,$7f,$93,$a7,$a0,$b3,$7f,$a8,$b2,$7f,$b3,$a7,$a4,$4f
    db $a2,$ae,$b1,$b1,$a4,$a2,$b3,$7f,$af,$a0,$b2,$b2,$b6,$ae,$b1,$a3,$e7,$4f
    db $92,$b4,$a1,$ac,$a8,$b3,$7f,$a8,$b3,$7f,$a0,$b2,$7f,$a0,$ad,$4f
    db $b4,$ad,$ab,$ae,$a2,$aa,$7f,$a2,$ae,$a3,$a4,$7f,$a0,$b3,$7f,$b3,$a7,$a4,$4f
    db $a4,$b5,$a4,$ad,$b3,$7f,$b6,$a4,$a1,$b2,$a8,$b3,$a4,$e8,$50