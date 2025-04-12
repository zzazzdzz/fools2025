MazeGame:
    call BlackOutPals
    ld c, 4
    ld de, MazeTiles
    ld hl, $97b0
    call CopyVideoDataDouble
    ld a, $7e
    ld bc, 18*20
    ld hl, wTileMap
    call FillMemory
    ld bc, 8
    coord de, 12, 17
    ld hl, ScoreText
    call CopyData
    call UpdateSprites
    call GetRandomCoord
    ; get some extra stack space
	; could write an iterative version but im lazy
    ld hl, sp+0
    ld sp, $cbf0
    push hl
    call GenerateMaze
    ; restore previous stack
    pop hl
    ld sp, hl
    ; place coins
    ld c, 5
.placeCoins
    call PlaceRandomCoin
    dec c
    jr nz, .placeCoins
    ; place player
    coord hl, 9, 9
    ld [hl], $7d
    ; begin
    call LoadGBPal
    ld c, 60
    call DelayFrames
    call PlayUnusedTheme
    ld a, 60
    ld [wIgnoreInputCounter], a
    ld de, $0909
.controlLoop
    ; get prev input
    ld a, [$fff0]
    ld c, a
    ; get cur input
    ld a, [$fff8]
    ld b, a
    ; check new buttons
    xor c
    and b
    ld c, a
    ; save cur input
    ld a, b
    ld [$fff0], a
    ; erase player
    call GetTilemapCoord
    ld [hl], $7f
    ; save position
    call StoreBetweenCell
    ; branch based on input
    ld a, c
    rlca
    call c, .down
    rlca
    call c, .up
    rlca
    call c, .left
    rlca
    call c, .right
    ; bring back saved position if in a wall
    call GetTilemapCoord
    ld a, [hl]
    cp $7e
    call z, FetchBetweenCell
    ; place back player
    call GetTilemapCoord
    ld [hl], $7d
    ; update time
    ld a, [wIgnoreInputCounter]
    and a
    call z, UpdateTime
    ; check win condition
    coord hl, 1, 1
    ld c, 190
.tileCheck
    ld a, [hli]
    inc hl
    cp $7c
    jr z, .noWin
    dec c
    jr nz, .tileCheck
.win
    ld a, $ff
    call PlaySound
    ld a, SFX_GET_ITEM_2
    call PlaySound
    call WaitForSoundToFinish
    ld c, 90
    call DelayFrames
    ld a, [$c506]
    ld [wMazeHighScoreDigit], a
    xor a
    jp WriteAToPals
.noWin
    ; next frame
    halt 
    jr .controlLoop
.down
    inc e
    ret
.up
    dec e
    ret
.left
    dec d
    ret
.right
    inc d
    ret
    
UpdateTime:
    ld a, 60
    ld [wIgnoreInputCounter], a
    ; inc lower tile
    coord hl, 19, 17
    inc [hl]
    ; carry
    ld a, [hl]
    and a
    jr nz, .noCarry
    ld [hl], $f6
    dec hl
    inc [hl]
    ld a, [hl]
    and a
    jr nz, .noCarry
    dec [hl]
    inc hl
    ld [hl], $ff
.noCarry
    ret

GetRandomCoord:
    call Random 
    and 7
    add a
    inc a
    ld d, a
    call Random 
    and 7
    add a
    inc a
    ld e, a
    ret
PlaceRandomCoin:
    push bc
.retry
    call GetRandomCoord
    call GetTilemapCoord
    ld a, [hl]
    cp $7f
    jr nz, .retry
    ld [hl], $7c
    pop bc
    ret

ScoreText:
    db $7b,$68,$6c,$64,$9c,$7f,$f6,$f6

GenerateMaze:
	; wikipedia please grant me 3 wishes
    ; Mark the current cell as visited
    call GetTilemapCoord
    ld [hl], $7f
.iter
    ; While the current cell has any unvisited neighbour cells
    push de
    call FindRandomUnvisitedNeighbor
    ; (bail if no candidates)
    jr c, .bail
    ; Remove the wall between the current cell and the chosen cell
    push de
    call FetchBetweenCell
    call GetTilemapCoord
    ld [hl], $7f
    pop de
    ; Invoke the routine recursively for the chosen cell
    call GenerateMaze
    pop de
    jr .iter
.bail
    pop de
    ret

FindRandomUnvisitedNeighbor:
    ld a, 20
    ld [wNumAttempts], a
.loop
    push de
    call RandomWithFailsafe
    and 3
    dec a
    jr z, .tryLeft
    dec a
    jr z, .tryRight
    dec a
    jr z, .tryUp
.tryDown
    inc e
    call StoreBetweenCell
    inc e
    jr .isVisited
.tryUp
    dec e
    call StoreBetweenCell
    dec e
    jr .isVisited
.tryLeft
    dec d
    call StoreBetweenCell
    dec d
    jr .isVisited
.tryRight
    inc d
    call StoreBetweenCell
    inc d
.isVisited
    call GetTilemapCoord
    ld a, h
    and a
    jr z, .nope
    ld a, [hl]
    cp $7f
    jr z, .nope
    ; found unvisited neighbor
    pop hl
    xor a
    ret
.nope
    pop de
    ; unless we failed too much
    ld hl, wNumAttempts
    dec [hl]
    ; try again
    jr nz, .loop
.failed
    scf
    ret

RandomWithFailsafe:
    ld a, [wNumAttempts]
    cp $5
    ret c
    jp Random

StoreBetweenCell:
    ld a, d
    ld [wMazeBetween], a
    ld a, e
    ld [wMazeBetween+1], a
    ret

FetchBetweenCell:
    ld a, [wMazeBetween]
    ld d, a
    ld a, [wMazeBetween+1]
    ld e, a
    ret

GetTilemapCoord:
    ld a, d
    cp $ff
    jr z, .oob
    cp 19
    jr z, .oob
    ld a, e
    cp $ff
    jr z, .oob
    cp 17
    jr z, .oob
    ld hl, wTileMap
    push de
    push bc
    ld bc, 20
    ld a, e
    and a
    jr z, .addX
.addY
    add hl, bc
    dec e
    jr nz, .addY
.addX
    ld c, d
    add hl, bc
    pop bc
    pop de
    ret
.oob
    ld h, 0
    ret

MazeTiles:
    db %00000000
    db %01111110
    db %00011000
    db %00011000
    db %00011000
    db %00011000
    db %00011000
    db %00000000
    
    db %00000000
    db %00011000
    db %00101100
    db %01010110
    db %01101010
    db %00110100
    db %00011000
    db %00000000
    
    db %00000000
    db %01111110
    db %01111110
    db %01111110
    db %01111110
    db %01111110
    db %01111110
    db %00000000
    
    db %11111111
    db %11111111
    db %11111111
    db %11111111
    db %11111111
    db %11111111
    db %11111111
    db %11111111
