HookNewMap:
    ; load map rom bank
    ldh a, [hLoadedROMBank]
	push af
    ld a, [wCurMap]
	call SwitchToMapRomBank
    ; from map text ptrs
    ld hl, wMapTextPtr
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ; to wEffectiveTextPtrs
    ld de, wEffectiveTextPtrs
    ; 64 entries
    ld bc, 64*2
    call CopyData
    ; repoint map text table to wEffectiveTextPtrs
    ld hl, wMapTextPtr
    ld [hl], LOW(wEffectiveTextPtrs)
    inc hl
    ld [hl], HIGH(wEffectiveTextPtrs)
    ; find orig map script
    ; get header ptr
    ld hl, MapHeaderPointers
	ld a, [wCurMap]
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc
    ld a, [hli]
	ld h, [hl]
	ld l, a
    ; get ptr to script ptr
    ld bc, 7
    add hl, bc
    ; read script ptr
    ld a, [hli]
	ld b, [hl]
    ; write script ptr to wOrigMapScriptPtr
    ld hl, wOrigMapScriptPtr
    ld [hli], a
    ld [hl], b
    ; repoint map script
    ; DMA hijack does that, so we can reuse that
    call DMACallback
    ; restore rom bank
    pop af
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
    ; hooked map is the current map
    ld a, [wCurMap]
    ld [wOrigMapID], a
    ; disable the SAVE option
    ld hl, $d72e
    set 6, [hl]
    ; clear text pointer shadow copy
    ld a, $ff
    ld bc, 32
    ld hl, wTextPtrShadowCopy
    call FillMemory
    xor a
    ld [wTextPtrShadowCopySentinel], a
    ; point 4F to Item4FCallback
    ld hl, $fa65
    ld [hl], $c3
    inc hl
    ld [hl], LOW(Item4FCallback)
    inc hl
    ld [hl], HIGH(Item4FCallback)
    ; make the required map changes
    call ModifyCurrentMap
    ; make sure sprite updates are reflected
    call ReloadSpriteVRAMIfNecessary
    jp UpdateSprites

HookDMA:
    ; make things safe while we patch them
    ld hl, $ff80
    ld [hl], $c9 ; ret
    inc hl
    ; now actually write stuff
    ld [hl], LOW(DMACallback)
    inc hl
    ld [hl], HIGH(DMACallback)
    inc hl
    ld [hl], $e2 ; ldh [c],a
    ld l, $80
    ld [hl], $cd ; call
    ret

ReloadSpriteVRAMIfNecessary:
    ld a, [wCurMap]
    cp $c5
    jr z, .reload
    cp $b7
    jr z, .reload
    cp $e5
    jr z, .reload
    cp $8e
    jr z, .reload
    cp $58
    jr z, .reload
    ret
.reload
    ld a, 0
    ld [wFontLoaded], a
    ld a, [$ffb8]
    push af
    ld c, 8
.notLikeThis
	; this is very hacky and stupid but it works
    ld a, 5
    ldh [$ffb8], a
    ld [$2000], a
    push bc
    call $785b
    pop bc
    dec c
    jr nz, .notLikeThis
.return
    pop af
    ld [$ffb8], a
    ret