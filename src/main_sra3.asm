SECTION "SRA3PARENT", ROMX[$6000], BANK[1]
LOAD "SRA3", SRAM[$A000], BANK[3]

_SRA3Checksum:
    ds 1

db 0

TestText:
Text_Data:
    incbin "text_data.bin"

SRA3_End:

ENDL