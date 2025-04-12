RetSum:
    ld bc, $6942
.go
    ld a, [hl]
    cp $c9
    jr z, .done
    xor b
    ld b, a
    ld a, [hli]
    add c
    ld c, a
    jr .go
.done
    ld a, b
    xor c
    ret

CheckForWTW:
    ld a, [$c45c]
    cp $14
    ret z
    cp $32
    ret z
    cp $48
    ret z
    cp $37
    ret z
    cp $27
    ret z
    cp $24
    ret z
    cp $1d
    ret z
    cp $2c
    ret z
    cp $0d
    ret z
    cp $36
    ret z
    call $0c18
    ret nc
.foundWtw
    ld a, $48
    ld [$d163], a
    jr DisplayUnskippableError

IntegrityFail:
    ld b, b
    ld a, $49
    ld [$d163], a
    ; fall through
DisplayUnskippableError:
    ld sp, $cbc0
    ld d, $ca
    ldh a, [$ff04]
    ld e, a
    push de
    ld hl, ErrorMessageRoutine
    ld bc, ErrorMessageRoutine_End - ErrorMessageRoutine
    jp CopyData
ErrorMessageRoutine:
    call PlayUnusedTheme
    call TextboxEnable
    call ClearScreen
    call UpdateSprites
    ld a, [$d163]
    call PrintTextVWF
.forever
    jr .forever
ErrorMessageRoutine_End:
    ret ; actually required for checksumming

CheckROM:
    ; A simple checksum test, to see if the loaded ROM is Pokemon Blue EN.
    ld hl, $0000
    ld bc, $3fff
    ld de, $0000
.loop
    ld a, [hl]
    xor d
    ld d, a
    ld a, [hli]
    add e
    ld e, a
    dec bc
    ld a, c
    or b
    jr nz, .loop
    ld a, e
    add d
    ret