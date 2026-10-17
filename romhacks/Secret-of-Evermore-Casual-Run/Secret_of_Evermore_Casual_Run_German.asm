; ============================================================================
; Secret of Evermore: Casual Run -- Deutsche PAL Version
; Autor: Andrew Clunn (Original) / Port für Deutsche PAL ROM
; Ziel-ROM: Secret of Evermore (Germany).sfc
; SHA-256: c341668847170d36fa5cfb720568b0b1ecbb24fc426a821f665f1d3853a46a6d
; SHA-1:   5e5c2082526690d05f962c3ffbd7e080c681bfa4
; Basis-Größe: 3.145.728 Bytes -> Erweitert: 4.194.304 Bytes (4 MiB HiROM)
; ============================================================================
arch 65816
hirom

; ============================================================================
; 1. MODUL: WAFFEN & GEGENSTÄNDE (Bank $C4, deutscher Shift +$0640)
; ============================================================================
; Original US: $C438E6 -> German PAL: $C43F26
org $C43F26
WeaponAttack_Record00_C438E6:
; $C438E6: Weapon directory entry 0 points to $C438E6; attack power is the little-endian word at record +$00.
; $C438E6: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $0D

; Range: $C4390A-$C4390A (1 bytes)

; Original US: $C4390A -> German PAL: $C43F4A
org $C43F4A
WeaponAttack_Record01_C4390A:
; $C4390A: Weapon directory entry 1 points to $C4390A; attack power is the little-endian word at record +$00.
; $C4390A: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $1B

; Range: $C4392E-$C4392E (1 bytes)

; Original US: $C4392E -> German PAL: $C43F6E
org $C43F6E
WeaponAttack_Record02_C4392E:
; $C4392E: Weapon directory entry 2 points to $C4392E; attack power is the little-endian word at record +$00.
; $C4392E: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $26

; Range: $C43952-$C43952 (1 bytes)

; Original US: $C43952 -> German PAL: $C43F92
org $C43F92
WeaponAttack_Record03_C43952:
; $C43952: Weapon directory entry 3 points to $C43952; attack power is the little-endian word at record +$00.
; $C43952: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $41

; Range: $C43976-$C43976 (1 bytes)

; Original US: $C43976 -> German PAL: $C43FB6
org $C43FB6
WeaponAttack_Record04_C43976:
; $C43976: Weapon directory entry 4 points to $C43976; attack power is the little-endian word at record +$00.
; $C43976: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $12

; Range: $C4399A-$C4399A (1 bytes)

; Original US: $C4399A -> German PAL: $C43FDA
org $C43FDA
WeaponAttack_Record05_C4399A:
; $C4399A: Weapon directory entry 5 points to $C4399A; attack power is the little-endian word at record +$00.
; $C4399A: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $21

; Range: $C439BE-$C439BE (1 bytes)

; Original US: $C439BE -> German PAL: $C43FFE
org $C43FFE
WeaponAttack_Record06_C439BE:
; $C439BE: Weapon directory entry 6 points to $C439BE; attack power is the little-endian word at record +$00.
; $C439BE: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $2F

; Range: $C439E2-$C439E2 (1 bytes)

; Original US: $C439E2 -> German PAL: $C44022
org $C44022
WeaponAttack_Record07_C439E2:
; $C439E2: Weapon directory entry 7 points to $C439E2; attack power is the little-endian word at record +$00.
; $C439E2: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $46

; Range: $C43A06-$C43A06 (1 bytes)

; Original US: $C43A06 -> German PAL: $C44046
org $C44046
WeaponAttack_Record08_C43A06:
; $C43A06: Weapon directory entry 8 points to $C43A06; attack power is the little-endian word at record +$00.
; $C43A06: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $17

; Range: $C43A2A-$C43A2A (1 bytes)

; Original US: $C43A2A -> German PAL: $C4406A
org $C4406A
WeaponAttack_Record09_C43A2A:
; $C43A2A: Weapon directory entry 9 points to $C43A2A; attack power is the little-endian word at record +$00.
; $C43A2A: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $1C

; Range: $C43A4E-$C43A4E (1 bytes)

; Original US: $C43A4E -> German PAL: $C4408E
org $C4408E
WeaponAttack_Record10_C43A4E:
; $C43A4E: Weapon directory entry 10 points to $C43A4E; attack power is the little-endian word at record +$00.
; $C43A4E: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $25

; Range: $C43A72-$C43A72 (1 bytes)

; Original US: $C43A72 -> German PAL: $C440B2
org $C440B2
WeaponAttack_Record11_C43A72:
; $C43A72: Weapon directory entry 11 points to $C43A72; attack power is the little-endian word at record +$00.
; $C43A72: This slice defines 1 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $41

; Range: $C43ADE-$C43ADF (2 bytes)

; Original US: $C43ADE -> German PAL: $C4411E
org $C4411E
WeaponAttack_Record14_C43ADE:
; $C43ADE: Weapon directory entry 14 points to $C43ADE; attack power is the little-endian word at record +$00.
; $C43ADE: This slice defines 2 of the two attack bytes; preserve inherited high bytes where omitted. Records are 36 bytes, with a name pointer at +$02 and undocumented words after +$04.
    db $58, $02

; Range: $C43B8E-$C43BEA (93 bytes)

; Original US: $C43B8E -> German PAL: $C441CE
org $C441CE
ArmorRecordFields_14_23_C43B8E:
; $C43B8E: Armor directory routes 40 ten-byte records at $C43B02-$C43C91; this slice intersects records 14-23.
; $C43B8E: Record fields: +$00 effective defense (word), +$02 displayed defense (word), +$04 name pointer (word in bank $C4), +$06 undocumented pointer (word), +$08 undocumented value (word).
; $C43B8E: Slice begins at record offset +$00 and ends after offset +$02; preserve partial words and all undocumented fields.
    db $05, $00, $05, $00, $7A, $64, $AD, $60, $BC, $00, $08, $00, $08, $00, $84, $64
    db $AD, $60, $BE, $00, $0D, $00, $0D, $00, $92, $64, $AD, $60, $C0, $00, $13, $00
    db $13, $00, $A0, $64, $AD, $60, $C2, $00, $1B, $00, $1B, $00, $AF, $64, $AD, $60
    db $C4, $00, $25, $00, $25, $00, $BD, $64, $AD, $60, $C6, $00, $31, $00, $31, $00
    db $C9, $64, $AD, $60, $C8, $00, $40, $00, $40, $00, $D7, $64, $AD, $60, $CA, $00
    db $4F, $00, $4F, $00, $E6, $64, $AD, $60, $CC, $00, $60, $00, $60

; Range: $C43C06-$C43C62 (93 bytes)

; Original US: $C43C06 -> German PAL: $C44246
org $C44246
ArmorRecordFields_26_35_C43C06:
; $C43C06: Armor directory routes 40 ten-byte records at $C43B02-$C43C91; this slice intersects records 26-35.
; $C43C06: Record fields: +$00 effective defense (word), +$02 displayed defense (word), +$04 name pointer (word in bank $C4), +$06 undocumented pointer (word), +$08 undocumented value (word).
; $C43C06: Slice begins at record offset +$00 and ends after offset +$02; preserve partial words and all undocumented fields.
    db $03, $00, $03, $00, $1A, $65, $AD, $60, $D4, $00, $07, $00, $07, $00, $25, $65
    db $AD, $60, $D6, $00, $0A, $00, $0A, $00, $34, $65, $AD, $60, $D8, $00, $10, $00
    db $10, $00, $44, $65, $AD, $60, $DA, $00, $16, $00, $16, $00, $51, $65, $AD, $60
    db $DC, $00, $1D, $00, $1D, $00, $5D, $65, $AD, $60, $DE, $00, $26, $00, $26, $00
    db $6D, $65, $AD, $60, $E0, $00, $2F, $00, $2F, $00, $7B, $65, $AD, $60, $E2, $00
    db $39, $00, $39, $00, $86, $65, $AD, $60, $E4, $00, $41, $00, $41

; Range: $C4559A-$C4559D (4 bytes)

; Original US: $C4559A -> German PAL: $C45BDA
org $C45BDA
DogEquipRing_IconPtr:
    db $E6, $00, $C8, $00

; Range: $C45AA0-$C45AA2 (3 bytes)

; Original US: $C45AA0 -> German PAL: $C460E0
org $C460E0
Undocumented_C45AA0:
; $C45AA0: Retained 3-byte slice in native bank; source boundaries are not verified instruction, record or routine boundaries.
; $C45AA0: Entry/field semantics and complete inbound references remain unresolved. Preserve bytes and neighboring inherited data; do not treat the range as free capacity.
; $C45AA0: TODO: Identify the undocumented functionality, complete boundaries and inbound references before changing or relocating this fragment.
    db $50, $00, $C8

; Range: $C45B9D-$C45BA2 (6 bytes)
; Function/storage: ALCHEMY_EXPERIENCE_LEVEL_TABLE

; Original US: $C45B9D -> German PAL: $C461DD
org $C461DD
AlchemyExperience_LevelValues_C45B9D:
; $C45B9D: Byte-valued alchemy experience table at $C45B9C-$C45BA4: this slice covers entry indexes 1-6.
; $C45B9D: Native nine-entry layout is corroborated by Evermizer. The unchanged first and final entries come from the clean base; do not interpret these values as CPU opcodes.
    db $07, $05, $04, $03, $02, $02

; Range: $C45E75-$C45E76 (2 bytes)

; Original US: $C45E75 -> German PAL: $C464B5
org $C464B5
CrushBaseMight:
    db $3D, $00

; Range: $C45E7B-$C45E7E (4 bytes)

; Original US: $C45E7B -> German PAL: $C464BB
org $C464BB
DrainPowers:
    db $20, $00, $20, $00

; ============================================================================
; ROM BANK $C5
; ============================================================================

; Range: $C57410-$C574D9 (202 bytes)
; Function/storage: SHARED_WEAPON_EXPERIENCE

; ============================================================================
; 2. MODUL: EXP-PROGRESSION & STATUSWERTE (Bank $CC, deutscher Shift +$0392)
; ============================================================================
; Original US: $CC8BD3 -> German PAL: $CC8F65
org $CC8F65
CodeData_CC8BD3:
; $CC8BD3: Data slice within PROGRESSION_LOOKUP_DATA; offset $0 from its allocation start.
; $CC8BD3: These numeric table entries are not CPU instructions or addresses into expanded dialogue. Preserve the complete indexed allocation.
    db $0A, $00, $00, $23, $00, $00, $58, $00, $00, $B8, $00, $00, $6F, $01, $00, $86
    db $02, $00, $12, $04, $00, $28, $06, $00, $DE, $08, $00, $4B, $0C, $00, $85, $10
    db $00, $A2, $15, $00, $BA, $1B, $00, $E2, $22, $00, $34, $2B, $00, $C6, $34, $00
    db $B1, $3F, $00, $09, $4C, $00, $EA, $59, $00, $69, $69, $00, $9E, $7A, $00, $A4
    db $8D, $00, $92, $A2, $00, $80, $B9, $00, $87, $D2, $00, $BF, $ED, $00, $42, $0B
    db $01, $27, $2B, $01, $87, $4D, $01, $7D, $72, $01, $21, $9A, $01, $8A, $C4, $01
    db $D8, $F1, $01, $1D, $22, $02, $76, $55, $02, $FC, $8B, $02, $C7, $C5, $02, $F3
    db $02, $03, $99, $43, $03, $D4, $87, $03, $B9, $CF, $03, $68, $1B, $04, $F8, $6A
    db $04, $83, $BE, $04, $24, $16, $05, $F5, $71, $05, $0F, $D2, $05, $8C, $36, $06
    db $8A, $9F, $06, $1E, $0D, $07, $68, $7F, $07, $7F, $F6, $07, $7E, $72, $08, $81
    db $F3, $08, $A0, $79, $09, $F9, $04, $0A, $A4, $95, $0A, $BD, $2B, $0B, $5F, $C7
    db $0B, $A4, $68, $0C, $AA, $0F, $0D, $86, $BC, $0D, $58, $6F, $0E, $3C, $28, $0F
    db $48, $E7, $0F, $9B, $AC, $10, $4E, $78, $11, $7E, $4A, $12, $47, $23, $13, $C1
    db $02, $14, $0A, $E9, $14, $3F, $D6, $15, $77, $CA, $16, $CD, $C5, $17, $63, $C8
    db $18, $50, $D2, $19, $AF, $E3, $1A, $9F, $FC, $1B, $37, $1D, $1D, $97, $45, $1E
    db $D9, $75, $1F, $18, $AE, $20, $72, $EE, $21, $00, $37, $23, $E0, $87, $24, $2B
    db $E1, $25, $02, $43, $27, $7D, $AD, $28, $B8, $20, $2A, $D1, $9C, $2B, $E3, $21
    db $2D, $0B, $B0, $2E, $63, $47, $30, $09, $E8, $31, $1A, $92, $33, $B0, $45, $35
    db $E9, $02, $37, $DF, $C9, $38, $FF, $FF, $FF, $00, $00, $00, $12, $00, $00, $3A
    db $00, $00, $88, $00, $00, $14, $01, $00, $FA, $01, $00, $4C, $03, $00, $1D, $05
    db $00, $83, $07, $00, $95, $0A, $00, $68, $0E, $00, $14, $13, $00, $AE, $18, $00
    db $4F, $1F, $00, $0D, $27, $00, $FF, $2F, $00, $3D, $3A, $00, $DE, $45, $00, $FA
    db $52, $00, $AA, $61, $00, $05, $72, $00, $23, $84, $00, $1D, $98, $00, $0A, $AE
    db $00, $04, $C6, $00, $24, $E0, $00, $81, $FC, $00, $34, $1B, $01, $57, $3C, $01
    db $02, $60, $01, $4F, $86, $01, $57, $AF, $01, $32, $DB, $01, $FB, $09, $02, $CA
    db $3B, $02, $B9, $70, $02, $E2, $A8, $02, $5F, $E4, $02, $48, $23, $03, $B7, $65
    db $03, $C8, $AB, $03, $92, $F5, $03, $31, $43, $04, $BF, $94, $04, $54, $EA, $04
    db $0D, $44, $05, $02, $A2, $05, $4E, $04, $06, $0C, $6B, $06, $55, $D6, $06, $44
    db $46, $07, $F4, $BA, $07, $7F, $34, $08, $00, $B3, $08, $91, $36, $09, $4D, $BF
    db $09, $4F, $4D, $0A, $B1, $E0, $0A, $8F, $79, $0B, $03, $18, $0C, $28, $BC, $0C
    db $19, $66, $0D, $F1, $15, $0E, $CB, $CB, $0E, $C2, $87, $0F, $F2, $49, $10, $75
    db $12, $11, $68, $E1, $11, $E4, $B6, $12, $05, $93, $13, $E7, $75, $14, $A5, $5F
    db $15, $5B, $50, $16, $23, $48, $17, $1A, $47, $18, $5A, $4D, $19, $01, $5B, $1A
    db $28, $70, $1B, $EC, $8C, $1C, $68, $B1, $1D, $B9, $DD, $1E, $FA, $11, $20, $46
    db $4E, $21, $B9, $92, $22, $70, $DF, $23, $86, $34, $25, $18, $92, $26, $40, $F8
    db $27, $1C, $67, $29, $C6, $DE, $2A, $5C, $5F, $2C, $F8, $E8, $2D, $B8, $7B, $2F
    db $B8, $17, $31, $13, $BD, $32, $E6, $6B, $34, $4D, $24, $36, $64, $E6, $37, $48
    db $B2, $39

; Range: $CC9285-$CC9357 (211 bytes)

; Original US: $CC9285 -> German PAL: $CC9617
org $CC9617
CharacterGrowthTableSlice_CC9285:
; $CC9285: Native level tables: 111 little-endian word entries per table, indexed by effective level. BoyDefense at $CC927B, entries 5-110, first byte offset 0, final byte offset 0.
; $CC9285: SoERomInfo USA table boundaries are corroborated by LDA long,X operands in the native boy/dog stat routines. Some source slices span several tables or retain only one byte of a boundary word; preserve inherited neighbors.
    db $0A, $00, $0B, $00, $0C, $00, $0D, $00, $0F, $00, $10, $00, $11, $00, $12, $00
    db $14, $00, $15, $00, $16, $00, $17, $00, $19, $00, $1A, $00, $1B, $00, $1C, $00
    db $1E, $00, $1F, $00, $20, $00, $21, $00, $23, $00, $24, $00, $25, $00, $26, $00
    db $28, $00, $29, $00, $2A, $00, $2B, $00, $2D, $00, $2E, $00, $2F, $00, $30, $00
    db $32, $00, $33, $00, $34, $00, $35, $00, $37, $00, $38, $00, $39, $00, $3A, $00
    db $3C, $00, $3D, $00, $3E, $00, $3F, $00, $41, $00, $42, $00, $43, $00, $44, $00
    db $46, $00, $47, $00, $48, $00, $49, $00, $4B, $00, $4C, $00, $4D, $00, $4E, $00
    db $50, $00, $51, $00, $52, $00, $53, $00, $55, $00, $56, $00, $57, $00, $58, $00
    db $5A, $00, $5B, $00, $5C, $00, $5D, $00, $5F, $00, $60, $00, $61, $00, $62, $00
    db $64, $00, $65, $00, $66, $00, $67, $00, $69, $00, $6A, $00, $6B, $00, $6C, $00
    db $6E, $00, $6F, $00, $70, $00, $71, $00, $73, $00, $74, $00, $75, $00, $76, $00
    db $78, $00, $79, $00, $7A, $00, $7B, $00, $7D, $00, $7E, $00, $7F, $00, $80, $00
    db $82, $00, $83, $00, $84, $00, $85, $00, $87, $00, $88, $00, $89, $00, $8A, $00
    db $8C, $00, $8D

; Range: $CC943F-$CC9513 (213 bytes)

; Original US: $CC943F -> German PAL: $CC97D1
org $CC97D1
CharacterGrowthTableSlice_CC943F:
; $CC943F: Native level tables: 111 little-endian word entries per table, indexed by effective level. BoyMagicDefense at $CC9437, entries 4-110, first byte offset 0, final byte offset 0.
; $CC943F: SoERomInfo USA table boundaries are corroborated by LDA long,X operands in the native boy/dog stat routines. Some source slices span several tables or retain only one byte of a boundary word; preserve inherited neighbors.
    db $07, $00, $08, $00, $09, $00, $0A, $00, $0A, $00, $0B, $00, $0C, $00, $0D, $00
    db $0D, $00, $0E, $00, $0F, $00, $10, $00, $10, $00, $11, $00, $12, $00, $13, $00
    db $13, $00, $14, $00, $15, $00, $16, $00, $16, $00, $17, $00, $18, $00, $19, $00
    db $19, $00, $1A, $00, $1B, $00, $1C, $00, $1C, $00, $1D, $00, $1E, $00, $1F, $00
    db $1F, $00, $20, $00, $21, $00, $22, $00, $22, $00, $23, $00, $24, $00, $25, $00
    db $25, $00, $26, $00, $27, $00, $28, $00, $28, $00, $29, $00, $2A, $00, $2B, $00
    db $2B, $00, $2C, $00, $2D, $00, $2E, $00, $2E, $00, $2F, $00, $30, $00, $31, $00
    db $31, $00, $32, $00, $33, $00, $34, $00, $34, $00, $35, $00, $36, $00, $37, $00
    db $37, $00, $38, $00, $39, $00, $3A, $00, $3A, $00, $3B, $00, $3C, $00, $3D, $00
    db $3D, $00, $3E, $00, $3F, $00, $40, $00, $40, $00, $41, $00, $42, $00, $43, $00
    db $43, $00, $44, $00, $45, $00, $46, $00, $46, $00, $47, $00, $48, $00, $49, $00
    db $49, $00, $4A, $00, $4B, $00, $4C, $00, $4C, $00, $4D, $00, $4E, $00, $4F, $00
    db $4F, $00, $50, $00, $51, $00, $52, $00, $52, $00, $53, $00, $54, $00, $55, $00
    db $55, $00, $56, $00, $57

; Range: $CC95F5-$CC988B (663 bytes)

; Original US: $CC95F5 -> German PAL: $CC9987
org $CC9987
CharacterGrowthTableSlice_CC95F5:
; $CC95F5: Native level tables: 111 little-endian word entries per table, indexed by effective level. DogDefense at $CC95F3, entries 1-110, first byte offset 0, final byte offset 1; DogAttack at $CC96D1, entries 0-110, first byte offset 0, final byte offset 1; DogMagicDefense at $CC97AF, entries 0-110, first byte offset 0, final byte offset 0.
; $CC95F5: SoERomInfo USA table boundaries are corroborated by LDA long,X operands in the native boy/dog stat routines. Some source slices span several tables or retain only one byte of a boundary word; preserve inherited neighbors.
    db $08, $00, $0B, $00, $0F, $00, $12, $00, $16, $00, $19, $00, $1D, $00, $20, $00
    db $24, $00, $27, $00, $2B, $00, $2E, $00, $32, $00, $35, $00, $39, $00, $3C, $00
    db $40, $00, $43, $00, $47, $00, $4A, $00, $4E, $00, $51, $00, $55, $00, $58, $00
    db $5C, $00, $5F, $00, $63, $00, $66, $00, $6A, $00, $6D, $00, $71, $00, $74, $00
    db $78, $00, $7B, $00, $7F, $00, $82, $00, $86, $00, $89, $00, $8D, $00, $90, $00
    db $94, $00, $97, $00, $9B, $00, $9E, $00, $A2, $00, $A5, $00, $A9, $00, $AC, $00
    db $B0, $00, $B3, $00, $B7, $00, $BA, $00, $BE, $00, $C1, $00, $C5, $00, $C8, $00
    db $CC, $00, $CF, $00, $D3, $00, $D6, $00, $DA, $00, $DD, $00, $E1, $00, $E4, $00
    db $E8, $00, $EB, $00, $EF, $00, $F2, $00, $F6, $00, $F9, $00, $FD, $00, $00, $01
    db $04, $01, $07, $01, $0B, $01, $0E, $01, $12, $01, $15, $01, $19, $01, $1C, $01
    db $20, $01, $23, $01, $27, $01, $2A, $01, $2E, $01, $31, $01, $35, $01, $38, $01
    db $3C, $01, $3F, $01, $43, $01, $46, $01, $4A, $01, $4D, $01, $51, $01, $54, $01
    db $58, $01, $5B, $01, $5F, $01, $62, $01, $66, $01, $69, $01, $6D, $01, $70, $01
    db $74, $01, $77, $01, $7B, $01, $7E, $01, $82, $01, $85, $01, $00, $00, $11, $00
    db $15, $00, $18, $00, $1C, $00, $1F, $00, $24, $00, $27, $00, $2B, $00, $2E, $00
    db $32, $00, $36, $00, $3A, $00, $3D, $00, $41, $00, $44, $00, $49, $00, $4C, $00
    db $50, $00, $53, $00, $57, $00, $5B, $00, $5F, $00, $62, $00, $66, $00, $69, $00
    db $6E, $00, $71, $00, $75, $00, $78, $00, $7C, $00, $80, $00, $84, $00, $87, $00
    db $8B, $00, $8E, $00, $93, $00, $96, $00, $9A, $00, $9D, $00, $A1, $00, $A5, $00
    db $A9, $00, $AC, $00, $B0, $00, $B3, $00, $B8, $00, $BB, $00, $BF, $00, $C2, $00
    db $C6, $00, $CA, $00, $CE, $00, $D1, $00, $D5, $00, $D8, $00, $DD, $00, $E0, $00
    db $E4, $00, $E7, $00, $EB, $00, $EF, $00, $F3, $00, $F6, $00, $FA, $00, $FD, $00
    db $02, $01, $05, $01, $09, $01, $0C, $01, $10, $01, $14, $01, $18, $01, $1B, $01
    db $1F, $01, $22, $01, $27, $01, $2A, $01, $2E, $01, $31, $01, $35, $01, $39, $01
    db $3D, $01, $40, $01, $44, $01, $47, $01, $4C, $01, $4F, $01, $53, $01, $56, $01
    db $5A, $01, $5E, $01, $62, $01, $65, $01, $69, $01, $6C, $01, $71, $01, $74, $01
    db $78, $01, $7B, $01, $7F, $01, $83, $01, $87, $01, $8A, $01, $8E, $01, $91, $01
    db $96, $01, $99, $01, $9D, $01, $A0, $01, $A4, $01, $00, $00, $04, $00, $05, $00
    db $05, $00, $06, $00, $06, $00, $07, $00, $07, $00, $08, $00, $08, $00, $09, $00
    db $09, $00, $0A, $00, $0A, $00, $0B, $00, $0B, $00, $0C, $00, $0C, $00, $0D, $00
    db $0D, $00, $0E, $00, $0E, $00, $0F, $00, $0F, $00, $10, $00, $10, $00, $11, $00
    db $11, $00, $12, $00, $12, $00, $13, $00, $13, $00, $14, $00, $14, $00, $15, $00
    db $15, $00, $16, $00, $16, $00, $17, $00, $17, $00, $18, $00, $18, $00, $19, $00
    db $19, $00, $1A, $00, $1A, $00, $1B, $00, $1B, $00, $1C, $00, $1C, $00, $1D, $00
    db $1D, $00, $1E, $00, $1E, $00, $1F, $00, $1F, $00, $20, $00, $20, $00, $21, $00
    db $21, $00, $22, $00, $22, $00, $23, $00, $23, $00, $24, $00, $24, $00, $25, $00
    db $25, $00, $26, $00, $26, $00, $27, $00, $27, $00, $28, $00, $28, $00, $29, $00
    db $29, $00, $2A, $00, $2A, $00, $2B, $00, $2B, $00, $2C, $00, $2C, $00, $2D, $00
    db $2D, $00, $2E, $00, $2E, $00, $2F, $00, $2F, $00, $30, $00, $30, $00, $31, $00
    db $31, $00, $32, $00, $32, $00, $33, $00, $33, $00, $34, $00, $34, $00, $35, $00
    db $35, $00, $36, $00, $36, $00, $37, $00, $37, $00, $38, $00, $38, $00, $39, $00
    db $39, $00, $3A, $00, $3A, $00, $3B

; Range: $CCA284-$CCA28F (12 bytes)

; ============================================================================
; 3. MODUL: GEGNER- & BOSS-REBALANCING (Bank $8E, identischer File-Offset $0EB678)
; ============================================================================
; German PAL Enemy Record at $8EC545
org $8EC545
EnemyStats_Record051_HP_CEC545:
; $CEC545: Physical native character record 51 at $CEC536; 74-byte stride, slice +$0F-+$27.
; $CEC545: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC545: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CEC545: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $2C, $01, $00, $00, $20, $00, $FF, $00, $00, $00, $58, $00, $A0, $00, $20, $00
    db $1E, $00, $3C, $00, $14, $00, $00, $00, $28

; Range: $CEC58F-$CEC5B0 (34 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC58F
org $8EC58F
EnemyStats_Record052_HP_CEC58F:
; $CEC58F: Physical native character record 52 at $CEC580; 74-byte stride, slice +$0F-+$30.
; $CEC58F: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money; +$29-+$29 PrizeChance; +$2C-+$2D ChargeLimit; +$2E-+$2F ChargeGain.
; $CEC58F: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CEC58F: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18, +$2A, +$2B, +$30. They remain record data and are not spare capacity.
    db $FA, $00, $00, $00, $50, $00, $32, $00, $00, $00, $33, $00, $C8, $00, $C1, $00
    db $00, $00, $50, $00, $14, $00, $00, $00, $28, $00, $08, $12, $00, $00, $04, $0A
    db $00, $16

; Range: $CEC5E3-$CEC5F1 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC5E3
org $8EC5E3
EnemyStats_Record053_Attack_CEC5E3:
; $CEC5E3: Physical native character record 53 at $CEC5CA; 74-byte stride, slice +$19-+$27.
; $CEC5E3: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC5E3: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $42, $00, $A0, $00, $3C, $00, $41, $00, $23, $00, $14, $00, $00, $00, $28

; Range: $CEC63B-$CEC63C (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC63B
org $8EC63B
EnemyStats_Record054_Money_CEC63B:
; $CEC63B: Physical native character record 54 at $CEC614; 74-byte stride, slice +$27-+$28.
; $CEC63B: Fields in this slice: +$27-+$28 Money.
; $CEC63B: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $58, $02

; Range: $CEC677-$CEC686 (16 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC677
org $8EC677
EnemyStats_Record055_Attack_CEC677:
; $CEC677: Physical native character record 55 at $CEC65E; 74-byte stride, slice +$19-+$28.
; $CEC677: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CEC677: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $60, $00, $B0, $04, $33, $00, $00, $00, $64, $00, $64, $00, $00, $00, $58, $02

; Range: $CEC6C1-$CEC6CF (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC6C1
org $8EC6C1
EnemyStats_Record056_Attack_CEC6C1:
; $CEC6C1: Physical native character record 56 at $CEC6A8; 74-byte stride, slice +$19-+$27.
; $CEC6C1: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC6C1: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $3E, $00, $58, $00, $00, $00, $0A, $00, $3C, $00, $96, $00, $00, $00, $C8

; Range: $CEC701-$CEC719 (25 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC701
org $8EC701
EnemyStats_Record057_HP_CEC701:
; $CEC701: Physical native character record 57 at $CEC6F2; 74-byte stride, slice +$0F-+$27.
; $CEC701: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC701: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CEC701: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $78, $00, $00, $00, $32, $00, $50, $00, $96, $00, $52, $00, $C8, $00, $26, $00
    db $0A, $00, $46, $00, $B4, $00, $00, $00, $F0

; Range: $CEC74B-$CEC75D (19 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC74B
org $8EC74B
EnemyStats_Record058_HP_CEC74B:
; $CEC74B: Physical native character record 58 at $CEC73C; 74-byte stride, slice +$0F-+$21.
; $CEC74B: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$21 HitRate (partial field).
; $CEC74B: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CEC74B: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $84, $03, $32, $00, $20, $00, $64, $00, $00, $00, $5A, $00, $C8, $00, $20, $00
    db $1E, $00, $46

; Range: $CEC79F-$CEC7AD (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC79F
org $8EC79F
EnemyStats_Record059_Attack_CEC79F:
; $CEC79F: Physical native character record 59 at $CEC786; 74-byte stride, slice +$19-+$27.
; $CEC79F: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC79F: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $19, $00, $50, $00, $00, $00, $0A, $00, $14, $00, $32, $00, $00, $00, $F0

; Range: $CEC7AF-$CEC7AF (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC7AF
org $8EC7AF
TumbleWeed_NormalDropClass:
; $CEC7AF: Physical native character record 59 at $CEC786; 74-byte stride, slice +$29-+$29.
; $CEC7AF: Fields in this slice: +$29-+$29 PrizeChance.
; $CEC7AF: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $08

; Range: $CEC7E9-$CEC7F7 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC7E9
org $8EC7E9
EnemyStats_Record060_Attack_CEC7E9:
; $CEC7E9: Physical native character record 60 at $CEC7D0; 74-byte stride, slice +$19-+$27.
; $CEC7E9: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC7E9: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $31, $00, $F0, $00, $00, $00, $08, $00, $37, $00, $A0, $00, $00, $00, $78

; Range: $CEC829-$CEC842 (26 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC829
org $8EC829
EnemyStats_Record061_HP_CEC829:
; $CEC829: Physical native character record 61 at $CEC81A; 74-byte stride, slice +$0F-+$28.
; $CEC829: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CEC829: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CEC829: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $C8, $00, $00, $00, $00, $00, $00, $00, $96, $00, $82, $00, $F0, $00, $00, $00
    db $0F, $00, $41, $00, $58, $02, $00, $00, $20, $03

; Range: $CEC87D-$CEC88B (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC87D
org $8EC87D
EnemyStats_Record062_Attack_CEC87D:
; $CEC87D: Physical native character record 62 at $CEC864; 74-byte stride, slice +$19-+$27.
; $CEC87D: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC87D: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $29, $00, $78, $00, $00, $00, $0F, $00, $2D, $00, $46, $00, $00, $00, $3C

; Range: $CEC8BD-$CEC8D5 (25 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC8BD
org $8EC8BD
EnemyStats_Record063_HP_CEC8BD:
; $CEC8BD: Physical native character record 63 at $CEC8AE; 74-byte stride, slice +$0F-+$27.
; $CEC8BD: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC8BD: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CEC8BD: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $5A, $00, $00, $00, $00, $00, $00, $00, $96, $00, $35, $00, $A0, $00, $00, $00
    db $0F, $00, $37, $00, $78, $00, $00, $00, $3C

; Range: $CEC911-$CEC91F (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC911
org $8EC911
EnemyStats_Record064_Attack_CEC911:
; $CEC911: Physical native character record 64 at $CEC8F8; 74-byte stride, slice +$19-+$27.
; $CEC911: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC911: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $3A, $00, $A0, $00, $10, $00, $0A, $00, $41, $00, $78, $00, $00, $00, $14

; Range: $CEC95B-$CEC969 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC95B
org $8EC95B
EnemyStats_Record065_Attack_CEC95B:
; $CEC95B: Physical native character record 65 at $CEC942; 74-byte stride, slice +$19-+$27.
; $CEC95B: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEC95B: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $3A, $00, $A0, $00, $10, $00, $0A, $00, $41, $00, $96, $00, $00, $00, $14

; Range: $CEC9A5-$CEC9B0 (12 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EC9A5
org $8EC9A5
EnemyStats_Record066_Attack_CEC9A5:
; $CEC9A5: Physical native character record 66 at $CEC98C; 74-byte stride, slice +$19-+$24.
; $CEC9A5: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$24 Experience (partial field).
; $CEC9A5: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $89, $00, $C8, $00, $00, $00, $00, $00, $64, $00, $E8, $03

; Range: $CECA83-$CECA91 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECA83
org $8ECA83
EnemyStats_Record069_Attack_CECA83:
; $CECA83: Physical native character record 69 at $CECA6A; 74-byte stride, slice +$19-+$27.
; $CECA83: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CECA83: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $91, $00, $40, $01, $20, $00, $0E, $00, $46, $00, $D0, $07, $00, $00, $28

; Range: $CECACD-$CECADC (16 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECACD
org $8ECACD
EnemyStats_Record070_Attack_CECACD:
; $CECACD: Physical native character record 70 at $CECAB4; 74-byte stride, slice +$19-+$28.
; $CECACD: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CECACD: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $88, $00, $A0, $00, $30, $00, $07, $00, $28, $00, $58, $02, $00, $00, $60, $09

; Range: $CECB17-$CECB26 (16 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECB17
org $8ECB17
EnemyStats_Record071_Attack_CECB17:
; $CECB17: Physical native character record 71 at $CECAFE; 74-byte stride, slice +$19-+$28.
; $CECB17: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CECB17: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $28, $00, $50, $00, $20, $00, $0A, $00, $19, $00, $88, $13, $00, $00, $D0, $07

; Range: $CECB57-$CECB6C (22 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECB57
org $8ECB57
EnemyStats_Record072_HP_CECB57:
; $CECB57: Physical native character record 72 at $CECB48; 74-byte stride, slice +$0F-+$24.
; $CECB57: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$24 Experience (partial field).
; $CECB57: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECB57: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $F4, $01, $14, $00, $64, $00, $14, $00, $82, $00, $50, $00, $A0, $00, $0C, $00
    db $0A, $00, $32, $00, $20, $03

; Range: $CECBA1-$CECBB5 (21 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECBA1
org $8ECBA1
EnemyStats_Record073_HP_CECBA1:
; $CECBA1: Physical native character record 73 at $CECB92; 74-byte stride, slice +$0F-+$23.
; $CECBA1: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$23 Experience (partial field).
; $CECBA1: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECBA1: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $FA, $00, $14, $00, $46, $00, $1E, $00, $96, $00, $36, $00, $A0, $00, $10, $00
    db $0A, $00, $46, $00, $90

; Range: $CECBEB-$CECBEC (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECBEB
org $8ECBEB
EnemyStats_Record074_HP_CECBEB:
; $CECBEB: Physical native character record 74 at $CECBDC; 74-byte stride, slice +$0F-+$10.
; $CECBEB: Fields in this slice: +$0F-+$10 HP.
; $CECBEB: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $F0, $0A

; Range: $CECBFF-$CECC00 (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECBFF
org $8ECBFF
EnemyStats_Record074_Experience_CECBFF:
; $CECBFF: Physical native character record 74 at $CECBDC; 74-byte stride, slice +$23-+$24.
; $CECBFF: Fields in this slice: +$23-+$24 Experience (partial field).
; $CECBFF: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $70, $17

; Range: $CECC3F-$CECC47 (9 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECC3F
org $8ECC3F
EnemyStats_Record075_Attack_CECC3F:
; $CECC3F: Physical native character record 75 at $CECC26; 74-byte stride, slice +$19-+$21.
; $CECC3F: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$21 HitRate (partial field).
; $CECC3F: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $40, $00, $00, $00, $00, $00, $19, $00, $64

; Range: $CECC7F-$CECC94 (22 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECC7F
org $8ECC7F
EnemyStats_Record076_HP_CECC7F:
; $CECC7F: Physical native character record 76 at $CECC70; 74-byte stride, slice +$0F-+$24.
; $CECC7F: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$24 Experience (partial field).
; $CECC7F: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECC7F: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $A0, $0F, $14, $00, $37, $00, $32, $00, $96, $00, $9C, $00, $78, $00, $00, $00
    db $0F, $00, $28, $00, $AC, $0D

; Range: $CECCC9-$CECCE2 (26 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECCC9
org $8ECCC9
EnemyStats_Record077_HP_CECCC9:
; $CECCC9: Physical native character record 77 at $CECCBA; 74-byte stride, slice +$0F-+$28.
; $CECCC9: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CECCC9: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECCC9: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $C8, $19, $14, $00, $28, $00, $32, $00, $96, $00, $88, $00, $A0, $00, $00, $00
    db $0A, $00, $23, $00, $E4, $0C, $00, $00, $B8, $0B

; Range: $CECD13-$CECD28 (22 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECD13
org $8ECD13
EnemyStats_Record078_HP_CECD13:
; $CECD13: Physical native character record 78 at $CECD04; 74-byte stride, slice +$0F-+$24.
; $CECD13: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$24 Experience (partial field).
; $CECD13: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECD13: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $B8, $0B, $14, $00, $37, $00, $32, $00, $2C, $01, $5A, $00, $18, $01, $33, $00
    db $0A, $00, $50, $00, $D0, $07

; Range: $CECD5D-$CECD5E (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECD5D
org $8ECD5D
EnemyStats_Record079_HP_CECD5D:
; $CECD5D: Physical native character record 79 at $CECD4E; 74-byte stride, slice +$0F-+$10.
; $CECD5D: Fields in this slice: +$0F-+$10 HP.
; $CECD5D: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $10, $0E

; Range: $CECD71-$CECD72 (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECD71
org $8ECD71
EnemyStats_Record079_Experience_CECD71:
; $CECD71: Physical native character record 79 at $CECD4E; 74-byte stride, slice +$23-+$24.
; $CECD71: Fields in this slice: +$23-+$24 Experience (partial field).
; $CECD71: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $D0, $07

; Range: $CECDBB-$CECDBF (5 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECDBB
org $8ECDBB
EnemyStats_Record080_Experience_CECDBB:
; $CECDBB: Physical native character record 80 at $CECD98; 74-byte stride, slice +$23-+$27.
; $CECDBB: Fields in this slice: +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CECDBB: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $1C, $00, $00, $00, $14

; Range: $CECE09-$CECE09 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECE09
org $8ECE09
EnemyStats_Record081_Money_CECE09:
; $CECE09: Physical native character record 81 at $CECDE2; 74-byte stride, slice +$27-+$27.
; $CECE09: Fields in this slice: +$27-+$27 Money (partial field).
; $CECE09: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $14

; Range: $CECE45-$CECE45 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECE45
org $8ECE45
EnemyStats_Record082_Attack_CECE45:
; $CECE45: Physical native character record 82 at $CECE2C; 74-byte stride, slice +$19-+$19.
; $CECE45: Fields in this slice: +$19-+$19 Attack (partial field).
; $CECE45: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $38

; Range: $CECE85-$CECE93 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECE85
org $8ECE85
EnemyStats_Record083_HP_CECE85:
; $CECE85: Physical native character record 83 at $CECE76; 74-byte stride, slice +$0F-+$1D.
; $CECE85: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1D MagicDefense (partial field).
; $CECE85: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECE85: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $96, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $A0, $00, $C1

; Range: $CECECF-$CECEE8 (26 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECECF
org $8ECECF
EnemyStats_Record084_HP_CECECF:
; $CECECF: Physical native character record 84 at $CECEC0; 74-byte stride, slice +$0F-+$28.
; $CECECF: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CECECF: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECECF: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $40, $06, $14, $00, $37, $00, $32, $00, $00, $00, $46, $00, $50, $00, $10, $00
    db $00, $00, $46, $00, $B0, $04, $00, $00, $B0, $04

; Range: $CECF23-$CECF32 (16 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECF23
org $8ECF23
EnemyStats_Record085_Attack_CECF23:
; $CECF23: Physical native character record 85 at $CECF0A; 74-byte stride, slice +$19-+$28.
; $CECF23: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CECF23: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $A5, $00, $50, $00, $10, $00, $00, $00, $4B, $00, $A0, $0F, $00, $00, $D0, $07

; Range: $CECF7B-$CECF7B (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECF7B
org $8ECF7B
EnemyStats_Record086_Money_CECF7B:
; $CECF7B: Physical native character record 86 at $CECF54; 74-byte stride, slice +$27-+$27.
; $CECF7B: Fields in this slice: +$27-+$27 Money (partial field).
; $CECF7B: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $08

; Range: $CECFAD-$CECFC2 (22 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECFAD
org $8ECFAD
EnemyStats_Record087_HP_CECFAD:
; $CECFAD: Physical native character record 87 at $CECF9E; 74-byte stride, slice +$0F-+$24.
; $CECFAD: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$24 Experience (partial field).
; $CECFAD: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECFAD: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $B0, $04, $28, $00, $9B, $00, $46, $00, $00, $00, $2A, $00, $28, $00, $29, $00
    db $05, $00, $64, $00, $E0, $03

; Range: $CECFF7-$CED005 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ECFF7
org $8ECFF7
EnemyStats_Record088_HP_CECFF7:
; $CECFF7: Physical native character record 88 at $CECFE8; 74-byte stride, slice +$0F-+$1D.
; $CECFF7: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1D MagicDefense (partial field).
; $CECFF7: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CECFF7: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $80, $0C, $64, $00, $9B, $00, $46, $00, $F4, $01, $55, $00, $78, $00, $F0

; Range: $CED059-$CED059 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED059
org $8ED059
EnemyStats_Record089_Money_CED059:
; $CED059: Physical native character record 89 at $CED032; 74-byte stride, slice +$27-+$27.
; $CED059: Fields in this slice: +$27-+$27 Money (partial field).
; $CED059: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $60

; Range: $CED095-$CED0A3 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED095
org $8ED095
EnemyStats_Record090_Attack_CED095:
; $CED095: Physical native character record 90 at $CED07C; 74-byte stride, slice +$19-+$27.
; $CED095: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED095: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $62, $00, $A0, $00, $26, $00, $19, $00, $55, $00, $58, $02, $00, $00, $60

; Range: $CED137-$CED137 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED137
org $8ED137
EnemyStats_Record092_Money_CED137:
; $CED137: Physical native character record 92 at $CED110; 74-byte stride, slice +$27-+$27.
; $CED137: Fields in this slice: +$27-+$27 Money (partial field).
; $CED137: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $64

; Range: $CED173-$CED181 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED173
org $8ED173
EnemyStats_Record093_Attack_CED173:
; $CED173: Physical native character record 93 at $CED15A; 74-byte stride, slice +$19-+$27.
; $CED173: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED173: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $4B, $00, $28, $00, $E0, $00, $05, $00, $32, $00, $96, $00, $00, $00, $14

; Range: $CED1BD-$CED1CB (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED1BD
org $8ED1BD
EnemyStats_Record094_Attack_CED1BD:
; $CED1BD: Physical native character record 94 at $CED1A4; 74-byte stride, slice +$19-+$27.
; $CED1BD: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED1BD: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $26, $00, $64, $00, $10, $00, $0F, $00, $3C, $00, $14, $00, $00, $00, $B4

; Range: $CED207-$CED215 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED207
org $8ED207
EnemyStats_Record095_Attack_CED207:
; $CED207: Physical native character record 95 at $CED1EE; 74-byte stride, slice +$19-+$27.
; $CED207: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED207: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $42, $00, $50, $00, $10, $00, $0A, $00, $3C, $00, $96, $00, $00, $00, $50

; Range: $CED247-$CED25C (22 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED247
org $8ED247
EnemyStats_Record096_HP_CED247:
; $CED247: Physical native character record 96 at $CED238; 74-byte stride, slice +$0F-+$24.
; $CED247: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$24 Experience (partial field).
; $CED247: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED247: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $FA, $00, $14, $00, $37, $00, $32, $00, $C8, $00, $4B, $00, $A0, $00, $10, $00
    db $0A, $00, $41, $00, $90, $01

; Range: $CED291-$CED2A3 (19 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED291
org $8ED291
EnemyStats_Record097_HP_CED291:
; $CED291: Physical native character record 97 at $CED282; 74-byte stride, slice +$0F-+$21.
; $CED291: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$21 HitRate (partial field).
; $CED291: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED291: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $EE, $02, $1E, $00, $50, $00, $01, $00, $00, $00, $49, $00, $4C, $00, $30, $00
    db $05, $00, $46

; Range: $CED2CC-$CED2CC (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED2CC
org $8ED2CC
EnemyStats_Record098_NamePointer_CED2CC:
; $CED2CC: Physical native character record 98 at $CED2CC; 74-byte stride, slice +$00-+$00.
; $CED2CC: Fields in this slice: +$00-+$00 NamePointer (partial field).
; $CED2CC: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $77

; Range: $CED2EF-$CED2F3 (5 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED2EF
org $8ED2EF
EnemyStats_Record098_Experience_CED2EF:
; $CED2EF: Physical native character record 98 at $CED2CC; 74-byte stride, slice +$23-+$27.
; $CED2EF: Fields in this slice: +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED2EF: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $0F, $00, $00, $00, $18

; Range: $CED339-$CED33D (5 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED339
org $8ED339
EnemyStats_Record099_Experience_CED339:
; $CED339: Physical native character record 99 at $CED316; 74-byte stride, slice +$23-+$27.
; $CED339: Fields in this slice: +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED339: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $12, $00, $00, $00, $36

; Range: $CED387-$CED387 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED387
org $8ED387
EnemyStats_Record100_Money_CED387:
; $CED387: Physical native character record 100 at $CED360; 74-byte stride, slice +$27-+$27.
; $CED387: Fields in this slice: +$27-+$27 Money (partial field).
; $CED387: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $18

; Range: $CED3C3-$CED3D1 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED3C3
org $8ED3C3
EnemyStats_Record101_Attack_CED3C3:
; $CED3C3: Physical native character record 101 at $CED3AA; 74-byte stride, slice +$19-+$27.
; $CED3C3: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED3C3: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $25, $00, $30, $00, $30, $00, $0F, $00, $28, $00, $48, $00, $00, $00, $24

; Range: $CED40D-$CED41B (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED40D
org $8ED40D
EnemyStats_Record102_Attack_CED40D:
; $CED40D: Physical native character record 102 at $CED3F4; 74-byte stride, slice +$19-+$27.
; $CED40D: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED40D: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $49, $00, $A0, $00, $30, $00, $00, $00, $32, $00, $18, $01, $00, $00, $3C

; Range: $CED457-$CED46E (24 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED457
org $8ED457
EnemyStats_Record103_Attack_CED457:
; $CED457: Physical native character record 103 at $CED43E; 74-byte stride, slice +$19-+$30.
; $CED457: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money; +$29-+$29 PrizeChance; +$2C-+$2D ChargeLimit; +$2E-+$2F ChargeGain.
; $CED457: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED457: Bytes with undocumented field meaning: +$2A, +$2B, +$30. They remain record data and are not spare capacity.
    db $1F, $00, $50, $00, $C1, $FF, $00, $00, $3C, $00, $F0, $00, $00, $00, $50, $00
    db $08, $01, $00, $00, $04, $0E, $00, $16

; Range: $CED4A1-$CED4B8 (24 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED4A1
org $8ED4A1
EnemyStats_Record104_Attack_CED4A1:
; $CED4A1: Physical native character record 104 at $CED488; 74-byte stride, slice +$19-+$30.
; $CED4A1: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money; +$29-+$29 PrizeChance; +$2C-+$2D ChargeLimit; +$2E-+$2F ChargeGain.
; $CED4A1: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED4A1: Bytes with undocumented field meaning: +$2A, +$2B, +$30. They remain record data and are not spare capacity.
    db $4C, $00, $50, $00, $C1, $FF, $00, $00, $46, $00, $F4, $01, $00, $00, $64, $00
    db $08, $01, $00, $00, $04, $0E, $00, $16

; Range: $CED4F9-$CED4F9 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED4F9
org $8ED4F9
EnemyStats_Record105_Money_CED4F9:
; $CED4F9: Physical native character record 105 at $CED4D2; 74-byte stride, slice +$27-+$27.
; $CED4F9: Fields in this slice: +$27-+$27 Money (partial field).
; $CED4F9: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $22

; Range: $CED52B-$CED52C (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED52B
org $8ED52B
EnemyStats_Record106_HP_CED52B:
; $CED52B: Physical native character record 106 at $CED51C; 74-byte stride, slice +$0F-+$10.
; $CED52B: Fields in this slice: +$0F-+$10 HP.
; $CED52B: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $00, $05

; Range: $CED53F-$CED540 (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED53F
org $8ED53F
EnemyStats_Record106_Experience_CED53F:
; $CED53F: Physical native character record 106 at $CED51C; 74-byte stride, slice +$23-+$24.
; $CED53F: Fields in this slice: +$23-+$24 Experience (partial field).
; $CED53F: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $E8, $03

; Range: $CED58D-$CED58D (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED58D
org $8ED58D
EnemyStats_Record107_Money_CED58D:
; $CED58D: Physical native character record 107 at $CED566; 74-byte stride, slice +$27-+$27.
; $CED58D: Fields in this slice: +$27-+$27 Money (partial field).
; $CED58D: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $C8

; Range: $CED5D7-$CED5D7 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED5D7
org $8ED5D7
EnemyStats_Record108_Money_CED5D7:
; $CED5D7: Physical native character record 108 at $CED5B0; 74-byte stride, slice +$27-+$27.
; $CED5D7: Fields in this slice: +$27-+$27 Money (partial field).
; $CED5D7: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $0E

; Range: $CED621-$CED621 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED621
org $8ED621
EnemyStats_Record109_Money_CED621:
; $CED621: Physical native character record 109 at $CED5FA; 74-byte stride, slice +$27-+$27.
; $CED621: Fields in this slice: +$27-+$27 Money (partial field).
; $CED621: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $04

; Range: $CED6A7-$CED6BE (24 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED6A7
org $8ED6A7
EnemyStats_Record111_Attack_CED6A7:
; $CED6A7: Physical native character record 111 at $CED68E; 74-byte stride, slice +$19-+$30.
; $CED6A7: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money; +$29-+$29 PrizeChance; +$2C-+$2D ChargeLimit; +$2E-+$2F ChargeGain.
; $CED6A7: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED6A7: Bytes with undocumented field meaning: +$2A, +$2B, +$30. They remain record data and are not spare capacity.
    db $6A, $00, $50, $00, $10, $00, $0F, $00, $3C, $00, $12, $01, $00, $00, $DC, $00
    db $08, $01, $00, $00, $04, $0A, $00, $12

; Range: $CED6FF-$CED6FF (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED6FF
org $8ED6FF
EnemyStats_Record112_Money_CED6FF:
; $CED6FF: Physical native character record 112 at $CED6D8; 74-byte stride, slice +$27-+$27.
; $CED6FF: Fields in this slice: +$27-+$27 Money (partial field).
; $CED6FF: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $08

; Range: $CED745-$CED749 (5 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED745
org $8ED745
EnemyStats_Record113_Experience_CED745:
; $CED745: Physical native character record 113 at $CED722; 74-byte stride, slice +$23-+$27.
; $CED745: Fields in this slice: +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED745: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $64, $00, $00, $00, $02

; Range: $CED74B-$CED74B (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED74B
org $8ED74B
BlueMosquito_NormalDropClass:
; $CED74B: Physical native character record 113 at $CED722; 74-byte stride, slice +$29-+$29.
; $CED74B: Fields in this slice: +$29-+$29 PrizeChance.
; $CED74B: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $08

; Range: $CED785-$CED793 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED785
org $8ED785
EnemyStats_Record114_Attack_CED785:
; $CED785: Physical native character record 114 at $CED76C; 74-byte stride, slice +$19-+$27.
; $CED785: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CED785: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $C3, $00, $00, $00, $00, $00, $1E, $00, $4B, $00, $64, $00, $00, $00, $C8

; Range: $CED795-$CED795 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED795
org $8ED795
GrayMosquito_NormalDropClass:
; $CED795: Physical native character record 114 at $CED76C; 74-byte stride, slice +$29-+$29.
; $CED795: Fields in this slice: +$29-+$29 PrizeChance.
; $CED795: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $08

; Range: $CED7C5-$CED7C6 (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED7C5
org $8ED7C5
EnemyStats_Record115_HP_CED7C5:
; $CED7C5: Physical native character record 115 at $CED7B6; 74-byte stride, slice +$0F-+$10.
; $CED7C5: Fields in this slice: +$0F-+$10 HP.
; $CED7C5: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $40, $1F

; Range: $CED7D9-$CED7DA (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED7D9
org $8ED7D9
EnemyStats_Record115_Experience_CED7D9:
; $CED7D9: Physical native character record 115 at $CED7B6; 74-byte stride, slice +$23-+$24.
; $CED7D9: Fields in this slice: +$23-+$24 Experience (partial field).
; $CED7D9: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $98, $3A

; Range: $CED80F-$CED821 (19 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED80F
org $8ED80F
EnemyStats_Record116_HP_CED80F:
; $CED80F: Physical native character record 116 at $CED800; 74-byte stride, slice +$0F-+$21.
; $CED80F: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$21 HitRate (partial field).
; $CED80F: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED80F: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $58, $02, $04, $00, $32, $00, $40, $00, $78, $00, $96, $00, $68, $01, $10, $00
    db $0A, $00, $28

; Range: $CED859-$CED86B (19 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED859
org $8ED859
EnemyStats_Record117_HP_CED859:
; $CED859: Physical native character record 117 at $CED84A; 74-byte stride, slice +$0F-+$21.
; $CED859: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$21 HitRate (partial field).
; $CED859: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED859: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $58, $02, $04, $00, $32, $00, $40, $00, $78, $00, $5A, $00, $50, $00, $39, $00
    db $0A, $00, $4B

; Range: $CED8A5-$CED8A5 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED8A5
org $8ED8A5
Undocumented_EnemyStats_Record118_UndocumentedField11_CED8A5:
; $CED8A5: Physical native character record 118 at $CED894; this retained slice covers +$11-+$11.
; $CED8A5: Record placement and 74-byte stride are verified, but these field semantics remain undocumented. Preserve bytes and inherited record neighbors.
; $CED8A5: TODO: Identify the undocumented functionality, complete boundaries and inbound references before changing or relocating this fragment.
    db $32

; Range: $CED8F9-$CED906 (14 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED8F9
org $8ED8F9
EnemyStats_Record119_Defense_CED8F9:
; $CED8F9: Physical native character record 119 at $CED8DE; 74-byte stride, slice +$1B-+$28.
; $CED8F9: Fields in this slice: +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CED8F9: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $78, $00, $00, $00, $00, $00, $00, $00, $E0, $2E, $00, $00, $28, $23

; Range: $CED937-$CED949 (19 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED937
org $8ED937
EnemyStats_Record120_HP_CED937:
; $CED937: Physical native character record 120 at $CED928; 74-byte stride, slice +$0F-+$21.
; $CED937: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$21 HitRate (partial field).
; $CED937: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED937: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $10, $0E, $28, $00, $96, $00, $14, $00, $00, $00, $AF, $00, $F0, $00, $00, $00
    db $00, $00, $3C

; Range: $CED981-$CED993 (19 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8ED981
org $8ED981
EnemyStats_Record121_HP_CED981:
; $CED981: Physical native character record 121 at $CED972; 74-byte stride, slice +$0F-+$21.
; $CED981: Fields in this slice: +$0F-+$10 HP; +$13-+$14 AggressionRange; +$15-+$16 AggressionChance; +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$21 HitRate (partial field).
; $CED981: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
; $CED981: Bytes with undocumented field meaning: +$11, +$12, +$17, +$18. They remain record data and are not spare capacity.
    db $10, $0E, $28, $00, $96, $00, $14, $00, $00, $00, $AF, $00, $F0, $00, $00, $00
    db $00, $00, $3C

; Range: $CEDAB3-$CEDAC1 (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDAB3
org $8EDAB3
EnemyStats_Record125_Attack_CEDAB3:
; $CEDAB3: Physical native character record 125 at $CEDA9A; 74-byte stride, slice +$19-+$27.
; $CEDAB3: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEDAB3: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $59, $00, $A0, $00, $F0, $00, $0F, $00, $3C, $00, $68, $01, $00, $00, $A0

; Range: $CEDAFD-$CEDB0B (15 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDAFD
org $8EDAFD
EnemyStats_Record126_Attack_CEDAFD:
; $CEDAFD: Physical native character record 126 at $CEDAE4; 74-byte stride, slice +$19-+$27.
; $CEDAFD: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$27 Money (partial field).
; $CEDAFD: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $70, $00, $C8, $00, $00, $00, $0F, $00, $3C, $00, $F4, $01, $00, $00, $A0

; Range: $CEDB47-$CEDB56 (16 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDB47
org $8EDB47
EnemyStats_Record127_Attack_CEDB47:
; $CEDB47: Physical native character record 127 at $CEDB2E; 74-byte stride, slice +$19-+$28.
; $CEDB47: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CEDB47: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $8D, $00, $2C, $01, $20, $00, $0F, $00, $41, $00, $E8, $03, $00, $00, $B0, $04

; Range: $CEDB91-$CEDBA0 (16 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDB91
org $8EDB91
EnemyStats_Record128_Attack_CEDB91:
; $CEDB91: Physical native character record 128 at $CEDB78; 74-byte stride, slice +$19-+$28.
; $CEDB91: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CEDB91: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $91, $00, $50, $00, $40, $00, $0F, $00, $41, $00, $C8, $00, $00, $00, $90, $01

; Range: $CEDC7D-$CEDC7D (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDC7D
org $8EDC7D
EnemyStats_Record131_Money_CEDC7D:
; $CEDC7D: Physical native character record 131 at $CEDC56; 74-byte stride, slice +$27-+$27.
; $CEDC7D: Fields in this slice: +$27-+$27 Money (partial field).
; $CEDC7D: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $14

; Range: $CEDCC7-$CEDCC8 (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDCC7
org $8EDCC7
EnemyStats_Record132_Money_CEDCC7:
; $CEDCC7: Physical native character record 132 at $CEDCA0; 74-byte stride, slice +$27-+$28.
; $CEDCC7: Fields in this slice: +$27-+$28 Money.
; $CEDCC7: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $30, $02

; Range: $CEDD03-$CEDD0E (12 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDD03
org $8EDD03
EnemyStats_Record133_Attack_CEDD03:
; $CEDD03: Physical native character record 133 at $CEDCEA; 74-byte stride, slice +$19-+$24.
; $CEDD03: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$24 Experience (partial field).
; $CEDD03: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $7D, $00, $18, $01, $0C, $00, $0A, $00, $37, $00, $E8, $03

; Range: $CEDD4D-$CEDD58 (12 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDD4D
org $8EDD4D
EnemyStats_Record134_Attack_CEDD4D:
; $CEDD4D: Physical native character record 134 at $CEDD34; 74-byte stride, slice +$19-+$24.
; $CEDD4D: Fields in this slice: +$19-+$1A Attack; +$1B-+$1C Defense; +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$24 Experience (partial field).
; $CEDD4D: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $69, $00, $F0, $00, $10, $00, $0A, $00, $4B, $00, $58, $02

; Range: $CEDDE5-$CEDDF0 (12 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDDE5
org $8EDDE5
EnemyStats_Record136_MagicDefense_CEDDE5:
; $CEDDE5: Physical native character record 136 at $CEDDC8; 74-byte stride, slice +$1D-+$28.
; $CEDDE5: Fields in this slice: +$1D-+$1E MagicDefense; +$1F-+$20 Evade; +$21-+$22 HitRate; +$23-+$26 Experience; +$27-+$28 Money.
; $CEDDE5: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $30, $00, $19, $00, $5A, $00, $96, $09, $00, $00, $80, $25

; Range: $CEDE39-$CEDE3A (2 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDE39
org $8EDE39
EnemyStats_Record137_Money_CEDE39:
; $CEDE39: Physical native character record 137 at $CEDE12; 74-byte stride, slice +$27-+$28.
; $CEDE39: Fields in this slice: +$27-+$28 Money.
; $CEDE39: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $F4, $01

; Range: $CEDE75-$CEDE75 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDE75
org $8EDE75
EnemyStats_Record138_Attack_CEDE75:
; $CEDE75: Physical native character record 138 at $CEDE5C; 74-byte stride, slice +$19-+$19.
; $CEDE75: Fields in this slice: +$19-+$19 Attack (partial field).
; $CEDE75: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $B9

; Range: $CEDEBF-$CEDEBF (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDEBF
org $8EDEBF
EnemyStats_Record139_Attack_CEDEBF:
; $CEDEBF: Physical native character record 139 at $CEDEA6; 74-byte stride, slice +$19-+$19.
; $CEDEBF: Fields in this slice: +$19-+$19 Attack (partial field).
; $CEDEBF: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $B9

; Range: $CEDF09-$CEDF09 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDF09
org $8EDF09
EnemyStats_Record140_Attack_CEDF09:
; $CEDF09: Physical native character record 140 at $CEDEF0; 74-byte stride, slice +$19-+$19.
; $CEDF09: Fields in this slice: +$19-+$19 Attack (partial field).
; $CEDF09: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $B4

; Range: $CEDF53-$CEDF53 (1 bytes)
; Function/storage: NATIVE_CHARACTER_RECORDS

; German PAL Enemy Record at $8EDF53
org $8EDF53
EnemyStats_Record141_Attack_CEDF53:
; $CEDF53: Physical native character record 141 at $CEDF3A; 74-byte stride, slice +$19-+$19.
; $CEDF53: Fields in this slice: +$19-+$19 Attack (partial field).
; $CEDF53: Numeric fields are little-endian. Keep partial fields joined to their inherited neighbors and preserve all record offsets.
    db $E6

; ============================================================================
; ROM BANK $CF
; ============================================================================

; Range: $CF8407-$CF8409 (3 bytes)

; ============================================================================
; 4. MODUL: STEUERUNG - AUTO-RUN / DEFAULT DASH & B ZUM GEHEN
; ============================================================================
; Deutscher PAL ROM Offset $1082B2 ($90:82B2): Invertiert B-Check
; Standardmäßig Dauerlauf; Halten von B schaltet auf Gehen & schnelles Aufladen um
org $9082B2
    db $F0, $07

; ============================================================================
; 5. MODUL: GETEILTE WAFFEN-ERFAHRUNG (Shared Weapon Experience)
; ============================================================================
; Hook am Beginn der deutschen Waffen-XP-Routine bei $8F:9714 (File-Offset $0F9714)
org $8F9714
    db $5C, $10, $00, $F0  ; JML $F00010 (SharedWeaponExperience)

; ============================================================================
; 6. ERWEITERTE HILFSROUTINEN IN BANK $F0 ($F00000-$F00FFF)
; ============================================================================
org $F00010
SharedWeaponExperience_German:
; Shared Weapon Experience angepasst an die deutsche PAL-Routine ($8F:973B)
; Selbe Waffenfamilie (Schwerter, Äxte, Speere) wird simultan gelevelt
    db $AD, $20, $BF, $48, $AE, $BA, $0A, $8E, $20, $BF, $E0, $1A, $00, $F0, $09, $BD
    db $DD, $0A, $29, $00, $FF, $C9, $00, $03, $F0, $0F, $BD, $DD, $0A, $29, $0C, $00
    db $C9, $00, $00, $F0, $06, $22, $3B, $97, $8F, $80, $34, $AD, $20, $BF, $3A, $29
    db $18, $00, $C9, $00, $00, $D0, $2A, $A9, $02, $00, $8D, $BA, $0A, $22, $3B, $97
    db $8F, $A9, $04, $00, $8D, $BA, $0A, $22, $3B, $97, $8F, $A9, $06, $00, $8D, $BA
    db $0A, $22, $3B, $97, $8F, $A9, $08, $00, $8D, $BA, $0A, $22, $3B, $97, $8F, $80
    db $5E, $AD, $20, $BF, $3A, $29, $10, $00, $C9, $00, $00, $D0, $2A, $A9, $0A, $00
    db $8D, $BA, $0A, $22, $3B, $97, $8F, $A9, $0C, $00, $8D, $BA, $0A, $22, $3B, $97
    db $8F, $A9, $0E, $00, $8D, $BA, $0A, $22, $3B, $97, $8F, $A9, $10, $00, $8D, $BA
    db $0A, $22, $3B, $97, $8F, $80, $28, $A9, $12, $00, $8D, $BA, $0A, $22, $3B, $97
    db $8F, $A9, $14, $00, $8D, $BA, $0A, $22, $3B, $97, $8F, $A9, $16, $00, $8D, $BA
    db $0A, $22, $3B, $97, $8F, $A9, $18, $00, $8D, $BA, $0A, $22, $3B, $97, $8F, $AD
    db $20, $BF, $8D, $BA, $0A, $68, $8D, $20, $BF, $6B

; ============================================================================
; 7. KARTEN- & DUNGEON-FIXES (Pyramid & Dog Maze in Bank $F0 & $FF)
; ============================================================================
org $F01000
PyramidSymbols_MapData:
    db $06, $0D, $78, $49, $17, $01, $42, $02, $00, $00, $00, $00, $00, $1A, $01, $4A
    db $1F, $4B, $21, $98, $0D, $4D, $1F, $4E, $21, $9B, $0D, $4A, $1A, $4B, $1C, $9E
    db $0D, $4D, $1B, $4E, $1D, $A1, $0D, $33, $0B, $35, $0D, $A4, $0D, $21, $0D, $23
    db $0F, $A7, $0D, $1B, $0F, $1D, $11, $AA, $0D, $3C, $0D, $3E, $0F, $AD, $0D, $32
    db $75, $34, $77, $B0, $0D, $3B, $75, $3D, $77, $B3, $0D, $44, $77, $46, $79, $B6
    db $0D, $49, $69, $4A, $6B, $B9, $0D, $4E, $63, $4F, $66, $BC, $0D, $4A, $68, $4E
    db $6B, $BF, $0D, $4A, $61, $4E, $66, $C2, $0D, $4A, $30, $4E, $35, $C5, $0D, $2A
    db $24, $2B, $26, $C8, $0D, $41, $6F, $42, $71, $CB, $0D, $48, $4A, $4A, $4C, $CE
    db $0D, $4E, $4A, $50, $4C, $D1, $0D, $55, $4A, $56, $4C, $D4, $0D, $31, $53, $33
    db $55, $D7, $0D, $3C, $53, $3E, $55, $DA, $0D, $31, $46, $33, $48, $DD, $0D, $3C
    db $46, $3E, $48, $E0, $0D, $3B, $45, $3C, $49, $E3, $0D, $3E, $45, $3F, $49, $E3
    db $0D, $3C, $45, $3E, $46, $E3, $0D, $3C, $48, $3E, $49, $E3, $0D, $30, $45, $31
    db $49, $E6, $0D, $33, $45, $34, $49, $E6, $0D, $31, $45, $33, $46, $E6, $0D, $31
    db $48, $33, $49, $E6, $0D, $30, $52, $31, $56, $E9, $0D, $33, $52, $34, $56, $E9
    db $0D, $31, $52, $33, $53, $E9, $0D, $31, $55, $33, $56, $E9, $0D, $3B, $52, $3C
    db $56, $EC, $0D, $3E, $52, $3F, $56, $EC, $0D, $3C, $52, $3E, $53, $EC, $0D, $3C
    db $55, $3E, $56, $EC, $0D, $29, $32, $2A, $37, $EF, $0D, $4A, $6D, $4E, $6F, $F2
    db $0D, $4D, $54, $4E, $56, $F5, $0D, $4A, $53, $4B, $55, $F8, $0D, $4D, $5A, $4E
    db $5C, $FB, $0D, $4A, $5B, $4B, $5D, $FE, $0D, $90, $00, $47, $20, $49, $22, $01
    db $0E, $3B, $1C, $3D, $1E, $04, $0E, $19, $6C, $1B, $6E, $07, $0E, $3D, $62, $3F
    db $64, $0A, $0E, $50, $50, $52, $52, $0D, $0E, $12, $57, $14, $59, $10, $0E, $12
    db $59, $14, $5B, $13, $0E, $12, $55, $14, $57, $16, $0E, $12, $5B, $14, $5D, $19
    db $0E, $12, $53, $14, $55, $1C, $0E, $34, $3D, $36, $3F, $1F, $0E, $34, $33, $36
    db $35, $22, $0E, $3B, $20, $3D, $22, $25, $0E, $3B, $18, $3D, $1A, $28, $0E, $21
    db $13, $23, $15, $2B, $0E, $2F, $08, $31, $0A, $2E, $0E, $2C, $08, $2E, $0A, $31
    db $0E, $12, $08, $14, $0A, $34, $0E, $31, $5B, $36, $5D, $37, $0E, $1F, $46, $22
    db $48, $3A, $0E, $19, $57, $1C, $59, $3D, $0E, $23, $6C, $26, $6E, $40, $0E, $43
    db $52, $45, $54, $43, $0E, $47, $17, $49, $19, $46, $0E, $07, $0C, $01, $0D, $01
    db $0E, $01, $73, $00, $0F, $01, $10, $01, $11, $01, $02, $1D, $03, $05, $3D, $03
    db $04, $FB, $00, $03, $6C, $01, $A6, $C5, $7C, $1E, $C8, $0C, $03, $9B, $03, $00
    db $28, $00, $24, $2A, $30, $F0, $02, $87, $88, $00, $83, $CC, $00, $41, $D4, $00
    db $1C, $20, $13, $0D, $6F, $BA, $A9, $11, $00, $E9, $5A, $BE, $40, $27, $0C, $B4
    db $36, $D6, $02, $A1, $CA, $C3, $40, $62, $16, $E0, $18, $08, $0E, $53, $1E, $03
    db $41, $01, $F8, $5C, $40, $70, $F3, $3F, $F0, $13, $C2, $10, $01, $E1, $FC, $7F
    db $F9, $90, $10, $27, $84, $D8, $0A, $43, $53, $87, $EC, $BE, $00, $53, $08, $6C
    db $03, $72, $05, $C1, $C3, $81, $08, $F4, $1E, $D9, $50, $16, $02, $04, $06, $B2
    db $C2, $81, $C0, $F4, $BE, $D9, $94, $03, $53, $04, $03, $E8, $60, $00, $E0, $79
    db $AF, $DF, $AB, $EC, $08, $B0, $BE, $43, $60, $BF, $F0, $2E, $85, $33, $E7, $AF
    db $86, $E2, $80, $70, $37, $60, $4D, $1C, $6F, $F4, $05, $70, $FC, $FC, $C0, $AE
    db $1E, $B0, $12, $18, $2A, $C2, $3B, $FA, $FC, $02, $CA, $62, $BF, $AE, $F4, $1A
    db $47, $ED, $06, $08, $7A, $81, $6C, $BF, $00, $5D, $0C, $90, $1A, $03, $DC, $89
    db $50, $BE, $FB, $F8, $45, $23, $EF, $B9, $84, $03, $55, $3A, $FF, $F0, $3B, $80
    db $12, $58, $1D, $E5, $D2, $FF, $CB, $C1, $ED, $7C, $AF, $FC, $DC, $22, $03, $B4
    db $03, $30, $C5, $61, $E1, $15, $20, $90, $F8, $4C, $BC, $09, $2D, $56, $FE, $04
    db $35, $35, $10, $3A, $D8, $53, $87, $4A, $01, $63, $0A, $FD, $00, $00, $1B, $8A
    db $01, $00, $06, $6D, $00, $00, $06, $7F, $00, $00, $06, $91, $00, $00, $06, $A3
    db $00, $00, $06, $B5, $00, $00, $06, $C7, $00, $00, $03, $D9, $00, $00, $03, $E2
    db $00, $00, $03, $EB, $00, $00, $03, $F4, $00, $00, $03, $FD, $00, $00, $03, $06
    db $01, $00, $03, $0F, $01, $00, $03, $18, $01, $00, $03, $21, $01, $00, $03, $2A
    db $01, $00, $03, $33, $01, $00, $03, $3C, $01, $00, $03, $45, $01, $00, $03, $4E
    db $01, $00, $03, $57, $01, $00, $03, $60, $01, $00, $03, $69, $01, $00, $02, $72
    db $01, $00, $02, $78, $01, $00, $02, $7E, $01, $00, $02, $84, $01, $FF, $07, $B6
    db $0A, $07, $B7, $0A, $07, $B8, $0A, $05, $B9, $0A, $07, $BA, $0A, $07, $B8, $0A
    db $07, $BB, $0A, $07, $BC, $0A, $07, $BD, $0A, $05, $BE, $0A, $07, $BF, $0A, $07
    db $BD, $0A, $07, $B8, $0A, $07, $B9, $0A, $05, $BA, $0A, $07, $B6, $0A, $07, $B7
    db $0A, $05, $BA, $0A, $07, $BD, $0A, $07, $BE, $0A, $05, $BF, $0A, $07, $BB, $0A
    db $07, $BC, $0A, $05, $BF, $0A, $07, $0A, $0C, $07, $0B, $0C, $07, $0C, $0C, $05
    db $0D, $0C, $07, $0E, $0C, $07, $0C, $0C, $07, $0F, $0C, $07, $10, $0C, $07, $11
    db $0C, $05, $12, $0C, $07, $13, $0C, $07, $11, $0C, $0B, $9A, $15, $0B, $A3, $15
    db $0B, $A4, $15, $0B, $9B, $15, $0B, $A5, $15, $0B, $A6, $15, $0B, $9C, $15, $0B
    db $A7, $15, $0B, $A8, $15, $0B, $9D, $15, $0B, $A9, $15, $0B, $AA, $15, $0B, $9E
    db $15, $0B, $AB, $15, $0B, $AC, $15, $0B, $9F, $15, $0B, $AD, $15, $0B, $AE, $15
    db $0B, $A0, $15, $0B, $AF, $15, $0B, $B0, $15, $0B, $A1, $15, $0B, $B1, $15, $0B
    db $B2, $15, $0B, $A2, $15, $0B, $B3, $15, $0B, $B4, $15, $0B, $B5, $15, $0B, $B6
    db $15, $0B, $B7, $15, $0B, $B8, $15, $0B, $B9, $15, $0B, $BA, $15, $0B, $BB, $15
    db $0B, $BC, $15, $0B, $BD, $15, $0B, $BE, $15, $0B, $BF, $15, $0B, $C0, $15, $0B
    db $C1, $15, $0B, $C2, $15, $0B, $C3, $15, $0B, $C4, $15, $0B, $C5, $15, $0B, $C6
    db $15, $0B, $C7, $15, $0B, $C8, $15, $0B, $C9, $15, $0B, $CA, $15, $0B, $CB, $15
    db $0B, $CC, $15, $07, $13, $12, $07, $14, $12, $07, $15, $12, $07, $16, $12, $07
    db $17, $12, $07, $18, $12, $07, $19, $12, $07, $1A, $12, $2F, $00, $00, $10, $00
    db $20, $00, $30, $00, $40, $00, $46, $00, $4C, $00, $52, $00, $58, $00, $5E, $00
    db $64, $00, $6A, $00, $70, $00, $85, $00, $9A, $00, $AF, $00, $C4, $00, $D9, $00
    db $DF, $00, $E5, $00, $EB, $00, $F1, $00, $F7, $00, $FD, $00, $03, $01, $09, $01
    db $0F, $01, $15, $01, $1B, $01, $21, $01, $27, $01, $2D, $01, $33, $01, $39, $01
    db $3F, $01, $45, $01, $4B, $01, $6A, $01, $89, $01, $B2, $01, $DB, $01, $04, $02
    db $1E, $02, $4C, $02, $52, $02, $58, $02, $5E, $02, $73, $44, $00, $70, $44, $70
    db $44, $78, $44, $80, $44, $88, $44, $80, $44, $90, $44, $98, $44, $A0, $44, $A8
    db $44, $80, $44, $B0, $44, $80, $44, $B8, $44, $98, $44, $A0, $44, $A8, $44, $C0
    db $44, $88, $44, $C0, $44, $B8, $44, $98, $44, $A0, $44, $A8, $44, $C0, $44, $B0
    db $44, $C0, $44, $B8, $44, $98, $44, $A0, $44, $A8, $44, $C0, $44, $88, $44, $C0
    db $44, $B8, $44, $98, $44, $A0, $44, $78, $44, $C0, $44, $88, $44, $C0, $44, $90
    db $44, $98, $44, $A0, $44, $A8, $44, $C0, $44, $B0, $44, $C0, $44, $B8, $44, $98
    db $44, $A0, $44, $A8, $44, $C0, $44, $88, $44, $C0, $44, $B8, $44, $98, $44, $A0
    db $44, $A8, $44, $C0, $44, $B0, $44, $C0, $44, $B8, $44, $98, $44, $A0, $44, $A8
    db $44, $C0, $44, $88, $44, $C0, $44, $B8, $44, $98, $44, $A0, $44, $A8, $44, $C0
    db $44, $B0, $44, $C0, $44, $B8, $44, $98, $44, $A0, $44, $A8, $44, $C0, $44, $88
    db $44, $C0, $44, $B8, $44, $98, $44, $A0, $44, $A8, $44, $C0, $44, $B0, $44, $C0
    db $44, $B8, $44, $98, $44, $A0, $44, $A8, $44, $C0, $44, $B0, $44, $C0, $44, $B8
    db $44, $98, $44, $A0, $44, $A8, $44, $C0, $44, $88, $44, $C0, $44, $B8, $44, $98
    db $44, $A0, $44, $A8, $44, $C0, $44, $B0, $44, $C0, $44, $B8, $44, $98, $44, $A0
    db $44, $A8, $44, $C0, $44, $88, $44, $C0, $44, $B8, $44, $98, $44, $A0, $44, $C8
    db $44, $D0, $44, $80, $44, $D8, $44, $80, $44, $E0, $44, $E8, $44, $F0, $44, $F8
    db $44, $80, $44, $D8, $44, $80, $44, $00, $45, $E8, $44, $F0, $44, $F8, $44, $80
    db $44, $D8, $44, $80, $44, $00, $45, $E8, $44, $F0, $44, $F8, $44, $C0, $44, $D8
    db $44, $C0, $44, $00, $45, $E8, $44, $F0, $44, $F8, $44, $80, $44, $08, $45, $10
    db $45, $00, $45, $E8, $44, $F0, $44, $D0, $44, $C0, $44, $D8, $44, $C0, $44, $E0
    db $44, $E8, $44, $F0, $44, $F8, $44, $C0, $44, $D8, $44, $C0, $44, $00, $45, $E8
    db $44, $F0, $44, $F8, $44, $C0, $44, $D8, $44, $C0, $44, $00, $45, $E8, $44, $F0
    db $44, $F8, $44, $C0, $44, $D8, $44, $C0, $44, $00, $45, $E8, $44, $F0, $44, $F8
    db $44, $C0, $44, $D8, $44, $C0, $44, $00, $45, $E8, $44, $F0, $44, $F8, $44, $C0
    db $44, $D8, $44, $C0, $44, $00, $45, $E8, $44, $F0, $44, $F8, $44, $C0, $44, $D8
    db $44, $C0, $44, $00, $45, $E8, $44, $F0, $44, $F8, $44, $C0, $44, $D8, $44, $C0
    db $44, $00, $45, $E8, $44, $F0, $44, $F8, $44, $C0, $44, $D8, $44, $C0, $44, $00
    db $45, $E8, $44, $F0, $44, $F8, $44, $C0, $44, $D8, $44, $C0, $44, $00, $45, $E8
    db $44, $F0, $44, $F8, $44, $C0, $44, $D8, $44, $C0, $44, $00, $45, $E8, $44, $F0
    db $44, $F8, $44, $18, $45, $20, $45, $18, $45, $00, $45, $E8, $44, $F0, $44, $28
    db $45, $30, $45, $38, $45, $38, $45, $38, $45, $28, $45, $30, $45, $28, $45, $30
    db $45, $38, $45, $38, $45, $38, $45, $28, $45, $30, $45, $28, $45, $30, $45, $38
    db $45, $38, $45, $38, $45, $28, $45, $30, $45, $28, $45, $30, $45, $38, $45, $38
    db $45, $38, $45, $28, $45, $30, $45, $28, $45, $30, $45, $38, $45, $40, $45, $48
    db $45, $50, $45, $58, $45, $28, $45, $30, $45, $38, $45, $38, $45, $38, $45, $28
    db $45, $30, $45, $28, $45, $30, $45, $38, $45, $38, $45, $38, $45, $28, $45, $30
    db $45, $28, $45, $30, $45, $38, $45, $38, $45, $38, $45, $28, $45, $30, $45, $28
    db $45, $30, $45, $60, $45, $68, $45, $38, $45, $28, $45, $30, $45, $28, $45, $30
    db $45, $38, $45, $38, $45, $38, $45, $28, $45, $30, $45, $28, $45, $30, $45, $38
    db $45, $38, $45, $38, $45, $28, $45, $30, $45, $28, $45, $30, $45, $38, $45, $38
    db $45, $38, $45, $28, $45, $30, $45, $28, $45, $30, $45, $38, $45, $38, $45, $38
    db $45, $28, $45, $30, $45, $28, $45, $30, $45, $38, $45, $38, $45, $38, $45, $28
    db $45, $30, $45, $28, $45, $30, $45, $38, $45, $38, $45, $38, $45, $28, $45, $30
    db $45, $28, $45, $30, $45, $38, $45, $38, $45, $38, $45, $28, $45, $30, $45, $28
    db $45, $30, $45, $70, $45, $78, $45, $78, $45, $28, $45, $30, $45, $50, $45, $80
    db $45, $88, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90
    db $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0
    db $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98
    db $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A8, $45, $B0
    db $45, $B8, $45, $80, $45, $88, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98
    db $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90
    db $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0
    db $45, $C0, $45, $B8, $45, $80, $45, $88, $45, $90, $45, $98, $45, $A0, $45, $90
    db $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0
    db $45, $C0, $45, $B8, $45, $80, $45, $88, $45, $98, $45, $A0, $45, $90, $45, $98
    db $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $C0, $45, $B8
    db $45, $80, $45, $88, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0
    db $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98
    db $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90
    db $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $C0, $45, $C8, $45, $D0
    db $45, $D8, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0
    db $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0
    db $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8
    db $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $F8, $45, $00, $46, $08
    db $46, $10, $46, $D0, $45, $D8, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8
    db $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0
    db $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0
    db $45, $18, $46, $10, $46, $D0, $45, $D8, $45, $E0, $45, $E8, $45, $F0, $45, $E0
    db $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0
    db $45, $18, $46, $10, $46, $D0, $45, $D8, $45, $E8, $45, $F0, $45, $E0, $45, $E8
    db $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $18, $46, $10
    db $46, $D0, $45, $D8, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0
    db $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8
    db $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0
    db $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $18, $46, $20, $46, $28
    db $46, $30, $46, $38, $46, $40, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48
    db $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58
    db $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $60, $46, $68, $46, $70
    db $46, $78, $46, $28, $46, $80, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58
    db $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48
    db $46, $88, $46, $78, $46, $28, $46, $80, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48
    db $46, $88, $46, $78, $46, $28, $46, $80, $46, $90, $46, $98, $46, $38, $46, $40
    db $46, $A0, $46, $A8, $46, $90, $46, $98, $46, $38, $46, $40, $46, $88, $46, $78
    db $46, $28, $46, $80, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48
    db $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58
    db $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $B0, $46, $B8, $46, $C0
    db $46, $C8, $46, $D0, $46, $D8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E8, $46, $E0, $46, $F0, $46, $F8, $46, $00
    db $47, $08, $47, $C0, $46, $10, $47, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E0, $46, $E8
    db $46, $18, $47, $08, $47, $C0, $46, $20, $47, $E0, $46, $E8, $46, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8
    db $46, $18, $47, $08, $47, $C0, $46, $20, $47, $28, $47, $30, $47, $28, $47, $30
    db $47, $28, $47, $30, $47, $28, $47, $30, $47, $28, $47, $30, $47, $18, $47, $08
    db $47, $C0, $46, $20, $47, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $38, $47, $40, $47, $48
    db $47, $50, $47, $E8, $46, $58, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $E0, $46, $E8, $46, $70
    db $47, $78, $47, $48, $47, $80, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $88, $47, $78, $47, $48, $47, $90, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $88, $47, $78, $47, $48, $47, $90, $47, $E0, $46, $E8, $46, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $88, $47, $78
    db $47, $48, $47, $50, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $98
    db $47, $A0, $47, $A8, $47, $B0, $47, $A8, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $B0, $47, $A8, $47, $B0, $47, $A8, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $B8, $47, $C0, $47, $C8
    db $47, $D0, $47, $98, $47, $E8, $46, $98, $47, $D8, $47, $98, $47, $D8, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $E0
    db $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $F0, $47, $F8, $47, $00, $48, $08, $48, $98, $47, $60, $47, $98, $47, $D8
    db $47, $10, $48, $E8, $47, $C8, $47, $18, $48, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $10, $48, $E8, $47, $C8, $47, $18, $48, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $20, $48, $28, $48, $20, $48, $10, $48, $E8
    db $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $98, $47, $30, $48, $A0
    db $47, $38, $48, $40, $48, $48, $48, $50, $48, $58, $48, $50, $48, $60, $48, $50
    db $48, $60, $48, $68, $48, $70, $48, $78, $48, $A0, $47, $30, $48, $D8, $47, $D8
    db $47, $98, $47, $98, $47, $D8, $47, $60, $47, $68, $47, $80, $48, $88, $48, $90
    db $48, $98, $48, $A0, $48, $A8, $48, $A0, $48, $A8, $48, $A0, $48, $A8, $48, $B0
    db $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B8, $48, $A8, $48, $B8
    db $48, $A8, $48, $A0, $48, $A8, $48, $B8, $48, $A8, $48, $A0, $48, $A8, $48, $B8
    db $48, $A8, $48, $B8, $48, $C0, $48, $A8, $47, $B0, $47, $60, $47, $68, $47, $18
    db $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $C8, $48, $60, $47, $68, $47, $18, $47, $08
    db $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $60, $47, $F0, $47, $D0
    db $48, $D8, $48, $E0, $48, $E8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0
    db $48, $F8, $48, $00, $49, $08, $49, $10, $49, $18, $49, $20, $49, $68, $47, $68
    db $47, $60, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $38, $47, $40, $47, $28
    db $49, $30, $49, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $38, $49, $00, $48, $40, $49, $98, $47, $D8, $47, $B8
    db $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $D8
    db $47, $98, $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $D8, $47, $98, $47, $98, $47, $D8
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8, $47, $30, $48, $A0
    db $47, $48, $49, $58, $48, $B8, $48, $A8, $48, $A0, $48, $A8, $48, $A0, $48, $A8
    db $48, $50, $49, $58, $49, $60, $49, $68, $49, $50, $48, $60, $48, $50, $48, $70
    db $49, $30, $48, $A0, $47, $48, $49, $78, $49, $80, $49, $58, $48, $88, $49, $58
    db $49, $90, $49, $50, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $18, $47, $08
    db $47, $80, $45, $98, $49, $A0, $49, $98, $45, $A8, $49, $90, $45, $98, $45, $B0
    db $49, $98, $45, $A8, $45, $B0, $45, $B8, $45, $C0, $46, $20, $47, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $98, $47, $60, $47, $68, $47, $B8, $47, $C0, $47, $80
    db $45, $88, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $C8, $49, $A0, $45, $90
    db $45, $98, $45, $A0, $45, $D0, $49, $A0, $45, $90, $45, $98, $45, $A0, $45, $B0
    db $49, $98, $45, $A0, $45, $90, $45, $98, $45, $A8, $49, $90, $45, $98, $45, $A0
    db $45, $90, $45, $C0, $45, $B8, $45, $C0, $46, $20, $47, $60, $47, $68, $47, $80
    db $48, $E8, $47, $C8, $47, $D8, $49, $60, $47, $68, $47, $60, $47, $68, $47, $68
    db $47, $60, $47, $68, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $68, $47, $60, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $F0, $47, $D0
    db $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0
    db $48, $E0, $49, $30, $49, $E0, $49, $30, $49, $F8, $48, $F0, $48, $F8, $48, $E8
    db $49, $F0, $49, $F8, $49, $00, $4A, $08, $4A, $F8, $48, $F0, $48, $E0, $49, $10
    db $4A, $18, $4A, $D0, $47, $60, $47, $68, $47, $60, $47, $68, $47, $B8, $47, $78
    db $47, $D0, $45, $20, $4A, $28, $4A, $30, $4A, $38, $4A, $E0, $45, $E8, $45, $40
    db $4A, $F8, $45, $00, $46, $08, $46, $10, $46, $48, $47, $50, $47, $48, $4A, $50
    db $4A, $50, $4A, $48, $4A, $60, $47, $68, $47, $D8, $47, $E0, $47, $88, $48, $D0
    db $45, $D8, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $58, $4A, $F0, $45, $E0
    db $45, $E8, $45, $F0, $45, $60, $4A, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $40
    db $4A, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $38, $4A, $E0, $45, $E8, $45, $F0
    db $45, $E0, $45, $18, $46, $10, $46, $48, $47, $50, $47, $98, $47, $D8, $47, $38
    db $47, $08, $47, $C0, $46, $C8, $46, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $D8, $47, $98, $47, $D8
    db $47, $68, $4A, $08, $47, $C0, $46, $10, $47, $D8, $47, $98, $47, $98, $47, $D8
    db $47, $68, $4A, $08, $47, $C0, $46, $10, $47, $98, $47, $D8, $47, $70, $4A, $78
    db $4A, $98, $45, $80, $4A, $98, $45, $A0, $45, $90, $45, $98, $45, $A8, $49, $90
    db $45, $98, $45, $A0, $45, $90, $45, $C8, $49, $A0, $45, $88, $4A, $90, $4A, $30
    db $49, $98, $4A, $A0, $4A, $A8, $4A, $88, $4A, $90, $4A, $A8, $49, $C0, $45, $B8
    db $45, $C0, $46, $20, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $E0, $47, $E8
    db $47, $28, $46, $B0, $4A, $B8, $4A, $C0, $4A, $48, $46, $38, $46, $40, $46, $50
    db $46, $60, $46, $68, $46, $70, $46, $78, $46, $C8, $47, $D0, $47, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $60, $47, $68, $47, $68, $47, $18, $47, $40, $47, $28
    db $46, $30, $46, $50, $46, $58, $46, $C8, $4A, $D0, $4A, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48
    db $46, $50, $46, $88, $46, $78, $46, $C8, $47, $D0, $47, $60, $47, $68, $47, $B8
    db $47, $78, $47, $48, $47, $50, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $68, $47, $60, $47, $68
    db $47, $70, $47, $78, $47, $48, $47, $80, $47, $68, $47, $60, $47, $60, $47, $68
    db $47, $70, $47, $78, $47, $48, $47, $80, $47, $60, $47, $68, $47, $D8, $4A, $E0
    db $4A, $E8, $45, $E8, $4A, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $38, $4A, $E0
    db $45, $E8, $45, $F0, $45, $E0, $45, $58, $4A, $F0, $45, $F0, $4A, $F8, $4A, $00
    db $4B, $08, $4B, $10, $4B, $00, $4B, $F0, $4A, $F8, $4A, $38, $4A, $18, $46, $10
    db $46, $48, $47, $50, $47, $60, $47, $68, $47, $60, $47, $68, $47, $18, $47, $08
    db $47, $C0, $46, $18, $4B, $20, $4B, $28, $4B, $E0, $46, $30, $4B, $38, $4B, $E8
    db $46, $40, $4B, $F8, $46, $48, $4B, $08, $47, $C0, $46, $20, $47, $48, $4A, $50
    db $4A, $50, $4A, $48, $4A, $98, $47, $98, $47, $D8, $47, $B8, $47, $C0, $47, $C0
    db $46, $C8, $46, $50, $4B, $58, $4B, $60, $4B, $68, $4B, $50, $4B, $E8, $46, $30
    db $48, $70, $4B, $78, $4B, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $18, $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $E0
    db $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $80, $4B, $88
    db $4B, $58, $46, $48, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $90, $4B, $98, $4B, $A0
    db $4B, $A8, $4B, $B0, $4B, $A0, $4B, $90, $4B, $98, $4B, $48, $46, $88, $46, $78
    db $46, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $B8, $47, $78
    db $47, $48, $47, $50, $47, $E0, $46, $E8, $46, $60, $47, $E0, $46, $E8, $46, $68
    db $47, $E0, $46, $E8, $46, $B8, $47, $78, $47, $48, $47, $50, $47, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $60, $47, $60, $47, $68, $47, $80, $48, $88, $48, $48
    db $47, $50, $47, $B8, $4B, $C0, $4B, $C8, $4B, $D0, $4B, $98, $47, $D8, $47, $A8
    db $47, $D8, $4B, $E0, $4B, $38, $48, $A0, $48, $B0, $48, $A0, $48, $B0, $48, $A0
    db $48, $B0, $48, $A0, $48, $B0, $48, $B8, $48, $C0, $48, $A8, $47, $B0, $47, $60
    db $47, $68, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $60, $47, $68, $47, $18
    db $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $E0, $46, $E8
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E8
    db $4B, $E0, $46, $E8, $46, $F0, $4B, $E0, $46, $E0, $46, $E8, $46, $68, $4A, $08
    db $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68, $47, $E0, $47, $E8
    db $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $A0, $47, $30, $48, $D8
    db $47, $98, $47, $D8, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $48, $4A, $50
    db $4A, $50, $4A, $48, $4A, $F8, $4B, $98, $47, $D8, $47, $38, $47, $40, $47, $C8
    db $47, $D8, $49, $00, $4C, $08, $4C, $10, $4C, $18, $4C, $60, $47, $68, $47, $98
    db $47, $20, $4C, $28, $4C, $30, $4C, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $38, $4C, $40, $4C, $08, $48, $98
    db $47, $D8, $47, $E0, $47, $48, $4C, $50, $4C, $D0, $47, $98, $47, $D8, $47, $B8
    db $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $98, $47, $D8
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $B8, $47, $58, $4C, $60, $49, $68, $49, $A0, $48, $B0, $48, $60, $4C, $B0
    db $47, $A8, $47, $68, $4C, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $A0, $48, $C0
    db $48, $30, $48, $A0, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $70, $47, $78
    db $47, $48, $47, $50, $47, $60, $47, $68, $47, $60, $47, $68, $47, $18, $47, $08
    db $47, $C0, $46, $20, $47, $60, $47, $68, $47, $A8, $47, $70, $4C, $78, $4C, $B0
    db $47, $60, $47, $68, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $C0, $49, $60, $47, $68, $47, $B8, $47, $C0, $47, $C0
    db $46, $C8, $46, $80, $4C, $88, $4C, $90, $4C, $98, $4C, $60, $47, $68, $47, $60
    db $47, $18, $47, $40, $47, $A0, $4C, $88, $45, $90, $45, $C8, $49, $A0, $45, $90
    db $45, $98, $45, $A8, $4C, $98, $45, $C0, $45, $B8, $45, $C0, $46, $20, $47, $60
    db $47, $68, $47, $70, $4A, $78, $4A, $B0, $4C, $B8, $4C, $60, $47, $68, $47, $80
    db $48, $E8, $47, $C8, $47, $D8, $49, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $E0, $47, $C0, $4C, $C8, $4C, $30, $49, $F8, $48, $F0, $48, $E8, $49, $F0
    db $49, $F8, $49, $00, $4A, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $10
    db $49, $00, $48, $40, $49, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $E0, $47, $E8
    db $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $B8, $47, $78
    db $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $D0, $4C, $D8, $4C, $D8
    db $47, $98, $47, $D8, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $48, $4A, $50
    db $4A, $50, $4A, $98, $47, $D8, $47, $98, $47, $D8, $47, $80, $48, $88, $48, $60
    db $49, $E0, $4C, $E8, $4C, $F0, $4C, $F8, $4C, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $B8, $47, $78, $47, $D0, $45, $D8, $45, $E0, $45, $58, $4A, $F0, $45, $E0
    db $45, $E8, $45, $00, $4D, $E8, $45, $18, $46, $10, $46, $48, $47, $50, $47, $98
    db $47, $D8, $47, $D8, $4A, $E0, $4A, $08, $4D, $10, $4D, $98, $47, $D8, $47, $38
    db $47, $08, $47, $C0, $46, $C8, $46, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $D8, $47, $98, $47, $98, $47, $D8
    db $47, $70, $4A, $78, $4A, $90, $45, $C8, $49, $18, $4D, $88, $4A, $30, $49, $98
    db $4A, $A0, $4A, $A8, $4A, $18, $4D, $88, $4A, $D0, $49, $A0, $45, $C0, $45, $B8
    db $45, $C0, $46, $10, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $18, $47, $08
    db $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68, $47, $E0, $47, $E8
    db $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $98, $47, $E0, $46, $E8, $46, $68
    db $47, $60, $47, $68, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $B8, $49, $C0
    db $49, $C0, $49, $60, $47, $68, $47, $60, $47, $68, $47, $38, $47, $40, $47, $20
    db $4D, $E0, $49, $F0, $48, $18, $49, $28, $4D, $60, $47, $68, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $28, $46, $80, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $50, $46, $58, $46, $88, $46, $78, $46, $C8, $47, $D0, $47, $60
    db $47, $68, $47, $80, $4B, $88, $4B, $30, $4D, $38, $4D, $60, $47, $68, $47, $B8
    db $47, $78, $47, $48, $47, $50, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $68, $47, $60, $47, $60, $47, $68
    db $47, $D8, $4A, $E0, $4A, $E0, $45, $58, $4A, $40, $4D, $F0, $4A, $48, $4D, $08
    db $4B, $10, $4B, $50, $4D, $40, $4D, $F0, $4A, $60, $4A, $F0, $45, $18, $46, $10
    db $46, $48, $47, $80, $47, $60, $47, $68, $47, $A8, $47, $30, $48, $58, $4D, $B0
    db $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $88, $49, $58
    db $49, $90, $49, $50, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $18, $47, $08
    db $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $98, $47, $D8, $47, $D8, $47, $B8, $47, $C0, $47, $80
    db $45, $88, $45, $98, $45, $B0, $4C, $B8, $4C, $60, $4D, $68, $4D, $70, $4B, $70
    db $4D, $18, $47, $08, $47, $C0, $46, $20, $47, $78, $4D, $80, $4D, $E0, $46, $E8
    db $46, $E0, $46, $E0, $46, $E8, $46, $18, $47, $08, $47, $C0, $46, $20, $47, $98
    db $47, $98, $47, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $98, $47, $D8, $47, $18
    db $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $80, $48, $E8, $47, $C8, $47, $D8, $49, $D8, $47, $98, $47, $98, $47, $D8
    db $47, $80, $4B, $88, $4B, $50, $46, $58, $46, $88, $4D, $90, $4B, $90, $4D, $A8
    db $4B, $B0, $4B, $98, $4D, $88, $4D, $90, $4B, $58, $46, $48, $46, $88, $46, $78
    db $46, $C8, $47, $D0, $47, $98, $47, $D8, $47, $A0, $4D, $F8, $47, $F8, $48, $F0
    db $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $E0, $49, $10
    db $4A, $18, $4A, $D0, $47, $60, $47, $68, $47, $60, $47, $68, $47, $B8, $47, $58
    db $4C, $60, $49, $E0, $4C, $B8, $48, $B0, $48, $60, $4C, $B0, $47, $A8, $47, $68
    db $4C, $B8, $48, $B0, $48, $88, $49, $58, $49, $90, $49, $50, $47, $48, $4A, $50
    db $4A, $50, $4A, $48, $4A, $60, $47, $68, $47, $68, $47, $E0, $47, $88, $48, $D0
    db $45, $D8, $45, $E8, $45, $08, $4D, $10, $4D, $A8, $4D, $B0, $4D, $D8, $4B, $B8
    db $4D, $B8, $47, $78, $47, $48, $47, $50, $47, $28, $47, $C0, $4D, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $60
    db $47, $C8, $4D, $A8, $47, $B0, $47, $A8, $47, $B0, $47, $D0, $4D, $C0, $48, $18
    db $47, $D8, $4D, $E0, $4D, $20, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $38, $47, $08, $47, $C0, $46, $C8, $46, $68, $47, $60, $47, $60, $47, $68
    db $47, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E8, $4D, $E0
    db $46, $E8, $46, $F0, $4D, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $18, $47, $08
    db $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $70, $4A, $78, $4A, $98, $45, $A8
    db $49, $90, $45, $98, $45, $A0, $45, $90, $45, $C8, $49, $A0, $45, $C0, $45, $B8
    db $45, $C0, $46, $20, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $E0, $47, $C0
    db $4C, $C8, $4C, $30, $49, $F8, $48, $F0, $48, $E8, $49, $F0, $49, $F8, $4D, $00
    db $4A, $F8, $48, $F0, $48, $E0, $49, $30, $49, $00, $4E, $D0, $47, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $98, $47, $D8, $47, $68, $47, $18, $47, $40, $47, $28
    db $46, $30, $46, $58, $46, $30, $4D, $08, $4E, $10, $4E, $30, $48, $D8, $47, $98
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $E0, $46, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $98
    db $47, $98, $47, $A0, $4D, $18, $4E, $20, $4E, $28, $4E, $D8, $48, $10, $49, $30
    db $4E, $38, $4E, $40, $4E, $90, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $60, $47, $68, $47, $B8, $47, $78
    db $47, $48, $47, $50, $47, $60, $47, $68, $47, $D8, $4A, $E0, $4A, $E8, $45, $38
    db $4A, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $58, $4A, $F0, $45, $18, $46, $10
    db $46, $48, $47, $50, $47, $60, $47, $68, $47, $60, $47, $68, $47, $70, $4A, $78
    db $4A, $90, $45, $98, $45, $18, $4D, $88, $4A, $30, $49, $98, $4A, $A0, $4A, $A8
    db $4A, $18, $4D, $88, $4A, $98, $45, $A0, $45, $B0, $4C, $B8, $4C, $48, $4A, $50
    db $4A, $50, $4A, $48, $4A, $98, $47, $D8, $47, $D8, $47, $B8, $47, $C0, $47, $C0
    db $46, $C8, $46, $50, $4B, $50, $4B, $48, $4E, $50, $4E, $A8, $47, $68, $47, $60
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $98, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $60, $47, $68, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60
    db $47, $68, $47, $18, $47, $58, $4E, $60, $4E, $68, $4E, $70, $4E, $78, $4E, $80
    db $4E, $88, $4E, $00, $4E, $18, $48, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $D8, $47, $E0, $47, $E8
    db $47, $C8, $47, $D8, $49, $60, $47, $68, $47, $80, $4B, $88, $4B, $58, $46, $48
    db $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $88, $46, $78
    db $46, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $D8, $4A, $E0
    db $4A, $E0, $45, $E8, $45, $40, $4D, $F0, $4A, $48, $4D, $08, $4B, $10, $4B, $50
    db $4D, $40, $4D, $F0, $4A, $E8, $45, $F0, $45, $08, $4D, $10, $4D, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $98, $47, $D8, $47, $D8, $47, $80, $48, $88, $48, $48
    db $47, $50, $47, $90, $4E, $98, $4E, $A0, $4E, $A8, $4E, $30, $48, $D8, $47, $98
    db $47, $B8, $47, $58, $4C, $60, $49, $E0, $4C, $B8, $48, $A0, $48, $B0, $4E, $30
    db $48, $A0, $47, $98, $47, $D8, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $98
    db $47, $D8, $47, $B8, $47, $B8, $4E, $C0, $4E, $C8, $4E, $70, $4E, $78, $4E, $D0
    db $4E, $D8, $4E, $40, $4E, $50, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $D8
    db $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $60, $47, $68, $47, $60, $47, $B0, $47, $A8, $47, $B0, $47, $A8
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $D8, $47, $18, $47, $08
    db $47, $C0, $46, $C8, $46, $98, $47, $D8, $47, $E0, $46, $58, $4B, $58, $4B, $50
    db $4B, $58, $4B, $E0, $46, $E8, $46, $E0, $46, $E0, $46, $E8, $46, $18, $47, $08
    db $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68, $47, $80, $4B, $88
    db $4B, $50, $46, $58, $46, $88, $4D, $90, $4B, $90, $4D, $A8, $4B, $B0, $4B, $98
    db $4D, $88, $4D, $90, $4B, $58, $46, $48, $46, $30, $4D, $38, $4D, $48, $4A, $50
    db $4A, $50, $4A, $48, $4A, $60, $47, $68, $47, $68, $47, $38, $47, $40, $47, $C8
    db $47, $D8, $49, $E0, $4E, $08, $4C, $10, $4C, $18, $4C, $60, $47, $68, $47, $60
    db $47, $E0, $47, $E8, $4E, $F0, $4E, $E0, $49, $F0, $48, $F8, $48, $F0, $48, $00
    db $48, $40, $49, $60, $47, $68, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $60
    db $47, $68, $47, $E0, $47, $C0, $4C, $C0, $4E, $F8, $4E, $00, $4F, $08, $4F, $10
    db $4F, $D8, $4E, $00, $4E, $D0, $47, $60, $47, $98, $47, $D8, $47, $D8, $47, $D8
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $60, $47, $68, $47, $60
    db $47, $88, $47, $78, $47, $48, $47, $90, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $B0, $47, $A0, $47, $18, $4F, $40, $48, $48, $48, $A0
    db $48, $A8, $48, $B0, $48, $A0, $48, $B0, $48, $A0, $48, $B0, $48, $88, $49, $58
    db $49, $60, $49, $E0, $4C, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $20, $4F, $28
    db $4F, $30, $4F, $30, $48, $A0, $47, $68, $47, $60, $47, $68, $47, $B8, $47, $78
    db $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $38, $4F, $E0, $46, $E8, $46, $40
    db $4F, $E0, $46, $E8, $46, $E8, $46, $E0, $46, $E0, $46, $E8, $46, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $C0, $49, $48, $4A, $50, $4A, $B8, $47, $C0, $47, $C0
    db $46, $C8, $46, $80, $4C, $88, $4C, $90, $4C, $98, $4C, $98, $47, $D8, $47, $98
    db $47, $18, $47, $08, $47, $80, $45, $88, $45, $90, $45, $D0, $49, $A0, $45, $B0
    db $4C, $B8, $4C, $98, $47, $D8, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $98
    db $47, $D8, $47, $18, $47, $58, $4E, $48, $4F, $50, $4F, $58, $4F, $60, $4F, $68
    db $4F, $70, $4F, $78, $4F, $20, $47, $98, $47, $60, $47, $68, $47, $68, $47, $68
    db $47, $68, $47, $98, $47, $D8, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98
    db $47, $10, $48, $E8, $47, $C8, $47, $18, $48, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $98, $47, $D8, $47, $F0, $47, $D0, $48, $D8, $48, $E0, $48, $E8, $48, $F0
    db $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $E0, $49, $30
    db $49, $E0, $49, $30, $49, $F8, $48, $F0, $48, $F8, $48, $F8, $48, $00, $49, $08
    db $49, $10, $49, $00, $48, $40, $49, $98, $47, $98, $47, $D8, $47, $E0, $47, $E8
    db $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $60, $47, $68, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $48, $4A, $50
    db $4A, $50, $4A, $98, $47, $D8, $47, $98, $47, $D8, $47, $80, $48, $88, $48, $60
    db $49, $E0, $4C, $E8, $4C, $F0, $4C, $F8, $4C, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $B8, $47, $78, $47, $D0, $45, $D8, $45, $E0, $45, $60, $4A, $F0, $45, $08
    db $4D, $10, $4D, $60, $47, $68, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $60
    db $47, $68, $47, $B8, $47, $B8, $4E, $80, $4F, $30, $49, $88, $4F, $90, $4F, $A8
    db $4A, $98, $4F, $40, $4E, $A0, $4F, $A0, $48, $B0, $48, $A0, $48, $B0, $48, $B8
    db $48, $B0, $4E, $A8, $47, $B0, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $60, $47, $68, $47, $18, $47, $40, $47, $A0, $4C, $98, $49, $A0, $49, $98
    db $45, $98, $45, $A0, $45, $90, $45, $98, $45, $80, $4A, $90, $45, $98, $45, $A0
    db $45, $A8, $4C, $98, $45, $A0, $45, $90, $45, $98, $45, $98, $45, $A8, $45, $B0
    db $45, $B8, $45, $48, $47, $50, $47, $60, $47, $60, $47, $68, $47, $18, $47, $08
    db $47, $C0, $46, $20, $47, $98, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $60, $47, $68, $47, $60, $47, $68, $47, $B8, $49, $C0
    db $49, $C0, $49, $60, $47, $98, $47, $D8, $47, $D8, $47, $38, $47, $40, $47, $20
    db $4D, $E0, $49, $F0, $48, $18, $49, $28, $4D, $60, $47, $68, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $28, $46, $80, $46, $50, $46, $58, $46, $48, $46, $30
    db $4D, $38, $4D, $98, $47, $D8, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $98
    db $47, $D8, $47, $E0, $47, $C0, $4C, $A8, $4F, $B0, $4F, $B8, $4F, $B8, $4F, $C0
    db $4F, $C8, $4F, $D0, $4F, $78, $45, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $00, $48, $40, $49, $D8, $4F, $E0, $4F, $D8, $4F, $E0, $4F, $E0
    db $4F, $B8, $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $B8, $47, $78, $47, $D0, $45, $20, $4A, $28, $4A, $E8
    db $4F, $E8, $45, $F0, $45, $F0, $4F, $F8, $4F, $E8, $4A, $E0, $45, $E8, $45, $F0
    db $45, $00, $4D, $00, $50, $08, $50, $E0, $45, $E8, $45, $F8, $45, $00, $46, $08
    db $46, $10, $46, $C8, $47, $D0, $47, $98, $47, $98, $47, $D8, $47, $B8, $47, $58
    db $4C, $60, $49, $E0, $4C, $B8, $48, $A0, $48, $A8, $48, $A0, $48, $A8, $48, $A0
    db $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0
    db $48, $B8, $48, $B0, $48, $50, $48, $10, $50, $30, $48, $A0, $47, $B8, $49, $C0
    db $49, $C0, $49, $B8, $49, $60, $47, $68, $47, $68, $47, $B8, $47, $C0, $47, $80
    db $45, $88, $45, $98, $45, $B0, $4C, $B8, $4C, $68, $47, $60, $47, $68, $47, $60
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $E0, $46, $E8, $46, $E0, $46, $E8
    db $46, $E8, $46, $60, $47, $68, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $98
    db $47, $D8, $47, $18, $47, $58, $4E, $18, $50, $20, $50, $28, $50, $30, $50, $38
    db $50, $40, $50, $48, $50, $88, $45, $90, $45, $C8, $49, $A0, $45, $90, $45, $98
    db $45, $A8, $49, $B0, $4C, $B8, $4C, $60, $47, $68, $47, $60, $47, $68, $47, $68
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $E0, $47, $E8, $47, $28, $46, $B0, $4A, $B8, $4A, $C0
    db $4A, $58, $46, $48, $46, $50, $50, $58, $50, $48, $46, $50, $46, $58, $46, $48
    db $46, $50, $46, $60, $50, $68, $50, $50, $46, $58, $46, $60, $46, $68, $46, $70
    db $46, $78, $46, $48, $47, $50, $47, $60, $47, $60, $47, $68, $47, $E0, $47, $C0
    db $4C, $E0, $49, $30, $49, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0
    db $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0
    db $48, $F8, $48, $F0, $48, $F8, $48, $10, $49, $00, $48, $40, $49, $48, $4A, $50
    db $4A, $50, $4A, $98, $47, $D8, $47, $98, $47, $D8, $47, $E0, $47, $88, $48, $D0
    db $45, $D8, $45, $E8, $45, $08, $4D, $10, $4D, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $60
    db $47, $68, $47, $B8, $47, $78, $47, $70, $50, $E8, $4D, $78, $50, $78, $50, $80
    db $50, $88, $50, $D0, $45, $D8, $45, $E0, $45, $58, $4A, $F0, $45, $E0, $45, $E8
    db $45, $38, $4A, $08, $4D, $10, $4D, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $18, $47, $08, $47, $C0, $46, $90, $50, $98, $50, $A0
    db $50, $A8, $50, $B0, $50, $B8, $50, $C0, $50, $C8, $50, $D0, $50, $D8, $50, $E0
    db $50, $E8, $50, $F0, $50, $F8, $50, $00, $51, $08, $51, $10, $51, $F8, $46, $48
    db $4B, $08, $47, $C0, $46, $20, $47, $98, $47, $98, $47, $D8, $47, $70, $4A, $78
    db $4A, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98
    db $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90
    db $45, $98, $45, $A0, $45, $C0, $45, $B8, $45, $C0, $46, $20, $47, $B8, $49, $C0
    db $49, $C0, $49, $60, $47, $68, $47, $60, $47, $68, $47, $18, $47, $40, $47, $28
    db $46, $30, $46, $90, $46, $18, $51, $38, $4D, $68, $47, $60, $47, $68, $47, $60
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $60, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $98
    db $47, $D8, $47, $E0, $47, $E8, $47, $20, $51, $68, $47, $60, $47, $68, $47, $60
    db $47, $28, $51, $28, $46, $80, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58
    db $46, $48, $46, $30, $4D, $38, $4D, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $88, $47, $78, $47, $48, $47, $90, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $E0, $46, $E8
    db $46, $30, $51, $38, $51, $40, $51, $48, $51, $50, $51, $58, $51, $60, $51, $68
    db $51, $70, $51, $78, $51, $80, $51, $88, $51, $90, $51, $E0, $46, $E8, $46, $18
    db $47, $08, $47, $C0, $46, $20, $47, $60, $47, $60, $47, $68, $47, $D8, $4A, $E0
    db $4A, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8
    db $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0
    db $45, $E8, $45, $F0, $45, $18, $46, $10, $46, $48, $47, $50, $47, $48, $4A, $50
    db $4A, $50, $4A, $30, $48, $A0, $47, $30, $48, $D8, $47, $B8, $47, $C0, $47, $C0
    db $46, $C8, $46, $D0, $46, $98, $51, $E8, $46, $D8, $47, $98, $47, $98, $47, $D8
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $D8, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60
    db $47, $68, $47, $18, $47, $08, $47, $70, $50, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $88, $50, $C0, $46, $20, $47, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $10, $48, $E8, $47, $C8, $47, $18, $48, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $60, $47, $68
    db $47, $A0, $51, $A8, $51, $B0, $51, $B8, $51, $C0, $51, $C0, $51, $C0, $51, $C0
    db $51, $C0, $51, $C8, $51, $D0, $51, $D8, $51, $E0, $51, $98, $47, $D8, $47, $B8
    db $47, $78, $47, $48, $47, $50, $47, $98, $47, $98, $47, $D8, $47, $80, $4B, $88
    db $4B, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58
    db $46, $48, $46, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $88, $46, $78, $46, $C8, $47, $D0, $47, $B8, $49, $C0
    db $49, $E8, $51, $F0, $51, $F8, $51, $A0, $47, $A0, $47, $80, $48, $88, $48, $48
    db $47, $50, $47, $68, $47, $58, $47, $60, $47, $68, $47, $60, $47, $60, $47, $68
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $60, $47, $68, $47, $30, $48, $A0
    db $47, $00, $52, $A8, $48, $B0, $48, $88, $49, $58, $49, $60, $49, $08, $52, $30
    db $48, $A0, $47, $10, $52, $58, $49, $18, $52, $B0, $4E, $A8, $47, $B0, $47, $00
    db $52, $20, $52, $28, $52, $90, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $18, $47, $08, $47, $C0, $46, $10, $47, $98, $47, $D8
    db $47, $30, $52, $38, $52, $30, $52, $38, $52, $30, $52, $38, $52, $30, $52, $30
    db $52, $38, $52, $30, $52, $38, $52, $30, $52, $38, $52, $60, $47, $68, $47, $80
    db $48, $E8, $47, $C8, $47, $D0, $47, $60, $47, $60, $47, $68, $47, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $18, $47, $08, $47, $C0, $46, $20, $47, $48, $4A, $50
    db $4A, $40, $52, $48, $52, $50, $52, $A0, $47, $B0, $47, $38, $47, $40, $47, $C8
    db $47, $D8, $49, $58, $52, $60, $52, $98, $47, $D8, $47, $98, $47, $98, $47, $D8
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $F0, $47, $D0
    db $48, $68, $52, $F8, $48, $F0, $48, $E0, $49, $70, $52, $78, $52, $80, $52, $88
    db $52, $F8, $49, $90, $52, $98, $52, $A0, $52, $F0, $48, $A8, $52, $B0, $52, $F8
    db $48, $10, $4A, $18, $4A, $18, $48, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $A0, $47, $30, $48, $A0, $47, $30, $48, $D8, $47, $98, $47, $30, $48, $A0
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $30, $48, $A0, $47, $98, $47, $D8
    db $47, $30, $48, $A0, $47, $B8, $47, $78, $47, $48, $47, $80, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $60, $47, $68, $47, $38
    db $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $98, $47, $60, $47, $98
    db $47, $60, $47, $98, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $60, $47, $68, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $B8, $49, $C0
    db $49, $E8, $51, $B8, $52, $C0, $52, $C8, $52, $D0, $52, $B8, $47, $C0, $47, $C0
    db $46, $C8, $46, $D8, $52, $38, $4B, $60, $47, $68, $47, $60, $47, $60, $47, $68
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $70, $4A, $78
    db $4A, $C8, $49, $A0, $45, $90, $45, $98, $45, $E0, $52, $90, $4A, $E8, $52, $F0
    db $52, $F8, $52, $00, $53, $88, $4A, $90, $4A, $A0, $45, $08, $53, $10, $53, $C0
    db $45, $B8, $45, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $30, $48, $A0
    db $47, $38, $48, $18, $53, $20, $53, $A0, $48, $B0, $48, $A0, $48, $A0, $48, $28
    db $53, $30, $53, $38, $53, $40, $53, $48, $53, $50, $53, $B0, $48, $B8, $48, $B0
    db $48, $A0, $48, $28, $53, $30, $53, $38, $53, $58, $53, $D0, $47, $D8, $4F, $E0
    db $4F, $D8, $4F, $E0, $4F, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $60, $53, $68, $53, $60, $53, $E0, $4F, $B8
    db $47, $58, $4C, $60, $49, $68, $49, $60, $4C, $B0, $47, $A8, $47, $68, $4C, $A0
    db $48, $A8, $48, $A0, $48, $A8, $48, $80, $49, $60, $48, $80, $49, $10, $50, $18
    db $4F, $60, $48, $80, $49, $60, $48, $80, $49, $60, $48, $70, $53, $A0, $47, $A0
    db $47, $98, $47, $D8, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $48, $4A, $50
    db $4A, $50, $4A, $78, $53, $80, $53, $88, $53, $90, $53, $80, $48, $88, $48, $60
    db $49, $E0, $4C, $70, $53, $50, $4B, $A8, $47, $B0, $47, $98, $47, $98, $47, $D8
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8, $47, $D8, $4A, $E0
    db $4A, $58, $4A, $F0, $45, $E0, $45, $E8, $45, $98, $53, $F8, $4A, $00, $4B, $A0
    db $53, $A8, $53, $B0, $53, $F0, $4A, $F8, $4A, $F0, $45, $B8, $53, $C0, $53, $18
    db $46, $10, $46, $48, $47, $50, $47, $98, $47, $98, $47, $D8, $47, $F0, $47, $D0
    db $48, $D8, $48, $E0, $48, $E8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $00
    db $49, $C8, $53, $10, $4A, $20, $4D, $D0, $53, $E8, $48, $F0, $48, $F0, $48, $F8
    db $48, $F0, $48, $D8, $53, $E0, $53, $E8, $53, $F0, $53, $50, $47, $D8, $4F, $F8
    db $53, $00, $54, $E0, $4F, $98, $47, $D8, $47, $30, $48, $A0, $47, $30, $48, $A0
    db $47, $A0, $47, $98, $47, $D8, $47, $68, $53, $08, $54, $10, $54, $E0, $4F, $E0
    db $47, $E8, $4E, $20, $4D, $30, $49, $E8, $49, $18, $54, $20, $54, $00, $4A, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $10, $49, $D8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $18, $49, $40
    db $49, $60, $47, $68, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $B8, $49, $C0
    db $49, $C0, $49, $28, $54, $30, $54, $38, $54, $40, $54, $38, $47, $40, $47, $48
    db $54, $E0, $49, $F0, $48, $18, $49, $28, $4D, $A0, $47, $60, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $80, $4B, $88
    db $4B, $58, $46, $48, $46, $50, $46, $58, $46, $88, $4D, $98, $4B, $A0, $4B, $50
    db $54, $58, $54, $60, $54, $90, $4B, $98, $4B, $48, $46, $68, $54, $70, $54, $88
    db $46, $78, $46, $C8, $47, $D0, $47, $60, $47, $60, $47, $68, $47, $18, $47, $08
    db $47, $80, $45, $98, $49, $A0, $49, $98, $45, $A0, $45, $90, $45, $98, $45, $78
    db $54, $B0, $45, $B8, $45, $80, $45, $98, $49, $A0, $49, $98, $45, $A0, $45, $90
    db $45, $98, $45, $A8, $45, $B0, $45, $B8, $45, $C0, $46, $20, $47, $68, $53, $80
    db $54, $88, $54, $60, $53, $A8, $47, $B0, $47, $F0, $47, $D0, $48, $90, $54, $18
    db $49, $40, $49, $A8, $47, $B0, $47, $D8, $4F, $98, $54, $A0, $54, $60, $53, $18
    db $47, $08, $47, $A8, $54, $B0, $54, $30, $49, $98, $4A, $A0, $4A, $A8, $4A, $90
    db $4A, $18, $4D, $90, $45, $C8, $49, $A0, $45, $90, $45, $B8, $54, $B8, $45, $80
    db $45, $C0, $54, $A0, $45, $90, $45, $98, $45, $A0, $45, $98, $45, $B0, $4C, $B8
    db $4C, $98, $47, $D8, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $C8, $54, $D0
    db $54, $D8, $54, $E0, $54, $E8, $54, $F0, $54, $F8, $54, $00, $55, $58, $49, $80
    db $45, $88, $45, $98, $45, $B0, $4C, $B8, $4C, $08, $55, $10, $55, $18, $55, $20
    db $55, $18, $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $80, $50, $28
    db $55, $28, $55, $30, $55, $E0, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $18
    db $47, $08, $47, $C0, $46, $10, $47, $98, $47, $98, $47, $D8, $47, $88, $47, $78
    db $47, $D0, $45, $20, $4A, $28, $4A, $30, $4A, $F0, $45, $E0, $45, $F8, $45, $00
    db $46, $08, $46, $10, $46, $D0, $45, $20, $4A, $28, $4A, $30, $4A, $F0, $45, $E0
    db $45, $F8, $45, $00, $46, $08, $46, $10, $46, $48, $47, $50, $47, $D8, $4F, $38
    db $55, $40, $55, $48, $55, $50, $55, $58, $55, $70, $4A, $78, $4A, $D0, $49, $B0
    db $4C, $B8, $4C, $30, $48, $A0, $47, $60, $55, $38, $55, $40, $55, $E0, $4F, $B8
    db $47, $78, $47, $68, $55, $70, $55, $78, $55, $08, $4B, $10, $4B, $B0, $53, $F8
    db $4A, $40, $4D, $E0, $45, $58, $4A, $F0, $45, $E0, $45, $18, $46, $10, $46, $D0
    db $45, $D8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E8, $45, $08, $4D, $10
    db $4D, $60, $47, $68, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $80, $55, $88
    db $55, $90, $55, $98, $55, $A0, $55, $A8, $55, $B0, $55, $B8, $55, $C0, $55, $D0
    db $45, $D8, $45, $E8, $45, $08, $4D, $10, $4D, $C8, $55, $D0, $55, $D8, $55, $E0
    db $55, $B8, $47, $78, $47, $48, $47, $50, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $80
    db $65, $88, $65, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $B8
    db $47, $78, $47, $48, $47, $80, $47, $60, $47, $60, $47, $68, $47, $10, $48, $E8
    db $47, $28, $46, $B0, $4A, $B8, $4A, $C0, $4A, $A0, $46, $A8, $46, $60, $46, $68
    db $46, $70, $46, $78, $46, $28, $46, $B0, $4A, $B8, $4A, $C0, $4A, $A0, $46, $A8
    db $46, $60, $46, $68, $46, $70, $46, $78, $46, $C8, $47, $D0, $47, $60, $47, $68
    db $47, $A8, $47, $B0, $47, $E8, $55, $F0, $55, $D8, $4A, $E0, $4A, $60, $4A, $08
    db $4D, $10, $4D, $F8, $55, $00, $56, $30, $48, $A0, $47, $98, $47, $D8, $47, $E0
    db $47, $E8, $47, $08, $56, $10, $56, $18, $56, $A8, $4B, $B0, $4B, $60, $54, $98
    db $4B, $88, $4D, $50, $46, $58, $46, $48, $46, $50, $46, $88, $46, $78, $46, $28
    db $46, $80, $46, $48, $46, $50, $46, $58, $46, $48, $46, $58, $46, $30, $4D, $38
    db $4D, $98, $47, $D8, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $70, $4A, $78, $4A, $20, $56, $C0, $45, $C8, $45, $28
    db $46, $30, $46, $58, $46, $30, $4D, $08, $4E, $10, $4E, $30, $48, $98, $47, $D8
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $90
    db $65, $98, $65, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $E0
    db $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $98, $47, $D8, $47, $18, $47, $08
    db $47, $C0, $46, $18, $4B, $20, $4B, $28, $4B, $28, $47, $30, $47, $40, $4B, $F8
    db $46, $48, $4B, $08, $47, $C0, $46, $18, $4B, $20, $4B, $28, $4B, $28, $47, $30
    db $47, $40, $4B, $F8, $46, $48, $4B, $08, $47, $C0, $46, $10, $47, $98, $47, $D8
    db $47, $90, $4E, $98, $4E, $C8, $4B, $28, $56, $C8, $50, $D0, $50, $30, $56, $38
    db $56, $E8, $50, $40, $56, $48, $56, $50, $56, $58, $56, $60, $47, $68, $47, $68
    db $4A, $08, $47, $C0, $46, $10, $47, $60, $56, $68, $56, $70, $56, $78, $56, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $B8, $47, $78, $47, $48
    db $47, $50, $47, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E0, $46, $E8
    db $46, $60, $47, $68, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $48, $4A, $50
    db $4A, $50, $4A, $48, $4A, $D8, $4A, $E0, $4A, $80, $56, $18, $46, $20, $46, $C0
    db $46, $C8, $46, $50, $4B, $58, $4B, $48, $4E, $50, $4E, $A8, $47, $60, $47, $68
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98, $47, $18
    db $47, $08, $47, $C0, $46, $20, $47, $60, $47, $60, $47, $68, $47, $B8, $47, $78
    db $47, $48, $47, $50, $47, $E0, $46, $E8, $46, $E8, $46, $E8, $46, $E0, $46, $E8
    db $46, $88, $47, $78, $47, $48, $47, $90, $47, $E0, $46, $E8, $46, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $B8, $47, $78, $47, $48, $47, $80, $47, $60, $47, $68
    db $47, $88, $56, $90, $56, $98, $56, $48, $51, $50, $51, $58, $51, $A0, $56, $A8
    db $56, $70, $51, $78, $51, $80, $51, $B0, $56, $B8, $56, $60, $47, $68, $47, $70
    db $47, $78, $47, $48, $47, $80, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $18, $47, $08, $47, $C0
    db $46, $20, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $B8, $49, $C0
    db $49, $E8, $51, $C0, $56, $C8, $56, $88, $4B, $D0, $56, $B0, $46, $B8, $46, $48
    db $47, $50, $47, $90, $4E, $98, $4E, $A0, $4E, $A8, $4E, $30, $48, $98, $47, $D8
    db $47, $B8, $47, $58, $4C, $60, $49, $D8, $56, $E0, $56, $58, $48, $80, $49, $58
    db $48, $80, $49, $60, $48, $50, $48, $58, $48, $50, $48, $58, $48, $50, $48, $58
    db $48, $58, $48, $60, $48, $58, $48, $60, $48, $A0, $48, $A8, $48, $20, $4F, $E8
    db $56, $58, $49, $90, $49, $90, $47, $98, $47, $98, $47, $D8, $47, $80, $48, $E8
    db $47, $C8, $47, $D8, $49, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $98
    db $47, $10, $48, $E8, $47, $C8, $47, $18, $48, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $80, $48, $E8, $47, $C8, $47, $D0, $47, $98, $47, $98
    db $47, $F0, $56, $A8, $51, $B0, $51, $B8, $51, $C0, $51, $C0, $51, $C0, $51, $C0
    db $51, $C0, $51, $C8, $51, $D0, $51, $D8, $51, $E0, $51, $98, $47, $D8, $47, $E0
    db $47, $E8, $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $B8, $47, $78, $47, $48
    db $47, $50, $47, $68, $47, $60, $47, $68, $47, $A8, $47, $B0, $47, $A8, $47, $B0
    db $47, $D0, $4D, $C0, $48, $18, $47, $D8, $4D, $C0, $46, $20, $47, $48, $4A, $50
    db $4A, $40, $52, $48, $52, $F8, $56, $00, $57, $00, $57, $38, $47, $40, $47, $C8
    db $47, $D8, $49, $E0, $4E, $08, $4C, $10, $4C, $18, $4C, $60, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $4E, $08, $57, $10, $57, $18, $57, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $00, $49, $E0
    db $53, $20, $57, $18, $4A, $18, $48, $98, $47, $60, $47, $68, $47, $38, $47, $08
    db $47, $C0, $46, $C8, $46, $60, $47, $68, $47, $60, $47, $B0, $47, $A8, $47, $A8
    db $47, $70, $4A, $78, $4A, $B0, $4C, $B8, $4C, $B0, $47, $A8, $47, $B0, $47, $60
    db $47, $68, $47, $60, $47, $38, $47, $08, $47, $C0, $46, $20, $47, $98, $47, $60
    db $47, $30, $52, $38, $52, $38, $52, $30, $52, $38, $52, $38, $52, $30, $52, $30
    db $52, $38, $52, $30, $52, $38, $52, $30, $52, $38, $52, $60, $47, $68, $47, $18
    db $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $F0, $47, $D0, $48, $40
    db $4C, $08, $48, $D8, $47, $98, $47, $D8, $47, $98, $47, $E0, $47, $E8, $47, $C8
    db $47, $D0, $47, $D8, $47, $98, $47, $D8, $47, $A0, $4D, $18, $4E, $20, $4E, $28
    db $4E, $D8, $48, $10, $49, $30, $4E, $38, $4E, $48, $47, $50, $47, $B8, $49, $C0
    db $49, $E8, $51, $28, $57, $30, $57, $38, $57, $D0, $52, $B8, $47, $C0, $47, $C0
    db $46, $C8, $46, $80, $4C, $88, $4C, $90, $4C, $98, $4C, $98, $47, $98, $47, $D8
    db $47, $18, $47, $08, $47, $80, $45, $98, $49, $A0, $49, $98, $45, $A0, $45, $90
    db $45, $98, $45, $A8, $49, $90, $45, $98, $45, $A0, $45, $B0, $49, $98, $45, $A0
    db $45, $90, $45, $D0, $49, $A0, $45, $90, $45, $98, $45, $90, $45, $40, $57, $B0
    db $45, $B8, $45, $C0, $46, $20, $47, $60, $47, $98, $47, $D8, $47, $B8, $47, $78
    db $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $A0, $47, $48, $57, $50
    db $57, $D8, $4A, $E0, $4A, $08, $4D, $10, $4D, $50, $55, $58, $57, $A0, $47, $98
    db $47, $D8, $47, $98, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $60
    db $47, $98, $47, $98, $47, $D8, $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $B8
    db $47, $78, $47, $48, $47, $50, $47, $60, $47, $68, $47, $18, $47, $08, $47, $C0
    db $46, $10, $47, $68, $47, $60, $47, $68, $47, $60, $47, $18, $47, $08, $47, $C0
    db $46, $20, $47, $68, $47, $60, $47, $68, $47, $18, $47, $58, $4E, $60, $4E, $68
    db $4E, $70, $4E, $78, $4E, $80, $4E, $88, $4E, $C8, $47, $D0, $47, $48, $4A, $50
    db $4A, $50, $4A, $60, $57, $68, $57, $70, $57, $78, $57, $80, $48, $88, $48, $60
    db $49, $68, $49, $E8, $4C, $F0, $4C, $F8, $4C, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $B8, $47, $78, $47, $D0, $45, $20, $4A, $28, $4A, $30, $4A, $F0, $45, $E0
    db $45, $E8, $45, $38, $4A, $E0, $45, $E8, $45, $F0, $45, $40, $4A, $E8, $45, $F0
    db $45, $E0, $45, $60, $4A, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $00, $46, $08
    db $46, $10, $46, $48, $47, $50, $47, $98, $47, $60, $47, $68, $47, $E0, $47, $E8
    db $47, $C8, $47, $D0, $47, $60, $47, $68, $47, $60, $47, $B0, $47, $80, $57, $88
    db $57, $80, $4B, $88, $4B, $30, $4D, $38, $4D, $E8, $55, $90, $57, $B0, $47, $60
    db $47, $68, $47, $60, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $98
    db $47, $D8, $47, $68, $47, $60, $47, $60, $47, $68, $47, $60, $47, $68, $47, $98
    db $47, $60, $47, $60, $47, $68, $47, $68, $47, $68, $47, $60, $47, $68, $47, $E0
    db $47, $E8, $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $B8, $47, $78, $47, $48
    db $47, $80, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $B8, $47, $78, $47, $48
    db $47, $50, $47, $D8, $47, $98, $47, $D8, $47, $B8, $47, $B8, $4E, $C0, $4E, $C8
    db $4E, $70, $4E, $78, $4E, $D0, $4E, $D8, $4E, $C0, $46, $20, $47, $B8, $49, $C0
    db $49, $C0, $49, $28, $54, $98, $57, $A0, $57, $A8, $57, $38, $47, $40, $47, $48
    db $54, $E0, $49, $F0, $48, $18, $49, $28, $4D, $60, $47, $68, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $C8, $47, $B0, $4A, $B8, $4A, $C0, $4A, $48, $46, $50
    db $46, $58, $46, $A0, $46, $A8, $46, $58, $46, $48, $46, $38, $46, $40, $46, $48
    db $46, $50, $46, $90, $46, $98, $46, $50, $46, $58, $46, $60, $46, $68, $46, $70
    db $46, $78, $46, $C8, $47, $D0, $47, $60, $47, $68, $47, $98, $47, $18, $47, $08
    db $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $98, $47, $A0, $47, $B8, $52, $B0
    db $57, $00, $51, $08, $51, $A8, $50, $B0, $50, $C8, $4B, $B8, $57, $A0, $47, $98
    db $47, $D8, $47, $98, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $D8, $4F, $68
    db $53, $60, $53, $E0, $4F, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $60
    db $47, $68, $47, $98, $47, $D8, $47, $D8, $4F, $E0, $4F, $D8, $4F, $E0, $4F, $18
    db $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $E0, $47, $E8, $47, $C8
    db $47, $D0, $47, $68, $47, $60, $47, $68, $47, $60, $47, $E0, $47, $E8, $47, $C8
    db $47, $D0, $47, $68, $47, $60, $47, $68, $47, $E0, $47, $C0, $4C, $C0, $4E, $F8
    db $4E, $00, $4F, $08, $4F, $10, $4F, $D8, $4E, $48, $47, $50, $47, $C8, $54, $D0
    db $54, $C0, $57, $C8, $57, $D0, $57, $D8, $57, $F8, $54, $00, $55, $58, $49, $80
    db $45, $88, $45, $98, $45, $B0, $4C, $B8, $4C, $60, $4D, $20, $55, $E0, $57, $E8
    db $57, $18, $47, $08, $47, $C0, $46, $18, $4B, $20, $4B, $A0, $50, $E0, $46, $E8
    db $46, $E0, $46, $30, $4B, $38, $4B, $E8, $46, $E0, $46, $30, $4B, $38, $4B, $E8
    db $46, $E0, $46, $30, $4B, $38, $4B, $E8, $46, $E0, $46, $10, $51, $F8, $46, $48
    db $4B, $08, $47, $C0, $46, $10, $47, $98, $47, $D8, $47, $60, $47, $88, $47, $78
    db $47, $48, $47, $90, $47, $60, $47, $68, $47, $60, $47, $68, $47, $F0, $57, $F8
    db $57, $88, $51, $90, $51, $88, $56, $90, $56, $98, $56, $00, $58, $68, $47, $60
    db $47, $68, $47, $60, $47, $88, $47, $78, $47, $48, $47, $90, $47, $68, $53, $08
    db $58, $10, $58, $60, $53, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $68, $53, $18, $58, $20, $58, $60, $53, $88
    db $47, $78, $47, $48, $47, $90, $47, $98, $47, $D8, $47, $18, $47, $08, $47, $C0
    db $46, $10, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $88, $47, $78, $47, $48
    db $47, $50, $47, $D8, $47, $98, $47, $D8, $47, $18, $47, $58, $4E, $48, $4F, $50
    db $4F, $58, $4F, $60, $4F, $68, $4F, $70, $4F, $C8, $47, $D0, $47, $80, $55, $88
    db $55, $28, $58, $30, $58, $A0, $55, $A8, $55, $B0, $55, $B8, $55, $C0, $55, $D0
    db $45, $D8, $45, $E8, $45, $08, $4D, $10, $4D, $A8, $4D, $E0, $55, $38, $58, $40
    db $58, $B8, $47, $78, $47, $48, $47, $50, $47, $E0, $46, $E8, $46, $D8, $47, $98
    db $47, $D8, $47, $D8, $47, $60, $47, $98, $47, $D8, $47, $D8, $47, $60, $47, $D8
    db $47, $60, $47, $D8, $47, $60, $47, $60, $47, $68, $47, $E0, $46, $E8, $46, $B8
    db $47, $78, $47, $48, $47, $80, $47, $60, $47, $68, $47, $98, $47, $10, $48, $E8
    db $47, $C8, $47, $18, $48, $98, $47, $D8, $47, $98, $47, $D8, $47, $48, $58, $50
    db $58, $58, $58, $60, $58, $A0, $51, $A8, $51, $B0, $51, $68, $58, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $10, $48, $E8, $47, $C8, $47, $18, $48, $D8, $4F, $70
    db $58, $78, $58, $E0, $4F, $98, $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $D8, $4F, $80, $58, $88, $58, $60, $53, $10
    db $48, $E8, $47, $C8, $47, $18, $48, $60, $47, $68, $47, $B8, $47, $78, $47, $48
    db $47, $80, $47, $68, $47, $60, $47, $90, $58, $98, $58, $10, $48, $E8, $47, $C8
    db $47, $D0, $47, $68, $47, $60, $47, $68, $47, $B8, $47, $B8, $4E, $80, $4F, $30
    db $49, $88, $4F, $90, $4F, $A8, $4A, $98, $4F, $C0, $46, $20, $47, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $70, $4A, $78, $4A, $20, $56, $C0, $45, $C8, $45, $28
    db $46, $30, $46, $58, $46, $30, $4D, $08, $4E, $10, $4E, $A8, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $C8, $47, $D8, $49, $A8, $47, $A8, $47, $A0, $58, $A8
    db $58, $B0, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $68
    db $47, $60, $47, $68, $47, $30, $48, $B0, $58, $F8, $51, $A0, $47, $A0, $47, $80
    db $48, $E8, $47, $C8, $47, $D0, $47, $98, $47, $D8, $47, $60, $47, $18, $47, $08
    db $47, $C0, $46, $20, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $30
    db $52, $38, $52, $38, $52, $30, $52, $38, $52, $30, $52, $E8, $46, $68, $47, $60
    db $47, $68, $47, $60, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $68, $53, $38
    db $55, $40, $55, $D8, $4F, $60, $47, $68, $47, $60, $47, $60, $47, $68, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $68, $53, $38, $55, $40, $55, $D8, $4F, $18
    db $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $E0, $47, $E8, $47, $C8
    db $47, $D0, $47, $D8, $47, $98, $47, $30, $4B, $30, $47, $18, $47, $08, $47, $C0
    db $46, $20, $47, $D8, $47, $D8, $47, $98, $47, $E0, $47, $C0, $4C, $A8, $4F, $B0
    db $4F, $B8, $4F, $B8, $4F, $C0, $4F, $C8, $4F, $48, $47, $50, $47, $48, $4A, $50
    db $4A, $50, $4A, $48, $4A, $D8, $4A, $E0, $4A, $80, $56, $18, $46, $20, $46, $C0
    db $46, $C8, $46, $50, $4B, $50, $4B, $48, $4E, $50, $4E, $30, $48, $98, $47, $D8
    db $47, $18, $47, $08, $47, $C0, $46, $C8, $46, $30, $48, $A0, $47, $B8, $58, $50
    db $4E, $30, $48, $A0, $47, $30, $48, $A0, $47, $30, $48, $D8, $47, $30, $48, $A0
    db $47, $30, $48, $A0, $47, $A8, $47, $C0, $58, $C8, $58, $B0, $47, $B0, $47, $38
    db $47, $08, $47, $C0, $46, $20, $47, $60, $47, $68, $47, $98, $47, $B8, $47, $78
    db $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $B8, $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8
    db $47, $98, $47, $60, $47, $60, $47, $68, $47, $D8, $47, $98, $47, $D8, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98, $47, $98, $47, $B8
    db $47, $78, $47, $48, $47, $50, $47, $60, $47, $68, $47, $18, $47, $08, $47, $C0
    db $46, $20, $47, $68, $47, $60, $47, $E0, $46, $E8, $46, $B8, $47, $78, $47, $48
    db $47, $50, $47, $68, $47, $68, $47, $60, $47, $18, $47, $58, $4E, $18, $50, $20
    db $50, $50, $4B, $58, $4B, $38, $50, $40, $50, $C8, $47, $D0, $47, $B8, $49, $C0
    db $49, $E8, $51, $C0, $56, $C8, $56, $88, $4B, $D0, $56, $B0, $46, $B8, $46, $48
    db $47, $50, $47, $90, $4E, $98, $4E, $A0, $4E, $A8, $4E, $A8, $47, $60, $47, $68
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $B8, $4B, $C0, $4B, $A0, $4E, $D0
    db $58, $D8, $58, $E0, $58, $E8, $58, $F0, $58, $30, $48, $D8, $47, $A8, $47, $D8
    db $58, $F8, $58, $00, $59, $F0, $58, $08, $59, $10, $59, $18, $59, $20, $59, $B8
    db $47, $58, $4C, $60, $49, $E0, $4C, $70, $53, $A0, $47, $A8, $47, $28, $59, $38
    db $53, $40, $53, $30, $59, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0
    db $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $60, $4C, $A8, $47, $B0, $47, $00
    db $52, $A8, $48, $A0, $48, $38, $59, $38, $53, $40, $53, $30, $59, $B8, $48, $B0
    db $48, $C0, $48, $30, $48, $A0, $47, $98, $47, $D8, $47, $30, $48, $A0, $47, $D0
    db $4D, $B0, $48, $A8, $48, $60, $4C, $B0, $47, $B0, $47, $48, $49, $80, $49, $38
    db $59, $38, $53, $00, $4E, $D0, $47, $98, $47, $D8, $47, $B8, $47, $58, $4C, $60
    db $49, $E0, $4C, $50, $48, $58, $48, $50, $48, $58, $48, $38, $59, $38, $53, $58
    db $53, $D0, $47, $98, $47, $60, $47, $68, $47, $B8, $47, $78, $47, $70, $50, $E8
    db $4D, $40, $59, $40, $59, $80, $50, $88, $50, $C0, $46, $20, $47, $48, $4A, $50
    db $4A, $40, $52, $48, $52, $F8, $56, $00, $57, $00, $57, $38, $47, $40, $47, $C8
    db $47, $D8, $49, $E0, $4E, $08, $4C, $10, $4C, $18, $4C, $98, $47, $98, $47, $D8
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $30, $51, $38, $51, $48, $59, $48
    db $51, $50, $51, $58, $51, $A8, $56, $70, $51, $60, $47, $68, $47, $98, $47, $50
    db $51, $50, $59, $58, $59, $70, $51, $78, $51, $60, $59, $68, $59, $90, $51, $E0
    db $47, $E8, $4E, $20, $4D, $30, $49, $E8, $49, $F0, $49, $F8, $49, $90, $52, $70
    db $59, $A0, $52, $E0, $49, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $78, $59, $F0, $49, $F8, $49, $80
    db $59, $F0, $48, $F8, $48, $30, $49, $70, $59, $A0, $52, $E0, $49, $F0, $48, $F8
    db $48, $10, $49, $00, $48, $40, $49, $60, $47, $68, $47, $F0, $47, $D0, $48, $D8
    db $48, $F0, $48, $F8, $48, $E8, $49, $F8, $49, $F0, $49, $80, $59, $F0, $48, $E0
    db $49, $88, $59, $40, $4E, $50, $47, $60, $47, $68, $47, $E0, $47, $C0, $4C, $C8
    db $4C, $30, $49, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $E0, $49, $10, $4A, $90
    db $59, $20, $47, $60, $47, $68, $47, $98, $47, $E0, $47, $E8, $47, $20, $51, $68
    db $47, $68, $53, $60, $53, $60, $47, $28, $51, $48, $47, $50, $47, $B8, $49, $C0
    db $49, $E8, $51, $28, $57, $30, $57, $38, $57, $D0, $52, $B8, $47, $C0, $47, $C0
    db $46, $C8, $46, $80, $4C, $88, $4C, $90, $4C, $98, $4C, $60, $47, $60, $47, $68
    db $47, $18, $47, $08, $47, $C0, $46, $10, $47, $98, $59, $A0, $59, $B0, $51, $B8
    db $51, $C0, $51, $C0, $51, $C0, $51, $C0, $51, $98, $47, $D8, $47, $60, $47, $C0
    db $51, $C0, $51, $C0, $51, $C0, $51, $C8, $51, $A8, $59, $B0, $59, $60, $58, $68
    db $4A, $08, $47, $80, $4E, $88, $4E, $B8, $59, $C0, $59, $C8, $59, $D0, $59, $90
    db $4A, $18, $4D, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $A0, $45, $90
    db $45, $98, $45, $A0, $45, $88, $4A, $90, $4A, $D8, $59, $E0, $59, $C8, $59, $E8
    db $59, $90, $4A, $18, $4D, $90, $45, $98, $45, $A0, $45, $90, $45, $98, $45, $C0
    db $45, $B8, $45, $C0, $46, $10, $47, $98, $47, $D8, $47, $68, $4A, $08, $47, $80
    db $45, $B0, $54, $88, $4A, $E0, $49, $F0, $59, $F8, $59, $00, $5A, $88, $4A, $08
    db $5A, $A0, $45, $B0, $4C, $B8, $4C, $98, $47, $D8, $47, $70, $4A, $78, $4A, $90
    db $45, $98, $45, $A0, $45, $B0, $49, $98, $45, $A0, $45, $C0, $45, $B8, $45, $48
    db $47, $50, $47, $98, $47, $D8, $47, $60, $47, $18, $47, $08, $47, $70, $50, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $88, $50, $C8, $47, $D0, $47, $48, $4A, $50
    db $4A, $50, $4A, $60, $57, $68, $57, $70, $57, $78, $57, $80, $48, $88, $48, $60
    db $49, $68, $49, $E8, $4C, $F0, $4C, $F8, $4C, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $B8, $47, $78, $47, $48, $47, $80, $47, $30, $52, $30, $52, $38, $52, $30
    db $52, $30, $52, $30, $52, $30, $52, $38, $52, $60, $47, $68, $47, $98, $47, $30
    db $52, $30, $52, $30, $52, $38, $52, $30, $52, $30, $52, $38, $52, $38, $52, $70
    db $47, $78, $47, $D0, $4E, $D8, $4E, $78, $55, $10, $5A, $A0, $53, $B0, $53, $F8
    db $4A, $40, $4D, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $F0, $45, $E0
    db $45, $E8, $45, $F0, $45, $F0, $4A, $F8, $4A, $00, $4B, $A0, $53, $A8, $53, $B0
    db $53, $F8, $4A, $40, $4D, $E0, $45, $E8, $45, $F0, $45, $E0, $45, $E8, $45, $18
    db $46, $10, $46, $48, $47, $18, $48, $60, $47, $68, $47, $10, $48, $78, $47, $D0
    db $45, $70, $55, $F0, $4A, $18, $5A, $08, $4B, $10, $4B, $20, $5A, $F0, $4A, $28
    db $5A, $F0, $45, $08, $4D, $10, $4D, $98, $47, $D8, $47, $D8, $4A, $E0, $4A, $E0
    db $45, $E8, $45, $F0, $45, $40, $4A, $E8, $45, $F0, $45, $18, $46, $10, $46, $C8
    db $47, $D0, $47, $98, $47, $D8, $47, $D8, $47, $B8, $47, $58, $4C, $18, $52, $B0
    db $4E, $A8, $47, $B0, $47, $00, $52, $20, $52, $C0, $46, $20, $47, $B8, $49, $C0
    db $49, $C0, $49, $28, $54, $98, $57, $A0, $57, $A8, $57, $38, $47, $40, $47, $48
    db $54, $E0, $49, $F0, $48, $18, $49, $28, $4D, $60, $47, $68, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $A8, $47, $B0, $47, $50, $55, $58
    db $55, $A8, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $30, $48, $B0, $58, $F8, $51, $A0, $47, $A0, $47, $E0
    db $47, $E8, $47, $30, $5A, $70, $4F, $18, $56, $50, $54, $58, $54, $60, $54, $98
    db $4B, $88, $4D, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $50
    db $46, $58, $46, $48, $46, $90, $4B, $98, $4B, $A0, $4B, $50, $54, $58, $54, $60
    db $54, $98, $4B, $88, $4D, $50, $46, $58, $46, $48, $46, $50, $46, $58, $46, $88
    db $46, $78, $46, $48, $47, $50, $47, $98, $47, $D8, $47, $B8, $47, $78, $47, $28
    db $46, $10, $56, $90, $4B, $38, $5A, $A8, $4B, $B0, $4B, $40, $5A, $90, $4B, $98
    db $4B, $48, $46, $30, $4D, $38, $4D, $60, $47, $68, $47, $80, $4B, $88, $4B, $50
    db $46, $58, $46, $48, $46, $50, $46, $58, $46, $48, $46, $88, $46, $78, $46, $C8
    db $47, $D0, $47, $60, $47, $68, $47, $68, $47, $E0, $47, $C0, $4C, $A0, $52, $F0
    db $48, $A8, $52, $B0, $52, $F8, $48, $10, $4A, $48, $47, $50, $47, $48, $5A, $50
    db $5A, $58, $5A, $60, $5A, $D0, $57, $D8, $57, $F8, $54, $00, $55, $58, $49, $80
    db $45, $88, $45, $98, $45, $B0, $4C, $B8, $4C, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $30, $48, $A0, $47, $E8, $55, $68
    db $5A, $30, $48, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $A8, $47, $C0, $58, $C8, $58, $B0, $47, $B0, $47, $18
    db $47, $08, $47, $C0, $46, $20, $47, $F0, $4B, $28, $55, $28, $55, $30, $55, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0
    db $46, $E8, $46, $E0, $46, $E8, $46, $E8, $46, $38, $4F, $28, $55, $28, $55, $40
    db $4F, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $E0, $46, $18
    db $47, $08, $47, $C0, $46, $10, $47, $60, $47, $68, $47, $68, $4A, $08, $47, $C0
    db $46, $20, $47, $E0, $46, $38, $4F, $E0, $46, $E8, $46, $40, $4F, $E0, $46, $E8
    db $46, $E0, $46, $E0, $46, $E8, $46, $98, $47, $D8, $47, $E0, $46, $E0, $46, $E0
    db $46, $E8, $46, $E8, $46, $E0, $46, $E8, $46, $E8, $46, $18, $47, $08, $47, $C0
    db $46, $20, $47, $98, $47, $D8, $47, $98, $47, $70, $4A, $78, $4A, $98, $45, $A0
    db $45, $08, $53, $10, $53, $C0, $45, $B8, $45, $C8, $47, $D0, $47, $70, $5A, $78
    db $5A, $80, $5A, $88, $5A, $A0, $55, $A8, $55, $B0, $55, $B8, $55, $C0, $55, $D0
    db $45, $D8, $45, $E8, $45, $08, $4D, $10, $4D, $60, $47, $68, $47, $60, $47, $68
    db $47, $B8, $47, $78, $47, $48, $47, $90, $47, $B8, $4B, $C0, $4B, $C8, $4B, $B8
    db $57, $A0, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $98, $47, $A0, $47, $90, $5A, $10, $59, $18, $59, $20, $59, $80
    db $48, $48, $4C, $50, $4C, $D0, $47, $A0, $65, $A8, $65, $60, $47, $E8, $46, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $68, $47, $E0, $46, $C0, $65, $C8, $65, $E8
    db $46, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $E0
    db $47, $48, $4C, $50, $4C, $18, $48, $98, $47, $D8, $47, $10, $48, $48, $4C, $28
    db $52, $D0, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $60, $47, $68, $47, $60, $47, $68, $47, $B8, $47, $98, $5A, $28
    db $52, $50, $47, $60, $47, $68, $47, $60, $47, $D8, $4A, $E0, $4A, $E8, $45, $F0
    db $45, $B8, $53, $C0, $53, $18, $46, $10, $46, $C0, $46, $20, $47, $E0, $46, $E8
    db $46, $E0, $46, $E8, $46, $70, $4A, $78, $4A, $20, $56, $C0, $45, $C8, $45, $28
    db $46, $80, $46, $58, $46, $30, $4D, $38, $4D, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $E0, $47, $E8, $47, $C8, $47, $18, $48, $30, $51, $38, $51, $98, $56, $A0
    db $5A, $A8, $5A, $B0, $5A, $30, $48, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $30, $48, $B8, $5A, $C0, $5A, $C8, $5A, $60, $59, $68, $59, $90, $51, $D0
    db $5A, $78, $4A, $B0, $4C, $B8, $4C, $B0, $65, $B8, $65, $60, $47, $68, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $D8, $47, $98, $47, $D0, $65, $D8, $65, $68
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $D8, $47, $70
    db $4A, $78, $4A, $B0, $4C, $B8, $4C, $60, $47, $68, $47, $70, $4A, $78, $4A, $B0
    db $4C, $B8, $4C, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $70, $4A, $78, $4A, $B0
    db $4C, $B8, $4C, $98, $47, $D8, $47, $60, $47, $80, $4B, $88, $4B, $58, $46, $48
    db $46, $68, $54, $70, $54, $88, $46, $78, $46, $48, $47, $50, $47, $B8, $49, $C0
    db $49, $B8, $49, $C0, $49, $D8, $4A, $E0, $4A, $80, $56, $18, $46, $20, $46, $C0
    db $46, $10, $47, $E0, $46, $E0, $46, $E8, $46, $D8, $47, $D8, $47, $60, $47, $68
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $98, $59, $A0, $59, $B0, $51, $D8
    db $5A, $E0, $5A, $E8, $5A, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $98, $47, $E0, $5A, $E8, $5A, $F0, $5A, $A8, $59, $58, $58, $60, $58, $D8
    db $4A, $E0, $4A, $08, $4D, $10, $4D, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $4A, $E0, $4A, $08, $4D, $10, $4D, $98, $47, $D8, $47, $D8, $4A, $E0, $4A, $08
    db $4D, $10, $4D, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $D8, $4A, $E0, $4A, $08
    db $4D, $10, $4D, $98, $47, $D8, $47, $98, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $48, $4A, $50
    db $4A, $48, $4A, $50, $4A, $80, $4B, $88, $4B, $D0, $56, $88, $46, $B8, $46, $48
    db $47, $80, $47, $60, $47, $98, $47, $D8, $47, $68, $47, $68, $47, $98, $47, $D8
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $F8, $5A, $00, $5B, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $60, $47, $F8, $5A, $00, $5B, $68, $47, $60, $47, $60, $47, $68, $47, $80
    db $4B, $88, $4B, $30, $4D, $38, $4D, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $80
    db $4B, $88, $4B, $30, $4D, $38, $4D, $68, $53, $60, $53, $80, $4B, $88, $4B, $30
    db $4D, $38, $4D, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $80, $4B, $88, $4B, $30
    db $4D, $38, $4D, $60, $47, $60, $53, $68, $53, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $18, $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8
    db $47, $60, $47, $68, $47, $E0, $46, $E0, $46, $E8, $46, $18, $47, $08, $47, $C8
    db $47, $D0, $47, $98, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $E0, $47, $E8, $47, $C8, $47, $D0, $47, $08, $5B, $10, $5B, $18, $5B, $08
    db $5B, $10, $5B, $18, $5B, $20, $5B, $28, $5B, $30, $5B, $08, $5B, $10, $5B, $18
    db $5B, $38, $5B, $40, $5B, $18, $5B, $08, $5B, $10, $5B, $18, $5B, $08, $5B, $10
    db $5B, $18, $5B, $08, $5B, $10, $5B, $18, $5B, $08, $5B, $10, $5B, $18, $5B, $08
    db $5B, $10, $5B, $48, $5B, $50, $5B, $58, $5B, $18, $5B, $08, $5B, $10, $5B, $18
    db $5B, $08, $5B, $10, $5B, $18, $5B, $08, $5B, $10, $5B, $18, $5B, $08, $5B, $10
    db $5B, $18, $5B, $08, $5B, $10, $5B, $18, $5B, $08, $5B, $10, $5B, $18, $5B, $10
    db $5B, $18, $5B, $08, $5B, $10, $5B, $18, $5B, $08, $5B, $10, $5B, $18, $5B, $08
    db $5B, $10, $5B, $18, $5B, $08, $5B, $10, $5B, $60, $5B, $50, $5B, $58, $5B, $18
    db $5B, $08, $5B, $10, $5B, $18, $5B, $20, $5B, $28, $5B, $68, $5B, $08, $5B, $10
    db $5B, $18, $5B, $08, $5B, $28, $5B, $68, $5B, $70, $5B, $10, $5B, $18, $5B, $08
    db $5B, $10, $5B, $18, $5B, $38, $5B, $40, $5B, $18, $5B, $08, $5B, $78, $5B, $80
    db $5B, $D8, $47, $98, $47, $B8, $47, $58, $4C, $60, $49, $E0, $4C, $B8, $48, $B0
    db $4E, $A8, $47, $B0, $47, $00, $52, $B0, $48, $58, $48, $88, $49, $58, $49, $C0
    db $46, $10, $47, $60, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $18, $47, $08, $47, $C0, $46, $20, $47, $88, $5B, $90, $5B, $98, $5B, $88
    db $5B, $90, $5B, $98, $5B, $A0, $5B, $A8, $5B, $B0, $5B, $88, $5B, $90, $5B, $B8
    db $5B, $C0, $5B, $C8, $5B, $98, $5B, $88, $5B, $90, $5B, $98, $5B, $88, $5B, $90
    db $5B, $98, $5B, $88, $5B, $90, $5B, $98, $5B, $88, $5B, $90, $5B, $98, $5B, $88
    db $5B, $90, $5B, $D0, $5B, $D8, $5B, $E0, $5B, $E8, $5B, $88, $5B, $90, $5B, $98
    db $5B, $88, $5B, $90, $5B, $98, $5B, $88, $5B, $90, $5B, $98, $5B, $88, $5B, $90
    db $5B, $98, $5B, $88, $5B, $90, $5B, $98, $5B, $88, $5B, $90, $5B, $98, $5B, $90
    db $5B, $98, $5B, $88, $5B, $90, $5B, $98, $5B, $88, $5B, $90, $5B, $98, $5B, $88
    db $5B, $90, $5B, $98, $5B, $88, $5B, $90, $5B, $F0, $5B, $F8, $5B, $00, $5C, $98
    db $5B, $88, $5B, $90, $5B, $98, $5B, $A0, $5B, $A8, $5B, $08, $5C, $88, $5B, $90
    db $5B, $98, $5B, $88, $5B, $10, $5C, $18, $5C, $20, $5C, $28, $5C, $98, $5B, $88
    db $5B, $90, $5B, $98, $5B, $30, $5C, $38, $5C, $98, $5B, $88, $5B, $40, $5C, $48
    db $5C, $68, $47, $60, $47, $E0, $47, $C0, $4C, $C8, $4C, $E0, $49, $F0, $48, $E8
    db $49, $F0, $49, $F8, $49, $00, $4A, $F8, $48, $F0, $48, $E0, $49, $10, $4A, $48
    db $47, $80, $47, $98, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $B8, $47, $78, $47, $48, $47, $50, $47, $50, $5C, $58, $5C, $60, $5C, $50
    db $5C, $58, $5C, $60, $5C, $68, $5C, $F8, $5B, $70, $5C, $50, $5C, $58, $5C, $78
    db $5C, $80, $5C, $88, $5C, $60, $5C, $50, $5C, $58, $5C, $60, $5C, $50, $5C, $58
    db $5C, $60, $5C, $50, $5C, $58, $5C, $60, $5C, $50, $5C, $58, $5C, $60, $5C, $50
    db $5C, $58, $5C, $90, $5C, $98, $5C, $18, $5C, $A0, $5C, $A8, $5C, $58, $5C, $60
    db $5C, $50, $5C, $58, $5C, $60, $5C, $50, $5C, $58, $5C, $60, $5C, $50, $5C, $58
    db $5C, $60, $5C, $50, $5C, $58, $5C, $60, $5C, $50, $5C, $58, $5C, $60, $5C, $58
    db $5C, $60, $5C, $50, $5C, $58, $5C, $60, $5C, $50, $5C, $58, $5C, $60, $5C, $50
    db $5C, $58, $5C, $60, $5C, $50, $5C, $58, $5C, $78, $5C, $80, $5C, $B0, $5C, $60
    db $5C, $50, $5C, $58, $5C, $60, $5C, $C0, $5B, $C8, $5B, $B8, $5C, $50, $5C, $58
    db $5C, $60, $5C, $50, $5C, $C0, $5C, $C8, $5C, $18, $5C, $D0, $5C, $D8, $5C, $50
    db $5C, $58, $5C, $E0, $5C, $30, $5C, $38, $5C, $60, $5C, $50, $5C, $E8, $5C, $F0
    db $5C, $D8, $47, $98, $47, $F8, $5C, $00, $5D, $90, $45, $90, $4A, $18, $4D, $30
    db $49, $F8, $59, $F0, $59, $A8, $4A, $90, $4A, $18, $4D, $C0, $45, $B8, $45, $C8
    db $47, $D0, $47, $60, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $E0, $47, $48, $4C, $50, $4C, $D0, $47, $08, $5D, $08, $5D, $08, $5D, $08
    db $5D, $08, $5D, $08, $5D, $10, $5D, $18, $5D, $18, $5C, $20, $5D, $08, $5D, $18
    db $5D, $18, $5C, $20, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08
    db $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08
    db $5D, $08, $5D, $08, $5D, $10, $5D, $28, $5D, $18, $5C, $30, $5D, $08, $5D, $08
    db $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08
    db $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $08, $5D, $38
    db $5D, $40, $5D, $48, $5D, $50, $5D, $08, $5D, $08, $5D, $38, $5D, $40, $5D, $48
    db $5D, $50, $5D, $08, $5D, $08, $5D, $08, $5D, $18, $5D, $18, $5C, $20, $5D, $08
    db $5D, $08, $5D, $08, $5D, $08, $5D, $30, $5C, $38, $5C, $58, $5D, $08, $5D, $38
    db $5D, $40, $5D, $48, $5D, $50, $5D, $10, $5D, $28, $5D, $18, $5C, $30, $5D, $08
    db $5D, $08, $5D, $60, $5D, $68, $5D, $70, $5D, $08, $5D, $08, $5D, $78, $5D, $78
    db $5D, $68, $47, $60, $47, $80, $5D, $88, $5D, $E0, $45, $F8, $4A, $40, $4D, $78
    db $55, $90, $5D, $10, $5A, $B0, $53, $F8, $4A, $40, $4D, $18, $46, $10, $46, $C0
    db $46, $10, $47, $98, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $70, $4A, $78, $4A, $B0, $4C, $B8, $4C, $98, $5D, $A0, $5D, $98, $5D, $A0
    db $5D, $98, $5D, $A0, $5D, $98, $5D, $A0, $5D, $98, $5D, $A0, $5D, $98, $5D, $A0
    db $5D, $98, $5D, $A0, $5D, $98, $5D, $A0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0
    db $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0
    db $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0
    db $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0
    db $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $B8
    db $47, $78, $47, $48, $47, $90, $47, $B8, $5D, $C0, $5D, $88, $47, $78, $47, $48
    db $47, $90, $47, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8
    db $5D, $B0, $5D, $A8, $5D, $B0, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $68
    db $4A, $08, $47, $C0, $46, $20, $47, $B0, $5D, $C8, $5D, $D0, $5D, $C8, $5D, $B0
    db $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $A8, $5D, $B0, $5D, $D8, $5D, $E0
    db $5D, $98, $47, $D8, $47, $E8, $5D, $F0, $5D, $50, $46, $98, $4B, $88, $4D, $18
    db $56, $50, $54, $58, $54, $60, $54, $98, $4B, $88, $4D, $88, $46, $78, $46, $48
    db $47, $80, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98, $47, $98, $47, $D8
    db $47, $D8, $4A, $E0, $4A, $08, $4D, $10, $4D, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $E0
    db $47, $E8, $47, $C8, $47, $18, $48, $60, $47, $68, $47, $10, $48, $E8, $47, $C8
    db $47, $18, $48, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60
    db $47, $68, $47, $60, $47, $68, $47, $68, $47, $60, $47, $68, $47, $60, $47, $70
    db $47, $78, $47, $48, $47, $50, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $F8, $5D, $00
    db $5E, $98, $47, $D8, $47, $08, $5E, $10, $5E, $E0, $46, $E0, $46, $E8, $46, $E8
    db $4D, $28, $55, $28, $55, $F0, $4D, $E0, $46, $E8, $46, $18, $47, $08, $47, $C8
    db $47, $D0, $47, $98, $47, $D8, $47, $60, $47, $68, $47, $60, $47, $60, $47, $68
    db $47, $80, $4B, $88, $4B, $30, $4D, $38, $4D, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $60, $47, $68
    db $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $18
    db $47, $08, $47, $C0, $46, $20, $47, $98, $47, $D8, $47, $18, $47, $08, $47, $C0
    db $46, $20, $47, $58, $52, $18, $5E, $98, $47, $D8, $47, $98, $47, $D8, $47, $60
    db $47, $68, $47, $68, $47, $60, $47, $68, $47, $60, $47, $68, $47, $60, $47, $E0
    db $47, $E8, $47, $C8, $47, $D0, $47, $68, $47, $98, $47, $D8, $47, $60, $47, $68
    db $47, $98, $47, $D8, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $60, $47, $68
    db $47, $98, $47, $D8, $47, $20, $5E, $28, $5E, $60, $47, $68, $47, $60, $47, $E0
    db $65, $E8, $65, $68, $47, $60, $47, $68, $47, $68, $47, $B8, $47, $78, $47, $C0
    db $46, $20, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $E0, $46, $E8, $46, $E0, $46, $E8, $46, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $60, $47, $68, $47, $60, $47, $68
    db $47, $98, $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $98, $47, $D8, $47, $B8
    db $47, $78, $47, $48, $47, $50, $47, $60, $47, $68, $47, $B8, $47, $78, $47, $48
    db $47, $50, $47, $30, $5E, $38, $5E, $60, $47, $68, $47, $98, $47, $D8, $47, $98
    db $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $98, $47, $18
    db $47, $08, $47, $C0, $46, $20, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8, $47, $98, $47, $D8
    db $47, $98, $47, $D8, $47, $60, $47, $68, $47, $98, $47, $D8, $47, $98, $47, $F0
    db $65, $F8, $65, $D8, $47, $98, $47, $98, $47, $D8, $47, $E0, $47, $E8, $47, $60
    db $49, $E0, $4C, $B8, $48, $A8, $48, $A0, $48, $A8, $48, $A0, $48, $A8, $48, $A0
    db $48, $A8, $48, $A0, $48, $A8, $48, $A0, $48, $B8, $48, $B0, $48, $B8, $48, $B0
    db $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0
    db $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $50, $48, $58, $48, $50, $48, $58
    db $48, $B8, $48, $B0, $48, $A8, $48, $A0, $48, $B0, $48, $B8, $48, $B0, $48, $B8
    db $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8
    db $48, $B0, $48, $A8, $48, $A0, $48, $A8, $48, $A0, $48, $A8, $48, $A0, $48, $A8
    db $48, $A0, $48, $A8, $48, $A0, $48, $A8, $48, $A0, $48, $B8, $48, $B0, $48, $38
    db $59, $38, $53, $58, $53, $D0, $47, $98, $47, $D8, $47, $E0, $47, $48, $4C, $40
    db $53, $30, $59, $80, $49, $60, $48, $80, $49, $60, $48, $B8, $48, $B0, $48, $B8
    db $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $A0, $48, $88
    db $49, $58, $49, $60, $49, $68, $49, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0
    db $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0, $48, $B8, $48, $B0
    db $48, $B8, $48, $B0, $48, $A0, $48, $A8, $48, $A0, $48, $A8, $48, $A0, $48, $A8
    db $48, $A0, $48, $A8, $48, $A0, $48, $B8, $48, $B0, $48, $40, $5E, $48, $5E, $E0
    db $49, $30, $49, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $70
    db $45, $50, $5E, $90, $59, $20, $47, $60, $47, $68, $47, $18, $47, $58, $5E, $60
    db $5E, $78, $45, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $70
    db $45, $78, $45, $70, $45, $78, $45, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $F8
    db $48, $F0, $48, $F8, $48, $F0, $48, $F8, $48, $F0, $48, $E0, $49, $30, $49, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $70, $5E, $48, $47, $50, $47, $98, $47, $D8, $47, $B8, $47, $78, $47, $78
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $70, $5E, $C8, $47, $D0, $47, $68, $53, $60, $53, $E0, $47, $E8, $47, $78
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68
    db $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $68, $5E, $01
    db $00, $00, $2F, $19, $00, $2C, $19, $A8, $28, $C2, $64, $00, $A8, $CE, $32, $C2
    db $24, $A8, $68, $A8, $28, $C2, $64, $E2, $32, $C2, $24, $00, $A8, $C8, $28, $C8
    db $68, $00, $A8, $C8, $28, $C8, $68, $C8, $28, $C8, $68, $C8, $28, $0C, $24, $0E
    db $24, $A4, $3C, $A4, $3C, $00, $A8, $00, $A8, $00, $A8, $2A, $24, $2C, $24, $4A
    db $3E, $4C, $3E, $4A, $3E, $4C, $3E, $00, $A8, $00, $A8, $0A, $3E, $00, $A8, $00
    db $A8, $00, $A8, $00, $A8, $44, $24, $46, $24, $08, $3E, $00, $A8, $0A, $7E, $0A
    db $3E, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $62, $24, $64, $24, $08
    db $3E, $00, $A8, $0A, $7E, $0A, $3E, $E4, $12, $60, $11, $62, $11, $00, $A8, $00
    db $A8, $00, $A8, $80, $24, $82, $24, $84, $24, $08, $3E, $00, $A8, $00, $A8, $60
    db $11, $62, $11, $60, $11, $62, $11, $E4, $52, $0A, $7E, $0A, $3E, $E6, $12, $6E
    db $11, $80, $11, $00, $A8, $00, $A8, $0C, $05, $00, $A8, $E4, $52, $08, $3E, $E4
    db $12, $00, $A8, $00, $A8, $6E, $11, $80, $11, $E6, $52, $0A, $7E, $0A, $3E, $00
    db $A8, $00, $A8, $00, $A8, $00, $A8, $E6, $52, $08, $3E, $E6, $12, $E4, $52, $E4
    db $12, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $0A, $7E, $0A, $3E, $00
    db $A8, $00, $A8, $00, $A8, $08, $3E, $2E, $25, $40, $25, $40, $65, $2E, $65, $E6
    db $52, $E6, $12, $00, $A8, $00, $A8, $00, $A8, $CC, $7D, $0E, $64, $0C, $64, $A6
    db $3C, $A4, $3C, $A6, $3C, $0C, $24, $0E, $24, $CC, $3D, $E4, $52, $0A, $7E, $24
    db $7E, $A6, $3C, $A4, $3C, $A6, $3C, $A4, $3C, $A6, $3C, $CC, $3D, $00, $A8, $40
    db $25, $E8, $7D, $2C, $64, $2A, $64, $00, $A8, $00, $A8, $2A, $24, $2C, $24, $E8
    db $3D, $40, $65, $2E, $65, $2E, $7E, $00, $A8, $00, $A8, $2E, $65, $28, $7D, $A4
    db $3C, $24, $3E, $24, $7E, $A6, $3C, $28, $3D, $A4, $3C, $A4, $3C, $A6, $3C, $26
    db $3E, $46, $64, $44, $64, $E0, $12, $CC, $12, $00, $A8, $00, $A8, $CC, $12, $E0
    db $12, $E4, $12, $00, $A8, $28, $7D, $A4, $3C, $A6, $3C, $28, $3D, $00, $A8, $E8
    db $3D, $EA, $3D, $64, $64, $62, $64, $00, $A8, $E2, $12, $CE, $12, $00, $A8, $00
    db $A8, $CE, $12, $E2, $12, $E4, $52, $00, $A8, $00, $A8, $CC, $12, $00, $A8, $00
    db $A8, $00, $A8, $00, $A8, $00, $A8, $84, $64, $82, $64, $80, $64, $2A, $35, $2C
    db $35, $00, $A8, $00, $A8, $CE, $12, $00, $A8, $00, $A8, $42, $2E, $00, $A8, $00
    db $A8, $00, $A8, $00, $A8, $0C, $45, $6E, $11, $80, $11, $0C, $05, $00, $A8, $00
    db $A8, $00, $A8, $48, $35, $4A, $35, $48, $56, $48, $16, $00, $A8, $00, $A8, $00
    db $A8, $00, $A8, $4E, $2E, $00, $A8, $00, $A8, $64, $35, $66, $35, $68, $35, $6A
    db $35, $64, $56, $64, $16, $6E, $0E, $6E, $0E, $00, $A8, $82, $15, $00, $A8, $00
    db $A8, $88, $15, $2E, $25, $40, $25, $E8, $7D, $E8, $3D, $40, $65, $6A, $3E, $6C
    db $3E, $26, $7E, $28, $3D, $28, $7D, $E4, $30, $E6, $30, $00, $A8, $00, $A8, $00
    db $A8, $A8, $15, $08, $7E, $E0, $12, $00, $A8, $00, $A8, $40, $6E, $2E, $7E, $04
    db $31, $06, $31, $A4, $3C, $28, $3D, $00, $A8, $00, $A8, $E2, $12, $00, $A8, $00
    db $A8, $00, $A8, $E8, $7D, $2E, $65, $00, $A8, $00, $A8, $00, $A8, $42, $2E, $42
    db $6E, $28, $7D, $E2, $55, $E2, $15, $48, $16, $60, $11, $62, $11, $00, $A8, $4E
    db $2E, $4E, $6E, $2E, $25, $02, $56, $02, $16, $64, $16, $80, $11, $00, $A8, $CC
    db $7D, $6A, $3E, $6C, $3E, $6E, $0E, $6E, $4E, $A4, $3C, $40, $2E, $2A, $35, $2C
    db $35, $40, $25, $2E, $25, $40, $25, $40, $65, $2E, $65, $40, $2E, $48, $35, $4A
    db $35, $40, $6E, $00, $A8, $08, $3E, $0A, $3E, $08, $3E, $0A, $3E, $00, $A8, $64
    db $35, $66, $35, $68, $35, $6A, $35, $28, $3D, $40, $6E, $00, $A8, $08, $3E, $0A
    db $3E, $00, $A8, $82, $15, $EA, $7D, $E8, $7D, $24, $3E, $24, $7E, $24, $3E, $24
    db $7E, $CC, $7D, $0C, $24, $0E, $24, $CC, $3D, $6E, $0E, $6E, $4E, $00, $A8, $28
    db $7D, $A4, $3C, $A6, $3C, $28, $3D, $00, $A8, $40, $2E, $00, $A8, $2E, $7E, $2E
    db $3E, $00, $A8, $28, $7D, $00, $A8, $42, $2E, $00, $A8, $42, $2E, $00, $A8, $40
    db $2E, $00, $A8, $00, $A8, $CE, $44, $2A, $35, $2C, $35, $2C, $75, $2A, $75, $CC
    db $3D, $4C, $3E, $4E, $2E, $00, $A8, $00, $A8, $4E, $2E, $4A, $3E, $40, $2E, $48
    db $35, $4A, $35, $4A, $75, $48, $75, $0A, $3E, $00, $A8, $6E, $0E, $08, $3E, $20
    db $45, $0E, $45, $0C, $45, $64, $35, $66, $35, $68, $35, $6A, $35, $00, $A8, $00
    db $A8, $00, $A8, $00, $A8, $00, $A8, $6A, $75, $68, $75, $66, $75, $64, $75, $0C
    db $05, $62, $11, $0A, $3E, $08, $3E, $82, $35, $84, $35, $86, $35, $88, $35, $00
    db $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $88, $75, $86, $75, $84, $75, $82
    db $75, $80, $11, $A2, $35, $A4, $35, $A6, $35, $A8, $35, $00, $A8, $A8, $75, $A6
    db $75, $A4, $75, $A2, $75, $00, $A8, $2C, $75, $2A, $75, $28, $7D, $28, $3D, $28
    db $7D, $24, $7E, $24, $3E, $6C, $3E, $00, $A8, $00, $A8, $00, $A8, $4A, $75, $48
    db $75, $60, $11, $62, $11, $46, $7D, $00, $A8, $2E, $7E, $28, $7D, $A6, $3C, $28
    db $3D, $C4, $3C, $2E, $7E, $44, $1A, $46, $1A, $6A, $75, $68, $75, $66, $75, $64
    db $75, $6E, $11, $E0, $12, $C4, $7C, $C4, $3C, $C6, $3C, $C4, $3C, $60, $1A, $62
    db $1A, $0E, $64, $0C, $64, $0C, $24, $0E, $24, $24, $3E, $24, $7E, $0E, $64, $0C
    db $64, $26, $3E, $00, $A8, $00, $A8, $28, $3D, $88, $55, $86, $55, $84, $55, $82
    db $55, $E2, $12, $6C, $29, $6C, $29, $42, $6E, $44, $1A, $46, $1A, $2C, $24, $2C
    db $64, $2A, $24, $2C, $24, $E8, $3D, $EA, $3D, $C6, $51, $C6, $11, $E2, $51, $E2
    db $11, $A4, $3C, $A6, $3C, $A8, $55, $A6, $55, $A4, $55, $A2, $55, $E8, $7D, $6C
    db $29, $6C, $29, $4E, $6E, $60, $1A, $62, $1A, $44, $24, $CA, $51, $CA, $11, $00
    db $A8, $02, $52, $02, $12, $0A, $3E, $00, $A8, $4E, $04, $4E, $44, $48, $56, $48
    db $16, $C6, $55, $C6, $15, $00, $A8, $00, $A8, $28, $7D, $A6, $7C, $48, $56, $48
    db $16, $E2, $55, $E2, $15, $8A, $35, $6E, $4E, $00, $A8, $00, $A8, $00, $A8, $2A
    db $35, $2C, $35, $00, $A8, $0A, $3E, $00, $A8, $42, $2E, $64, $56, $64, $16, $CA
    db $55, $CA, $15, $2E, $25, $40, $25, $00, $A8, $00, $A8, $E8, $3D, $64, $56, $64
    db $16, $02, $56, $02, $16, $48, $35, $4A, $35, $E0, $75, $CE, $75, $0A, $3E, $00
    db $A8, $4E, $2E, $00, $A8, $6A, $35, $00, $A8, $00, $A8, $00, $76, $EE, $75, $66
    db $75, $64, $75, $6E, $0E, $00, $A8, $00, $A8, $6E, $4E, $00, $A8, $82, $35, $84
    db $35, $86, $35, $00, $A8, $00, $A8, $84, $75, $82, $75, $2C, $75, $2A, $75, $00
    db $A8, $0E, $64, $0C, $64, $0E, $24, $A2, $35, $48, $75, $00, $A8, $E8, $7D, $2C
    db $64, $2A, $64, $E8, $3D, $6A, $75, $68, $75, $66, $75, $44, $24, $2C, $75, $2A
    db $75, $2C, $35, $88, $55, $00, $A8, $00, $A8, $82, $55, $4A, $75, $48, $75, $4A
    db $35, $00, $A8, $00, $A8, $00, $A8, $68, $75, $6A, $35, $E2, $55, $E2, $15, $00
    db $A8, $00, $A8, $22, $56, $22, $16, $88, $75, $86, $75, $88, $35, $48, $52, $48
    db $12, $22, $52, $22, $12, $02, $56, $02, $16, $2C, $56, $2C, $16, $A8, $75, $A6
    db $75, $A4, $75, $A2, $75, $A8, $35, $64, $52, $64, $12, $2C, $52, $2C, $12, $60
    db $11, $62, $11, $2A, $35, $2C, $35, $2C, $75, $48, $35, $4A, $75, $48, $75, $6A
    db $35, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $6A, $75, $68
    db $75, $66, $75, $64, $75, $28, $7D, $A4, $3C, $A6, $3C, $00, $A8, $86, $35, $00
    db $A8, $00, $A8, $86, $75, $84, $75, $2E, $3E, $28, $7D, $28, $3D, $2E, $3E, $EA
    db $3D, $A2, $35, $A4, $35, $A6, $75, $A4, $75, $C6, $3C, $C4, $3C, $C6, $3C, $C6
    db $7C, $C6, $3C, $C4, $3C, $C6, $7C, $00, $A8, $00, $A8, $C6, $3C, $CC, $12, $6C
    db $29, $42, $2E, $42, $6E, $CE, $12, $0A, $3E, $4E, $2E, $4E, $6E, $E2, $55, $E2
    db $15, $22, $56, $22, $16, $4A, $35, $02, $56, $02, $16, $2C, $56, $2C, $16, $6A
    db $75, $6A, $3E, $88, $35, $60, $31, $62, $31, $60, $31, $62, $31, $88, $75, $E6
    db $52, $A8, $35, $6E, $31, $80, $31, $A8, $75, $20, $08, $22, $08, $00, $A8, $00
    db $A8, $00, $A8, $00, $A8, $66, $3A, $68, $3A, $66, $3A, $68, $3A, $66, $3A, $68
    db $3A, $00, $A8, $66, $3A, $68, $3A, $00, $A8, $EA, $3A, $EC, $3A, $00, $A8, $00
    db $A8, $00, $A8, $66, $3A, $68, $3A, $28, $3B, $00, $A8, $66, $3A, $68, $3A, $26
    db $3B, $66, $3A, $68, $3A, $00, $A8, $26, $3B, $66, $3A, $68, $3A, $28, $3B, $26
    db $3B, $66, $3A, $68, $3A, $00, $A8, $66, $3A, $68, $3A, $00, $1B, $02, $1B, $00
    db $A8, $00, $A8, $00, $A8, $26, $3B, $68, $3A, $66, $3A, $68, $3A, $28, $3B, $22
    db $3B, $26, $3B, $68, $3A, $00, $A8, $28, $3B, $24, $3B, $22, $3B, $26, $3B, $68
    db $3A, $00, $A8, $00, $A8, $06, $1B, $08, $1B, $08, $05, $0A, $05, $00, $A8, $22
    db $3B, $26, $3B, $68, $3A, $26, $3B, $68, $3A, $2E, $25, $40, $25, $40, $65, $2E
    db $65, $24, $3B, $66, $3A, $68, $3A, $28, $3B, $C2, $19, $24, $05, $26, $05, $6C
    db $29, $22, $99, $22, $99, $22, $99, $22, $99, $22, $B9, $22, $B9, $22, $99, $22
    db $99, $E4, $10, $E6, $10, $42, $05, $44, $05, $04, $11, $06, $11, $02, $08, $04
    db $08, $62, $11, $20, $08, $22, $08, $6E, $11, $80, $11, $A6, $3C, $24, $3E, $E8
    db $3D, $EA, $7D, $E8, $7D, $00, $A8, $08, $3E, $0A, $3E, $4C, $29, $4E, $29, $4C
    db $29, $4E, $29, $00, $A8, $00, $A8, $4C, $29, $4E, $29, $4C, $29, $4E, $29, $C6
    db $4D, $C6, $0D, $CA, $4D, $CA, $0D, $E2, $4D, $E2, $0D, $02, $4E, $02, $0E, $48
    db $4E, $48, $0E, $64, $4E, $64, $0E, $22, $4E, $22, $0E, $2C, $4E, $2C, $0E, $E0
    db $35, $EE, $35, $00, $36, $CE, $35, $E0, $35, $EE, $35, $00, $36, $2A, $07, $2C
    db $07, $2E, $07, $40, $07, $8C, $06, $8E, $06, $A6, $06, $A8, $06, $A4, $06, $A0
    db $06, $A2, $06, $8A, $06, $A4, $06, $8A, $06, $00, $A8, $00, $A8, $00, $A8, $00
    db $76, $EE, $75, $00, $76, $EE, $75, $8E, $11, $A0, $11, $AE, $11, $C0, $11, $8E
    db $11, $A0, $11, $AE, $11, $C0, $11, $8E, $11, $A0, $11, $AE, $11, $C0, $11, $8E
    db $11, $A0, $11, $C0, $11, $A0, $11, $8E, $11, $A0, $11, $A0, $11, $AE, $11, $C0
    db $11, $8E, $11, $A0, $11, $AE, $11, $C0, $11, $66, $3A, $68, $3A, $86, $3A, $86
    db $7A, $0E, $3B, $66, $3A, $68, $3A, $26, $3B, $86, $3A, $86, $7A, $86, $3A, $86
    db $7A, $88, $3A, $88, $7A, $20, $3B, $86, $3A, $86, $7A, $00, $A8, $88, $3A, $88
    db $7A, $88, $3A, $88, $7A, $84, $3A, $84, $7A, $88, $3A, $88, $7A, $84, $3A, $84
    db $7A, $84, $3A, $84, $7A, $0E, $3B, $84, $3A, $84, $7A, $20, $3B, $00, $A8, $00
    db $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $00, $A8, $00
    db $A8, $00, $A8, $66, $3A, $68, $3A, $86, $3A, $86, $7A, $86, $3A, $86, $7A, $0E
    db $3B, $68, $3A, $86, $3A, $86, $7A, $88, $3A, $88, $7A, $88, $3A, $88, $3A, $88
    db $7A, $84, $3A, $84, $7A, $84, $3A, $84, $3A, $84, $7A, $0E, $3B, $20, $3B, $66
    db $3A, $68, $3A, $26, $3B, $66, $3A, $68, $3A, $26, $3B, $66, $3A, $86, $7A, $88
    db $7A, $86, $3A, $86, $7A, $0E, $3B, $88, $7A, $84, $7A, $88, $3A, $88, $7A, $84
    db $7A, $20, $3B, $84, $3A, $84, $7A, $20, $3B, $26, $3B, $88, $7A, $84, $3A, $86
    db $3A, $86, $7A, $86, $3A, $86, $7A, $20, $3B, $66, $3A, $68, $3A, $88, $3A, $88
    db $7A, $88, $3A, $88, $7A, $66, $3A, $68, $3A, $66, $3A, $68, $3A, $86, $3A, $86
    db $7A, $86, $3A, $88, $3A, $84, $3A, $86, $3A, $86, $7A, $86, $7A, $88, $7A, $88
    db $7A, $84, $7A, $84, $7A, $20, $3B, $2E, $65, $66, $3A, $86, $3A, $28, $3B, $88
    db $3A, $88, $7A, $20, $3B, $88, $3A, $88, $7A, $84, $3A, $84, $7A, $84, $3A, $84
    db $7A, $0E, $3B, $0E, $3B, $0E, $7B, $0E, $7B, $E0, $75, $CE, $75, $00, $76, $EE
    db $75, $86, $75, $84, $75, $8E, $11, $A0, $11, $8E, $11, $C6, $51, $C6, $11, $CA
    db $51, $CA, $11, $48, $52, $48, $12, $64, $52, $64, $12, $E2, $51, $E2, $11, $02
    db $52, $02, $12, $22, $52, $22, $12, $2C, $52, $2C, $12, $C8, $09, $C4, $09, $C4
    db $05, $C8, $05, $C4, $09, $EC, $45, $EC, $05, $C4, $05, $C8, $05, $C4, $05, $C4
    db $09, $C8, $09, $C4, $09, $C8, $05, $C4, $09, $0C, $46, $0C, $06, $C4, $05, $C4
    db $05, $C8, $05, $C4, $05, $C4, $05, $C8, $05, $E8, $08, $E8, $48, $42, $0C, $C6
    db $1C, $42, $0C, $E8, $08, $E8, $48, $42, $0C, $42, $0C, $C4, $1C, $C6, $1C, $60
    db $44, $4E, $44, $48, $04, $4A, $04, $4C, $04, $4C, $04, $4E, $04, $60, $04, $4E
    db $04, $60, $04, $6E, $44, $6C, $44, $66, $04, $68, $04, $6A, $04, $CE, $04, $E0
    db $04, $E2, $04, $6E, $04, $6C, $04, $6E, $04, $8E, $44, $8C, $44, $86, $04, $88
    db $04, $8A, $04, $86, $04, $88, $04, $EE, $04, $00, $05, $02, $05, $8E, $04, $8C
    db $44, $8C, $04, $88, $04, $8A, $04, $8A, $04, $86, $04, $8C, $04, $8E, $04, $AC
    db $44, $AA, $44, $AA, $19, $AC, $19, $AA, $19, $AC, $19, $AC, $19, $0E, $05, $20
    db $05, $AC, $04, $AA, $44, $AA, $04, $AA, $44, $2E, $18, $2E, $18, $AA, $04, $AC
    db $04, $CC, $44, $CA, $44, $2E, $18, $20, $08, $22, $08, $CA, $04, $CC, $04, $CA
    db $44, $CA, $04, $CA, $44, $02, $08, $04, $08, $20, $08, $22, $08, $CA, $04, $CC
    db $04, $EC, $44, $EA, $44, $04, $08, $EA, $04, $EC, $04, $20, $08, $20, $08, $20
    db $08, $04, $08, $EA, $04, $EA, $44, $04, $08, $02, $08, $02, $08, $22, $08, $02
    db $08, $04, $08, $02, $08, $04, $08, $04, $08, $02, $08, $04, $08, $02, $08, $EA
    db $04, $EC, $04, $AC, $44, $AA, $44, $20, $08, $22, $08, $22, $08, $20, $08, $22
    db $08, $22, $08, $22, $08, $C4, $3C, $C6, $3C, $C4, $3C, $C6, $3C, $C4, $3C, $C6
    db $3C, $C4, $3C, $C6, $3C, $22, $08, $20, $08, $C4, $1C, $C6, $3C, $E8, $3D, $22
    db $08, $02, $08, $CA, $04, $CC, $04, $CC, $44, $CA, $44, $04, $08, $04, $08, $02
    db $08, $CA, $04, $CC, $44, $4E, $44, $48, $04, $4C, $04, $48, $04, $22, $48, $20
    db $48, $4A, $04, $4A, $04, $EA, $44, $C4, $3C, $C4, $3C, $42, $2C, $42, $6C, $C6
    db $3C, $C6, $3C, $C6, $3C, $EC, $44, $E2, $44, $E0, $44, $CE, $44, $6A, $04, $66
    db $04, $04, $48, $02, $48, $68, $04, $68, $04, $AA, $04, $08, $05, $0A, $05, $4C
    db $04, $48, $24, $4A, $24, $C4, $3C, $C6, $3C, $C6, $7C, $02, $45, $00, $45, $EE
    db $44, $8A, $04, $86, $04, $24, $05, $26, $05, $6A, $04, $66, $24, $68, $24, $6A
    db $24, $E4, $25, $E6, $25, $20, $45, $0E, $45, $2E, $18, $2E, $18, $2E, $18, $2E
    db $18, $20, $05, $AA, $19, $AC, $19, $AA, $19, $AC, $19, $04, $08, $AA, $19, $42
    db $05, $44, $05, $86, $24, $88, $24, $8A, $24, $04, $26, $06, $26, $20, $08, $22
    db $08, $02, $08, $04, $08, $22, $08, $20, $08, $22, $08, $20, $08, $AC, $59, $02
    db $08, $84, $15, $86, $15, $04, $08, $04, $08, $02, $08, $46, $4D, $C6, $1C, $02
    db $08, $EC, $04, $EC, $44, $CC, $04, $20, $08, $22, $08, $22, $08, $20, $08, $A2
    db $15, $A4, $15, $A6, $15, $22, $08, $60, $44, $48, $04, $0A, $45, $08, $45, $EC
    db $04, $C4, $3C, $04, $08, $02, $08, $CA, $44, $AA, $19, $AA, $19, $AC, $19, $66
    db $04, $26, $45, $24, $45, $4C, $24, $C4, $3C, $02, $08, $44, $45, $42, $45, $6A
    db $24, $68, $24, $68, $24, $04, $08, $22, $08, $02, $08, $02, $08, $AA, $19, $AC
    db $19, $8A, $24, $88, $24, $88, $24, $02, $08, $04, $08, $20, $08, $20, $08, $20
    db $08, $02, $88, $20, $08, $AC, $04, $AC, $44, $04, $08, $02, $08, $42, $6C, $EC
    db $44, $42, $45, $22, $08, $04, $08, $42, $6C, $42, $2C, $42, $2C, $42, $6C, $CC
    db $44, $AC, $19, $04, $08, $AC, $04, $AA, $24, $AC, $24, $42, $2C, $42, $6C, $AC
    db $64, $AA, $64, $02, $08, $04, $08, $20, $08, $22, $08, $22, $08, $CC, $04, $CA
    db $24, $CC, $24, $CC, $64, $CA, $64, $20, $08, $EC, $04, $46, $6D, $CC, $24, $42
    db $2C, $42, $6C, $CC, $64, $02, $08, $20, $08, $22, $08, $20, $08, $00, $A8, $00
    db $A8, $EA, $24, $46, $3D, $C4, $3C, $C6, $3C, $C6, $7C, $EA, $64, $AC, $44, $08
    db $25, $C6, $3C, $C4, $3C, $08, $65, $CA, $44, $24, $25, $26, $25, $2E, $18, $26
    db $65, $24, $65, $42, $0C, $02, $08, $04, $08, $CE, $44, $66, $04, $68, $04, $68
    db $04, $6A, $04, $04, $08, $42, $25, $44, $25, $AA, $19, $AC, $19, $44, $65, $42
    db $65, $60, $44, $86, $04, $88, $04, $88, $04, $8A, $04, $02, $08, $8C, $19, $02
    db $08, $04, $08, $AA, $44, $AA, $19, $AC, $19, $AA, $19, $AC, $19, $AA, $19, $2E
    db $18, $06, $0C, $08, $0C, $0A, $4C, $08, $4C, $06, $4C, $2E, $18, $AC, $19, $AA
    db $19, $AC, $19, $AA, $19, $44, $45, $20, $08, $22, $08, $02, $08, $04, $08, $04
    db $08, $2E, $18, $24, $0C, $26, $0C, $28, $4C, $26, $4C, $24, $4C, $2E, $18, $04
    db $08, $20, $08, $22, $08, $AA, $19, $02, $08, $04, $08, $02, $08, $2E, $18, $40
    db $10, $2E, $18, $22, $08, $20, $08, $22, $08, $20, $48, $20, $08, $02, $08, $20
    db $08, $CA, $44, $CA, $04, $20, $08, $22, $08, $CC, $44, $AA, $19, $AC, $19, $02
    db $48, $04, $48, $02, $08, $02, $08, $AA, $19, $46, $6D, $2E, $3E, $EC, $64, $C4
    db $3C, $42, $2C, $C6, $3C, $EC, $24, $C6, $3C, $02, $08, $04, $08, $02, $08, $20
    db $08, $22, $08, $02, $48, $22, $08, $4C, $24, $4A, $24, $02, $08, $04, $08, $4A
    db $64, $20, $08, $22, $08, $20, $08, $22, $08, $22, $08, $EA, $04, $EC, $04, $EC
    db $44, $EA, $44, $20, $08, $EC, $44, $22, $08, $20, $08, $02, $08, $20, $08, $22
    db $08, $02, $08, $04, $08, $6A, $24, $20, $08, $22, $08, $66, $24, $02, $08, $04
    db $08, $C4, $3C, $C6, $3C, $C4, $3C, $C6, $3C, $C4, $3C, $CC, $44, $04, $08, $02
    db $08, $22, $08, $02, $08, $42, $2C, $42, $6C, $22, $48, $02, $08, $04, $08, $22
    db $08, $C4, $2C, $AA, $99, $AC, $99, $86, $24, $AA, $19, $AC, $19, $4E, $04, $22
    db $08, $20, $08, $88, $24, $04, $08, $20, $08, $60, $64, $4E, $64, $4E, $04, $4E
    db $44, $22, $48, $20, $48, $20, $48, $22, $48, $20, $08, $22, $08, $AA, $59, $CA
    db $04, $22, $08, $20, $08, $22, $08, $20, $08, $8C, $19, $04, $08, $AA, $19, $AC
    db $19, $04, $08, $02, $08, $04, $08, $20, $08, $6E, $64, $6C, $64, $66, $24, $04
    db $48, $02, $48, $02, $48, $04, $48, $02, $48, $22, $48, $C6, $7C, $C4, $7C, $C4
    db $6C, $04, $08, $02, $08, $04, $08, $02, $08, $20, $08, $2E, $18, $2E, $18, $04
    db $08, $8E, $64, $8C, $64, $86, $24, $4A, $44, $2E, $18, $A2, $4C, $0A, $0C, $2E
    db $18, $22, $08, $20, $08, $22, $08, $AA, $19, $AA, $19, $AC, $19, $AC, $19, $68
    db $44, $20, $08, $22, $08, $20, $08, $C0, $4C, $28, $0C, $02, $08, $04, $08, $22
    db $48, $42, $05, $88, $44, $CA, $44, $02, $08, $CA, $04, $04, $08, $AC, $59, $AA
    db $59, $EC, $44, $C4, $3C, $C6, $3C, $C4, $1C, $22, $48, $20, $48, $04, $48, $4A
    db $04, $02, $08, $04, $08, $02, $08, $04, $48, $86, $55, $84, $55, $20, $48, $20
    db $08, $22, $08, $20, $08, $A6, $55, $A4, $55, $A2, $55, $04, $08, $02, $08, $20
    db $48, $22, $48, $AC, $59, $AA, $59, $20, $08, $22, $08, $20, $08, $22, $08, $20
    db $08, $22, $08, $20, $08, $22, $08, $20, $08, $02, $48, $04, $48, $02, $08, $04
    db $08, $02, $08, $04, $08, $02, $08, $04, $08, $02, $08, $04, $08, $02, $08, $04
    db $08, $20, $08, $22, $08, $20, $08, $22, $08, $20, $08, $04, $08, $02, $08, $22
    db $08, $20, $08, $22, $08, $06, $2C, $08, $2C, $0A, $2C, $06, $6C, $A0, $2C, $A2
    db $2C, $04, $08, $02, $08, $04, $08, $04, $08, $EA, $04, $EA, $44, $EA, $04, $8C
    db $19, $02, $08, $AE, $0C, $C0, $0C, $20, $08, $22, $08, $C4, $3C, $C6, $3C, $C4
    db $3C, $C6, $3C, $AC, $44, $20, $08, $22, $08, $02, $08, $04, $08, $48, $24, $04
    db $08, $00, $A8, $48, $24, $00, $A8, $00, $A8, $00, $A8, $C6, $3C, $C4, $3C, $C6
    db $3C, $4A, $24, $04, $08, $C8, $25, $C8, $25, $68, $24, $EC, $64, $C8, $25, $C8
    db $25, $04, $48, $02, $48, $04, $48, $02, $48, $22, $08, $22, $48, $20, $48, $22
    db $48, $20, $48, $04, $08, $CC, $04, $20, $08, $22, $08, $04, $08, $20, $08, $22
    db $08, $22, $08, $08, $05, $04, $08, $2E, $18, $2E, $18, $04, $08, $2E, $18, $2E
    db $18, $E8, $1A, $EA, $1A, $EC, $1A, $E8, $1A, $EA, $1A, $EC, $1A, $E8, $1A, $EA
    db $1A, $EC, $1A, $E8, $1A, $EA, $1A, $EC, $1A, $EC, $1A, $E8, $1A, $EA, $1A, $EC
    db $1A, $EE, $1A, $00, $1B, $02, $1B, $EE, $1A, $00, $1B, $02, $1B, $02, $1B, $26
    db $1B, $28, $1B, $02, $1B, $EE, $1A, $00, $1B, $02, $1B, $0E, $1B, $28, $1B, $00
    db $1B, $02, $1B, $00, $1B, $28, $1B, $EE, $1A, $00, $1B, $26, $1B, $28, $1B, $00
    db $A8, $00, $A8, $04, $1B, $06, $1B, $08, $1B, $04, $1B, $08, $1B, $08, $1B, $26
    db $1B, $06, $1B, $08, $1B, $04, $1B, $08, $1B, $04, $1B, $20, $1B, $08, $1B, $06
    db $1B, $08, $1B, $06, $1B, $08, $1B, $08, $1B, $00, $A8, $00, $A8, $08, $05, $0A
    db $05, $C2, $19, $C2, $19, $C2, $19, $C2, $19, $C2, $19, $C2, $19, $C2, $19, $C2
    db $19, $C2, $19, $C2, $19, $C2, $19, $C2, $19, $26, $1B, $C2, $19, $00, $A8, $24
    db $05, $26, $05, $02, $08, $20, $08, $22, $08, $02, $08, $04, $08, $02, $08, $04
    db $08, $02, $08, $04, $08, $02, $08, $04, $08, $42, $05, $44, $05, $20, $08, $22
    db $08, $AA, $19, $AC, $19, $04, $08, $02, $08, $04, $08, $20, $08, $22, $08, $AA
    db $04, $AC, $04, $C6, $1C, $AC, $04, $C4, $1C, $2E, $18, $2E, $18, $2E, $18, $20
    db $08, $22, $08, $AA, $99, $AC, $99, $AA, $99, $AC, $99, $04, $08, $20, $08, $02
    db $08, $04, $08, $04, $08, $02, $08, $22, $08, $20, $08, $22, $08, $02, $08, $04
    db $08, $20, $08, $22, $08, $20, $08, $04, $08, $02, $08, $22, $08, $20, $08, $04
    db $08, $20, $08, $AC, $19, $02, $08, $04, $08, $AC, $19, $04, $08, $20, $08, $22
    db $08, $80, $26, $82, $26, $04, $26, $06, $26, $AA, $99, $AC, $99, $80, $06, $82
    db $06, $02, $08, $02, $08, $04, $08, $AA, $99, $04, $08, $AA, $99, $22, $48, $04
    db $48, $AC, $59, $22, $48, $20, $48, $02, $08, $20, $08, $88, $04, $44, $45, $AA
    db $19, $AA, $19, $02, $08, $AA, $19, $22, $08, $2E, $18, $AA, $19, $AC, $19, $2E
    db $18, $20, $08, $8A, $04, $86, $04, $2E, $18, $8A, $04, $86, $04, $88, $04, $04
    db $08, $20, $08, $22, $08, $22, $08, $20, $08, $2E, $18, $AC, $19, $EA, $1A, $EC
    db $1A, $EE, $1A, $26, $1B, $04, $1B, $0A, $1B, $08, $1B, $C2, $19, $28, $1B, $C2
    db $19, $EA, $1A, $EC, $1A, $EE, $1A, $0C, $1B, $02, $1B, $0A, $1B, $08, $1B, $0C
    db $1B, $20, $1B, $C2, $19, $EA, $1A, $EC, $1A, $EE, $1A, $0C, $1B, $0A, $1B, $24
    db $1B, $20, $1B, $C2, $19, $EA, $1A, $EC, $1A, $00, $1B, $0A, $1B, $24, $1B, $C2
    db $19, $0A, $1B, $AA, $0A, $AC, $0A, $AE, $0A, $C0, $0A, $C2, $0A, $C4, $0A, $C6
    db $0A, $C8, $0A, $CA, $0A, $C2, $05, $E8, $1A, $EA, $1A, $26, $1B, $28, $1B, $08
    db $1B, $0C, $1B, $C2, $19, $C2, $19, $E8, $1A, $EA, $1A, $0C, $1B, $0A, $1B, $08
    db $1B, $E8, $1A, $EA, $1A, $0C, $1B, $0A, $1B, $08, $1B, $E8, $1A, $EA, $1A, $EE
    db $1A, $00, $1B, $EC, $1A, $E8, $1A, $02, $1B, $EE, $1A, $00, $1B, $04, $1B, $28
    db $1B, $00, $1B, $08, $1B, $EC, $1A, $E8, $1A, $02, $1B, $00, $1B, $08, $1B, $EC
    db $1A, $E8, $1A, $00, $1B, $06, $1B, $EC, $1A, $E8, $1A, $EE, $1A, $0E, $1B, $26
    db $1B, $22, $1B, $EA, $1A, $EC, $1A, $EE, $1A, $0C, $1B, $02, $1B, $04, $1B, $0A
    db $1B, $EA, $1A, $EC, $1A, $EE, $1A, $0C, $1B, $04, $1B, $0A, $1B, $26, $1B, $28
    db $1B, $0E, $1B, $0A, $1B, $0C, $1B, $0E, $1B, $0E, $1B, $20, $1B, $EE, $1A, $06
    db $1B, $EE, $1A, $06, $1B, $EE, $1A, $06, $1B, $04, $1B, $C2, $05, $0C, $1B, $C2
    db $19, $C2, $19, $C2, $19, $0E, $1B, $24, $1B, $26, $1B, $28, $1B, $C2, $19, $0E
    db $1B, $26, $1B, $28, $1B, $22, $1B, $26, $1B, $28, $1B, $24, $1B, $22, $08, $20
    db $08, $04, $08, $02, $08, $20, $08, $22, $08, $20, $08, $22, $08, $22, $08, $04
    db $08, $02, $08, $22, $08, $20, $08, $22, $08, $20, $08, $04, $08, $02, $08, $22
    db $08, $02, $08, $04, $08, $20, $08, $22, $08, $20, $08, $04, $08, $20, $08, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $90, $1F, $90, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $90, $1F, $90, $1F, $90, $1F, $90, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $90, $1A, $90, $10, $10, $10, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $90, $1F
    db $90, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $10, $10, $10, $10, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $10, $10, $00, $10, $00, $10
    db $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $10, $1F, $10, $1F, $10, $13
    db $00, $13, $00, $13, $00, $13, $00, $1F, $10, $1F, $10, $10, $13, $10, $13, $10
    db $00, $10, $00, $10, $00, $10, $00, $10, $00, $10, $00, $10, $00, $10, $00, $10
    db $00, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $00, $10, $00, $10
    db $00, $10, $00, $10, $00, $10, $13, $13, $00, $13, $00, $13, $00, $13, $00, $13
    db $00, $13, $00, $13, $00, $13, $00, $13, $00, $13, $00, $13, $00, $1F, $10, $1F
    db $10, $13, $00, $13, $00, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10
    db $00, $10, $03, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $10, $10, $10, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $13, $00, $10
    db $00, $10, $00, $13, $00, $13, $03, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $10, $10, $10, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $80, $10, $80, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $10, $80, $10, $80, $1F, $10, $1F, $10, $1F, $10, $19
    db $90, $1A, $90, $1F, $10, $1F, $10, $10, $00, $10, $00, $10, $00, $10, $00, $10
    db $50, $10, $50, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $80, $1F
    db $80, $13, $00, $13, $00, $13, $00, $10, $00, $10, $50, $10, $40, $1F, $10, $1F
    db $10, $10, $10, $1F, $10, $1F, $10, $1F, $10, $17, $10, $13, $00, $13, $00, $13
    db $00, $13, $00, $13, $00, $1F, $10, $1F, $10, $1F, $10, $10, $00, $10, $00, $13
    db $00, $13, $00, $1F, $10, $1F, $10, $1F, $10, $17, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1C, $00, $1C
    db $00, $1C, $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $13, $00, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $00, $10, $00, $10, $10, $10
    db $50, $1F, $90, $1F, $90, $1F, $10, $1F, $10, $1F, $10, $13, $00, $10, $00, $10
    db $10, $10, $50, $1A, $90, $10, $10, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $10, $00, $1F, $10, $1F, $10, $10, $00, $13, $00, $13, $00, $13, $00, $1F
    db $10, $1F, $10, $1F, $10, $10, $00, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $13, $00, $13, $00, $13, $00, $10, $00, $10
    db $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $10, $00, $10, $00, $1F, $10, $10, $00, $10, $00, $10, $00, $10
    db $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $00, $10, $00, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $10, $00, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $10, $00, $1F, $10, $1F, $10, $1F, $10, $10, $50, $10, $50, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $10, $00, $1F, $10, $1F, $10, $10, $40, $10
    db $40, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $10, $13, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $90, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1A, $90, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $00, $10
    db $00, $10, $00, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1C
    db $10, $1C, $10, $10, $00, $10, $00, $10, $00, $1F, $90, $16, $90, $13, $00, $1F
    db $10, $1F, $10, $1F, $10, $10, $00, $1F, $10, $1F, $10, $1F, $10, $10, $00, $10
    db $00, $10, $00, $13, $00, $13, $00, $13, $00, $1F, $90, $1F, $10, $1F, $10, $10
    db $00, $10, $00, $1F, $10, $10, $10, $10, $10, $10, $00, $10, $00, $10, $00, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $10, $00, $1F, $10, $10, $50, $10, $50, $10
    db $00, $18, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $00, $10, $00, $1F
    db $10, $10, $10, $10, $10, $1F, $10, $1F, $10, $13, $00, $1F, $10, $1F, $10, $1F
    db $10, $10, $50, $10, $50, $10, $50, $10, $50, $10, $80, $10, $80, $18, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $13, $00, $13, $00, $1F, $10, $10, $10, $10
    db $10, $1F, $10, $10, $50, $10, $50, $13, $00, $10, $50, $10, $50, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $10, $50, $10, $50, $10, $10, $10, $00, $1C, $00, $1C
    db $00, $1C, $00, $1F, $10, $10, $40, $10, $50, $10, $10, $10, $10, $1C, $10, $1F
    db $10, $10, $50, $10, $50, $10, $40, $10, $00, $10, $00, $10, $40, $1F, $10, $1F
    db $10, $1F, $10, $10, $50, $10, $50, $10, $10, $10, $00, $13, $00, $13, $00, $13
    db $00, $1F, $10, $1F, $10, $10, $40, $10, $50, $10, $10, $10, $10, $10, $00, $10
    db $00, $10, $00, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $13, $00, $1F
    db $10, $1F, $10, $13, $00, $13, $00, $13, $00, $13, $00, $1F, $10, $10, $90, $10
    db $90, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $10, $00, $1F, $10, $1F, $10, $1F, $10, $10, $00, $1F, $10, $1F
    db $10, $10, $00, $10, $00, $1F, $10, $1F, $10, $13, $00, $1F, $10, $10, $00, $13
    db $00, $13, $00, $1F, $10, $10, $00, $10, $00, $10, $00, $18, $10, $1F, $10, $1F
    db $10, $1F, $10, $10, $00, $10, $00, $10, $00, $1F, $10, $1F, $10, $1F, $10, $13
    db $00, $10, $00, $10, $10, $10, $00, $1C, $00, $1C, $00, $10, $50, $10, $50, $18
    db $10, $1F, $10, $17, $10, $10, $50, $10, $50, $10, $50, $10, $50, $10, $10, $10
    db $00, $10, $50, $10, $50, $18, $10, $1F, $10, $1F, $10, $1F, $10, $17, $10, $10
    db $50, $10, $50, $10, $50, $10, $50, $15, $90, $1F, $90, $10, $00, $10, $00, $10
    db $00, $10, $00, $10, $00, $10, $00, $13, $00, $13, $00, $13, $00, $13, $00, $13
    db $00, $13, $00, $13, $00, $13, $00, $13, $00, $13, $00, $13, $00, $1F, $10, $1F
    db $10, $1F, $10, $10, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $13, $00, $13, $00, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $10, $00, $10, $00, $1F, $10, $1F, $10, $10, $00, $1F, $10, $10
    db $00, $10, $00, $1F, $10, $1F, $10, $10, $00, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $10, $10, $10, $10, $10, $50, $10, $40, $10, $00, $10
    db $10, $10, $10, $10, $50, $10, $40, $10, $00, $1F, $10, $17, $00, $15, $80, $16
    db $80, $15, $80, $16, $80, $18, $00, $1F, $10, $17, $10, $19, $90, $1A, $90, $18
    db $10, $10, $10, $10, $10, $1F, $10, $1F, $10, $1F, $10, $1A, $10, $10, $50, $11
    db $50, $10, $50, $10, $50, $10, $50, $10, $50, $19, $10, $12, $50, $10, $50, $19
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $10, $10, $10, $1F
    db $10, $1A, $10, $10, $10, $10, $10, $16, $50, $10, $50, $10, $50, $19, $10, $1A
    db $10, $10, $10, $11, $10, $15, $10, $16, $50, $10, $50, $10, $50, $19, $10, $10
    db $50, $10, $50, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $16, $10, $1D
    db $10, $10, $10, $10, $10, $15, $10, $1F, $10, $16, $50, $10, $50, $19, $10, $1F
    db $10, $1F, $10, $1F, $10, $16, $50, $10, $50, $19, $10, $1A, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $16, $10, $1D, $50, $16, $50, $10
    db $50, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $10, $50, $10, $50, $15
    db $50, $1F, $10, $1F, $10, $1F, $10, $10, $00, $10, $10, $10, $10, $10, $10, $10
    db $10, $10, $50, $10, $50, $10, $50, $10, $50, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $10, $10, $10, $10, $16, $90, $10, $10, $10, $10, $1F
    db $90, $1A, $90, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $10, $00, $10, $00, $13, $00, $13, $00, $10, $00, $10, $00, $10
    db $00, $10, $00, $10, $00, $10, $00, $10, $50, $10, $50, $10, $50, $10, $50, $10
    db $50, $10, $50, $10, $50, $10, $50, $10, $50, $10, $50, $10, $50, $10, $50, $10
    db $50, $10, $50, $10, $50, $10, $50, $10, $00, $13, $00, $10, $00, $10, $00, $10
    db $00, $13, $00, $10, $00, $10, $00, $10, $00, $1F, $00, $1F, $00, $10, $00, $10
    db $00, $1F, $00, $1F, $00, $10, $10, $10, $00, $10, $00, $1F, $00, $10, $10, $10
    db $00, $10, $00, $10, $00, $10, $00, $10, $00, $13, $00, $10, $00, $13, $00, $1F
    db $10, $1F, $10, $1F, $10, $1A, $10, $1F, $10, $16, $10, $1F, $10, $1A, $10, $1F
    db $10, $1F, $10, $1F, $10, $1A, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $16, $10, $1F, $10, $1A, $10, $15, $10, $1F, $10, $19, $10, $1A
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $10, $10, $10, $10, $10, $10, $10, $10, $15
    db $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F, $10, $1F
    db $10, $10, $00, $10, $00, $10, $00, $13, $00, $1F, $00, $1F, $00, $15, $10, $16
    db $00, $15, $00, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
    db $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
    db $10, $10, $10, $03, $05, $18, $24, $64, $02, $05, $18, $24, $6B, $02, $05, $18
    db $25, $76, $02, $03, $05, $25, $36, $81, $02, $05, $25, $36, $88, $02, $05, $25
    db $37, $93, $02, $03, $05, $36, $36, $9E, $02, $05, $36, $36, $A5, $02, $05, $36
    db $37, $B0, $02, $03, $05, $71, $40, $BB, $02, $05, $71, $40, $C2, $02, $05, $71
    db $41, $CD, $02, $01, $00, $40, $24, $D8, $02, $01, $00, $4D, $24, $E3, $02, $01
    db $00, $40, $2F, $EE, $02, $01, $00, $4D, $2F, $F9, $02, $01, $02, $04, $0D, $04
    db $03, $01, $02, $04, $16, $13, $03, $01, $02, $04, $31, $22, $03, $01, $02, $04
    db $28, $31, $03, $04, $06, $40, $13, $40, $03, $0A, $40, $13, $4F, $03, $0A, $40
    db $13, $5C, $03, $0A, $40, $13, $69, $03, $04, $06, $51, $0D, $74, $03, $0A, $51
    db $0D, $83, $03, $0A, $51, $0D, $90, $03, $0A, $51, $0D, $9D, $03, $04, $06, $55
    db $26, $A8, $03, $0A, $55, $26, $B7, $03, $06, $55, $26, $C6, $03, $0A, $55, $26
    db $D3, $03, $04, $0A, $4C, $36, $DE, $03, $0A, $4C, $36, $ED, $03, $0A, $4C, $36
    db $FC, $03, $0A, $4C, $36, $09, $04, $04, $06, $66, $17, $14, $04, $0A, $66, $17
    db $23, $04, $0A, $66, $17, $30, $04, $0A, $66, $17, $3D, $04, $01, $00, $72, $32
    db $48, $04, $01, $00, $72, $29, $57, $04, $01, $00, $72, $20, $66, $04, $01, $00
    db $02, $1F, $75, $04, $01, $00, $02, $22, $80, $04, $01, $00, $0D, $14, $8B, $04
    db $01, $00, $2D, $27, $96, $04, $01, $00, $37, $27, $A1, $04, $01, $00, $4D, $05
    db $AC, $04, $01, $00, $4F, $05, $B7, $04, $01, $00, $51, $05, $C2, $04, $01, $00
    db $53, $05, $CD, $04, $01, $00, $55, $05, $D8, $04, $01, $00, $4A, $43, $E3, $04
    db $01, $00, $5C, $30, $EE, $04, $01, $00, $66, $0C, $F9, $04, $01, $00, $12, $2E
    db $04, $05, $01, $00, $1A, $2E, $0F, $05, $01, $00, $02, $05, $1A, $05, $06, $07
    db $13, $3D, $25, $05, $07, $13, $3D, $3F, $05, $07, $13, $3D, $57, $05, $07, $13
    db $3D, $6B, $05, $07, $14, $3D, $7F, $05, $07, $13, $3D, $8A, $05, $06, $06, $18
    db $3D, $AE, $05, $07, $18, $3D, $C8, $05, $07, $18, $3D, $DC, $05, $07, $18, $3D
    db $F0, $05, $07, $19, $3D, $04, $06, $07, $18, $3D, $0F, $06, $08, $07, $2A, $3D
    db $2B, $06, $07, $2C, $3F, $4C, $06, $07, $2B, $3E, $59, $06, $07, $2A, $3D, $6B
    db $06, $07, $2A, $3D, $82, $06, $07, $2A, $3D, $92, $06, $07, $2A, $3D, $9D, $06
    db $07, $2A, $3D, $A4, $06, $08, $07, $4D, $3D, $D1, $06, $07, $4D, $3D, $EB, $06
    db $07, $4D, $3D, $FA, $06, $07, $4D, $3D, $0C, $07, $07, $4D, $3D, $20, $07, $07
    db $4E, $3E, $30, $07, $07, $4E, $40, $3B, $07, $07, $4D, $3D, $42, $07, $08, $07
    db $54, $3D, $5E, $07, $07, $54, $3D, $74, $07, $07, $54, $3D, $7F, $07, $07, $54
    db $3D, $97, $07, $07, $54, $3F, $AB, $07, $07, $54, $3F, $B6, $07, $07, $54, $3F
    db $C1, $07, $07, $54, $3D, $CC, $07, $05, $07, $5B, $3D, $E8, $07, $07, $5B, $3D
    db $09, $08, $07, $5B, $3D, $1E, $08, $07, $5B, $3D, $33, $08, $07, $5B, $3D, $48
    db $08, $09, $07, $62, $3D, $75, $08, $07, $62, $3D, $8D, $08, $07, $62, $3D, $9F
    db $08, $07, $62, $3F, $AF, $08, $07, $63, $3D, $BA, $08, $07, $63, $3E, $C9, $08
    db $07, $63, $3E, $D4, $08, $07, $63, $3E, $DB, $08, $07, $62, $3D, $E2, $08, $01
    db $00, $16, $2E, $FE, $08, $01, $01, $1C, $37, $09, $09, $01, $01, $1A, $3A, $1F
    db $09, $01, $01, $11, $3A, $2A, $09, $02, $01, $03, $20, $0D, $20, $0D, $02, $02
    db $0F, $28, $19, $38, $19, $C0, $0A, $C0, $0A, $02, $02, $0F, $30, $00, $30, $00
    db $68, $0C, $68, $0C, $02, $01, $03, $A0, $04, $18, $0D, $02, $02, $0F, $10, $19
    db $10, $19, $C0, $0A, $C0, $0A, $02, $02, $0F, $30, $00, $30, $00, $68, $0C, $68
    db $0C, $02, $01, $03, $20, $0D, $20, $0D, $02, $02, $0F, $28, $19, $38, $19, $C0
    db $0A, $C0, $0A, $02, $02, $0F, $30, $00, $30, $00, $68, $0C, $68, $0C, $02, $01
    db $03, $50, $03, $D8, $04, $02, $02, $0F, $F0, $16, $68, $19, $C0, $0A, $C0, $0A
    db $02, $02, $0F, $30, $00, $30, $00, $68, $0C, $68, $0C, $02, $02, $0F, $28, $0D
    db $D8, $0A, $60, $0A, $60, $0A, $02, $02, $0F, $F8, $0A, $E8, $0A, $98, $0B, $A8
    db $0B, $02, $02, $0F, $18, $07, $08, $07, $50, $07, $50, $07, $02, $02, $0F, $28
    db $07, $18, $07, $C0, $07, $C0, $07, $02, $03, $3F, $80, $0C, $80, $0C, $30, $00
    db $38, $14, $90, $14, $B0, $14, $02, $03, $3F, $30, $03, $A0, $09, $20, $11, $20
    db $11, $D8, $11, $28, $11, $02, $03, $3F, $30, $03, $A0, $09, $20, $11, $20, $11
    db $D8, $11, $28, $11, $02, $03, $3F, $30, $03, $A0, $09, $20, $11, $20, $11, $D8
    db $11, $28, $11, $02, $03, $3F, $80, $14, $80, $14, $30, $14, $10, $14, $78, $01
    db $30, $01, $02, $03, $1F, $20, $00, $20, $00, $20, $00, $60, $00, $50, $18, $02
    db $03, $2F, $78, $00, $68, $00, $58, $00, $20, $00, $30, $18, $02, $02, $0F, $E0
    db $17, $78, $18, $10, $00, $10, $00, $02, $03, $3F, $80, $14, $80, $14, $30, $14
    db $10, $14, $78, $01, $30, $01, $02, $03, $1F, $20, $00, $20, $00, $20, $00, $60
    db $00, $50, $18, $02, $03, $2F, $78, $00, $68, $00, $58, $00, $20, $00, $30, $18
    db $02, $02, $0F, $E0, $17, $78, $18, $10, $00, $10, $00, $02, $03, $3F, $80, $14
    db $80, $14, $30, $14, $10, $14, $80, $10, $90, $10, $02, $03, $3F, $20, $00, $20
    db $00, $20, $00, $60, $00, $20, $19, $38, $01, $02, $03, $2F, $78, $00, $68, $00
    db $58, $00, $20, $00, $30, $18, $02, $02, $0F, $E0, $17, $78, $18, $10, $00, $10
    db $00, $02, $03, $3F, $80, $14, $80, $14, $30, $14, $10, $14, $08, $00, $08, $00
    db $02, $03, $3F, $20, $00, $20, $00, $20, $00, $60, $00, $20, $19, $38, $01, $02
    db $03, $2F, $78, $00, $68, $00, $58, $00, $20, $00, $30, $18, $02, $02, $0F, $E0
    db $17, $78, $18, $10, $00, $10, $00, $02, $03, $3F, $80, $14, $80, $14, $30, $14
    db $10, $14, $78, $01, $30, $01, $02, $03, $1F, $20, $00, $20, $00, $20, $00, $60
    db $00, $50, $18, $02, $03, $2F, $78, $00, $68, $00, $58, $00, $20, $00, $30, $18
    db $02, $02, $0F, $E0, $17, $78, $18, $10, $00, $10, $00, $02, $03, $3F, $38, $09
    db $48, $1D, $48, $32, $F0, $36, $38, $37, $28, $37, $02, $03, $3F, $38, $09, $48
    db $1D, $48, $32, $F0, $36, $38, $37, $28, $37, $02, $03, $3F, $58, $16, $C8, $19
    db $48, $32, $60, $1A, $98, $32, $E8, $32, $02, $02, $0F, $A0, $26, $20, $31, $90
    db $26, $D0, $31, $02, $02, $0F, $08, $32, $38, $32, $B8, $32, $50, $2B, $02, $02
    db $0F, $08, $2D, $F8, $2D, $A8, $27, $48, $2D, $02, $02, $0F, $30, $26, $30, $26
    db $A8, $27, $90, $27, $02, $02, $0F, $30, $26, $30, $26, $A8, $27, $90, $27, $02
    db $02, $0F, $A0, $26, $30, $26, $A8, $27, $90, $27, $02, $02, $0F, $88, $26, $F8
    db $26, $A8, $27, $90, $27, $02, $02, $0F, $30, $26, $30, $26, $A8, $27, $90, $27
    db $02, $02, $0F, $A0, $26, $30, $26, $A8, $27, $90, $27, $02, $02, $0F, $88, $26
    db $F8, $26, $A8, $27, $90, $27, $02, $02, $0F, $08, $32, $D8, $3E, $F8, $3E, $E8
    db $3E, $02, $02, $0F, $48, $38, $78, $38, $D8, $2B, $90, $27, $02, $02, $0F, $88
    db $26, $F8, $26, $D8, $2B, $50, $2B, $02, $02, $0F, $30, $26, $30, $26, $D8, $2B
    db $50, $2B, $02, $02, $0F, $A0, $26, $30, $26, $D8, $2B, $50, $2B, $02, $02, $0F
    db $88, $26, $F8, $26, $90, $26, $28, $26, $04, $04, $37, $28, $00, $D0, $3B, $30
    db $3A, $A8, $3A, $B8, $3A, $E7, $70, $3D, $D8, $3A, $58, $3D, $28, $3C, $20, $3D
    db $60, $3C, $04, $04, $76, $B0, $01, $50, $00, $50, $00, $70, $00, $D8, $3A, $E6
    db $50, $00, $50, $00, $B0, $00, $B0, $00, $D0, $00, $04, $04, $36, $D0, $00, $F0
    db $00, $F0, $00, $D0, $00, $C6, $C8, $00, $B8, $00, $40, $00, $40, $00, $04, $04
    db $36, $40, $00, $40, $00, $20, $3A, $58, $00, $C6, $48, $00, $38, $00, $C8, $03
    db $D8, $3C, $02, $03, $33, $C8, $3A, $F8, $3A, $F8, $03, $40, $3D, $04, $04, $FF
    db $18, $39, $08, $39, $38, $39, $18, $39, $A0, $39, $D8, $03, $50, $03, $A0, $39
    db $FF, $58, $03, $40, $00, $E8, $3E, $10, $3E, $48, $3F, $D8, $03, $58, $00, $50
    db $3F, $03, $04, $FE, $58, $39, $28, $39, $20, $00, $B0, $39, $B0, $39, $F8, $3E
    db $08, $3E, $0F, $80, $3E, $88, $3F, $38, $3D, $B8, $3F, $03, $04, $F6, $C0, $00
    db $C0, $00, $C0, $00, $C0, $00, $40, $00, $E8, $03, $0C, $50, $00, $D8, $03, $03
    db $04, $F6, $68, $00, $78, $00, $68, $00, $58, $00, $28, $00, $D0, $00, $0C, $C8
    db $00, $D0, $00, $03, $04, $F6, $38, $00, $28, $00, $D8, $01, $E8, $01, $88, $3E
    db $30, $00, $0C, $48, $00, $40, $00, $02, $04, $C3, $F8, $39, $E8, $39, $F8, $03
    db $88, $3C, $03, $04, $FF, $38, $39, $18, $39, $08, $39, $A0, $39, $28, $01, $38
    db $01, $30, $3E, $C0, $03, $0F, $40, $00, $C8, $00, $50, $00, $00, $3F, $05, $04
    db $E7, $58, $38, $48, $38, $48, $00, $F0, $38, $F0, $38, $D0, $38, $79, $70, $00
    db $A0, $3F, $58, $3F, $88, $3D, $F8, $00, $0E, $18, $3C, $20, $3D, $70, $3C, $03
    db $02, $3B, $78, $02, $50, $00, $B0, $00, $B0, $00, $D0, $00, $04, $03, $73, $10
    db $02, $78, $00, $B8, $02, $B0, $00, $28, $02, $0C, $40, $00, $40, $00, $05, $04
    db $E3, $48, $00, $78, $00, $48, $00, $B0, $00, $38, $00, $30, $40, $00, $28, $00
    db $0C, $C8, $03, $D8, $3C, $04, $03, $63, $D8, $00, $E8, $00, $40, $00, $E0, $00
    db $0C, $50, $02, $18, $3F, $03, $02, $33, $20, $00, $20, $00, $78, $02, $00, $38
    db $02, $01, $03, $B8, $38, $A0, $38, $05, $04, $FF, $38, $39, $18, $39, $08, $39
    db $38, $39, $18, $39, $50, $01, $98, $01, $A0, $39, $FF, $A0, $39, $A0, $39, $C0
    db $3E, $C0, $03, $D0, $01, $30, $3E, $10, $3E, $50, $3F, $0F, $48, $3F, $D8, $03
    db $58, $00, $50, $3F, $03, $04, $FF, $70, $38, $48, $38, $48, $00, $48, $38, $B8
    db $38, $30, $3F, $F8, $3E, $90, $3D, $0E, $88, $3F, $38, $3D, $B8, $3F, $02, $03
    db $3F, $48, $00, $78, $00, $D0, $00, $60, $02, $40, $00, $D0, $02, $03, $03, $F3
    db $D8, $00, $E8, $00, $50, $00, $78, $00, $08, $01, $70, $02, $01, $28, $3F, $03
    db $04, $F3, $20, $00, $20, $00, $C8, $00, $38, $00, $58, $3F, $30, $00, $0C, $50
    db $00, $D8, $03, $03, $04, $33, $B8, $38, $A0, $38, $48, $00, $E0, $00, $0C, $C8
    db $00, $80, $00, $02, $03, $33, $40, $02, $00, $38, $48, $00, $38, $00, $02, $01
    db $03, $F8, $03, $A0, $3C, $03, $04, $FF, $38, $39, $18, $39, $08, $39, $50, $01
    db $98, $01, $A0, $39, $C0, $3E, $C0, $03, $0F, $D0, $01, $C8, $00, $50, $00, $00
    db $3F, $03, $04, $FE, $F8, $38, $B0, $38, $40, $38, $40, $38, $F8, $3F, $38, $38
    db $C8, $3F, $06, $F0, $07, $F0, $07, $03, $02, $1E, $D8, $07, $C8, $07, $F8, $07
    db $C8, $07, $03, $04, $FF, $28, $00, $D0, $05, $F0, $05, $B0, $05, $90, $05, $98
    db $02, $D0, $07, $30, $00, $06, $F8, $3F, $88, $3F, $03, $04, $DE, $C8, $3A, $F8
    db $3A, $20, $3A, $30, $00, $60, $00, $60, $00, $06, $60, $00, $10, $00, $02, $02
    db $0F, $28, $00, $E8, $06, $E8, $06, $E8, $06, $02, $02, $0F, $08, $00, $58, $00
    db $68, $00, $58, $00, $02, $02, $0F, $70, $05, $E8, $00, $58, $03, $E8, $00, $03
    db $04, $FF, $18, $39, $08, $39, $38, $39, $A0, $39, $B0, $03, $50, $03, $58, $03
    db $40, $00, $0F, $E8, $3E, $D8, $03, $50, $00, $00, $3F, $05, $04, $E7, $60, $3A
    db $38, $3A, $78, $00, $F8, $3D, $68, $38, $58, $38, $79, $B8, $07, $48, $3D, $68
    db $38, $50, $38, $B8, $00, $0E, $A8, $3C, $68, $38, $70, $3C, $05, $04, $C3, $D0
    db $00, $F0, $00, $F8, $05, $F0, $00, $30, $F8, $05, $10, $00, $0C, $F8, $05, $D0
    db $00, $05, $04, $C3, $40, $00, $40, $00, $40, $00, $10, $00, $30, $40, $00, $30
    db $00, $0C, $40, $00, $40, $00, $05, $04, $C3, $C8, $3A, $F8, $3A, $A0, $00, $10
    db $3F, $30, $60, $05, $F8, $38, $0C, $C8, $03, $D8, $3C, $05, $04, $FF, $08, $39
    db $38, $39, $18, $39, $08, $39, $38, $39, $D8, $03, $50, $03, $A0, $39, $FF, $A0
    db $39, $A0, $39, $88, $3E, $D0, $03, $E8, $06, $10, $3E, $30, $3E, $E0, $39, $0F
    db $48, $3F, $D8, $03, $58, $00, $50, $3F, $03, $04, $F6, $98, $39, $E8, $39, $88
    db $38, $08, $38, $80, $00, $08, $38, $0F, $78, $38, $A0, $39, $78, $3C, $B8, $39
    db $03, $04, $86, $68, $00, $78, $00, $48, $06, $0F, $38, $06, $10, $00, $C8, $05
    db $28, $00, $03, $04, $86, $38, $00, $28, $00, $98, $06, $07, $88, $06, $28, $00
    db $D8, $01, $03, $02, $1E, $E0, $01, $E0, $01, $F0, $39, $18, $00, $02, $03, $3F
    db $F8, $39, $E8, $39, $E0, $00, $60, $00, $28, $00, $38, $00, $02, $02, $0F, $E8
    db $06, $E8, $06, $38, $00, $18, $00, $02, $01, $03, $68, $00, $58, $00, $02, $01
    db $03, $D8, $01, $E8, $01, $03, $04, $FF, $38, $39, $18, $39, $08, $39, $A0, $39
    db $28, $01, $38, $01, $30, $3E, $58, $07, $0F, $78, $07, $50, $3F, $40, $07, $B8
    db $06, $02, $02, $0F, $88, $26, $F8, $26, $D8, $2B, $50, $2B, $03, $04, $DF, $68
    db $1F, $60, $16, $78, $00, $F8, $3D, $88, $3D, $D8, $3F, $40, $3C, $0C, $38, $3C
    db $08, $3C, $02, $02, $0F, $D0, $3F, $B0, $3F, $08, $3A, $80, $3A, $02, $02, $0F
    db $D0, $3F, $70, $3A, $08, $3A, $80, $3A, $00, $00, $00, $8A, $A4, $0C, $74, $40
    db $B4, $40, $C1, $CF, $C9, $79, $02, $01, $03, $F3, $A0, $F1, $20, $F1, $FF, $81
    db $40, $C0, $80, $8B, $CF, $C9, $C1, $66, $0C, $04, $E0, $60, $45, $55, $FB, $01
    db $02, $03, $06, $B8, $01, $02, $01, $06, $0F, $1B, $3B, $24, $6C, $29, $98, $18
    db $56, $31, $AD, $63, $4B, $C7, $0F, $38, $07, $63, $1F, $87, $7F, $E0, $0F, $1F
    db $3F, $FF, $FF, $FF, $FF, $3F, $00, $01, $01, $02, $3F, $01, $01, $03, $02, $3F
    db $C8, $FD, $7C, $03, $3F, $FD, $35, $FF, $02, $F8, $62, $D9, $00, $F6, $00, $60
    db $F8, $BF, $99, $F6, $F6, $60, $60, $00, $02, $1C, $01, $0E, $00, $07, $04, $0B
    db $03, $0F, $02, $07, $00, $03, $08, $06, $00, $1F, $10, $0F, $0A, $07, $07, $0F
    db $08, $0F, $08, $07, $07, $0F, $01, $0E, $02, $F0, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $F0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F0, $FF, $FF, $FF, $FF
    db $FF, $FF, $01, $01, $F0, $FF, $FF, $FF, $FF, $FF, $FF, $01, $01, $07, $20, $F8
    db $A8, $C4, $52, $96, $2C, $CA, $D0, $26, $07, $F8, $D8, $FC, $04, $EE, $80, $F6
    db $C2, $FE, $22, $FF, $FF, $00, $1B, $26, $C4, $3E, $1C, $FE, $04, $FF, $AA, $C7
    db $10, $EF, $28, $FF, $06, $FF, $00, $FF, $20, $FF, $22, $FF, $C2, $FF, $7B, $FF
    db $45, $FF, $C7, $FF, $C5, $B9, $B9, $00, $00, $80, $80, $FE, $5C, $63, $96, $79
    db $1F, $E8, $6F, $F4, $70, $7B, $21, $3D, $00, $80, $80, $3E, $36, $81, $01, $E0
    db $00, $F0, $E0, $F8, $90, $7C, $08, $3E, $04, $01, $01, $03, $02, $04, $00, $06
    db $02, $07, $00, $03, $05, $3A, $16, $0F, $01, $03, $02, $07, $04, $07, $00, $07
    db $04, $03, $03, $3C, $38, $21, $01, $01, $90, $F8, $F8, $04, $A9, $AF, $5D, $97
    db $00, $FF, $74, $E7, $82, $7A, $01, $F8, $68, $FC, $04, $57, $02, $EF, $02, $FF
    db $9F, $1B, $01, $BD, $10, $F8, $1A, $23, $01, $0E, $18, $17, $F8, $3C, $00, $0F
    db $0C, $1F, $13, $00, $01, $DE, $84, $FF, $00, $FF, $02, $05, $01, $07, $05, $0F
    db $01, $0B, $02, $06, $00, $3F, $0C, $7F, $72, $FF, $FF, $07, $04, $07, $04, $0B
    db $0B, $0F, $0A, $06, $00, $FF, $FF, $80, $40, $9B, $30, $F9, $20, $71, $20, $00
    db $00, $28, $00, $38, $00, $10, $80, $FB, $8B, $F9, $89, $71, $71, $30, $00, $38
    db $08, $38, $28, $10, $10, $E1, $FF, $FF, $FF, $FF, $FF, $FF, $F0, $F0, $E1, $FF
    db $FF, $FF, $FF, $FF, $FF, $F0, $F0, $F1, $80, $80, $FF, $FF, $F0, $F0, $F1, $80
    db $80, $FF, $FF, $F0, $F0, $00, $00, $80, $00, $40, $80, $A0, $60, $90, $20, $D0
    db $40, $B8, $2C, $DF, $A2, $7B, $00, $80, $80, $C0, $40, $60, $20, $F0, $90, $F0
    db $90, $F8, $98, $F3, $13, $FC, $10, $3F, $80, $60, $E0, $33, $3F, $E0, $20, $13
    db $13, $C0, $81, $FF, $41, $FE, $86, $FF, $C7, $E7, $82, $C3, $00, $81, $C0, $FE
    db $20, $FF, $2E, $FF, $39, $E7, $20, $C3, $40, $81, $81, $00, $D1, $37, $69, $9C
    db $BA, $4F, $18, $AF, $14, $D8, $28, $CE, $16, $E6, $02, $7B, $00, $0C, $00, $07
    db $04, $87, $04, $C7, $87, $E4, $40, $F2, $02, $F9, $A0, $7C, $78, $00, $05, $35
    db $12, $3C, $00, $1F, $2B, $D7, $B4, $7B, $D1, $1F, $0C, $F7, $50, $8F, $00, $3A
    db $00, $3F, $20, $1F, $1C, $E0, $C0, $0D, $08, $E0, $00, $FB, $F3, $FF, $8F, $00
    db $42, $7F, $ED, $B9, $00, $FF, $BB, $38, $10, $D0, $03, $7C, $00, $FF, $54, $EF
    db $00, $BF, $1D, $7E, $10, $FF, $F7, $C7, $00, $EF, $80, $FF, $60, $FF, $FF, $FF
    db $80, $F8, $25, $D9, $04, $FF, $00, $70, $F8, $FE, $88, $FF, $CB, $70, $70, $C0
    db $12, $F7, $65, $FF, $0B, $3F, $0F, $1F, $07, $0F, $00, $07, $C0, $0F, $04, $FF
    db $80, $3F, $30, $1F, $10, $0F, $08, $07, $07, $F0, $40, $32, $80, $63, $40, $E1
    db $00, $C0, $F0, $F3, $32, $E3, $22, $E1, $21, $C0, $C0, $E0, $00, $70, $C0, $60
    db $00, $E0, $00, $E0, $00, $C0, $E0, $F0, $50, $E0, $20, $E0, $A0, $E0, $A0, $C0
    db $C0, $E1, $FF, $FF, $FF, $FF, $FF, $FF, $F8, $F8, $E1, $FF, $FF, $FF, $FF, $FF
    db $FF, $F8, $F8, $F1, $C0, $C0, $FF, $FF, $F8, $F8, $F1, $C0, $C0, $FF, $FF, $F8
    db $F8, $F1, $00, $01, $00, $01, $00, $01, $F1, $01, $01, $01, $01, $01, $01, $C0
    db $01, $FA, $00, $F3, $00, $C7, $04, $8D, $02, $09, $00, $0E, $C0, $FB, $9A, $F3
    db $F2, $C7, $47, $8B, $89, $0F, $09, $0E, $0E, $F1, $03, $03, $1F, $1F, $01, $01
    db $F1, $03, $03, $1F, $1F, $01, $01, $E1, $FF, $FF, $FF, $FF, $FF, $FF, $07, $07
    db $E1, $FF, $FF, $FF, $FF, $FF, $FF, $07, $07, $0D, $34, $17, $21, $17, $2F, $02
    db $3D, $18, $3D, $09, $1C, $00, $1D, $00, $0D, $3B, $20, $3F, $20, $3E, $20, $3E
    db $24, $3E, $24, $1F, $14, $1F, $1D, $0F, $0D, $31, $C7, $D4, $F3, $52, $BD, $DD
    db $37, $F3, $1F, $12, $F7, $A4, $B7, $44, $3E, $FF, $00, $FF, $00, $0F, $08, $0F
    db $00, $0F, $0C, $EF, $E5, $5F, $13, $FE, $12, $00, $0D, $01, $0C, $04, $0D, $00
    db $05, $09, $0C, $08, $0F, $0A, $0C, $00, $07, $0F, $09, $0F, $08, $0F, $09, $07
    db $00, $0F, $0C, $0F, $0F, $0F, $0C, $07, $06, $80, $FE, $1E, $E4, $08, $92, $48
    db $D2, $65, $FF, $93, $E7, $60, $FE, $30, $FC, $FE, $32, $FA, $E0, $9E, $10, $DE
    db $D2, $FF, $FF, $FF, $E3, $FE, $76, $FC, $FC, $1F, $00, $18, $18, $34, $20, $6D
    db $1F, $18, $18, $2C, $24, $5D, $45, $0F, $00, $06, $06, $0B, $01, $0D, $02, $EC
    db $0F, $06, $06, $0D, $09, $0E, $08, $EF, $E8, $00, $11, $4E, $12, $6F, $23, $7F
    db $12, $3E, $08, $0F, $00, $07, $01, $0C, $02, $3A, $00, $7F, $46, $7F, $4C, $7F
    db $4C, $3F, $2C, $0F, $07, $07, $04, $0F, $08, $3D, $30, $00, $22, $15, $31, $FF
    db $F2, $FF, $D4, $DC, $10, $EC, $C0, $3F, $B4, $8F, $6A, $67, $00, $F7, $14, $FF
    db $0C, $FF, $0D, $3C, $08, $FC, $E4, $FF, $1F, $7F, $02, $9F, $01, $1A, $31, $04
    db $1B, $01, $1F, $05, $0D, $02, $09, $01, $07, $01, $07, $01, $02, $3F, $21, $1F
    db $11, $1F, $1E, $0B, $08, $0F, $09, $07, $06, $07, $06, $03, $02, $61, $FF, $60
    db $9F, $F8, $FF, $F4, $F9, $F2, $FF, $08, $FF, $85, $F8, $02, $9D, $FF, $6E, $FF
    db $99, $FF, $05, $FF, $09, $FD, $09, $FF, $F7, $FF, $68, $9F, $88, $00, $03, $02
    db $05, $01, $03, $01, $00, $00, $03, $03, $03, $07, $07, $0F, $0F, $03, $03, $07
    db $04, $03, $03, $03, $00, $03, $03, $03, $03, $07, $07, $0F, $0F, $00, $9F, $08
    db $D6, $00, $8C, $00, $80, $98, $98, $FC, $FC, $FC, $FC, $FE, $FE, $9F, $9F, $DE
    db $56, $8C, $8C, $80, $80, $98, $98, $FC, $FC, $FC, $FC, $FE, $FE, $1F, $00, $01
    db $00, $07, $01, $0F, $1F, $01, $01, $07, $06, $0F, $0A, $0F, $00, $F0, $20, $98
    db $58, $56, $62, $8F, $0F, $F0, $F0, $F8, $08, $AE, $06, $FF, $05, $00, $00, $1F
    db $0A, $3D, $15, $3F, $13, $3A, $04, $32, $08, $37, $06, $3F, $10, $3F, $00, $1F
    db $15, $3F, $25, $3A, $2A, $3F, $28, $3F, $32, $3F, $32, $3F, $31, $3F, $2F, $00
    db $A2, $FF, $04, $FB, $6A, $9D, $FA, $95, $92, $F5, $00, $7B, $84, $73, $E2, $7F
    db $00, $FF, $0C, $FF, $FA, $07, $05, $FF, $95, $0F, $05, $FF, $79, $FF, $11, $FF
    db $71, $00, $4B, $EE, $B0, $BD, $0D, $F7, $A6, $1F, $43, $BF, $A6, $FF, $1A, $FF
    db $04, $9D, $00, $9C, $04, $CE, $04, $FE, $F2, $FF, $19, $FF, $1C, $FF, $19, $FF
    db $FF, $9D, $9D, $00, $40, $F8, $40, $E0, $20, $90, $F0, $E8, $10, $F8, $10, $E8
    db $A0, $10, $40, $B0, $00, $38, $38, $20, $20, $70, $10, $18, $08, $C8, $C0, $F8
    db $E8, $F0, $10, $F0, $10, $18, $00, $81, $01, $01, $00, $01, $FF, $FF, $FF, $FF
    db $FF, $FF, $18, $81, $80, $01, $00, $01, $01, $FF, $FF, $FF, $FF, $FF, $FF, $18
    db $00, $E0, $80, $00, $00, $80, $C0, $C0, $FE, $FE, $F0, $F0, $18, $E0, $E0, $80
    db $00, $80, $80, $C0, $C0, $FE, $FE, $F0, $F0, $FE, $0C, $0B, $FE, $0F, $09, $00
    db $05, $FB, $00, $3F, $22, $5F, $18, $7F, $10, $F9, $00, $E1, $00, $03, $01, $02
    db $00, $FF, $FA, $3F, $3A, $7F, $45, $7F, $47, $F9, $B9, $E1, $E1, $03, $03, $03
    db $02, $BF, $01, $01, $BF, $01, $01, $1E, $00, $03, $3F, $3F, $FF, $FF, $1F, $1F
    db $1E, $03, $03, $3F, $3F, $FF, $FF, $1F, $1F, $7F, $00, $01, $7F, $01, $01, $7F
    db $C8, $FC, $7F, $FC, $34, $00, $01, $02, $00, $03, $01, $03, $00, $01, $22, $3D
    db $0B, $07, $0D, $11, $00, $07, $00, $03, $02, $03, $00, $03, $02, $01, $01, $3E
    db $1C, $10, $00, $1E, $00, $07, $06, $00, $7C, $03, $54, $57, $2E, $CB, $00, $FF
    db $82, $7E, $34, $C5, $08, $C7, $B1, $4F, $00, $FF, $03, $AB, $01, $F7, $01, $FF
    db $CF, $3D, $38, $FB, $C0, $7F, $43, $FF, $46, $FE, $00, $04, $FE, $04, $04, $00
    db $03, $0F, $02, $0F, $03, $07, $00, $03, $00, $01, $00, $03, $00, $07, $04, $0B
    db $00, $0F, $08, $0F, $0D, $07, $04, $03, $03, $01, $01, $03, $02, $07, $07, $0F
    db $08, $FF, $FF, $F0, $03, $0F, $02, $0F, $04, $12, $00, $0C, $F0, $0F, $08, $0F
    db $0F, $1E, $12, $0C, $0C, $00, $54, $8F, $50, $FF, $20, $F4, $C8, $FC, $88, $DA
    db $8C, $DA, $08, $9C, $00, $9C, $00, $FF, $8B, $8F, $8F, $CC, $C4, $E4, $24, $D6
    db $52, $D6, $52, $94, $94, $9C, $9C, $00, $04, $DE, $D2, $F9, $EE, $FF, $70, $7F
    db $00, $1F, $0A, $11, $04, $3B, $00, $2F, $00, $E2, $C2, $E7, $21, $F1, $11, $7D
    db $0D, $1F, $1F, $1F, $11, $3F, $31, $3F, $2F, $C0, $14, $A2, $08, $36, $14, $3E
    db $00, $3C, $68, $68, $30, $30, $C0, $BE, $A2, $3E, $22, $3E, $22, $3C, $3C, $58
    db $00, $30, $00, $F0, $0C, $36, $00, $3E, $00, $1C, $00, $08, $F0, $3E, $22, $3E
    db $3A, $1C, $14, $08, $08, $7F, $40, $F0, $7F, $F0, $B0, $0F, $00, $0E, $06, $1F
    db $04, $13, $0A, $1F, $0F, $0E, $0E, $11, $11, $1F, $11, $1F, $11, $00, $50, $48
    db $A4, $2C, $D8, $14, $A0, $4F, $77, $8D, $4B, $BF, $38, $FC, $09, $FE, $00, $B8
    db $08, $DC, $00, $EC, $04, $FF, $05, $FE, $00, $FC, $04, $FF, $04, $FF, $F6, $00
    db $00, $0E, $00, $06, $00, $7A, $3E, $CE, $C6, $FE, $82, $BA, $78, $62, $34, $EE
    db $00, $0E, $0E, $06, $06, $7E, $5A, $82, $80, $02, $00, $46, $00, $C6, $02, $C2
    db $02, $1F, $03, $07, $05, $08, $01, $0D, $1F, $07, $04, $0F, $08, $0E, $00, $03
    db $00, $1C, $00, $26, $10, $2A, $44, $BA, $80, $3E, $40, $7F, $03, $1C, $1C, $3E
    db $26, $3E, $22, $FE, $A2, $FE, $22, $BF, $23, $00, $04, $0F, $00, $07, $8B, $F4
    db $2D, $9E, $35, $46, $02, $1D, $00, $03, $00, $06, $00, $0F, $08, $07, $07, $F8
    db $70, $C2, $82, $79, $00, $1F, $18, $03, $01, $06, $02, $00, $80, $7F, $41, $BE
    db $04, $FF, $01, $F6, $B0, $07, $01, $FE, $00, $9F, $04, $0B, $00, $FF, $47, $FF
    db $1E, $FF, $7A, $FF, $22, $FF, $02, $FF, $64, $9F, $9C, $0F, $08, $00, $54, $8F
    db $50, $FF, $20, $F4, $4C, $FA, $8C, $FD, $86, $CD, $00, $CF, $05, $88, $00, $FF
    db $8B, $8F, $8F, $CC, $C4, $E6, $A2, $F3, $71, $CB, $49, $CF, $CF, $8F, $88, $00
    db $32, $D9, $8E, $EF, $50, $7F, $00, $1F, $0A, $11, $04, $3B, $00, $2F, $0C, $B6
    db $00, $E7, $81, $F1, $41, $7D, $2D, $1F, $1F, $1F, $11, $3F, $31, $3F, $2F, $BE
    db $A2, $E0, $02, $0D, $05, $0F, $00, $0F, $1A, $1A, $0C, $0C, $E0, $0F, $08, $0F
    db $08, $0F, $0F, $16, $00, $0C, $00, $F8, $00, $BE, $00, $9C, $00, $08, $F8, $BE
    db $BA, $9C, $94, $08, $08, $FE, $00, $04, $FE, $04, $04, $00, $03, $0F, $02, $0F
    db $03, $07, $00, $03, $00, $01, $00, $07, $04, $0B, $03, $0F, $00, $0F, $08, $0F
    db $0D, $07, $04, $03, $03, $01, $01, $07, $07, $0F, $08, $0F, $08, $FF, $FF, $F8
    db $02, $0F, $04, $12, $00, $0C, $F8, $0F, $0F, $1E, $12, $0C, $0C, $1F, $03, $07
    db $05, $08, $01, $0D, $1F, $07, $04, $0F, $08, $0E, $00, $01, $00, $38, $08, $44
    db $28, $54, $10, $6C, $20, $DC, $80, $7C, $00, $78, $01, $38, $38, $7C, $44, $7C
    db $44, $7C, $44, $FC, $C4, $FC, $44, $F8, $08, $00, $04, $0F, $00, $07, $8B, $F4
    db $2D, $9E, $35, $46, $02, $1D, $00, $03, $00, $06, $00, $0F, $08, $07, $07, $F8
    db $70, $C2, $82, $79, $00, $1F, $18, $03, $01, $06, $02, $00, $80, $79, $11, $EE
    db $28, $BF, $05, $86, $B0, $07, $01, $FE, $00, $9F, $04, $0B, $00, $F9, $39, $FF
    db $EE, $C3, $00, $FB, $02, $FF, $02, $FF, $64, $9F, $9C, $0F, $08, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $03, $01, $06, $02, $0C, $03, $1F, $1C
    db $3F, $06, $32, $09, $69, $00, $00, $03, $03, $07, $04, $0F, $08, $1F, $18, $3F
    db $20, $3D, $20, $76, $40, $00, $00, $00, $80, $00, $C0, $80, $60, $80, $F0, $80
    db $F8, $C8, $38, $A0, $9C, $00, $00, $80, $80, $C0, $40, $E0, $20, $F0, $30, $F8
    db $68, $F8, $10, $7C, $0C, $34, $D3, $5F, $87, $5B, $BB, $48, $B7, $2A, $FE, $69
    db $F4, $4A, $77, $08, $77, $EF, $80, $FF, $80, $FC, $80, $FB, $93, $F5, $94, $F7
    db $94, $77, $34, $73, $63, $C4, $1E, $50, $CE, $C8, $B6, $74, $DE, $A4, $FE, $28
    db $DC, $20, $DC, $20, $D8, $FE, $02, $FE, $02, $7E, $22, $BE, $82, $5E, $52, $DC
    db $54, $DC, $DC, $98, $88, $01, $03, $07, $05, $08, $01, $0D, $04, $0F, $00, $07
    db $8D, $FE, $09, $BB, $01, $07, $04, $0F, $08, $0E, $00, $0F, $08, $07, $07, $F8
    db $70, $C6, $82, $01, $20, $F0, $F0, $08, $50, $5C, $B8, $2C, $08, $FC, $63, $DB
    db $C3, $9C, $01, $F0, $D0, $F8, $08, $AC, $04, $DC, $04, $FC, $24, $FB, $98, $FF
    db $1C, $88, $34, $47, $1B, $1B, $30, $2F, $00, $01, $00, $01, $00, $01, $88, $78
    db $00, $1C, $18, $3F, $27, $01, $01, $01, $01, $01, $01, $00, $D8, $DC, $87, $B8
    db $44, $BC, $10, $FF, $57, $F8, $E0, $FF, $0B, $FF, $0C, $1F, $00, $B7, $04, $FF
    db $08, $FB, $88, $FF, $88, $FF, $08, $FF, $10, $FF, $E0, $1F, $10, $03, $00, $03
    db $00, $06, $01, $0D, $05, $0E, $02, $1F, $08, $1F, $03, $03, $03, $07, $04, $0E
    db $08, $0F, $08, $1F, $1C, $1F, $17, $03, $00, $C0, $80, $60, $60, $50, $80, $30
    db $A0, $D8, $00, $FC, $03, $C0, $C0, $E0, $20, $B0, $10, $F0, $10, $F8, $18, $FC
    db $EC, $00, $17, $3A, $0D, $67, $14, $E9, $69, $EC, $12, $ED, $59, $FD, $60, $FE
    db $5E, $FF, $00, $3C, $28, $7A, $62, $FE, $C8, $FE, $84, $FF, $A5, $FF, $A4, $FF
    db $9E, $FF, $81, $00, $E8, $54, $B0, $E6, $28, $97, $86, $37, $52, $AF, $98, $BF
    db $06, $7F, $7A, $FF, $00, $3C, $14, $5E, $46, $7F, $13, $7F, $21, $FF, $A5, $FF
    db $25, $FF, $79, $FF, $81, $10, $6D, $12, $2D, $15, $2F, $1F, $2B, $09, $3F, $0D
    db $1B, $09, $1B, $05, $1F, $73, $60, $33, $21, $33, $21, $37, $21, $37, $23, $17
    db $03, $17, $13, $1B, $1B, $10, $6C, $90, $68, $50, $E8, $F0, $A8, $20, $F8, $60
    db $B0, $20, $B0, $40, $F0, $9C, $0C, $98, $08, $98, $08, $D8, $08, $D8, $88, $D0
    db $80, $D0, $90, $B0, $B0, $15, $0D, $01, $3F, $2A, $31, $04, $13, $00, $1F, $01
    db $1F, $01, $13, $13, $1F, $1B, $01, $3F, $2F, $3F, $31, $1F, $11, $1F, $19, $1F
    db $1F, $1F, $13, $1F, $1F, $50, $E0, $00, $F8, $A8, $18, $40, $30, $00, $F0, $00
    db $F0, $00, $90, $80, $E0, $B0, $80, $F8, $E8, $F8, $18, $F0, $10, $F0, $90, $F0
    db $F0, $F0, $90, $E0, $E0, $3F, $0C, $1F, $06, $22, $3F, $1F, $00, $3D, $20, $3F
    db $F0, $F0, $D0, $38, $3F, $F0, $00, $F8, $08, $00, $19, $79, $3F, $C7, $5F, $9B
    db $48, $B0, $45, $B5, $23, $F7, $6D, $FD, $48, $7C, $00, $66, $40, $FF, $80, $FC
    db $80, $FF, $90, $FA, $90, $F8, $90, $F2, $90, $73, $20, $00, $A8, $9C, $5C, $CE
    db $C4, $BE, $F0, $DE, $A8, $F6, $24, $DE, $24, $DE, $28, $DC, $00, $7C, $04, $FE
    db $02, $7E, $22, $3E, $02, $1E, $12, $1E, $12, $1E, $12, $1C, $04, $80, $C0, $80
    db $A0, $64, $5B, $9F, $00, $C1, $3E, $14, $F7, $B9, $77, $F2, $FD, $C0, $40, $60
    db $20, $BF, $10, $F0, $00, $F0, $00, $F8, $00, $FE, $02, $FF, $05, $10, $10, $40
    db $70, $80, $50, $20, $F0, $90, $70, $C0, $30, $D0, $30, $50, $B0, $10, $00, $70
    db $10, $F0, $10, $10, $10, $10, $00, $10, $00, $10, $00, $10, $00, $76, $79, $72
    db $AD, $20, $F3, $20, $C1, $40, $E1, $00, $E1, $A1, $12, $40, $B3, $9F, $09, $DF
    db $8D, $D3, $D3, $A1, $81, $A1, $01, $E1, $E1, $F3, $12, $F3, $12, $E0, $A0, $60
    db $10, $10, $E8, $20, $FC, $94, $78, $04, $D8, $00, $7C, $D4, $E6, $10, $00, $90
    db $10, $98, $88, $C4, $C4, $E4, $60, $D4, $D0, $FC, $3C, $FE, $22, $3F, $00, $03
    db $07, $04, $3F, $03, $03, $07, $00, $00, $01, $0F, $0A, $1C, $1D, $30, $24, $7A
    db $2E, $79, $29, $7E, $34, $FF, $3B, $FF, $00, $0F, $0E, $1F, $10, $3F, $20, $7F
    db $40, $7F, $40, $7F, $40, $FF, $C0, $FF, $40, $00, $06, $08, $1F, $13, $2A, $21
    db $20, $07, $08, $3F, $09, $1E, $02, $07, $07, $0F, $00, $0F, $08, $1C, $00, $3F
    db $00, $3F, $00, $3F, $23, $1D, $14, $05, $05, $08, $08, $00, $DC, $7F, $28, $FF
    db $4C, $BB, $B6, $9C, $40, $9E, $40, $9A, $10, $EF, $20, $FF, $00, $FF, $23, $FF
    db $97, $FF, $93, $FA, $08, $FE, $8E, $FE, $8A, $FF, $8B, $FF, $8F, $00, $11, $ED
    db $77, $6B, $24, $38, $05, $3E, $13, $3F, $00, $6F, $14, $69, $29, $6C, $00, $FE
    db $88, $7C, $08, $3F, $08, $3F, $38, $3F, $2C, $7F, $6B, $7E, $48, $7E, $44, $00
    db $EE, $D3, $8C, $B6, $60, $5C, $40, $38, $C8, $F4, $10, $E4, $28, $94, $80, $34
    db $00, $3F, $11, $7E, $10, $BC, $1C, $F8, $18, $FC, $34, $FC, $E4, $7C, $14, $7C
    db $24, $C0, $13, $2C, $1A, $3D, $00, $3F, $0E, $0F, $1F, $27, $1F, $1F, $C0, $3E
    db $24, $3F, $25, $3F, $3E, $37, $07, $3F, $27, $1F, $1F, $C0, $D0, $2C, $58, $BC
    db $00, $F8, $20, $E0, $F0, $C8, $F0, $F0, $C0, $7C, $24, $FC, $A4, $F8, $78, $D8
    db $C0, $F8, $C8, $F0, $F0, $07, $07, $0D, $0E, $11, $16, $2C, $2F, $36, $27, $3F
    db $2F, $36, $39, $08, $30, $07, $00, $08, $00, $18, $00, $30, $00, $38, $00, $3F
    db $00, $3F, $00, $3F, $20, $E0, $E0, $B0, $70, $A8, $68, $24, $E4, $6C, $E4, $FC
    db $E4, $9C, $7C, $9C, $04, $E0, $00, $10, $00, $18, $00, $1C, $00, $1C, $00, $FC
    db $00, $FC, $00, $FC, $00, $17, $60, $2A, $C5, $C8, $B7, $C0, $BF, $C0, $BF, $A0
    db $DF, $40, $BF, $42, $BC, $7F, $40, $FF, $80, $FF, $00, $FF, $00, $FF, $00, $FF
    db $00, $FF, $83, $FF, $84, $64, $02, $AE, $53, $09, $F7, $03, $FD, $01, $FF, $01
    db $FF, $09, $F7, $86, $7B, $FE, $02, $FF, $01, $FF, $00, $FF, $00, $FF, $00, $FF
    db $00, $FF, $C0, $FF, $21, $00, $11, $ED, $77, $6B, $24, $38, $05, $3E, $13, $3F
    db $00, $6F, $14, $69, $29, $6C, $00, $FE, $88, $7C, $08, $3F, $08, $3F, $38, $3F
    db $2C, $7F, $6B, $7E, $48, $7E, $44, $00, $EE, $D3, $8C, $B6, $60, $5C, $40, $38
    db $C8, $F4, $10, $E4, $28, $94, $80, $34, $00, $3F, $11, $7E, $10, $BC, $1C, $F8
    db $18, $FC, $34, $FC, $E4, $7C, $14, $7C, $24, $C0, $13, $2C, $1B, $3C, $00, $3F
    db $0E, $0F, $1F, $27, $1F, $1F, $C0, $3E, $24, $3E, $24, $3F, $3F, $37, $07, $3F
    db $27, $1F, $1F, $C0, $D0, $2C, $D8, $3C, $00, $F8, $20, $E0, $F0, $C8, $F0, $F0
    db $C0, $7C, $24, $7C, $24, $F8, $F8, $D8, $C0, $F8, $C8, $F0, $F0, $03, $00, $03
    db $02, $04, $01, $0D, $07, $0B, $04, $08, $05, $1E, $03, $03, $03, $07, $04, $0E
    db $08, $0C, $08, $0F, $08, $1F, $18, $03, $00, $C0, $80, $60, $E0, $D0, $80, $B0
    db $60, $50, $40, $38, $03, $C0, $C0, $E0, $20, $30, $10, $70, $10, $B0, $10, $F8
    db $18, $00, $13, $3F, $00, $6F, $14, $69, $29, $6C, $13, $2C, $1A, $3D, $00, $1B
    db $00, $01, $00, $3F, $2C, $7F, $6B, $7E, $48, $7E, $44, $3E, $24, $3F, $25, $1B
    db $1A, $01, $01, $00, $C8, $F4, $10, $E4, $28, $94, $80, $34, $D0, $2C, $58, $BC
    db $00, $D8, $00, $80, $00, $FC, $34, $FC, $E4, $7C, $14, $7C, $24, $7C, $24, $FC
    db $A4, $D8, $58, $80, $80, $1F, $00, $01, $03, $02, $05, $04, $1F, $01, $01, $03
    db $00, $07, $00, $07, $00, $78, $E0, $98, $D8, $0C, $F4, $6E, $48, $36, $07, $78
    db $78, $F8, $08, $FC, $04, $9E, $02, $FE, $02, $08, $04, $00, $01, $07, $01, $03
    db $00, $01, $00, $03, $07, $04, $04, $07, $08, $07, $00, $07, $04, $03, $02, $01
    db $01, $02, $02, $07, $00, $07, $03, $00, $16, $F3, $08, $F3, $28, $D3, $42, $FD
    db $E4, $FF, $06, $BF, $8E, $7F, $00, $8E, $00, $FF, $01, $FF, $71, $BF, $91, $BF
    db $B1, $1F, $11, $7F, $11, $FF, $71, $8E, $8E, $1F, $00, $01, $03, $02, $05, $04
    db $1F, $01, $01, $03, $00, $07, $00, $07, $00, $78, $E0, $98, $C0, $1C, $EC, $5E
    db $50, $3E, $07, $78, $78, $F8, $08, $FC, $0C, $BE, $02, $FE, $02, $08, $04, $00
    db $01, $07, $01, $03, $00, $01, $00, $03, $03, $02, $00, $03, $08, $07, $00, $07
    db $04, $03, $02, $01, $01, $02, $02, $03, $00, $03, $03, $00, $0C, $E2, $10, $E2
    db $14, $E2, $48, $F6, $C0, $FC, $08, $FC, $B8, $7C, $00, $F8, $00, $FE, $22, $FE
    db $62, $BE, $A2, $BE, $A2, $3C, $24, $7C, $44, $FC, $44, $F8, $F8, $1F, $00, $01
    db $03, $02, $05, $04, $1F, $01, $01, $03, $00, $07, $00, $07, $00, $78, $E0, $98
    db $D8, $0C, $FC, $66, $74, $02, $07, $78, $78, $F8, $08, $FC, $04, $9E, $02, $FE
    db $02, $08, $04, $00, $01, $07, $01, $03, $00, $01, $00, $03, $03, $02, $00, $03
    db $08, $07, $00, $07, $04, $03, $02, $01, $01, $02, $02, $03, $00, $03, $03, $00
    db $1A, $F3, $1C, $F3, $26, $D9, $4C, $F9, $F2, $ED, $00, $BF, $87, $6F, $00, $8F
    db $00, $FF, $01, $FF, $61, $BF, $91, $BF, $B1, $1F, $08, $7F, $18, $EF, $68, $8F
    db $8F, $03, $00, $03, $02, $04, $01, $0D, $07, $0B, $04, $08, $05, $1E, $03, $03
    db $03, $07, $04, $0E, $08, $0C, $08, $0F, $08, $1F, $18, $03, $00, $C0, $80, $60
    db $E0, $D0, $80, $B0, $60, $50, $40, $38, $03, $C0, $C0, $E0, $20, $30, $10, $70
    db $10, $B0, $10, $F8, $18, $00, $13, $3F, $00, $6F, $14, $69, $29, $6C, $13, $2C
    db $1B, $3C, $00, $1B, $00, $01, $00, $3F, $2C, $7F, $6B, $7E, $48, $7E, $44, $3E
    db $24, $3E, $24, $1B, $1A, $01, $01, $00, $C8, $F4, $10, $E4, $28, $94, $80, $34
    db $D0, $2C, $D8, $3C, $00, $D8, $00, $80, $00, $FC, $34, $FC, $E4, $7C, $14, $7C
    db $24, $7C, $24, $7C, $24, $D8, $58, $80, $80, $1E, $28, $18, $29, $16, $27, $00
    db $00, $04, $14, $10, $20, $10, $27, $03, $17, $27, $31, $2F, $32, $27, $38, $32
    db $3F, $33, $3F, $2F, $3F, $2F, $3F, $1F, $1F, $60, $90, $A0, $D0, $20, $90, $A0
    db $10, $E0, $C0, $60, $30, $30, $80, $00, $90, $D0, $70, $D0, $70, $90, $F0, $90
    db $F0, $10, $F0, $90, $F0, $D0, $F0, $D0, $D0, $0B, $17, $03, $17, $0B, $17, $0B
    db $37, $03, $3F, $03, $17, $0F, $0F, $03, $03, $17, $1F, $17, $1F, $17, $1F, $37
    db $2F, $3F, $27, $17, $1F, $0F, $0F, $03, $03, $40, $A0, $00, $A0, $00, $B0, $00
    db $B0, $00, $F0, $00, $A0, $C0, $C0, $80, $80, $A0, $E0, $A0, $E0, $B0, $F0, $B0
    db $D0, $F0, $90, $A0, $E0, $C0, $C0, $80, $80, $0F, $00, $1C, $10, $34, $18, $43
    db $2C, $57, $0F, $1C, $1C, $34, $2C, $43, $7F, $57, $78, $1F, $00, $E0, $E0, $70
    db $E0, $88, $1F, $E0, $E0, $70, $90, $88, $78, $00, $08, $77, $14, $27, $1A, $23
    db $0E, $37, $04, $06, $19, $2C, $19, $2C, $1B, $28, $00, $77, $78, $27, $38, $23
    db $3C, $37, $38, $17, $18, $2F, $30, $2F, $30, $2F, $30, $00, $10, $A8, $C0, $98
    db $20, $10, $40, $B0, $00, $20, $80, $10, $00, $10, $20, $90, $00, $A8, $78, $B8
    db $78, $10, $F0, $B0, $70, $A0, $60, $F0, $30, $F0, $B0, $D0, $30, $1F, $28, $19
    db $28, $17, $27, $03, $13, $08, $18, $00, $23, $0B, $27, $13, $37, $2F, $30, $2F
    db $33, $27, $38, $10, $1F, $17, $1F, $3F, $3F, $37, $3F, $27, $3F, $C0, $30, $A0
    db $50, $E0, $90, $A0, $10, $60, $30, $00, $10, $40, $90, $00, $90, $F0, $50, $F0
    db $B0, $D0, $70, $90, $F0, $90, $F0, $F0, $F0, $B0, $F0, $B0, $F0, $13, $37, $1B
    db $2F, $0B, $17, $1B, $1F, $03, $1B, $07, $1F, $07, $1F, $1B, $1F, $27, $3F, $2F
    db $37, $17, $1F, $1F, $17, $1B, $17, $1F, $13, $1F, $13, $1F, $17, $20, $90, $40
    db $D0, $40, $A0, $20, $A0, $00, $60, $80, $E0, $80, $E0, $40, $E0, $90, $F0, $F0
    db $B0, $A0, $E0, $A0, $E0, $60, $A0, $E0, $20, $E0, $20, $E0, $A0, $00, $3C, $00
    db $7C, $10, $F5, $09, $22, $0C, $17, $08, $37, $14, $67, $1A, $43, $3C, $3C, $7C
    db $44, $F5, $ED, $22, $3F, $17, $18, $37, $38, $67, $78, $43, $7C, $00, $00, $00
    db $60, $00, $B0, $60, $70, $E0, $90, $00, $B0, $C0, $98, $30, $08, $00, $00, $60
    db $60, $B0, $D0, $70, $90, $90, $70, $B0, $70, $B8, $78, $08, $F8, $2E, $77, $14
    db $66, $2C, $7E, $39, $4C, $1B, $48, $1F, $68, $1B, $28, $1F, $28, $77, $58, $67
    db $58, $7F, $50, $4F, $70, $6F, $70, $67, $70, $2F, $30, $27, $30, $50, $B8, $00
    db $28, $90, $08, $80, $08, $A0, $08, $A0, $08, $A0, $18, $A0, $10, $B8, $68, $A8
    db $78, $A8, $78, $F8, $38, $D8, $38, $D8, $38, $D8, $38, $F0, $30, $08, $2C, $1B
    db $28, $1F, $28, $1B, $28, $1B, $28, $18, $0E, $04, $07, $06, $E7, $3F, $30, $2F
    db $30, $2F, $30, $2F, $30, $2F, $30, $2F, $30, $37, $38, $F7, $F8, $A0, $30, $80
    db $10, $C0, $10, $C0, $10, $A0, $10, $60, $40, $20, $90, $D0, $80, $D0, $30, $D0
    db $30, $D0, $30, $D0, $30, $D0, $30, $90, $30, $90, $70, $B0, $70, $08, $C2, $0D
    db $43, $08, $67, $13, $24, $10, $15, $00, $1B, $01, $0B, $01, $07, $D2, $BF, $53
    db $7E, $67, $7F, $27, $37, $17, $17, $1F, $1F, $0F, $0F, $07, $07, $C0, $1C, $C0
    db $9A, $20, $D4, $10, $F8, $00, $70, $20, $60, $20, $E0, $C0, $C0, $BC, $FC, $FE
    db $76, $FC, $3C, $F8, $C8, $F0, $F0, $E0, $E0, $E0, $E0, $C0, $C0, $0F, $00, $0C
    db $00, $1C, $10, $34, $08, $23, $0F, $0C, $0C, $1C, $14, $34, $2C, $23, $3F, $1F
    db $00, $60, $40, $B0, $E0, $70, $1F, $60, $60, $B0, $D0, $70, $90, $00, $0C, $37
    db $08, $17, $14, $27, $1A, $23, $0E, $17, $04, $07, $08, $17, $02, $26, $00, $37
    db $38, $17, $18, $27, $38, $23, $3C, $17, $18, $17, $18, $17, $18, $35, $38, $00
    db $F0, $98, $00, $B0, $C0, $90, $20, $10, $00, $A0, $00, $A0, $40, $E0, $40, $50
    db $00, $98, $68, $B0, $70, $B0, $70, $10, $F0, $A0, $60, $A0, $60, $A0, $60, $B0
    db $70, $38, $00, $80, $80, $C0, $00, $80, $00, $F8, $38, $07, $38, $80, $80, $C0
    db $40, $80, $80, $F8, $F8, $7F, $87, $1F, $00, $0F, $08, $3F, $13, $DB, $1F, $0F
    db $0F, $3E, $30, $DC, $E7, $00, $BE, $80, $5F, $C1, $3E, $FE, $81, $BE, $52, $D3
    db $83, $FD, $C1, $62, $00, $C1, $00, $7F, $00, $FE, $00, $FD, $00, $BF, $40, $E3
    db $3C, $FD, $3E, $62, $A3, $C1, $C1, $00, $80, $F4, $00, $E8, $00, $68, $00, $60
    db $10, $F0, $00, $F8, $20, $3C, $20, $CE, $00, $74, $0C, $E8, $18, $E8, $18, $E8
    db $18, $F8, $08, $F8, $08, $3C, $C4, $CE, $F2, $0F, $00, $01, $03, $0D, $01, $08
    db $04, $08, $0F, $01, $01, $0D, $0E, $08, $0F, $08, $0F, $00, $00, $1B, $0B, $27
    db $25, $4F, $28, $FF, $E2, $EE, $18, $8F, $9A, $1E, $69, $0F, $00, $1B, $1B, $27
    db $3C, $5F, $78, $FF, $91, $EF, $19, $8F, $F1, $1E, $E1, $1F, $F0, $FE, $01, $04
    db $FE, $06, $07, $80, $80, $17, $04, $67, $0A, $03, $03, $7F, $04, $BF, $09, $EC
    db $00, $19, $80, $77, $F8, $77, $78, $13, $1C, $7F, $7C, $BF, $E0, $EE, $F7, $19
    db $19, $03, $00, $02, $00, $03, $00, $07, $00, $1D, $00, $EC, $40, $7A, $03, $02
    db $02, $01, $01, $07, $05, $1D, $1B, $EE, $F2, $BA, $06, $FF, $FF, $80, $80, $F4
    db $00, $36, $80, $33, $28, $3B, $50, $9F, $11, $60, $00, $1F, $80, $74, $0C, $F6
    db $0E, $F7, $0F, $3F, $C4, $9F, $E0, $60, $7F, $1F, $1F, $83, $00, $60, $40, $F0
    db $A0, $B8, $00, $EC, $00, $1C, $83, $60, $60, $F0, $90, $B8, $48, $EC, $F4, $1C
    db $1C, $00, $00, $0C, $04, $13, $12, $27, $34, $7F, $71, $F7, $8C, $C7, $CD, $0F
    db $34, $07, $00, $0C, $0C, $13, $1F, $2F, $3C, $7F, $48, $F7, $8C, $C7, $78, $0F
    db $F0, $0F, $F8, $11, $00, $E0, $C0, $E0, $00, $C0, $00, $80, $00, $7F, $9F, $80
    db $01, $E0, $E0, $E0, $20, $C0, $C0, $80, $80, $80, $80, $7F, $FF, $BF, $40, $00
    db $C0, $0B, $02, $33, $05, $09, $09, $35, $0A, $C7, $E1, $1F, $08, $FB, $40, $DC
    db $00, $3B, $FC, $3B, $3C, $09, $0E, $35, $3E, $C7, $FC, $1F, $F8, $FB, $E7, $DC
    db $3C, $80, $5F, $C0, $2F, $E3, $1C, $FF, $81, $FD, $28, $EB, $40, $3C, $00, $C0
    db $80, $BF, $00, $FE, $00, $FF, $00, $FD, $02, $F3, $1F, $3C, $FC, $C0, $C0, $3F
    db $00, $01, $00, $06, $3F, $01, $01, $06, $07, $07, $00, $20, $00, $30, $20, $70
    db $00, $D0, $40, $C0, $07, $20, $20, $10, $10, $70, $50, $D0, $B0, $E0, $20, $00
    db $04, $1F, $1E, $E7, $F8, $0B, $EC, $07, $02, $03, $ED, $E1, $18, $C7, $A0, $9B
    db $00, $1B, $18, $FF, $E0, $F3, $0C, $F7, $08, $EB, $1C, $E9, $1E, $C7, $3F, $9F
    db $7E, $00, $80, $A0, $00, $40, $80, $C0, $80, $A0, $40, $E0, $20, $90, $40, $A0
    db $80, $C0, $00, $A0, $60, $40, $C0, $C0, $40, $A0, $60, $E0, $20, $90, $70, $A0
    db $60, $C0, $40, $1F, $00, $01, $01, $03, $03, $07, $1F, $01, $01, $03, $02, $07
    db $04, $07, $00, $60, $60, $F0, $80, $38, $A8, $8C, $80, $BE, $07, $60, $60, $F0
    db $90, $78, $F8, $8C, $74, $BA, $62, $E0, $0C, $36, $06, $20, $11, $20, $06, $10
    db $00, $01, $E0, $36, $3B, $20, $3F, $20, $3F, $19, $1F, $01, $01, $00, $40, $1E
    db $6C, $6B, $A4, $3C, $02, $5E, $11, $9F, $28, $0F, $0E, $3F, $05, $2F, $00, $1E
    db $FE, $6B, $97, $7D, $C2, $DD, $E0, $DF, $E0, $4F, $70, $3F, $30, $3F, $38, $03
    db $00, $F0, $90, $FC, $04, $F7, $C0, $F7, $81, $73, $90, $F1, $03, $F0, $F0, $7C
    db $0C, $F7, $0B, $F7, $08, $77, $8E, $F9, $09, $1F, $00, $80, $00, $80, $00, $C0
    db $1F, $80, $80, $80, $80, $40, $40, $80, $10, $F8, $20, $F0, $40, $E0, $80, $A0
    db $3C, $7C, $FF, $FF, $F0, $F0, $80, $F8, $08, $F0, $10, $E0, $20, $A0, $60, $7C
    db $FC, $FF, $FF, $F0, $F0, $FF, $FF, $80, $63, $B1, $33, $03, $8D, $01, $30, $82
    db $00, $0E, $01, $02, $00, $01, $80, $B1, $DE, $03, $FC, $03, $FE, $CE, $FF, $0E
    db $0F, $02, $03, $01, $01, $00, $00, $E0, $40, $DF, $27, $E0, $17, $F0, $8B, $F8
    db $40, $7F, $B7, $37, $6B, $BA, $00, $E0, $20, $DF, $3F, $EF, $10, $EF, $00, $FF
    db $00, $7F, $80, $37, $C8, $BC, $C7, $8F, $1F, $1F, $7F, $7F, $1F, $1F, $8F, $1F
    db $1F, $7F, $7F, $1F, $1F, $80, $20, $4E, $10, $27, $08, $13, $14, $2B, $88, $FF
    db $F0, $FE, $F0, $FF, $80, $4E, $77, $27, $3B, $13, $1F, $2B, $3E, $FF, $FE, $FE
    db $FD, $FF, $FF, $00, $12, $30, $10, $39, $02, $2E, $00, $3D, $04, $3E, $05, $1F
    db $25, $3F, $21, $2B, $00, $35, $2F, $3B, $27, $2D, $33, $3F, $33, $3E, $32, $1F
    db $13, $3F, $33, $2B, $37, $00, $48, $0C, $00, $94, $40, $74, $00, $B8, $20, $78
    db $A0, $F8, $A0, $F8, $80, $D0, $00, $AC, $F4, $D4, $EC, $BC, $CC, $F8, $C8, $78
    db $48, $F8, $C8, $F8, $C8, $D0, $E8, $E0, $0B, $3F, $07, $1F, $0F, $0F, $03, $03
    db $01, $01, $E0, $3F, $27, $1F, $1F, $0F, $0F, $03, $03, $01, $01, $E0, $D0, $F8
    db $E0, $F8, $F0, $F0, $C0, $C0, $80, $80, $E0, $F8, $E0, $F8, $F8, $F0, $F0, $C0
    db $C0, $80, $80, $03, $00, $02, $02, $02, $02, $06, $00, $07, $02, $1F, $05, $1B
    db $0B, $02, $02, $06, $04, $07, $05, $1F, $1D, $1B, $16, $3F, $00, $18, $20, $D8
    db $3F, $18, $18, $D8, $E8, $00, $08, $0B, $0E, $23, $14, $23, $0C, $17, $0B, $23
    db $02, $31, $16, $2B, $09, $21, $00, $1B, $17, $23, $3C, $2B, $3C, $17, $18, $33
    db $3E, $39, $3E, $3B, $2C, $35, $2F, $00, $10, $D4, $70, $C4, $28, $E4, $30, $E8
    db $D0, $C0, $40, $88, $68, $D4, $90, $84, $00, $DC, $EC, $C4, $3C, $F4, $1C, $E8
    db $18, $C8, $78, $98, $78, $D4, $3C, $A4, $FC, $1F, $00, $03, $30, $CD, $E8, $0F
    db $1F, $03, $03, $FD, $CE, $F7, $00, $03, $00, $40, $00, $60, $00, $E0, $00, $A0
    db $00, $80, $00, $40, $03, $40, $40, $20, $20, $E0, $A0, $A0, $60, $C0, $40, $40
    db $C0, $00, $F0, $1F, $E0, $E6, $10, $26, $80, $BF, $A8, $FF, $12, $7F, $04, $9E
    db $00, $06, $00, $EF, $00, $DE, $01, $3F, $C1, $BF, $41, $7F, $C1, $FF, $E1, $9E
    db $99, $06, $05, $30, $00, $80, $00, $80, $00, $80, $80, $00, $40, $80, $00, $80
    db $00, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $C0, $C0, $C0
    db $C0, $00, $00, $06, $00, $07, $00, $07, $02, $0F, $0C, $1B, $11, $F8, $19, $81
    db $46, $80, $00, $06, $06, $07, $05, $07, $04, $0F, $0C, $1B, $16, $F8, $CF, $81
    db $FE, $81, $FF, $03, $00, $80, $00, $C0, $80, $E0, $80, $E0, $A6, $F9, $97, $DC
    db $03, $80, $80, $C0, $40, $E0, $20, $E0, $20, $FF, $19, $DB, $20, $F8, $18, $41
    db $00, $06, $00, $01, $F8, $67, $7F, $07, $07, $01, $01, $00, $01, $7C, $05, $7F
    db $08, $7B, $41, $FD, $21, $BB, $08, $7A, $11, $3A, $00, $3D, $00, $7F, $80, $7E
    db $80, $7B, $84, $FE, $87, $BA, $C7, $7B, $67, $3B, $27, $3F, $27, $FF, $FF, $3F
    db $06, $39, $07, $FC, $3F, $3F, $39, $FB, $C0, $00, $00, $1D, $01, $3E, $00, $5F
    db $00, $6F, $01, $3F, $00, $2F, $1C, $36, $0C, $56, $00, $1D, $1D, $3E, $23, $7F
    db $70, $7F, $78, $37, $38, $3F, $31, $25, $3B, $71, $7F, $00, $81, $3C, $05, $7F
    db $08, $FB, $01, $BD, $A1, $FB, $88, $7A, $11, $FA, $00, $BD, $00, $3F, $C0, $7E
    db $80, $FB, $04, $7E, $C7, $7A, $C7, $7B, $E7, $FB, $E7, $BF, $A7, $00, $10, $30
    db $10, $34, $10, $34, $13, $37, $3B, $17, $37, $2F, $1F, $1F, $1F, $1F, $00, $34
    db $2C, $34, $2C, $34, $2C, $37, $2F, $17, $2F, $2F, $1F, $1F, $1F, $1F, $1F, $00
    db $18, $BC, $10, $BC, $00, $BC, $00, $FC, $E0, $F8, $E0, $E0, $E0, $E0, $F0, $F0
    db $00, $FC, $E4, $FC, $E4, $FC, $E4, $FC, $E4, $F8, $F8, $E0, $E0, $E0, $E0, $F0
    db $F0, $F0, $1F, $1F, $07, $07, $07, $07, $03, $03, $F0, $1F, $1F, $07, $07, $07
    db $07, $03, $03, $F8, $F0, $F0, $B0, $B0, $80, $80, $F8, $F0, $F0, $B0, $B0, $80
    db $80, $00, $00, $02, $02, $00, $00, $04, $02, $FC, $48, $67, $04, $47, $28, $47
    db $18, $2F, $00, $02, $02, $02, $00, $04, $06, $FC, $FE, $67, $1F, $7F, $78, $57
    db $78, $2F, $30, $07, $00, $F8, $48, $9C, $80, $88, $50, $88, $60, $D0, $07, $F8
    db $F8, $9C, $E4, $F8, $78, $A8, $78, $D0, $30, $00, $17, $07, $04, $23, $0C, $37
    db $13, $23, $04, $20, $18, $33, $17, $10, $34, $17, $00, $27, $3C, $33, $3C, $37
    db $38, $2B, $3F, $2B, $3F, $37, $2F, $10, $2F, $13, $2F, $00, $A0, $80, $80, $10
    db $C0, $A8, $30, $08, $90, $08, $00, $08, $C0, $00, $18, $C4, $00, $90, $F0, $30
    db $F0, $B8, $78, $48, $F8, $48, $F8, $98, $F8, $38, $F8, $E4, $FC, $00, $30, $53
    db $30, $74, $30, $70, $30, $78, $17, $FF, $07, $FF, $07, $7F, $17, $EF, $00, $53
    db $6F, $74, $4C, $70, $48, $78, $48, $FF, $CF, $FF, $CF, $7F, $4F, $EF, $9F, $00
    db $00, $10, $00, $90, $40, $D0, $00, $A0, $00, $E0, $00, $90, $80, $F0, $E0, $E0
    db $00, $30, $F0, $F0, $F0, $B0, $F0, $E0, $E0, $E0, $E0, $F0, $F0, $F0, $F0, $E0
    db $E0, $F0, $7F, $7F, $3F, $3F, $07, $07, $03, $03, $F0, $7F, $7F, $3F, $3F, $07
    db $07, $03, $03, $F8, $E0, $E0, $E0, $E0, $80, $80, $F8, $E0, $E0, $E0, $E0, $80
    db $80, $00, $01, $01, $00, $00, $3A, $09, $36, $10, $17, $1C, $47, $28, $47, $18
    db $2F, $01, $01, $01, $00, $3A, $3B, $36, $2F, $37, $2F, $47, $78, $57, $78, $2F
    db $30, $00, $00, $00, $00, $00, $30, $40, $B0, $20, $A0, $E0, $88, $50, $C8, $60
    db $D0, $00, $00, $00, $00, $30, $30, $B0, $D0, $B0, $D0, $88, $78, $E8, $38, $D0
    db $30, $17, $07, $04, $23, $2C, $57, $33, $43, $04, $40, $38, $73, $3F, $78, $1F
    db $5C, $27, $3C, $33, $3C, $57, $78, $4B, $7F, $4B, $7F, $77, $4F, $78, $47, $5C
    db $63, $A0, $80, $80, $10, $D0, $A0, $20, $00, $90, $10, $70, $38, $B0, $38, $20
    db $28, $90, $F0, $30, $F0, $A0, $70, $40, $F0, $50, $E0, $B8, $C8, $38, $C8, $A8
    db $D8, $FF, $FF, $7F, $00, $1F, $7F, $1F, $1F, $01, $C6, $39, $FD, $81, $3E, $83
    db $BC, $FC, $02, $64, $30, $B7, $35, $7F, $01, $FF, $39, $7E, $00, $FD, $00, $DB
    db $00, $67, $98, $D7, $E8, $4B, $FC, $00, $00, $7C, $00, $B0, $00, $E8, $00, $F0
    db $00, $D0, $00, $D0, $00, $F8, $00, $FC, $00, $7A, $62, $BC, $CC, $E8, $18, $F0
    db $10, $D0, $30, $F0, $30, $F8, $38, $FC, $3C, $3F, $00, $01, $01, $03, $3F, $01
    db $01, $03, $02, $07, $00, $20, $00, $60, $00, $F0, $80, $78, $10, $7C, $07, $20
    db $20, $60, $40, $F0, $90, $78, $C8, $7C, $C4, $F0, $06, $1B, $03, $10, $08, $10
    db $03, $08, $F0, $1B, $1D, $10, $1F, $10, $1F, $0C, $0F, $00, $30, $1C, $34, $3F
    db $D2, $1B, $00, $2F, $00, $CF, $01, $2F, $08, $1F, $04, $17, $00, $1C, $E4, $3F
    db $C3, $3B, $E4, $EF, $F0, $EF, $F0, $2F, $30, $1F, $10, $17, $18, $FF, $FF, $7F
    db $00, $06, $7F, $06, $06, $03, $C6, $39, $FD, $81, $3E, $83, $BC, $FC, $02, $64
    db $B4, $B7, $03, $FF, $39, $7E, $00, $FD, $00, $DB, $00, $67, $98, $57, $E8, $00
    db $00, $0E, $00, $1C, $08, $FC, $08, $E4, $10, $E8, $00, $F0, $00, $F0, $00, $F0
    db $00, $0A, $0A, $1C, $14, $FC, $E4, $E4, $1C, $E8, $18, $F0, $10, $F0, $10, $F0
    db $10, $4F, $00, $01, $00, $01, $00, $01, $4F, $01, $01, $01, $01, $01, $01, $0F
    db $00, $C0, $00, $E0, $00, $F0, $40, $F8, $0F, $C0, $C0, $E0, $20, $F0, $90, $F8
    db $88, $E0, $01, $03, $06, $1B, $03, $10, $08, $10, $03, $08, $E0, $03, $02, $1B
    db $1D, $10, $1F, $10, $1F, $0C, $0F, $00, $10, $7C, $30, $1C, $34, $3F, $D2, $1B
    db $00, $2F, $00, $CF, $01, $2F, $08, $1F, $00, $7C, $C4, $1C, $E4, $3F, $C3, $3B
    db $E4, $EF, $F0, $EF, $F0, $2F, $30, $1F, $10, $FF, $FF, $1F, $00, $08, $00, $0C
    db $00, $1C, $1F, $08, $08, $04, $04, $1C, $14, $01, $C6, $39, $FD, $81, $3E, $83
    db $BC, $FC, $0A, $6C, $34, $B7, $35, $79, $01, $FF, $39, $7E, $00, $FD, $00, $DB
    db $00, $67, $98, $DF, $E8, $49, $FE, $00, $00, $74, $00, $B0, $00, $E8, $00, $F0
    db $00, $D0, $00, $D0, $00, $F0, $00, $F8, $00, $74, $6C, $B8, $C8, $E8, $18, $F0
    db $10, $D0, $30, $F0, $30, $F0, $30, $F8, $18, $3F, $00, $01, $01, $03, $3F, $01
    db $01, $03, $02, $07, $00, $C0, $00, $E0, $00, $F0, $80, $78, $10, $5C, $07, $C0
    db $C0, $E0, $A0, $F0, $90, $78, $C8, $5C, $E4, $F0, $06, $1B, $03, $10, $08, $10
    db $03, $08, $F0, $1B, $1D, $10, $1F, $10, $1F, $0C, $0F, $00, $70, $1C, $34, $3F
    db $D2, $1B, $00, $2F, $00, $CF, $01, $2F, $08, $1F, $04, $37, $00, $1C, $E4, $3F
    db $C3, $3B, $E4, $EF, $F0, $EF, $F0, $2F, $30, $1F, $10, $37, $38, $FF, $FF, $FF
    db $FF, $03, $C6, $39, $FD, $81, $3E, $83, $BC, $FC, $02, $64, $F0, $F7, $03, $FF
    db $39, $7E, $00, $FD, $00, $DB, $00, $67, $98, $9F, $68, $00, $00, $0E, $00, $1F
    db $00, $F6, $00, $F8, $00, $F0, $00, $E0, $00, $C0, $00, $E0, $00, $0E, $0E, $1D
    db $11, $F6, $EE, $F8, $08, $F0, $10, $E0, $20, $E0, $20, $E0, $20, $3F, $00, $01
    db $00, $01, $3F, $01, $01, $01, $01, $0F, $00, $40, $00, $E0, $00, $F0, $40, $F8
    db $0F, $40, $40, $E0, $A0, $F0, $10, $F8, $88, $E0, $01, $03, $06, $1B, $03, $10
    db $08, $10, $03, $08, $E0, $03, $02, $1B, $1D, $10, $1F, $10, $1F, $0C, $0F, $00
    db $10, $7C, $30, $1C, $34, $3F, $D2, $1B, $00, $2F, $00, $CF, $18, $2F, $0C, $17
    db $00, $7C, $C4, $1C, $E4, $3F, $C3, $3B, $E4, $EF, $F0, $EF, $F0, $2F, $30, $17
    db $18, $81, $80, $00, $00, $80, $00, $D0, $40, $90, $80, $20, $00, $C0, $81, $00
    db $80, $80, $80, $D0, $F0, $90, $F0, $20, $E0, $C0, $C0, $FF, $FF, $FF, $FF, $FF
    db $FF, $82, $00, $1F, $00, $01, $03, $00, $02, $04, $00, $04, $07, $06, $82, $1F
    db $1F, $01, $01, $00, $03, $04, $07, $04, $07, $06, $07, $00, $40, $81, $01, $62
    db $C3, $07, $3E, $3A, $FC, $FD, $20, $26, $F3, $00, $00, $FE, $00, $81, $FF, $62
    db $7F, $07, $FC, $3A, $C5, $FD, $03, $26, $FF, $00, $FF, $FE, $FE, $FF, $FF, $FF
    db $FF, $0F, $00, $80, $00, $80, $80, $C0, $40, $E0, $0F, $80, $80, $80, $80, $C0
    db $40, $E0, $20, $FF, $FF, $00, $80, $E0, $A0, $10, $C0, $10, $E0, $10, $E0, $10
    db $C0, $20, $C0, $00, $00, $80, $00, $60, $20, $F0, $10, $F0, $10, $F0, $10, $F0
    db $10, $E0, $20, $80, $40, $80, $80, $FF, $FF, $03, $00, $7F, $40, $7F, $1A, $7F
    db $01, $03, $01, $05, $00, $04, $03, $7F, $7F, $7F, $00, $7F, $64, $03, $02, $05
    db $06, $04, $07, $00, $00, $04, $02, $04, $00, $82, $81, $C3, $00, $FE, $67, $FF
    db $80, $FF, $82, $FF, $00, $04, $04, $04, $06, $82, $83, $C3, $42, $FE, $7F, $FF
    db $18, $FF, $00, $F9, $00, $80, $02, $04, $00, $01, $00, $60, $40, $9E, $31, $BF
    db $01, $3E, $00, $07, $00, $04, $07, $01, $01, $60, $60, $9E, $FF, $BF, $C0, $3E
    db $3F, $07, $07, $1F, $1F, $00, $74, $7C, $35, $C4, $15, $E6, $87, $E6, $BD, $BC
    db $FD, $FC, $1E, $DE, $5E, $1F, $00, $7B, $80, $C7, $F8, $E7, $F8, $E5, $78, $BF
    db $40, $FF, $00, $DF, $E0, $9F, $E0, $78, $10, $08, $60, $90, $00, $A0, $00, $80
    db $78, $08, $F8, $90, $F0, $E0, $E0, $80, $80, $FF, $FF, $FF, $FF, $FF, $FF, $E0
    db $04, $0D, $00, $05, $03, $05, $01, $02, $00, $01, $E0, $09, $0F, $05, $07, $05
    db $06, $02, $03, $01, $01, $00, $40, $E0, $42, $D1, $E0, $C2, $04, $62, $F8, $06
    db $04, $FA, $02, $05, $01, $00, $00, $FE, $3F, $DD, $3F, $DE, $3E, $7A, $FE, $06
    db $FE, $FA, $FE, $0D, $0F, $02, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $10
    db $00, $F0, $28, $FC, $E4, $02, $00, $7C, $00, $98, $10, $FC, $B8, $DC, $10, $F0
    db $F0, $FC, $04, $02, $FE, $7C, $7C, $98, $98, $FC, $64, $DC, $64, $FF, $FF, $00
    db $70, $10, $68, $28, $27, $1C, $47, $28, $47, $1B, $2B, $10, $01, $0A, $22, $70
    db $70, $68, $58, $67, $5F, $47, $78, $57, $78, $2B, $36, $21, $3E, $32, $3D, $00
    db $30, $40, $B0, $20, $A0, $E0, $80, $50, $C0, $E0, $D0, $20, $80, $C0, $D0, $30
    db $30, $B0, $D0, $B0, $D0, $80, $70, $E0, $30, $D0, $70, $90, $70, $D0, $F0, $07
    db $10, $00, $38, $10, $4F, $10, $F3, $6A, $78, $22, $9D, $01, $33, $04, $0E, $18
    db $1F, $3F, $3F, $4F, $7F, $F3, $8F, $78, $87, $9D, $FE, $3F, $3E, $0A, $0F, $20
    db $17, $0D, $DF, $0F, $E0, $18, $9C, $08, $4C, $00, $C5, $03, $C5, $05, $C1, $DF
    db $FF, $F7, $F8, $F0, $FF, $E4, $FC, $74, $FC, $FD, $7D, $FD, $7E, $F9, $7E, $00
    db $16, $27, $09, $15, $00, $0C, $00, $0A, $04, $06, $00, $02, $04, $02, $02, $01
    db $00, $27, $39, $15, $1E, $0C, $0F, $0A, $0E, $06, $02, $02, $06, $02, $06, $01
    db $03, $C0, $43, $C4, $07, $38, $0E, $C1, $07, $38, $03, $08, $00, $07, $C0, $C4
    db $3F, $38, $FF, $F1, $FF, $38, $3F, $0C, $0F, $07, $07, $FF, $FF, $FF, $FF, $00
    db $03, $05, $1F, $1B, $3B, $37, $7B, $02, $58, $01, $04, $00, $04, $00, $1E, $03
    db $03, $1F, $19, $3B, $24, $7B, $4C, $5C, $7F, $06, $07, $04, $07, $1E, $1F, $00
    db $FC, $94, $F2, $F8, $FA, $FC, $FC, $50, $78, $80, $04, $00, $38, $40, $60, $FC
    db $FC, $F2, $0E, $FA, $06, $FC, $18, $78, $BC, $04, $FC, $38, $F8, $20, $E0, $12
    db $7F, $1F, $BF, $30, $AC, $34, $67, $00, $46, $22, $4F, $26, $5F, $1E, $2E, $7F
    db $61, $BF, $C0, $AC, $DF, $63, $5F, $47, $7F, $4F, $79, $5F, $71, $2E, $31, $00
    db $B0, $10, $4C, $9C, $43, $0C, $80, $03, $3C, $00, $20, $00, $3E, $13, $F4, $F0
    db $F0, $6C, $FC, $63, $FF, $F0, $FF, $FC, $FF, $E0, $E0, $FE, $FE, $F4, $CF, $FE
    db $30, $74, $FE, $4C, $7C, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $00, $03, $FE, $03
    db $03, $FE, $00, $70, $FE, $70, $70, $FF, $FF, $FF, $FF, $03, $00, $C0, $40, $70
    db $80, $98, $08, $94, $20, $94, $A8, $DC, $03, $C0, $C0, $70, $B0, $98, $78, $94
    db $FC, $94, $FC, $DC, $74, $FF, $FF, $00, $90, $74, $00, $74, $88, $F4, $B8, $BC
    db $D8, $F4, $68, $7C, $20, $3C, $38, $BC, $00, $74, $CC, $F4, $8C, $F4, $0C, $BC
    db $4C, $F4, $4C, $7C, $84, $3C, $C4, $BC, $DC, $FF, $FF, $00, $00, $00, $01, $00
    db $02, $03, $06, $00, $0A, $0D, $04, $04, $1D, $12, $6E, $00, $00, $01, $01, $03
    db $02, $07, $04, $0A, $0D, $04, $0B, $1D, $1B, $6E, $79, $00, $7C, $FC, $03, $F4
    db $06, $12, $1F, $04, $9F, $3A, $9F, $69, $BE, $99, $7E, $7C, $7C, $7F, $83, $FA
    db $01, $EF, $00, $9F, $E3, $9F, $E4, $BE, $C5, $7E, $C5, $79, $87, $81, $47, $09
    db $83, $03, $0B, $06, $0B, $03, $07, $01, $05, $02, $04, $87, $F8, $47, $C8, $83
    db $8C, $0B, $0C, $0B, $0C, $07, $04, $05, $06, $04, $07, $12, $B6, $2A, $A6, $0B
    db $B6, $29, $B5, $30, $7A, $10, $B9, $10, $B9, $50, $98, $B7, $CD, $A7, $DD, $B6
    db $DD, $B5, $DE, $FE, $CF, $BB, $CB, $B9, $C9, $98, $E8, $02, $3C, $28, $6B, $0E
    db $23, $14, $23, $0C, $37, $0B, $23, $02, $31, $16, $2B, $3F, $3C, $5B, $77, $23
    db $3C, $2B, $3C, $37, $38, $33, $3E, $39, $3E, $3B, $2C, $C4, $DE, $18, $FA, $70
    db $C4, $28, $E4, $30, $E8, $D0, $C0, $40, $8C, $68, $D4, $3E, $7A, $FA, $E6, $C4
    db $3C, $F4, $1C, $E8, $18, $C8, $78, $9C, $7C, $D4, $3C, $11, $31, $12, $38, $03
    db $29, $00, $39, $04, $3E, $05, $1F, $25, $3F, $21, $2B, $35, $2F, $3D, $27, $2D
    db $37, $3B, $37, $3E, $32, $1F, $13, $3F, $33, $2B, $37, $88, $8C, $40, $14, $C0
    db $94, $00, $98, $20, $78, $A0, $F8, $A0, $F8, $80, $D0, $AC, $F4, $B4, $EC, $BC
    db $EC, $D8, $E8, $78, $48, $F8, $C8, $F8, $C8, $D0, $E8, $1F, $00, $03, $30, $CD
    db $E8, $0F, $1F, $03, $03, $FD, $CE, $F7, $00, $03, $00, $20, $00, $30, $00, $70
    db $00, $D0, $00, $A0, $00, $40, $03, $20, $20, $10, $10, $70, $50, $D0, $B0, $E0
    db $60, $40, $C0, $FF, $FF, $FF, $FF, $01, $00, $06, $00, $07, $00, $07, $02, $0F
    db $08, $1B, $11, $F9, $18, $80, $01, $06, $06, $07, $05, $07, $04, $0F, $0C, $1B
    db $16, $F9, $CE, $81, $FF, $01, $00, $40, $00, $60, $20, $F0, $20, $F0, $80, $F0
    db $A6, $E9, $97, $DC, $01, $40, $40, $60, $60, $F0, $D0, $F0, $10, $F0, $10, $EF
    db $19, $DB, $20, $F0, $46, $81, $08, $70, $04, $03, $10, $0C, $F0, $81, $FF, $7F
    db $7F, $0F, $0F, $1C, $1C, $FF, $FF, $FF, $FF, $3F, $70, $08, $E0, $70, $7F, $00
    db $70, $00, $03, $04, $27, $10, $E4, $1B, $E3, $18, $DE, $22, $AF, $54, $A7, $D8
    db $1C, $00, $00, $00, $07, $08, $38, $08, $88, $04, $03, $01, $1F, $03, $8F, $3F
    db $FF, $3E, $3F, $40, $80, $7C, $A8, $58, $80, $40, $E0, $60, $18, $E0, $F0, $00
    db $60, $60, $00, $00, $C0, $00, $38, $38, $F8, $18, $F8, $F8, $F8, $F8, $F8, $E0
    db $F0, $60, $80, $03, $15, $17, $5A, $65, $90, $EF, $A0, $DF, $3E, $41, $53, $2C
    db $03, $08, $1F, $00, $78, $0F, $FF, $0F, $EF, $80, $FE, $80, $D0, $03, $80, $FC
    db $7B, $85, $F4, $03, $07, $F8, $0B, $F4, $F5, $0A, $03, $00, $FC, $00, $03, $F8
    db $F9, $F8, $F9, $00, $09, $00, $05, $00, $60, $3F, $05, $72, $58, $63, $38, $0F
    db $09, $06, $8F, $80, $DC, $D0, $31, $71, $00, $BF, $9F, $B8, $BC, $37, $FF, $77
    db $FF, $7F, $FF, $CF, $7F, $9E, $6F, $39, $4E, $00, $01, $FD, $A0, $5E, $19, $EE
    db $7B, $84, $F8, $00, $08, $00, $07, $07, $FF, $F7, $00, $FD, $FE, $0F, $3F, $F7
    db $FF, $FF, $FF, $FF, $FF, $F8, $FF, $0F, $F8, $FF, $08, $06, $07, $0E, $11, $15
    db $08, $36, $29, $0E, $31, $35, $0A, $10, $3F, $A5, $BE, $00, $07, $00, $1E, $23
    db $37, $03, $37, $40, $6B, $00, $64, $9F, $CF, $18, $FD, $00, $00, $E0, $70, $88
    db $F4, $32, $DD, $85, $FA, $28, $DF, $F9, $86, $4B, $B4, $00, $00, $00, $F0, $00
    db $CC, $E0, $FB, $7C, $FF, $04, $3E, $00, $C0, $70, $F8, $18, $07, $40, $47, $88
    db $87, $7F, $70, $30, $30, $0E, $0E, $01, $01, $00, $00, $3B, $FB, $3F, $FF, $CF
    db $7F, $3F, $4F, $3F, $0F, $0E, $01, $01, $00, $00, $00, $E0, $5D, $09, $FF, $F9
    db $06, $FB, $04, $18, $00, $10, $00, $EC, $EC, $0C, $0C, $8C, $FE, $F6, $FF, $FF
    db $FF, $FF, $FF, $FE, $FE, $18, $FE, $FC, $10, $0C, $00, $FF, $FF, $1F, $70, $00
    db $E0, $70, $00, $F8, $3F, $00, $70, $00, $40, $80, $02, $01, $07, $08, $2E, $11
    db $F5, $02, $EE, $12, $F9, $02, $97, $68, $02, $00, $02, $00, $30, $08, $81, $01
    db $0F, $07, $1F, $0F, $9F, $3C, $3F, $80, $30, $C0, $40, $88, $C8, $40, $9C, $40
    db $3C, $C0, $F0, $00, $C0, $00, $00, $38, $B8, $78, $78, $08, $F8, $3C, $FC, $FC
    db $FC, $F8, $F8, $E0, $E0, $80, $C0, $0F, $03, $04, $27, $10, $E4, $13, $E3, $18
    db $0F, $00, $07, $08, $38, $08, $80, $04, $03, $03, $70, $08, $E0, $70, $80, $7C
    db $A8, $58, $80, $40, $E0, $60, $07, $00, $70, $00, $C0, $00, $38, $38, $F8, $18
    db $F8, $F0, $DE, $22, $AF, $54, $A7, $D8, $1C, $00, $F0, $01, $1F, $03, $8F, $3F
    db $FF, $3E, $3F, $F4, $18, $E0, $F0, $00, $60, $60, $F0, $F8, $F8, $F8, $F8, $E0
    db $F0, $60, $80, $03, $78, $07, $1D, $23, $00, $7F, $00, $7F, $00, $7F, $62, $15
    db $03, $80, $A8, $C0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F8, $FC, $03, $8B, $74
    db $F4, $FB, $00, $FF, $00, $FF, $00, $FF, $DE, $21, $03, $00, $F9, $00, $FD, $FF
    db $FF, $FF, $FF, $FF, $FF, $00, $C0, $00, $45, $12, $40, $17, $5F, $33, $0B, $3F
    db $30, $0F, $0F, $00, $5E, $58, $20, $20, $00, $68, $7D, $6B, $7B, $60, $7F, $70
    db $7F, $7F, $7F, $7F, $7F, $27, $7F, $04, $3F, $00, $3F, $C0, $5A, $25, $FF, $FF
    db $FF, $FF, $00, $FF, $FF, $00, $03, $03, $FC, $F8, $01, $80, $C3, $00, $FF, $00
    db $FF, $FF, $FF, $FF, $FF, $84, $FF, $FC, $07, $1F, $01, $00, $03, $00, $03, $00
    db $1F, $01, $01, $03, $03, $03, $03, $1F, $C0, $00, $00, $20, $E0, $10, $1F, $E0
    db $E0, $F0, $F0, $F0, $F0, $00, $03, $00, $07, $04, $0E, $09, $1D, $02, $1F, $00
    db $61, $0F, $F4, $02, $1E, $E0, $00, $03, $03, $03, $07, $06, $0F, $1D, $1F, $1F
    db $1F, $7E, $7F, $FE, $FE, $9E, $FE, $E0, $E0, $10, $20, $D0, $80, $60, $80, $40
    db $80, $80, $E0, $F0, $F0, $F0, $F0, $E0, $E0, $80, $C0, $00, $80, $1F, $D0, $28
    db $D0, $28, $F3, $08, $1F, $00, $98, $04, $14, $04, $31, $FF, $FF, $00, $92, $6D
    db $69, $12, $26, $1D, $39, $06, $1C, $01, $0E, $01, $0F, $08, $05, $04, $00, $04
    db $B4, $64, $78, $70, $7E, $3C, $3F, $3E, $3F, $0F, $1F, $0F, $07, $05, $03, $00
    db $80, $00, $30, $C0, $B8, $70, $08, $FC, $20, $10, $10, $08, $20, $80, $00, $80
    db $02, $00, $80, $00, $70, $80, $98, $60, $E0, $B0, $F0, $E0, $E0, $80, $80, $07
    db $01, $00, $03, $01, $01, $03, $02, $01, $0A, $05, $0F, $00, $01, $00, $01, $00
    db $02, $00, $08, $03, $40, $00, $C0, $40, $80, $E0, $20, $C0, $C0, $10, $10, $00
    db $07, $00, $40, $00, $C0, $20, $20, $F0, $F0, $D0, $F0, $00, $1F, $00, $1D, $02
    db $1B, $25, $30, $47, $79, $82, $EF, $10, $D4, $28, $20, $E0, $00, $00, $11, $00
    db $01, $00, $23, $0B, $17, $07, $0F, $07, $0F, $0E, $1F, $1C, $BC, $C0, $90, $88
    db $78, $C0, $38, $C0, $E0, $00, $C0, $00, $80, $00, $80, $38, $F8, $38, $F8, $F8
    db $F8, $F0, $F0, $E0, $E0, $C0, $E0, $00, $80, $07, $02, $02, $0B, $03, $04, $06
    db $0C, $0D, $03, $03, $07, $02, $0D, $0C, $1F, $10, $1F, $0C, $13, $09, $0E, $07
    db $E0, $E0, $70, $70, $E8, $E8, $70, $38, $50, $40, $07, $E0, $18, $08, $FC, $EC
    db $14, $30, $CC, $00, $F8, $A0, $05, $04, $0D, $0F, $06, $02, $0B, $0B, $05, $05
    db $00, $02, $A0, $04, $0B, $09, $06, $02, $0D, $09, $06, $0C, $0B, $00, $02, $60
    db $A8, $A8, $B0, $A0, $88, $D0, $E8, $68, $40, $20, $40, $40, $20, $20, $D8, $80
    db $78, $00, $F8, $48, $B0, $08, $F8, $00, $10, $40, $00, $03, $80, $00, $0F, $47
    db $22, $03, $03, $1E, $1F, $2B, $46, $5F, $03, $00, $01, $07, $00, $03, $1C, $0F
    db $20, $36, $00, $58, $20, $00, $40, $00, $00, $40, $40, $40, $16, $06, $B3, $F3
    db $74, $8F, $FF, $BD, $D8, $BD, $03, $00, $80, $46, $B0, $B3, $0C, $BE, $00, $0D
    db $00, $91, $02, $00, $2F, $6D, $6B, $78, $BB, $3D, $7F, $80, $3D, $6F, $3B, $2E
    db $1D, $57, $0B, $0E, $88, $29, $10, $20, $06, $10, $02, $04, $10, $02, $10, $01
    db $08, $00, $5D, $17, $FE, $AA, $FF, $12, $FF, $00, $FE, $16, $FB, $AE, $7F, $14
    db $4C, $9A, $08, $A1, $00, $00, $05, $00, $09, $04, $01, $08, $01, $90, $02, $20
    db $00, $E0, $05, $04, $0B, $14, $01, $0A, $04, $00, $00, $09, $FF, $C0, $C4, $10
    db $C0, $2A, $30, $82, $00, $40, $00, $08, $00, $80, $FF, $FF, $FF, $E3, $80, $80
    db $00, $80, $80, $00, $FF, $03, $F0, $F0, $23, $FF, $00, $FF, $C0, $FE, $18, $78
    db $17, $F0, $00, $00, $F0, $00, $FC, $F0, $0F, $FF, $00, $FF, $00, $FE, $01, $78
    db $87, $F0, $0F, $0F, $00, $80, $20, $00, $60, $00, $40, $00, $03, $00, $80, $00
    db $E0, $80, $70, $00, $F0, $00, $F0, $80, $70, $00, $24, $E0, $C7, $06, $BF, $08
    db $9F, $F1, $FC, $0E, $A0, $70, $23, $38, $42, $2D, $80, $E3, $1C, $06, $F9, $08
    db $77, $00, $0A, $01, $60, $0E, $00, $C0, $03, $00, $B0, $00, $A0, $00, $40, $40
    db $98, $80, $30, $00, $40, $00, $4D, $4E, $80, $80, $00, $00, $F0, $40, $A0, $A0
    db $00, $40, $18, $08, $30, $30, $40, $A0, $00, $40, $00, $0F, $04, $00, $06, $00
    db $03, $00, $03, $00, $07, $00, $03, $00, $07, $00, $07, $04, $03, $04, $03, $01
    db $20, $3C, $09, $79, $9C, $FF, $70, $7F, $D0, $DF, $FF, $FF, $7C, $7D, $01, $3C
    db $03, $79, $86, $FF, $00, $7F, $80, $DF, $20, $FF, $00, $7D, $82, $00, $06, $00
    db $03, $02, $00, $01, $01, $01, $07, $05, $03, $02, $A0, $60, $01, $00, $C8, $01
    db $06, $00, $01, $02, $00, $00, $02, $00, $01, $00, $B9, $21, $08, $00, $E0, $00
    db $D2, $B0, $54, $C7, $FE, $32, $20, $21, $3B, $0D, $80, $21, $DE, $87, $78, $01
    db $FE, $0C, $03, $28, $10, $01, $C8, $40, $8E, $3A, $32, $3E, $03, $00, $03, $03
    db $0F, $FF, $18, $3E, $C0, $00, $FF, $04, $0B, $00, $01, $03, $04, $FF, $00, $01
    db $20, $20, $18, $18, $44, $04, $20, $00, $20, $20, $C8, $C0, $30, $00, $01, $20
    db $C0, $18, $E0, $04, $F8, $00, $FC, $20, $DC, $C0, $38, $00, $F8, $38, $83, $80
    db $F6, $00, $F0, $00, $02, $02, $00, $20, $E0, $80, $7F, $01, $FE, $0C, $F2, $C0
    db $01, $03, $04, $FE, $C0, $00, $F0, $20, $D0, $00, $80, $00, $70, $80, $40, $00
    db $01, $01, $0B, $0F, $3D, $3C, $2C, $20, $08, $00, $06, $06, $02, $03, $60, $00
    db $00, $01, $00, $0F, $00, $3C, $03, $20, $5E, $00, $FC, $06, $F8, $03, $7C, $00
    db $FF, $38, $98, $F8, $3E, $00, $80, $00, $80, $80, $33, $3F, $38, $F8, $07, $00
    db $FF, $40, $80, $80, $00, $3F, $C0, $BC, $3D, $01, $09, $00, $01, $01, $E0, $01
    db $7E, $06, $19, $00, $61, $20, $58, $08, $04, $10, $DF, $FF, $E0, $00, $3F, $00
    db $1C, $00, $58, $58, $83, $83, $04, $26, $D0, $FF, $00, $00, $FF, $C0, $3F, $01
    db $3E, $80, $00, $FB, $00, $07, $FB, $07, $80, $03, $20, $E0, $44, $7C, $00, $06
    db $01, $03, $04, $06, $02, $0E, $03, $E0, $00, $7C, $80, $06, $18, $03, $04, $06
    db $09, $0E, $31, $FD, $00, $06, $F9, $06, $11, $00, $03, $FC, $28, $38, $A0, $E0
    db $FC, $38, $44, $E0, $10, $07, $0C, $0F, $14, $1C, $00, $30, $60, $60, $30, $30
    db $07, $0F, $00, $1C, $22, $30, $48, $60, $10, $30, $40, $F3, $63, $7F, $80, $80
    db $F3, $7F, $00, $80, $40, $FF, $F8, $00, $3E, $00, $1B, $00, $04, $FF, $F8, $00
    db $80, $00, $E0, $00, $02, $1F, $08, $14, $0E, $32, $0C, $3E, $FF, $00, $00, $20
    db $20, $50, $70, $88, $E8, $98, $A8, $D8, $00, $70, $70, $51, $51, $FA, $FF, $00
    db $19, $19, $0C, $0C, $02, $02, $05, $0B, $18, $07, $08, $09, $1E, $1E, $09, $7D
    db $18, $06, $00, $03, $00, $01, $00, $06, $00, $01, $00, $02, $00, $00, $DB, $FF
    db $9C, $BC, $49, $7A, $86, $7D, $07, $F9, $4D, $FE, $B1, $F1, $A5, $ED, $39, $42
    db $00, $84, $00, $0E, $00, $10, $00, $0F, $40, $A0, $60, $F0, $41, $D0, $11, $7B
    db $BF, $20, $00, $00, $00, $18, $18, $20, $10, $2C, $18, $3C, $10, $10, $08, $18
    db $81, $09, $01, $83, $EF, $08, $00, $9A, $00, $19, $08, $08, $34, $2C, $12, $1E
    db $FF, $28, $86, $C6, $40, $C0, $10, $10, $A4, $A4, $28, $28, $02, $02, $FF, $DD
    db $20, $20, $00, $01, $FF, $1F, $00, $E0, $20, $B0, $40, $58, $3F, $40, $00, $20
    db $00, $83, $00, $04, $04, $06, $00, $05, $01, $02, $00, $01, $EF, $02, $00, $FC
    db $30, $68, $00, $30, $FF, $F8, $00, $06, $08, $14, $00, $08, $FF, $FB, $10, $10
    db $FF, $C1, $00, $08, $08, $18, $00, $28, $30, $50, $00, $30, $F7, $10, $00, $83
    db $00, $42, $02, $C2, $00, $85, $02, $05, $00, $02, $EF, $02, $00, $03, $00, $80
    db $80, $80, $00, $80, $80, $80, $10, $08, $30, $18, $FF, $1F, $00, $18, $18, $24
    db $28, $6E, $7F, $10, $00, $B6, $00, $30, $80, $80, $08, $08, $FF, $9C, $20, $78
    db $00, $C0, $10, $28, $08, $18, $FF, $FF, $FF, $41, $00, $03, $03, $04, $02, $04
    db $02, $06, $00, $03, $40, $80, $E7, $01, $00, $01, $00, $C0, $00, $40, $40, $A0
    db $E0, $D0, $60, $F0, $00, $60, $04, $04, $FF, $7C, $60, $C0, $00, $60, $10, $10
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FC, $08, $08, $10, $10, $F9, $08, $00, $10, $00, $FF, $FF, $E7, $41, $41
    db $20, $20, $F3, $40, $00, $20, $00, $C3, $00, $02, $02, $06, $03, $07, $02, $02
    db $FF, $E3, $02, $00, $05, $03, $02, $02, $EF, $01, $00, $0F, $02, $06, $05, $07
    db $00, $03, $03, $03, $FF, $FF, $FF, $C7, $00, $06, $02, $03, $03, $03, $FF, $1F
    db $00, $01, $00, $02, $01, $05, $3F, $01, $00, $02, $00, $F0, $02, $00, $05, $01
    db $06, $04, $03, $03, $F9, $02, $00, $03, $00, $C0, $02, $02, $00, $40, $20, $20
    db $20, $A0, $C0, $C0, $48, $48, $F3, $40, $00, $40, $00, $FF, $FF, $9F, $02, $02
    db $02, $02, $FF, $F0, $02, $02, $03, $03, $03, $03, $02, $02, $FF, $87, $40, $40
    db $C0, $C0, $80, $80, $80, $80, $FF, $FF, $FF, $00, $E6, $1E, $18, $F8, $C3, $C3
    db $19, $1F, $DB, $E7, $EC, $1C, $70, $F1, $C1, $C3, $00, $FE, $01, $F8, $07, $C3
    db $3C, $1F, $E0, $FF, $00, $FC, $03, $F1, $0F, $C3, $3F, $C0, $00, $20, $80, $A0
    db $80, $A0, $00, $40, $00, $40, $00, $80, $C0, $20, $E0, $A0, $60, $A0, $60, $40
    db $C0, $40, $C0, $80, $80, $80, $0F, $1F, $07, $6F, $B3, $BF, $CA, $CF, $FA, $FB
    db $E4, $E6, $01, $01, $80, $1F, $FF, $7F, $FF, $C7, $FF, $F1, $FF, $FC, $FF, $E7
    db $E7, $01, $01, $88, $80, $80, $80, $80, $80, $80, $00, $80, $00, $C0, $00, $40
    db $88, $80, $80, $80, $80, $80, $80, $80, $80, $40, $C0, $C0, $C0, $00, $27, $B8
    db $31, $BE, $14, $9F, $0E, $4F, $03, $43, $10, $50, $CD, $EF, $61, $E1, $00, $BF
    db $C0, $BF, $C0, $9F, $E0, $4F, $70, $43, $7C, $50, $6F, $6F, $F0, $E1, $FE, $00
    db $0F, $F0, $FE, $01, $02, $FF, $B6, $FE, $E0, $E0, $1C, $1F, $1E, $E1, $AD, $FF
    db $00, $FF, $00, $FF, $00, $FF, $00, $FE, $01, $E0, $1F, $1F, $E0, $FF, $00, $FF
    db $00, $80, $E0, $F0, $F0, $FF, $62, $7E, $09, $39, $3F, $7F, $37, $77, $10, $50
    db $80, $F0, $FF, $FF, $FF, $71, $7F, $27, $3F, $4F, $7F, $57, $77, $70, $70, $81
    db $00, $80, $7F, $7F, $FF, $FF, $FF, $FF, $FF, $FF, $7E, $7E, $80, $00, $FF, $80
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7E, $7E, $07, $00, $80, $00, $40
    db $00, $C0, $00, $A0, $C0, $F0, $07, $80, $80, $C0, $40, $40, $40, $60, $20, $30
    db $30, $FF, $FF, $00, $40, $6C, $10, $B2, $04, $D5, $56, $76, $6B, $EF, $11, $1F
    db $4D, $73, $7B, $87, $00, $AC, $3C, $F2, $AE, $D5, $EB, $76, $89, $EF, $10, $1F
    db $E0, $7F, $80, $FF, $00, $07, $00, $80, $00, $80, $80, $C0, $80, $C0, $00, $20
    db $07, $80, $80, $80, $80, $C0, $40, $C0, $40, $20, $E0, $3F, $00, $01, $00, $03
    db $3F, $01, $01, $03, $03, $00, $00, $0C, $00, $1E, $00, $3F, $0A, $77, $28, $F7
    db $5C, $F2, $4E, $73, $BC, $E3, $00, $0C, $0C, $1A, $1A, $35, $35, $54, $54, $92
    db $92, $A3, $A2, $A1, $21, $41, $41, $00, $00, $0D, $06, $17, $09, $2F, $0A, $4D
    db $05, $46, $32, $B3, $68, $F8, $4A, $F6, $00, $0D, $0F, $17, $19, $2F, $30, $4F
    db $70, $47, $78, $B3, $CC, $F8, $87, $FE, $81, $00, $AC, $F3, $12, $5E, $8C, $CC
    db $E1, $E1, $5E, $DE, $73, $8F, $E0, $E0, $0C, $0F, $00, $41, $41, $E1, $40, $F3
    db $C0, $FF, $61, $DE, $3F, $FF, $00, $E0, $1F, $0F, $F0, $3C, $BD, $D6, $D6, $21
    db $21, $40, $40, $40, $40, $C1, $C1, $E3, $E3, $9C, $FD, $BD, $7E, $D6, $FB, $21
    db $E3, $40, $C9, $40, $C3, $C1, $6F, $E3, $BE, $FD, $9E, $FB, $07, $A6, $9E, $E1
    db $E1, $57, $57, $56, $56, $D3, $F3, $7B, $8B, $B9, $79, $FF, $00, $BE, $C1, $E1
    db $FF, $57, $FA, $56, $FA, $F3, $9E, $FB, $0D, $F9, $3E, $DE, $E1, $2E, $3E, $D1
    db $D1, $21, $21, $D3, $D3, $14, $14, $08, $08, $08, $08, $FF, $40, $3E, $EF, $D1
    db $FF, $E1, $FF, $D3, $DF, $14, $1C, $08, $08, $08, $08, $C0, $C0, $CF, $CF, $34
    db $34, $DB, $DF, $66, $66, $18, $18, $02, $02, $00, $00, $C0, $7F, $CF, $FF, $3C
    db $FC, $E3, $FF, $7E, $7E, $18, $18, $02, $02, $00, $00, $0B, $0B, $0C, $0F, $14
    db $14, $11, $11, $27, $27, $38, $38, $20, $20, $00, $00, $0B, $0C, $0F, $08, $14
    db $1B, $11, $1E, $27, $3F, $38, $38, $20, $A2, $00, $8C, $12, $97, $B6, $B8, $71
    db $7D, $96, $96, $4A, $4A, $9D, $9D, $8A, $8A, $47, $47, $97, $68, $BE, $41, $7D
    db $83, $96, $6F, $4A, $B7, $9D, $E3, $8A, $F5, $47, $78, $00, $00, $03, $03, $05
    db $05, $05, $05, $00, $00, $01, $01, $01, $01, $01, $01, $00, $18, $03, $03, $05
    db $06, $05, $07, $00, $00, $01, $01, $01, $01, $01, $01, $B0, $B0, $C0, $C0, $BF
    db $BF, $C9, $CF, $04, $04, $C7, $C7, $C0, $C0, $40, $40, $B0, $CF, $C0, $3F, $BF
    db $7F, $C8, $CF, $07, $07, $07, $C7, $40, $C0, $C0, $C0, $40, $40, $E9, $E9, $E4
    db $6C, $EA, $62, $5B, $D7, $FF, $F3, $AF, $B3, $FD, $F3, $40, $40, $A9, $A9, $34
    db $24, $32, $22, $53, $53, $63, $63, $A1, $A1, $51, $51, $80, $80, $40, $40, $B0
    db $B0, $88, $88, $10, $10, $20, $20, $28, $28, $AC, $AC, $80, $80, $C0, $40, $F0
    db $B0, $F8, $88, $F0, $10, $E0, $20, $E8, $28, $EC, $AC, $ED, $F3, $52, $5E, $4C
    db $4C, $A1, $A1, $58, $58, $5F, $DF, $7C, $83, $07, $F8, $41, $41, $E1, $40, $F3
    db $40, $FF, $A1, $67, $C0, $DF, $3F, $FF, $00, $FF, $00, $32, $32, $ED, $ED, $FA
    db $FA, $44, $54, $D4, $F4, $69, $E9, $36, $FE, $CD, $33, $F2, $3E, $ED, $F3, $FA
    db $E6, $54, $AD, $F4, $CC, $E9, $1D, $FE, $07, $FF, $00, $1F, $07, $07, $05, $06
    db $02, $03, $1F, $07, $07, $07, $04, $03, $02, $03, $01, $01, $01, $01, $03, $02
    db $03, $02, $83, $83, $B7, $B7, $03, $01, $01, $01, $01, $02, $02, $02, $02, $82
    db $82, $B6, $B6, $00, $03, $03, $01, $01, $04, $04, $03, $03, $02, $02, $01, $01
    db $01, $01, $06, $06, $00, $03, $02, $01, $41, $04, $04, $03, $33, $02, $1B, $01
    db $09, $01, $01, $06, $07, $00, $AF, $AF, $A9, $A9, $57, $57, $29, $2F, $DA, $DD
    db $0D, $0E, $D6, $D7, $4C, $DF, $00, $AF, $BB, $A9, $B7, $57, $59, $2F, $30, $DF
    db $E0, $0F, $F0, $D7, $28, $DF, $20, $1C, $43, $43, $40, $40, $01, $01, $02, $02
    db $02, $02, $00, $43, $41, $40, $E0, $00, $F0, $00, $FE, $00, $FF, $01, $C1, $02
    db $3B, $02, $E3, $3F, $C0, $C0, $A0, $E0, $3E, $00, $50, $C0, $C0, $E0, $20, $00
    db $01, $01, $0E, $0B, $05, $0D, $1F, $1F, $20, $20, $EE, $EE, $35, $37, $05, $05
    db $00, $01, $C1, $0F, $80, $0D, $02, $FF, $FF, $F8, $F8, $F6, $FE, $3D, $3F, $07
    db $07, $E0, $60, $60, $C0, $C0, $00, $80, $40, $40, $C0, $C0, $E0, $60, $A0, $C0
    db $C0, $80, $00, $40, $C0, $C0, $C0, $20, $80, $80, $78, $78, $A4, $C4, $50, $90
    db $60, $E0, $10, $08, $58, $39, $00, $80, $FE, $78, $07, $E4, $1C, $D0, $30, $E0
    db $63, $00, $F1, $18, $E0, $79, $88, $04, $1E, $1E, $04, $04, $10, $08, $08, $18
    db $08, $38, $10, $70, $47, $C7, $00, $1E, $1E, $04, $3C, $00, $7D, $18, $E1, $18
    db $E3, $38, $83, $70, $0C, $C7, $3F, $88, $70, $30, $51, $11, $20, $20, $26, $E6
    db $1D, $BF, $E2, $E2, $80, $70, $13, $51, $B9, $20, $27, $00, $01, $1E, $FC, $5F
    db $F8, $E2, $E3, $84, $F8, $F8, $80, $80, $06, $06, $33, $23, $F0, $50, $A0, $A0
    db $80, $F8, $FF, $80, $C3, $00, $F1, $07, $D7, $33, $03, $F0, $10, $A0, $60, $80
    db $01, $03, $05, $03, $04, $0A, $08, $0C, $13, $13, $0C, $0C, $08, $08, $00, $03
    db $00, $07, $00, $0E, $01, $0C, $03, $13, $0F, $0C, $1C, $08, $08, $00, $01, $E8
    db $15, $15, $0E, $0E, $80, $80, $C0, $C0, $00, $15, $1B, $0E, $1F, $80, $38, $00
    db $F5, $C0, $E3, $00, $61, $00, $0F, $00, $FE, $C3, $02, $02, $05, $05, $04, $04
    db $03, $03, $C0, $00, $03, $00, $24, $02, $02, $05, $07, $04, $07, $03, $03, $80
    db $60, $00, $B0, $A0, $48, $48, $38, $38, $80, $80, $00, $05, $00, $0E, $80, $60
    db $1D, $B0, $C0, $48, $38, $38, $38, $80, $80, $00, $05, $00, $0E, $80, $80, $40
    db $40, $60, $60, $60, $20, $10, $30, $71, $30, $42, $43, $01, $11, $00, $00, $80
    db $00, $80, $00, $90, $00, $D0, $10, $30, $30, $40, $40, $02, $00, $20, $20, $10
    db $10, $09, $09, $06, $06, $08, $18, $80, $10, $18, $98, $8C, $8C, $38, $20, $1E
    db $10, $0F, $09, $06, $06, $00, $00, $08, $00, $08, $08, $5C, $0C, $10, $10, $01
    db $01, $00, $00, $04, $04, $00, $00, $83, $C2, $A1, $21, $43, $43, $09, $00, $18
    db $00, $0C, $00, $04, $24, $00, $30, $C3, $18, $A1, $7E, $43, $FF, $40, $40, $40
    db $40, $80, $80, $03, $02, $41, $61, $70, $B0, $E0, $F0, $E0, $E0, $C0, $40, $C0
    db $46, $80, $9F, $03, $00, $61, $02, $F0, $01, $F0, $08, $E0, $FE, $80, $00, $01
    db $03, $05, $DE, $A6, $4A, $7A, $14, $17, $07, $07, $D0, $D0, $00, $01, $10, $07
    db $80, $FE, $02, $7A, $86, $17, $6C, $07, $3D, $D0, $F0, $00, $F0, $E7, $00, $80
    db $60, $E0, $C7, $80, $00, $E0, $60, $00, $50, $07, $0F, $0B, $05, $0D, $28, $38
    db $E6, $EE, $35, $37, $00, $00, $C0, $00, $18, $40, $40, $4F, $41, $ED, $E3, $EB
    db $FB, $F6, $FE, $3D, $3F, $C1, $20, $20, $D0, $D0, $50, $D0, $A0, $A0, $C0, $C0
    db $C1, $20, $20, $D0, $F0, $D0, $30, $A0, $60, $C0, $C0, $06, $01, $01, $80, $C0
    db $A0, $20, $80, $81, $7B, $7A, $A4, $C4, $06, $0C, $00, $C0, $18, $A0, $60, $81
    db $80, $7B, $00, $E4, $1D, $86, $40, $40, $60, $E0, $C0, $60, $58, $D8, $85, $85
    db $04, $C0, $40, $00, $01, $E0, $10, $E0, $00, $D8, $18, $85, $3D, $00, $7D, $01
    db $10, $08, $70, $30, $51, $11, $20, $20, $26, $E6, $1D, $BF, $E2, $E2, $00, $00
    db $F1, $18, $E0, $70, $13, $51, $31, $20, $20, $1E, $FC, $5F, $F8, $E2, $E3, $10
    db $08, $38, $10, $70, $F8, $F8, $80, $80, $33, $23, $F0, $50, $A0, $A0, $00, $38
    db $83, $70, $0C, $F8, $F8, $80, $80, $0A, $0A, $33, $03, $F0, $10, $A0, $60, $25
    db $01, $01, $03, $03, $01, $01, $02, $02, $0C, $0D, $21, $01, $01, $00, $01, $03
    db $32, $01, $99, $02, $04, $0D, $0E, $80, $10, $10, $D4, $D4, $58, $D8, $20, $A1
    db $C1, $C2, $15, $15, $0E, $0E, $00, $10, $20, $D4, $2C, $D8, $38, $A1, $60, $C3
    db $C0, $15, $1B, $0E, $0F, $00, $08, $80, $02, $03, $02, $02, $03, $03, $02, $02
    db $02, $02, $04, $04, $03, $03, $80, $03, $02, $02, $03, $03, $02, $02, $06, $02
    db $0A, $04, $47, $03, $03, $00, $00, $C0, $C0, $C0, $60, $00, $B0, $A0, $48, $48
    db $80, $80, $00, $05, $00, $0E, $00, $C0, $21, $C0, $07, $60, $00, $B0, $C0, $48
    db $38, $80, $80, $00, $05, $00, $0E, $21, $00, $18, $00, $1E, $00, $0F, $00, $03
    db $00, $0C, $00, $18, $FF, $E7, $00, $80, $00, $C0, $0F, $01, $00, $03, $00, $1F
    db $00, $0E, $00, $EC, $00, $F8, $00, $F0, $01, $00, $7F, $19, $00, $47, $04, $0C
    db $80, $08, $06, $06, $40, $40, $4F, $04, $00, $0E, $06, $C0, $40, $07, $04, $1C
    db $78, $F8, $50, $50, $10, $13, $40, $40, $07, $1C, $01, $F8, $08, $50, $B0, $13
    db $F0, $40, $E0, $9F, $00, $80, $60, $E0, $9F, $80, $28, $E0, $60, $07, $0E, $0B
    db $05, $0D, $C8, $D8, $3C, $3C, $05, $05, $00, $00, $F0, $00, $C0, $00, $18, $0F
    db $00, $0D, $02, $E8, $F8, $34, $3C, $07, $07, $E7, $A8, $E8, $D0, $D0, $E7, $E8
    db $98, $D0, $B0, $11, $01, $00, $11, $11, $01, $01, $80, $C0, $A0, $20, $7B, $7A
    db $13, $0A, $00, $0C, $00, $C0, $18, $A0, $60, $7B, $00, $00, $04, $0C, $80, $08
    db $86, $86, $40, $40, $03, $02, $60, $E0, $C0, $60, $84, $84, $01, $04, $00, $4E
    db $06, $C0, $46, $03, $00, $E0, $11, $E0, $00, $84, $3C, $82, $A4, $C4, $10, $08
    db $51, $11, $20, $20, $3D, $BF, $E2, $E2, $80, $E4, $1D, $00, $F1, $18, $E0, $51
    db $31, $20, $20, $5F, $F8, $E2, $E3, $91, $08, $38, $10, $70, $80, $80, $F0, $50
    db $A0, $A0, $90, $00, $7D, $38, $83, $70, $0C, $80, $80, $F0, $10, $A0, $60, $57
    db $01, $01, $01, $01, $02, $02, $07, $01, $01, $00, $01, $01, $31, $00, $98, $02
    db $04, $07, $D4, $D4, $58, $D8, $C0, $C1, $01, $02, $0E, $0E, $07, $D4, $2C, $D8
    db $38, $C1, $C0, $03, $00, $0E, $0F, $C0, $0C, $0D, $02, $03, $02, $02, $02, $02
    db $02, $02, $03, $03, $C0, $0D, $0E, $03, $02, $02, $03, $02, $06, $02, $02, $03
    db $03, $81, $00, $C0, $C0, $C0, $B0, $A0, $48, $48, $05, $05, $0A, $0E, $80, $00
    db $08, $C0, $21, $C0, $07, $B0, $C0, $48, $38, $00, $05, $00, $0E, $7F, $00, $01
    db $FF, $0F, $00, $10, $00, $30, $00, $70, $00, $E0, $FF, $C0, $00, $07, $00, $80
    db $00, $C0, $00, $F0, $00, $7E, $00, $1C, $FF, $FE, $00, $C0, $C3, $10, $00, $38
    db $00, $1F, $00, $0E, $00, $0F, $E0, $E0, $C0, $C0, $84, $84, $8D, $8D, $0F, $E0
    db $00, $C0, $40, $84, $80, $8D, $93, $FF, $FF, $0F, $38, $38, $04, $04, $C0, $C0
    db $A0, $A0, $05, $00, $80, $00, $C0, $38, $40, $04, $7B, $40, $C0, $E0, $E0, $FF
    db $CE, $00, $80, $00, $40, $00, $80, $20, $00, $60, $00, $C0, $0C, $C0, $0C, $8C
    db $0A, $0A, $07, $07, $0F, $0F, $27, $52, $00, $66, $02, $07, $C0, $0F, $00, $91
    db $20, $60, $00, $40, $30, $30, $1D, $1D, $02, $02, $00, $3E, $00, $1C, $00, $20
    db $00, $70, $30, $00, $30, $1D, $02, $02, $8D, $00, $07, $20, $1C, $1C, $20, $20
    db $01, $01, $C2, $C2, $8C, $8C, $FF, $FF, $11, $11, $20, $1C, $01, $20, $EB, $01
    db $8C, $C2, $01, $8C, $8C, $FF, $C0, $11, $1F, $3A, $22, $22, $C0, $C0, $87, $87
    db $01, $01, $30, $22, $E7, $00, $EF, $C0, $1E, $00, $E0, $87, $87, $01, $01, $8F
    db $02, $02, $06, $06, $0E, $0E, $0F, $02, $01, $06, $09, $0E, $0E, $00, $C0, $03
    db $00, $07, $00, $07, $A0, $A0, $C0, $C0, $0E, $0E, $1D, $1D, $0F, $A0, $60, $C0
    db $C0, $0E, $00, $1D, $03, $80, $10, $10, $08, $08, $16, $16, $10, $10, $15, $15
    db $12, $12, $18, $18, $80, $10, $20, $08, $00, $16, $19, $10, $1E, $15, $36, $12
    db $11, $18, $18, $0C, $70, $70, $01, $01, $86, $86, $41, $41, $2D, $2D, $77, $77
    db $00, $70, $78, $01, $42, $00, $0F, $00, $3F, $86, $01, $41, $C1, $02, $2F, $07
    db $77, $01, $00, $0F, $00, $3D, $00, $F8, $28, $28, $00, $C0, $04, $04, $10, $10
    db $27, $01, $00, $98, $08, $04, $1A, $10, $2C, $15, $80, $80, $80, $80, $03, $03
    db $0A, $0A, $02, $02, $03, $A0, $00, $F0, $80, $3E, $00, $1F, $61, $0A, $36, $02
    db $1E, $A1, $80, $80, $05, $05, $08, $08, $30, $30, $0C, $0C, $20, $00, $70, $80
    db $AF, $05, $32, $08, $06, $30, $30, $0C, $F0, $00, $38, $3F, $1D, $1D, $06, $06
    db $01, $00, $BE, $00, $78, $00, $03, $00, $01, $00, $01, $1D, $1F, $07, $07, $9F
    db $03, $03, $38, $38, $9F, $1B, $1F, $38, $38, $07, $00, $1C, $00, $0F, $00, $07
    db $38, $38, $44, $44, $37, $01, $00, $38, $03, $44, $3C, $80, $41, $41, $20, $20
    db $50, $50, $40, $40, $56, $56, $49, $49, $60, $60, $00, $41, $81, $20, $01, $50
    db $6C, $40, $78, $56, $D8, $49, $47, $60, $60, $01, $01, $06, $80, $80, $02, $02
    db $0A, $0A, $04, $04, $02, $02, $1C, $1C, $00, $80, $80, $00, $01, $00, $1E, $02
    db $7D, $0A, $16, $04, $04, $BE, $BE, $DC, $DC, $00, $12, $1E, $1F, $20, $7D, $42
    db $2A, $55, $15, $6A, $02, $7D, $31, $FF, $0A, $3F, $0F, $20, $20, $44, $44, $CA
    db $CA, $35, $35, $81, $40, $C0, $A0, $60, $A0, $60, $00, $E0, $40, $E0, $80, $C0
    db $8F, $20, $20, $20, $20, $40, $40, $00, $00, $BE, $09, $FD, $00, $FC, $94, $FE
    db $08, $FF, $2D, $F7, $15, $FA, $15, $BA, $00, $BE, $BE, $F4, $F4, $F4, $F4, $0A
    db $0A, $E5, $E5, $92, $92, $EA, $EA, $AA, $AA, $1D, $40, $40, $00, $C0, $40, $E0
    db $C0, $60, $1F, $C0, $C0, $20, $20, $20, $20, $00, $06, $07, $09, $0F, $06, $09
    db $0C, $03, $1B, $14, $0C, $13, $0E, $51, $06, $09, $5E, $01, $01, $01, $01, $01
    db $01, $00, $00, $10, $00, $81, $84, $84, $80, $C0, $40, $E0, $38, $FC, $34, $CE
    db $68, $97, $05, $80, $80, $40, $40, $A0, $A0, $44, $44, $C2, $C2, $01, $01, $00
    db $20, $27, $07, $08, $09, $17, $2A, $37, $3F, $30, $13, $1F, $0C, $7F, $52, $EF
    db $00, $06, $06, $08, $08, $13, $13, $21, $21, $20, $20, $13, $13, $6F, $6F, $8D
    db $8D, $00, $7E, $81, $B7, $79, $A6, $79, $F8, $07, $D4, $3D, $B9, $FB, $30, $FF
    db $88, $F6, $01, $38, $38, $71, $71, $03, $03, $0D, $0D, $8A, $8A, $FF, $FF, $76
    db $76, $00, $2C, $5B, $22, $5E, $00, $7D, $10, $2B, $00, $BD, $01, $93, $01, $06
    db $02, $1D, $00, $53, $53, $5C, $5C, $54, $54, $2B, $2B, $A9, $A9, $92, $92, $04
    db $04, $19, $19, $00, $00, $50, $08, $A8, $04, $D4, $C0, $BA, $60, $94, $8A, $62
    db $54, $84, $20, $A0, $80, $50, $50, $A0, $A0, $C0, $C0, $32, $32, $10, $10, $60
    db $60, $80, $80, $F8, $14, $3A, $0C, $32, $00, $0C, $F8, $22, $22, $32, $32, $0C
    db $0C, $FF, $FF, $00, $00, $02, $05, $00, $0A, $00, $00, $15, $00, $0A, $00, $15
    db $08, $0A, $00, $05, $0F, $08, $08, $11, $11, $02, $02, $05, $05, $00, $80, $80
    db $50, $10, $28, $88, $00, $50, $00, $A8, $10, $50, $20, $B0, $00, $40, $2F, $08
    db $08, $90, $90, $40, $40, $00, $00, $0A, $00, $C0, $C0, $20, $40, $B0, $20, $D8
    db $10, $EC, $18, $F6, $26, $59, $00, $0A, $0A, $C0, $C0, $20, $20, $30, $30, $98
    db $98, $CC, $CC, $E6, $E6, $51, $51, $7E, $00, $80, $00, $A0, $7E, $80, $80, $A0
    db $A0, $00, $08, $0A, $55, $40, $A2, $88, $00, $55, $00, $AB, $41, $56, $21, $7E
    db $1E, $21, $07, $01, $01, $83, $83, $04, $04, $58, $58, $20, $20, $03, $00, $E0
    db $E0, $F0, $D0, $38, $A0, $5C, $F8, $06, $DC, $E6, $03, $E0, $E0, $10, $10, $08
    db $08, $04, $04, $02, $02, $E2, $E2, $00, $26, $5D, $AB, $DC, $FF, $C0, $4E, $7F
    db $32, $37, $00, $07, $02, $0D, $0A, $15, $00, $4D, $4D, $84, $84, $80, $80, $4E
    db $4E, $35, $35, $05, $05, $0D, $0D, $15, $15, $00, $98, $E4, $E0, $1F, $55, $FF
    db $E0, $FF, $CA, $FF, $80, $FF, $A0, $70, $40, $B0, $00, $C4, $C4, $0F, $0F, $3A
    db $3A, $3F, $3F, $C4, $C4, $3F, $3F, $50, $50, $90, $90, $00, $00, $7E, $3A, $C7
    db $03, $FD, $CC, $77, $82, $6F, $60, $B7, $A0, $DF, $D0, $EF, $00, $7E, $7E, $81
    db $81, $FC, $FC, $32, $32, $29, $29, $95, $95, $4D, $4D, $27, $27, $03, $00, $80
    db $80, $C0, $00, $C0, $00, $C0, $80, $C0, $00, $80, $03, $80, $80, $40, $40, $40
    db $40, $40, $40, $40, $40, $80, $80, $00, $48, $D7, $86, $DD, $03, $8C, $0C, $1B
    db $08, $74, $50, $E8, $30, $C8, $00, $30, $00, $17, $17, $59, $59, $88, $88, $13
    db $13, $64, $64, $88, $88, $C8, $C8, $30, $30, $F9, $00, $80, $00, $80, $F9, $80
    db $80, $80, $80, $00, $03, $03, $06, $01, $06, $06, $0D, $04, $1A, $08, $77, $57
    db $E8, $30, $CF, $03, $03, $04, $04, $04, $04, $09, $09, $12, $12, $67, $67, $88
    db $88, $CF, $CF, $00, $00, $00, $C0, $80, $40, $00, $BE, $3E, $7F, $41, $FF, $00
    db $FF, $5D, $E3, $00, $00, $C0, $C0, $40, $40, $BE, $BE, $41, $41, $80, $80, $55
    db $55, $C3, $C3, $42, $F7, $06, $ED, $08, $FF, $41, $FF, $01, $7F, $08, $1F, $02
    db $0F, $00, $03, $B4, $B4, $A9, $A9, $B2, $B2, $B6, $B6, $74, $74, $15, $15, $0D
    db $0D, $03, $03, $DD, $E2, $9C, $E3, $A2, $FF, $C1, $FF, $7F, $80, $BE, $C1, $DD
    db $FF, $00, $C0, $82, $82, $01, $01, $77, $77, $63, $63, $00, $00, $00, $00, $E3
    db $E3, $40, $40, $00, $00, $04, $00, $0E, $04, $0A, $00, $1E, $08, $16, $08, $16
    db $0A, $15, $03, $1F, $00, $04, $04, $0A, $0A, $0A, $0A, $16, $16, $16, $16, $16
    db $16, $15, $15, $15, $15, $1F, $00, $01, $C0, $C1, $81, $F3, $1F, $01, $01, $C1
    db $C1, $32, $32, $00, $0E, $1B, $06, $0F, $03, $07, $01, $03, $01, $01, $00, $33
    db $33, $DB, $63, $9B, $00, $12, $12, $0A, $0A, $05, $05, $03, $03, $01, $01, $32
    db $32, $CA, $CA, $8A, $8A, $00, $E0, $13, $90, $69, $D0, $69, $B0, $6C, $F0, $0E
    db $CC, $33, $7F, $B1, $DB, $B5, $00, $13, $13, $09, $09, $29, $29, $64, $64, $02
    db $02, $23, $23, $30, $30, $30, $30, $00, $00, $80, $80, $60, $40, $EC, $04, $CF
    db $81, $4F, $80, $4F, $44, $BF, $A9, $DF, $00, $80, $80, $60, $60, $2C, $2C, $CB
    db $CB, $4A, $4A, $4A, $4A, $B2, $B2, $54, $54, $0F, $00, $80, $00, $80, $00, $80
    db $00, $80, $0F, $80, $80, $80, $80, $80, $80, $80, $80, $00, $16, $EB, $C9, $37
    db $EC, $3B, $D3, $3C, $12, $FD, $ED, $FF, $EC, $FB, $C1, $CF, $00, $29, $29, $17
    db $17, $13, $13, $38, $38, $7D, $7D, $F3, $F3, $F1, $F1, $CF, $CF, $00, $00, $70
    db $30, $D8, $B0, $F8, $4C, $FC, $40, $C0, $E0, $E0, $E0, $E0, $80, $80, $00, $70
    db $70, $88, $88, $C8, $C8, $FC, $FC, $C0, $C0, $E0, $E0, $E0, $E0, $80, $80, $0F
    db $00, $01, $01, $03, $00, $1B, $18, $3F, $0F, $01, $01, $02, $02, $1A, $1A, $26
    db $26, $00, $00, $01, $01, $02, $01, $7E, $5C, $E3, $C1, $BE, $38, $EF, $40, $FF
    db $06, $F9, $00, $01, $01, $02, $02, $7E, $7E, $81, $81, $3E, $3E, $46, $46, $9F
    db $9F, $B8, $B8, $00, $19, $37, $22, $3F, $1E, $1F, $0D, $0E, $05, $06, $0F, $0E
    db $0E, $0F, $07, $07, $00, $22, $22, $3F, $3F, $1F, $1F, $0E, $0E, $04, $04, $0C
    db $0C, $0E, $0E, $07, $07, $00, $0D, $F2, $0F, $F0, $F6, $0F, $34, $EF, $5F, $E0
    db $FA, $07, $77, $FF, $FF, $FF, $00, $A0, $A0, $C0, $C0, $07, $07, $6E, $6E, $20
    db $20, $01, $01, $71, $71, $FF, $FF, $00, $60, $60, $18, $F8, $0C, $FF, $94, $FF
    db $60, $7F, $30, $3F, $0F, $7F, $80, $FF, $FF, $03, $C0, $D0, $60, $E0, $60, $E0
    db $C0, $C0, $80, $80, $C0, $C0, $FF, $F8, $24, $F7, $76, $77, $03, $03, $FE, $08
    db $00, $FC, $40, $C0, $C0, $C0, $FF, $C0, $B0, $9C, $40, $13, $BC, $B7, $76, $17
    db $A3, $23, $A0, $C1, $80, $63, $00, $EC, $00, $48, $00, $E8, $00, $D8, $00, $70
    db $00, $E0, $00, $18, $00, $C0, $00, $80, $00, $80, $00, $80, $00, $C0, $00, $60
    db $FF, $FF, $FF, $FE, $00, $20, $FF, $00, $04, $04, $01, $01, $00, $01, $00, $03
    db $00, $03, $01, $07, $02, $06, $04, $0C, $FE, $03, $00, $00, $A0, $0F, $71, $5F
    db $13, $C6, $79, $C0, $E7, $B0, $97, $1C, $03, $0E, $02, $0C, $00, $F0, $00, $A0
    db $00, $39, $00, $3F, $00, $4F, $00, $83, $00, $01, $00, $03, $00, $FC, $08, $18
    db $10, $10, $FF, $A4, $0B, $0D, $0E, $0C, $06, $02, $04, $00, $04, $04, $C0, $02
    db $00, $02, $00, $06, $00, $04, $00, $04, $00, $04, $00, $0F, $00, $01, $80, $83
    db $C0, $CE, $E2, $DE, $0F, $80, $00, $40, $00, $20, $00, $20, $00, $E3, $00, $40
    db $00, $C0, $00, $80, $FF, $00, $44, $1C, $C4, $3C, $E0, $20, $60, $0C, $B0, $86
    db $5C, $CF, $1B, $C0, $5A, $CE, $00, $E0, $00, $C0, $00, $D8, $00, $F0, $00, $78
    db $00, $30, $00, $3F, $00, $31, $00, $1F, $00, $E0, $C0, $FC, $00, $E0, $FF, $83
    db $00, $04, $00, $02, $00, $03, $00, $01, $00, $01, $FF, $00, $00, $02, $00, $02
    db $00, $02, $00, $02, $00, $06, $00, $8F, $81, $DF, $40, $FF, $E7, $01, $00, $01
    db $00, $00, $02, $03, $00, $03, $03, $07, $00, $07, $00, $07, $00, $1F, $05, $FF
    db $39, $21, $7F, $1E, $00, $00, $63, $BF, $E5, $CF, $93, $86, $00, $E0, $05, $E1
    db $18, $CF, $60, $8F, $D0, $9F, $00, $40, $00, $30, $00, $79, $00, $1F, $00, $1E
    db $00, $30, $00, $70, $00, $60, $00, $00, $00, $20, $00, $84, $00, $1C, $00, $38
    db $40, $78, $00, $E0, $00, $04, $00, $91, $10, $06, $00, $18, $00, $61, $00, $C4
    db $00, $11, $00, $61, $00, $06, $00, $02, $01, $00, $00, $10, $00, $30, $00, $60
    db $00, $E0, $00, $C0, $00, $80, $00, $03, $00, $A8, $00, $68, $00, $42, $00, $98
    db $00, $10, $00, $24, $00, $40, $00, $80, $04, $07, $00, $A0, $80, $D0, $00, $4B
    db $00, $40, $00, $A4, $00, $50, $E0, $48, $00, $1B, $00, $04, $00, $A0, $00, $08
    db $00, $E4, $00, $10, $00, $20, $40, $40, $00, $80, $FE, $C0, $00, $20, $00, $01
    db $00, $01, $00, $03, $00, $01, $00, $01, $00, $02, $00, $01, $B0, $30, $00, $02
    db $00, $08, $00, $06, $00, $04, $00, $01, $00, $04, $00, $82, $00, $81, $00, $C8
    db $00, $40, $00, $08, $00, $02, $00, $58, $00, $80, $00, $10, $00, $64, $00, $20
    db $00, $B3, $00, $65, $00, $38, $00, $FE, $01, $01, $FD, $01, $00, $80, $00, $81
    db $80, $94, $40, $40, $00, $08, $00, $14, $00, $08, $00, $02, $00, $0C, $00, $41
    db $00, $2B, $00, $03, $00, $03, $00, $41, $00, $09, $00, $01, $00, $FD, $00, $80
    db $02, $80, $00, $98, $00, $8C, $00, $E5, $00, $60, $00, $C9, $00, $52, $00, $3F
    db $00, $60, $00, $60, $07, $40, $00, $C0, $00, $E0, $00, $90, $00, $90, $00, $81
    db $00, $4C, $04, $46, $01, $01, $01, $21, $00, $10, $00, $08, $00, $04, $00, $12
    db $00, $09, $00, $06, $00, $10, $00, $09, $00, $10, $00, $0A, $00, $0E, $00, $20
    db $04, $04, $00, $8C, $0A, $0E, $04, $06, $00, $44, $00, $B0, $00, $14, $00, $44
    db $00, $88, $00, $52, $00, $80, $00, $48, $00, $FF, $7F, $0C, $00, $39, $00, $01
    db $00, $01, $00, $30, $00, $40, $03, $22, $00, $65, $00, $02, $00, $90, $00, $49
    db $00, $A4, $00, $68, $00, $08, $00, $01, $00, $01, $00, $02, $00, $04, $00, $01
    db $00, $08, $00, $04, $00, $03, $00, $04, $00, $02, $00, $09, $00, $F1, $00, $80
    db $00, $C3, $00, $04, $00, $1C, $00, $38, $00, $30, $00, $31, $00, $10, $00, $10
    db $00, $8A, $00, $20, $00, $46, $00, $0C, $00, $48, $00, $28, $00, $14, $00, $06
    db $81, $81, $00, $12, $80, $81, $00, $82, $24, $24, $00, $20, $1D, $01, $00, $01
    db $00, $03, $00, $04, $00, $4A, $00, $20, $00, $01, $00, $20, $00, $10, $00, $50
    db $44, $80, $00, $01, $00, $01, $00, $90, $00, $84, $00, $0A, $00, $01, $44, $55
    db $00, $44, $12, $53, $A0, $B2, $F8, $F8, $49, $ED, $30, $76, $7B, $01, $00, $80
    db $00, $40, $10, $B1, $20, $24, $00, $04, $00, $80, $00, $20, $08, $28, $00, $80
    db $F8, $08, $00, $10, $00, $60, $00, $10, $04, $04, $00, $04, $08, $08, $00, $08
    db $00, $01, $00, $01, $00, $08, $13, $01, $00, $01, $00, $02, $00, $08, $00, $01
    db $00, $3B, $00, $08, $08, $0A, $40, $C8, $2C, $20, $00, $08, $00, $20, $00, $80
    db $00, $20, $00, $FC, $02, $02, $00, $02, $E7, $01, $00, $01, $00, $00, $40, $41
    db $00, $02, $20, $21, $20, $24, $80, $81, $16, $17, $05, $2F, $14, $15, $5A, $A0
    db $00, $08, $00, $C0, $00, $2A, $00, $FF, $D3, $0C, $00, $41, $00, $40, $00, $1F
    db $10, $10, $08, $18, $00, $08, $17, $80, $00, $20, $00, $20, $00, $14, $00, $63
    db $01, $01, $01, $01, $00, $20, $00, $10, $37, $20, $00, $10, $00, $81, $00, $02
    db $00, $04, $80, $80, $80, $90, $C0, $C2, $00, $08, $00, $20, $80, $95, $B4, $08
    db $00, $04, $00, $02, $00, $04, $00, $7F, $00, $10, $FF, $33, $00, $20, $00, $60
    db $30, $30, $60, $60, $FF, $FA, $00, $24, $00, $08, $C0, $08, $00, $08, $00, $10
    db $00, $11, $00, $01, $00, $10, $00, $0E, $40, $40, $10, $10, $30, $30, $00, $20
    db $00, $20, $03, $80, $00, $90, $00, $20, $00, $08, $00, $50, $00, $40, $00, $59
    db $00, $10, $00, $01, $40, $40, $00, $10, $FF, $09, $00, $80, $00, $80, $00, $01
    db $00, $40, $00, $81, $00, $40, $FF, $00, $00, $12, $00, $02, $00, $04, $40, $C4
    db $A0, $B2, $F4, $AF, $4B, $DF, $30, $76, $07, $10, $00, $40, $00, $50, $00, $20
    db $00, $89, $00, $06, $00, $80, $10, $10, $10, $14, $40, $44, $90, $D0, $48, $E8
    db $FF, $F5, $00, $08, $00, $10, $FF, $66, $00, $40, $00, $08, $00, $08, $08, $08
    db $FF, $72, $08, $08, $08, $08, $00, $02, $00, $01, $FF, $00, $22, $22, $A0, $A8
    db $00, $80, $00, $0A, $08, $2B, $1A, $5F, $01, $AB, $54, $D5, $27, $01, $00, $04
    db $00, $14, $00, $2A, $00, $F9, $00, $08, $00, $03, $FF, $BF, $08, $0C, $FF, $BF
    db $00, $20, $FF, $EA, $02, $06, $00, $C0, $00, $20, $FF, $77, $00, $01, $00, $10
    db $FF, $3B, $00, $80, $00, $40, $00, $80, $FF, $D0, $00, $10, $00, $02, $00, $21
    db $00, $02, $00, $08, $FF, $2F, $00, $50, $00, $20, $00, $80, $FF, $01, $40, $40
    db $A0, $F0, $4A, $EE, $A1, $BB, $F4, $AE, $49, $DD, $30, $76, $07, $10, $00, $44
    db $00, $51, $00, $22, $00, $89, $00, $07, $80, $80, $60, $E0, $50, $F8, $14, $7C
    db $5A, $FE, $BF, $80, $00, $FC, $65, $6D, $00, $95, $FC, $92, $00, $48, $00, $FC
    db $28, $F8, $00, $40, $FF, $3F, $05, $05, $08, $09, $FF, $03, $08, $0A, $00, $1E
    db $48, $7B, $1A, $FF, $01, $EB, $54, $D5, $21, $02, $00, $05, $00, $21, $00, $04
    db $00, $14, $00, $2A, $00, $FC, $02, $03, $01, $01, $FF, $FC, $42, $F7, $02, $3A
    db $FC, $08, $00, $05, $00, $00, $01, $01, $03, $01, $63, $40, $79, $38, $CD, $75
    db $EF, $13, $3C, $07, $7C, $01, $01, $03, $02, $63, $62, $79, $19, $FD, $85, $FF
    db $82, $3F, $20, $7F, $70, $80, $E0, $E0, $30, $E0, $10, $00, $E0, $80, $E0, $C0
    db $60, $60, $B0, $98, $7E, $E0, $20, $F0, $10, $D0, $30, $E0, $20, $E0, $20, $60
    db $A0, $F0, $10, $FE, $06, $4E, $BD, $64, $DF, $07, $6D, $0E, $0B, $08, $16, $00
    db $3E, $14, $3C, $08, $1C, $FF, $90, $DF, $B8, $6F, $68, $0F, $01, $1E, $12, $3E
    db $22, $3C, $20, $1C, $14, $16, $FB, $6A, $FD, $DC, $B6, $48, $FC, $30, $6C, $04
    db $3E, $0C, $3A, $00, $1C, $FF, $01, $FD, $03, $F6, $0A, $FC, $84, $7C, $44, $3E
    db $22, $3A, $26, $1C, $1C, $00, $00, $00, $60, $40, $B0, $20, $D0, $10, $78, $08
    db $34, $00, $18, $00, $00, $00, $00, $60, $60, $F0, $90, $F0, $90, $78, $48, $34
    db $2C, $18, $18, $00, $00, $00, $60, $40, $F0, $30, $D8, $30, $D8, $50, $E8, $00
    db $70, $20, $71, $01, $2A, $60, $60, $F0, $90, $F8, $88, $F8, $88, $E8, $98, $70
    db $50, $71, $51, $2A, $2B, $00, $02, $02, $77, $30, $DA, $00, $70, $00, $07, $02
    db $0D, $0D, $1B, $02, $1F, $02, $02, $77, $75, $FA, $8A, $70, $70, $07, $07, $0F
    db $08, $1F, $10, $1F, $11, $08, $1D, $00, $08, $00, $18, $08, $3E, $1A, $B7, $8C
    db $DB, $02, $8D, $00, $06, $1D, $15, $08, $08, $18, $18, $3E, $26, $BF, $A1, $DF
    db $51, $8D, $8B, $06, $06, $00, $00, $3C, $18, $5A, $3C, $BD, $2E, $B2, $65, $BB
    db $30, $5F, $04, $37, $01, $03, $00, $3C, $3C, $5A, $66, $BD, $C3, $BE, $C1, $BF
    db $C0, $5F, $60, $37, $38, $03, $04, $07, $00, $80, $00, $80, $00, $80, $00, $80
    db $00, $80, $07, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $F8, $02, $06
    db $03, $06, $00, $03, $F8, $06, $05, $06, $05, $03, $03, $FE, $00, $80, $FE, $80
    db $80, $01, $00, $01, $00, $01, $00, $78, $60, $D4, $10, $7B, $00, $14, $06, $0F
    db $01, $01, $01, $01, $01, $78, $78, $F4, $8C, $7B, $67, $14, $1B, $0F, $08, $00
    db $00, $A0, $C0, $E1, $21, $73, $42, $AE, $28, $DD, $50, $6A, $E4, $D1, $C2, $3B
    db $00, $A0, $E0, $E1, $21, $73, $92, $EE, $9D, $FD, $83, $7A, $86, $F1, $0F, $FB
    db $04, $F8, $0B, $13, $31, $3E, $03, $03, $F8, $13, $1C, $3E, $3F, $03, $03, $F8
    db $1E, $FE, $7A, $79, $87, $FF, $F8, $FE, $01, $79, $87, $FF, $FF, $01, $00, $06
    db $05, $1D, $0B, $27, $28, $72, $95, $DD, $CF, $F7, $30, $3F, $01, $06, $07, $1D
    db $1A, $2F, $30, $7A, $45, $DD, $E2, $F7, $F8, $3F, $3F, $00, $00, $E0, $E0, $3C
    db $84, $6D, $10, $43, $AD, $E1, $B8, $35, $30, $F3, $EE, $FD, $00, $E0, $E0, $FC
    db $1C, $ED, $13, $43, $BC, $ED, $12, $BD, $42, $F3, $0C, $FD, $03, $FE, $07, $07
    db $FE, $07, $07, $FE, $8F, $FF, $FE, $FF, $FF, $0F, $03, $03, $07, $07, $07, $06
    db $01, $01, $0F, $03, $03, $07, $07, $07, $07, $01, $01, $00, $DA, $DE, $E5, $FF
    db $CA, $DE, $E0, $E0, $C0, $DC, $C2, $C2, $E3, $B3, $E3, $73, $00, $FB, $DA, $E5
    db $FD, $EB, $DE, $FF, $E0, $E3, $C0, $FF, $C2, $EF, $E3, $EC, $E0, $C0, $07, $06
    db $07, $05, $07, $07, $07, $07, $02, $02, $01, $01, $C0, $07, $07, $07, $07, $07
    db $07, $07, $07, $03, $03, $01, $01, $08, $93, $9F, $18, $1F, $8F, $8F, $63, $63
    db $F6, $B6, $FD, $BC, $FB, $F8, $00, $F3, $F7, $F8, $FC, $FF, $FF, $FF, $FF, $FD
    db $FF, $AA, $FF, $A4, $FF, $F8, $DF, $FF, $FF, $1F, $18, $18, $38, $38, $50, $50
    db $1F, $18, $18, $38, $38, $70, $50, $9F, $01, $01, $01, $01, $9F, $01, $01, $01
    db $01, $00, $70, $70, $48, $48, $34, $34, $2E, $2E, $17, $17, $19, $19, $BC, $BC
    db $FE, $FE, $00, $70, $70, $78, $48, $3C, $34, $36, $26, $1F, $17, $1E, $18, $BB
    db $B8, $E5, $E4, $BB, $BA, $BE, $BC, $8C, $B8, $9C, $B4, $B2, $A2, $6D, $4D, $7F
    db $5F, $FE, $BE, $BB, $E7, $BF, $D7, $BF, $CF, $BF, $DF, $BF, $FF, $73, $7F, $61
    db $7F, $E2, $FF, $DD, $5D, $7D, $3D, $31, $1D, $39, $2D, $4D, $45, $B6, $B2, $FE
    db $FA, $7F, $7D, $DD, $E7, $FD, $EB, $FD, $F3, $FD, $FB, $FD, $FF, $CE, $FE, $86
    db $FE, $47, $FF, $FE, $9F, $DF, $91, $FF, $EE, $F7, $E9, $DF, $F1, $5F, $6B, $3F
    db $37, $0F, $0F, $FF, $FE, $F1, $FF, $EE, $F1, $EF, $B0, $FF, $91, $7E, $4B, $3C
    db $37, $0F, $0F, $7F, $F9, $FB, $89, $FF, $77, $EF, $97, $FB, $8F, $FA, $D6, $FC
    db $EC, $F0, $F0, $FF, $7F, $8F, $FF, $77, $8F, $F7, $0D, $FF, $89, $7E, $D2, $3C
    db $EC, $F0, $F0, $7E, $42, $7E, $4A, $7E, $4A, $76, $4A, $66, $5A, $56, $6A, $56
    db $6A, $46, $7A, $42, $7E, $4A, $76, $7A, $46, $7A, $4E, $7A, $56, $7A, $66, $7A
    db $66, $7A, $76, $7E, $42, $7E, $52, $7E, $52, $6E, $52, $66, $5A, $6A, $56, $6A
    db $56, $62, $5E, $42, $7E, $52, $6E, $5E, $62, $5E, $72, $5E, $6A, $5E, $66, $5E
    db $66, $5E, $6E, $56, $6A, $56, $6A, $46, $5A, $46, $6A, $46, $76, $44, $7C, $4C
    db $7C, $38, $38, $7A, $66, $7A, $66, $7A, $76, $5A, $7E, $4E, $7E, $4C, $7C, $5C
    db $74, $38, $38, $6A, $56, $6A, $56, $62, $5A, $62, $56, $62, $6E, $22, $3E, $32
    db $3E, $1C, $1C, $5E, $66, $5E, $66, $5E, $6E, $5A, $7E, $72, $7E, $32, $3E, $3A
    db $2E, $1C, $1C, $00, $F8, $F8, $FE, $FE, $FF, $AB, $FE, $5E, $F9, $B8, $5C, $54
    db $EE, $EA, $FE, $EA, $00, $F8, $F8, $FE, $FE, $FF, $FF, $FF, $FF, $F8, $F9, $FC
    db $FC, $FE, $FE, $FE, $FE, $C3, $C0, $C0, $20, $A0, $60, $20, $80, $00, $C3, $C0
    db $C0, $60, $60, $A0, $60, $40, $80, $00, $FE, $F6, $FE, $DA, $FE, $2E, $FE, $76
    db $4E, $7E, $AE, $F6, $8C, $0C, $7C, $04, $00, $FE, $FE, $DE, $3E, $EE, $DE, $FE
    db $FE, $CE, $CE, $AE, $AE, $FC, $FC, $F4, $7C, $FF, $FF, $07, $01, $01, $01, $01
    db $03, $03, $0F, $0D, $1F, $1A, $07, $01, $01, $01, $01, $03, $03, $0D, $0F, $1A
    db $1F, $00, $38, $38, $5D, $55, $EF, $EA, $FF, $BF, $DB, $5D, $BF, $AB, $DF, $D5
    db $BF, $AF, $00, $38, $38, $7D, $7D, $FF, $FF, $FF, $FF, $F9, $FB, $F1, $F5, $F1
    db $FB, $FF, $FF, $C0, $3F, $35, $3F, $2A, $77, $75, $D3, $A2, $91, $F1, $50, $70
    db $C0, $35, $3F, $2A, $3F, $75, $77, $C2, $D3, $81, $A1, $50, $50, $00, $FF, $5F
    db $FF, $B7, $FF, $E8, $FF, $DC, $E5, $FC, $EB, $DE, $62, $60, $7C, $40, $00, $7F
    db $FF, $F7, $F8, $EF, $F7, $FF, $FF, $E7, $E7, $EB, $EB, $7F, $7E, $5F, $7C, $60
    db $40, $71, $71, $B0, $B0, $FF, $BE, $BF, $9F, $DF, $C7, $B3, $B0, $AC, $BC, $5F
    db $60, $6F, $61, $EF, $E0, $F2, $F3, $F8, $F8, $FF, $FF, $FF, $FF, $EF, $FF, $0C
    db $04, $1A, $1A, $1D, $19, $FF, $FD, $FD, $F1, $F3, $C3, $CD, $0D, $35, $3D, $F4
    db $0C, $EE, $0E, $EF, $0F, $9F, $9F, $3F, $3F, $FF, $FF, $FF, $FF, $F7, $FF, $6B
    db $5F, $72, $75, $EE, $8F, $C3, $83, $C0, $80, $C0, $80, $E1, $80, $F3, $F0, $6B
    db $7F, $7A, $7F, $8C, $FF, $83, $FF, $80, $FF, $80, $FF, $80, $FF, $F0, $CF, $D6
    db $FA, $4E, $AE, $77, $F1, $C3, $C1, $03, $01, $03, $01, $87, $01, $CF, $0F, $D6
    db $FE, $5E, $FE, $31, $FF, $C1, $FF, $01, $FF, $01, $FF, $01, $FF, $0F, $F3, $3F
    db $7F, $7F, $FF, $B4, $3F, $7F, $7F, $F7, $FF, $3F, $FE, $FE, $FF, $51, $3F, $FE
    db $FE, $F1, $FF, $F8, $FE, $22, $FF, $41, $FF, $FF, $F8, $E3, $FF, $C1, $FF, $FF
    db $FF, $F8, $9F, $89, $0F, $05, $FE, $FE, $F8, $F9, $FF, $FD, $FF, $FE, $FE, $00
    db $30, $30, $78, $48, $FC, $8C, $FE, $82, $FF, $C1, $61, $7E, $35, $2A, $10, $1F
    db $00, $30, $30, $48, $78, $8C, $FC, $82, $FE, $C1, $FF, $7E, $69, $3E, $29, $1F
    db $1F, $1F, $80, $80, $C0, $40, $20, $E0, $1F, $80, $80, $40, $C0, $E0, $E0, $F0
    db $08, $08, $04, $07, $02, $03, $01, $01, $F0, $0F, $0F, $04, $07, $02, $03, $01
    db $01, $00, $30, $70, $38, $F8, $3C, $C4, $3E, $C2, $83, $FD, $7B, $45, $21, $21
    db $1F, $1F, $00, $F0, $D0, $78, $C8, $44, $FC, $42, $FE, $FD, $C3, $7D, $43, $3F
    db $3F, $1F, $1F, $00, $60, $60, $F0, $F0, $F8, $B8, $FC, $FC, $FE, $FE, $7F, $77
    db $27, $25, $17, $14, $00, $60, $60, $F0, $F0, $B8, $D8, $FC, $8C, $FE, $9E, $7F
    db $5F, $3D, $3F, $1C, $1F, $3F, $80, $80, $C0, $C0, $3F, $80, $80, $C0, $C0, $F0
    db $08, $0F, $05, $05, $03, $03, $01, $01, $F0, $0F, $0F, $07, $06, $03, $02, $01
    db $01, $00, $E0, $E0, $F0, $F0, $F8, $F8, $FC, $DC, $9E, $96, $5F, $53, $23, $3F
    db $1F, $1F, $00, $E0, $60, $F0, $30, $F8, $78, $FC, $7C, $F6, $FE, $73, $7F, $3F
    db $3D, $1F, $18, $0F, $0D, $1F, $13, $1F, $1D, $1F, $19, $1F, $19, $1F, $19, $1F
    db $1D, $1B, $1B, $0F, $0F, $1F, $1F, $1D, $1F, $19, $1F, $19, $1F, $19, $1F, $1D
    db $1F, $1F, $1F, $F0, $B0, $F8, $C8, $F8, $B8, $F8, $98, $F8, $98, $F8, $98, $F8
    db $B8, $D8, $D8, $F0, $F0, $F8, $F8, $B8, $F8, $98, $F8, $98, $F8, $98, $F8, $B8
    db $F8, $F8, $F8, $1D, $1D, $19, $19, $19, $11, $1F, $11, $1F, $19, $1F, $15, $1F
    db $13, $1F, $11, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $17, $1F, $13
    db $1F, $11, $1F, $B8, $B8, $98, $98, $98, $88, $F8, $88, $F8, $98, $F8, $A8, $F8
    db $C8, $F8, $88, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $E8, $F8, $C8
    db $F8, $88, $F8, $00, $F0, $90, $FC, $FC, $FE, $86, $FF, $BF, $FF, $FB, $F3, $F2
    db $FB, $FA, $FC, $BF, $00, $F0, $F0, $FC, $FC, $86, $FE, $BF, $CF, $FF, $CF, $FE
    db $7F, $FE, $FF, $FF, $FF, $0F, $80, $80, $C0, $C0, $E0, $60, $70, $F0, $0F, $80
    db $80, $C0, $C0, $60, $E0, $F0, $B0, $00, $3E, $2F, $BF, $A7, $47, $7F, $2F, $2F
    db $1F, $1F, $0F, $0E, $04, $04, $03, $03, $00, $EF, $FF, $E7, $FF, $7F, $7B, $3F
    db $31, $1F, $13, $0F, $0B, $07, $07, $03, $03, $00, $F8, $F8, $FC, $FC, $FE, $EE
    db $CF, $CB, $EF, $E9, $F1, $FF, $F7, $B7, $FF, $9F, $00, $F8, $18, $FC, $3C, $FE
    db $BE, $FB, $FF, $F9, $FF, $FF, $FF, $BF, $F9, $9F, $FB, $1C, $1C, $36, $3E, $2E
    db $3E, $32, $3E, $08, $0C, $00, $00, $20, $2C, $20, $20, $13, $10, $25, $24, $2F
    db $2E, $33, $3E, $1B, $0C, $1F, $00, $33, $20, $3F, $20, $78, $78, $C8, $C8, $94
    db $94, $D4, $D4, $14, $14, $64, $64, $04, $04, $1C, $1C, $A8, $28, $78, $48, $FC
    db $94, $FC, $D4, $FC, $14, $FC, $64, $FC, $04, $FC, $1C, $00, $18, $30, $38, $70
    db $5F, $FF, $AF, $E0, $40, $CE, $8E, $FB, $FB, $F3, $F1, $27, $00, $37, $38, $70
    db $78, $FF, $FF, $FF, $FF, $F5, $FF, $8A, $FF, $F1, $FF, $30, $70, $30, $70, $78
    db $C8, $E4, $C4, $02, $02, $E7, $E5, $BF, $BF, $DF, $1F, $B0, $30, $B0, $30, $78
    db $78, $FC, $FC, $FE, $FE, $5F, $FF, $A3, $FF, $1F, $FF, $3F, $1F, $1F, $7F, $70
    db $3F, $1F, $1F, $70, $7F, $3F, $FF, $FF, $FF, $00, $3F, $FF, $FF, $00, $FF, $F0
    db $C0, $EF, $83, $F4, $80, $FB, $7F, $7F, $F0, $FF, $B8, $CF, $FC, $87, $FF, $7F
    db $7F, $F0, $30, $F7, $42, $BD, $E1, $12, $FF, $FF, $F0, $FF, $48, $E3, $BD, $FF
    db $1E, $FF, $FF, $00, $30, $30, $78, $48, $FC, $8C, $FE, $82, $FF, $C9, $61, $7E
    db $35, $2A, $10, $1F, $00, $30, $30, $48, $78, $8C, $FC, $82, $FE, $C9, $FF, $7E
    db $69, $3E, $29, $1F, $1F, $1F, $80, $80, $C0, $40, $40, $C0, $1F, $80, $80, $40
    db $C0, $C0, $C0, $F0, $08, $08, $04, $07, $02, $03, $01, $01, $F0, $0F, $0F, $04
    db $07, $02, $03, $01, $01, $E0, $20, $60, $30, $F0, $30, $F0, $60, $E0, $80, $80
    db $E0, $E0, $E0, $70, $D0, $70, $F0, $60, $E0, $80, $80, $FF, $FF, $1F, $18, $18
    db $38, $38, $50, $50, $1F, $18, $18, $38, $38, $70, $50, $9F, $01, $01, $01, $01
    db $9F, $01, $01, $01, $01, $00, $70, $70, $48, $48, $34, $34, $2E, $2E, $17, $17
    db $19, $19, $BC, $BC, $EA, $EA, $00, $70, $70, $78, $48, $3C, $34, $36, $26, $1F
    db $17, $1E, $18, $BB, $B8, $F5, $E0, $0F, $03, $03, $07, $07, $07, $06, $01, $01
    db $0F, $03, $03, $07, $07, $07, $07, $01, $01, $00, $D5, $D5, $E0, $E0, $C0, $C0
    db $E0, $E0, $C0, $E0, $C0, $E0, $E0, $B0, $E0, $70, $00, $EA, $C0, $DF, $C0, $FF
    db $C0, $FF, $E0, $DF, $C0, $DF, $C0, $EF, $E0, $EF, $E0, $C0, $07, $06, $07, $05
    db $07, $07, $07, $07, $02, $02, $01, $01, $C0, $07, $07, $07, $07, $07, $07, $07
    db $07, $03, $03, $01, $01, $08, $90, $98, $18, $1F, $8F, $8F, $63, $63, $F6, $B6
    db $FD, $BC, $FB, $F8, $00, $F7, $F0, $F8, $F8, $FF, $FF, $FF, $FF, $FD, $FF, $AA
    db $FF, $A4, $FF, $F8, $DF, $FF, $FF, $7F, $30, $30, $7F, $30, $30, $1F, $01, $01
    db $07, $07, $08, $08, $1F, $01, $01, $07, $07, $0F, $08, $00, $F8, $F8, $F4, $F4
    db $7C, $7C, $E4, $E4, $D8, $D8, $A8, $A8, $D0, $D0, $38, $38, $00, $F8, $F8, $FC
    db $F4, $7C, $7C, $FC, $E4, $F8, $D8, $D8, $88, $F0, $D0, $F8, $38, $E0, $04, $04
    db $18, $18, $1C, $14, $F0, $F0, $F0, $F0, $E8, $FC, $04, $E0, $00, $F4, $1C, $F0
    db $F0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E0, $7C, $78, $7E, $7E, $3E, $3E
    db $1F, $1F, $0F, $0F, $E0, $7B, $7C, $7D, $7C, $3D, $3C, $1E, $1E, $0F, $0F, $FF
    db $FF, $FF, $FF, $00, $F8, $F8, $FE, $FE, $FF, $AB, $FE, $5E, $F9, $B8, $5C, $54
    db $EC, $AC, $FE, $EA, $00, $F8, $F8, $FE, $FE, $FF, $FF, $FF, $FF, $F8, $F9, $FC
    db $FC, $FC, $FC, $FE, $FE, $C3, $C0, $C0, $20, $A0, $60, $20, $80, $00, $C3, $C0
    db $C0, $60, $60, $A0, $60, $40, $80, $00, $FE, $F6, $FE, $0A, $FE, $06, $FC, $74
    db $48, $78, $D8, $30, $90, $00, $60, $00, $00, $FE, $FE, $0E, $FE, $F6, $FE, $FC
    db $FC, $C8, $C8, $D8, $D8, $F8, $F0, $F8, $60, $FF, $FF, $07, $01, $01, $01, $01
    db $03, $03, $0F, $0D, $1F, $1A, $07, $01, $01, $01, $01, $03, $03, $0D, $0F, $1A
    db $1F, $00, $38, $38, $5D, $55, $EF, $EA, $FF, $BF, $DB, $5D, $BF, $AB, $DF, $D5
    db $BF, $AE, $00, $38, $38, $7D, $7D, $FF, $FF, $FF, $FF, $F9, $FB, $F1, $F5, $F1
    db $FB, $FF, $FF, $C0, $3F, $35, $3F, $2A, $77, $75, $D3, $A2, $91, $F1, $50, $70
    db $C0, $35, $3F, $2A, $3F, $75, $77, $C2, $D3, $81, $A1, $50, $50, $00, $FF, $55
    db $FF, $AB, $FF, $56, $FF, $AC, $FF, $54, $FF, $AC, $7C, $78, $7C, $78, $00, $7F
    db $FF, $BF, $FF, $5E, $FF, $AD, $FF, $5D, $FF, $FD, $FF, $7B, $7C, $7B, $7C, $FC
    db $01, $01, $01, $01, $FC, $01, $01, $01, $01, $00, $FF, $FF, $FF, $AA, $FF, $D5
    db $AA, $AA, $55, $55, $2A, $2A, $15, $15, $0F, $0F, $00, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $7F, $7F, $3F, $3F, $1F, $1F, $0F, $0F, $FF, $FF, $FF, $FF, $1F
    db $01, $01, $0F, $0F, $11, $15, $1F, $01, $01, $0F, $0F, $1B, $1B, $0F, $7C, $7C
    db $FE, $FE, $FF, $55, $FF, $EA, $0F, $7C, $7C, $FE, $FE, $FF, $FF, $FF, $FF, $00
    db $1A, $10, $04, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $14, $1A, $08, $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $00, $7F, $75, $EA, $A9, $DF, $5E, $FF, $5D, $FF, $BF, $FF, $7F, $FF, $FF
    db $FF, $FF, $00, $7F, $7F, $FC, $FE, $FC, $FD, $5C, $FE, $BF, $FF, $7F, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $1A, $10, $04, $00
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $14, $1A, $08
    db $04, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $7F, $75
    db $EA, $A9, $DF, $5E, $FF, $5D, $FF, $BF, $FF, $7F, $FF, $FF, $FF, $FF, $00, $7F
    db $7F, $FC, $FE, $FC, $FD, $5C, $FE, $BF, $FF, $7F, $FF, $FF, $FF, $FF, $FF, $FC
    db $01, $01, $01, $01, $FC, $01, $01, $01, $01, $00, $FF, $FF, $FF, $AA, $FF, $D5
    db $AA, $AA, $55, $55, $2A, $2A, $15, $15, $0F, $0F, $00, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $7F, $7F, $3F, $3F, $1F, $1F, $0F, $0F, $08, $FC, $B4, $FE, $22
    db $FF, $52, $FF, $1D, $FE, $19, $EE, $C7, $F8, $47, $E8, $F4, $FF, $42, $7F, $41
    db $7F, $21, $3F, $22, $3F, $26, $3F, $38, $3F, $28, $2F, $00, $40, $00, $40, $00
    db $40, $00, $40, $00, $40, $00, $40, $00, $40, $00, $40, $40, $C0, $40, $C0, $40
    db $C0, $40, $C0, $40, $C0, $40, $C0, $40, $C0, $40, $C0, $07, $C8, $03, $04, $03
    db $04, $01, $02, $01, $02, $00, $01, $00, $01, $00, $00, $C8, $CF, $04, $07, $04
    db $07, $02, $03, $02, $03, $01, $01, $01, $01, $00, $00, $00, $40, $00, $40, $00
    db $40, $00, $40, $00, $40, $00, $40, $00, $40, $00, $80, $40, $C0, $40, $C0, $40
    db $C0, $40, $C0, $40, $C0, $40, $C0, $40, $C0, $80, $80, $00, $04, $0B, $04, $0B
    db $00, $0F, $01, $03, $00, $07, $07, $0F, $0C, $17, $0B, $17, $00, $08, $0B, $08
    db $0B, $0C, $0F, $02, $03, $07, $07, $08, $08, $1B, $13, $1C, $14, $00, $68, $DF
    db $C0, $BF, $04, $FF, $0C, $FF, $9D, $FB, $38, $F7, $C1, $FF, $E8, $FF, $00, $07
    db $DF, $04, $BC, $02, $FE, $02, $FE, $02, $FE, $C7, $FF, $38, $38, $10, $10, $E0
    db $0B, $1E, $03, $0E, $01, $02, $01, $03, $00, $01, $E0, $15, $14, $0D, $0C, $03
    db $02, $02, $02, $01, $01, $F0, $C3, $7F, $C0, $67, $80, $C0, $00, $80, $F0, $B8
    db $38, $A7, $27, $40, $40, $80, $80, $03, $00, $80, $80, $C0, $00, $C0, $40, $E0
    db $60, $D0, $A0, $C8, $03, $80, $80, $C0, $40, $C0, $40, $E0, $20, $D0, $30, $C8
    db $78, $FF, $FF, $00, $40, $84, $80, $06, $26, $09, $56, $A9, $21, $18, $04, $C0
    db $40, $F0, $30, $F8, $00, $84, $FC, $06, $FE, $E9, $1F, $B9, $EF, $18, $FF, $C0
    db $FF, $30, $FF, $48, $FF, $0F, $00, $80, $00, $80, $00, $80, $00, $40, $0F, $80
    db $80, $80, $80, $80, $80, $40, $C0, $00, $01, $00, $03, $00, $07, $00, $07, $01
    db $0F, $02, $0F, $02, $0F, $00, $1F, $01, $01, $02, $02, $04, $04, $04, $04, $08
    db $08, $08, $09, $08, $09, $10, $10, $00, $FC, $00, $FE, $32, $CF, $33, $CF, $8C
    db $FF, $59, $7F, $92, $7F, $04, $FF, $FC, $FC, $02, $02, $01, $01, $01, $00, $1F
    db $10, $8F, $86, $09, $09, $01, $01, $18, $3F, $10, $3F, $05, $3F, $11, $3F, $02
    db $17, $00, $03, $03, $07, $06, $09, $24, $24, $3F, $2B, $3F, $28, $3F, $2C, $17
    db $15, $03, $03, $04, $07, $08, $09, $02, $FF, $0B, $FC, $69, $F0, $0B, $F4, $DA
    db $FF, $56, $39, $17, $F8, $61, $FE, $01, $01, $04, $07, $91, $9E, $F4, $FF, $21
    db $3F, $E0, $39, $E0, $F8, $18, $FE, $00, $2E, $FF, $06, $FB, $41, $FE, $73, $FC
    db $07, $F8, $27, $F8, $43, $E4, $01, $C2, $00, $11, $1F, $19, $1F, $8E, $8F, $8C
    db $8F, $08, $0F, $18, $1F, $24, $27, $C2, $C3, $00, $80, $20, $80, $20, $80, $20
    db $80, $20, $80, $20, $80, $20, $80, $20, $80, $20, $00, $20, $E0, $20, $E0, $20
    db $E0, $20, $E0, $20, $E0, $20, $E0, $20, $E0, $20, $E0, $FC, $01, $02, $00, $01
    db $FC, $02, $03, $01, $01, $F0, $80, $20, $00, $A0, $00, $A0, $00, $40, $F0, $20
    db $E0, $A0, $E0, $A0, $E0, $40, $40, $60, $04, $0B, $04, $0B, $04, $0B, $02, $0F
    db $00, $0E, $00, $01, $60, $08, $0B, $08, $0B, $08, $0B, $09, $0F, $0E, $0E, $01
    db $01, $00, $62, $DF, $22, $DF, $07, $FE, $46, $FF, $2F, $FD, $41, $7F, $1C, $7F
    db $BC, $7E, $00, $00, $DC, $01, $DF, $00, $FF, $01, $FF, $C0, $FE, $3E, $3E, $63
    db $63, $C2, $42, $FC, $00, $01, $00, $01, $FC, $01, $01, $01, $01, $E0, $BC, $66
    db $B8, $E4, $18, $EC, $08, $1C, $00, $08, $E0, $DA, $42, $5C, $44, $F4, $E4, $14
    db $14, $08, $08, $07, $00, $80, $00, $60, $00, $38, $18, $24, $94, $22, $07, $80
    db $80, $60, $E0, $38, $F8, $24, $FC, $A2, $7E, $FF, $FF, $00, $40, $A1, $D8, $20
    db $00, $80, $80, $F8, $30, $FE, $02, $FF, $21, $FF, $1B, $FF, $00, $E1, $BF, $20
    db $FF, $80, $FF, $78, $FF, $4E, $FF, $F1, $FF, $C0, $FF, $20, $3F, $01, $00, $80
    db $00, $40, $00, $40, $00, $20, $00, $20, $00, $A0, $00, $A0, $01, $80, $80, $40
    db $C0, $40, $C0, $20, $E0, $20, $E0, $A0, $E0, $A0, $E0, $00, $07, $00, $1F, $03
    db $3C, $03, $3C, $00, $7F, $00, $7F, $1C, $7F, $10, $7B, $07, $07, $18, $18, $20
    db $20, $20, $20, $41, $41, $40, $40, $40, $40, $44, $4C, $00, $E0, $60, $FC, $34
    db $FE, $46, $FF, $C3, $FE, $94, $FE, $A2, $FC, $1E, $F8, $E0, $E0, $1C, $1C, $1E
    db $02, $7F, $01, $FE, $31, $4E, $4B, $4C, $4F, $01, $06, $04, $7B, $00, $FF, $68
    db $FF, $04, $7F, $02, $7F, $25, $7F, $00, $67, $00, $07, $40, $48, $80, $80, $90
    db $90, $7F, $63, $7F, $51, $7E, $5A, $67, $67, $04, $07, $2D, $F0, $65, $C2, $B4
    db $CE, $34, $FB, $AE, $F1, $96, $79, $00, $FF, $68, $FF, $17, $18, $02, $3F, $4A
    db $7F, $C1, $FB, $40, $71, $E0, $79, $FB, $FF, $04, $FC, $3F, $00, $FF, $58, $02
    db $3F, $FF, $FF, $A7, $00, $07, $00, $30, $30, $58, $60, $90, $40, $D0, $80, $60
    db $07, $30, $30, $58, $48, $90, $90, $D0, $B0, $E0, $60, $00, $05, $92, $25, $92
    db $6C, $93, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $22, $1C, $00, $FF, $00, $FF
    db $00, $FF, $00, $FF, $00, $FF, $81, $FF, $FF, $FF, $00, $FF, $00, $00, $40, $20
    db $80, $60, $00, $E0, $00, $C0, $00, $F0, $00, $D0, $40, $20, $40, $C0, $00, $E0
    db $20, $E0, $20, $E0, $60, $C0, $40, $F0, $F0, $F0, $10, $E0, $20, $C0, $C0, $16
    db $C1, $41, $3E, $42, $42, $BE, $3E, $1C, $9D, $42, $81, $69, $86, $00, $78, $EF
    db $C1, $FF, $FF, $BD, $FF, $C1, $FF, $62, $FF, $7E, $FF, $79, $FE, $87, $78, $00
    db $A0, $C0, $60, $00, $70, $74, $8C, $8A, $06, $A2, $0E, $6C, $1C, $F4, $1C, $C0
    db $E0, $80, $A0, $B0, $F0, $7C, $84, $FE, $02, $FE, $02, $FC, $0C, $F4, $1C, $81
    db $00, $FF, $00, $81, $7E, $00, $FF, $00, $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF
    db $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $C3, $FF, $FF, $FF, $FF, $D0
    db $3C, $D8, $34, $B8, $66, $2C, $FE, $00, $E2, $40, $FC, $C0, $C4, $B8, $FC, $F4
    db $1C, $F4, $1C, $E6, $3E, $EE, $32, $E2, $7E, $FC, $FC, $C4, $FC, $FC, $A4, $4E
    db $77, $12, $7F, $00, $FD, $16, $7E, $2E, $7E, $04, $6D, $24, $FD, $19, $DA, $00
    db $11, $00, $01, $02, $83, $61, $63, $41, $7F, $7A, $7F, $5B, $FF, $67, $FE, $10
    db $F0, $40, $E8, $88, $D8, $7A, $86, $45, $83, $89, $07, $A6, $1E, $5A, $26, $08
    db $38, $10, $B8, $28, $78, $7E, $82, $7F, $81, $FF, $01, $E6, $1E, $C6, $3E, $03
    db $EC, $4F, $F0, $DE, $E1, $46, $79, $28, $6F, $2F, $6F, $2F, $6F, $3F, $40, $3F
    db $FC, $7F, $F0, $FF, $C0, $7F, $40, $6F, $5C, $6F, $7F, $6F, $5F, $7F, $40, $7A
    db $C6, $7A, $C6, $00, $EE, $78, $FA, $E0, $E0, $F8, $FC, $84, $C4, $BE, $7E, $C6
    db $7E, $C6, $7E, $8E, $FE, $FA, $86, $E0, $9C, $F8, $FC, $84, $FC, $BE, $46, $1F
    db $00, $1F, $07, $30, $19, $20, $1F, $1F, $1F, $3C, $20, $3F, $20, $3F, $00, $C0
    db $80, $38, $3F, $C0, $C0, $78, $38, $00, $14, $2B, $04, $3B, $00, $FF, $10, $C7
    db $01, $78, $00, $7F, $7C, $7E, $6E, $7F, $00, $3F, $20, $3F, $20, $FF, $F8, $EF
    db $87, $3E, $78, $07, $47, $39, $3B, $00, $19, $00, $D0, $06, $B8, $02, $54, $2A
    db $10, $EC, $80, $78, $00, $8C, $C8, $F6, $20, $2E, $00, $EE, $06, $FE, $02, $FE
    db $02, $FC, $84, $F8, $78, $FC, $8C, $3E, $F6, $D6, $FA, $3F, $00, $FC, $DC, $22
    db $3F, $FC, $FC, $FE, $02, $FF, $FF, $00, $86, $22, $A8, $44, $9C, $7C, $40, $FF
    db $12, $41, $00, $FE, $F4, $FB, $FC, $FC, $00, $7E, $02, $FC, $04, $FC, $3C, $FF
    db $FF, $ED, $01, $F6, $FE, $07, $0F, $6F, $6F, $27, $00, $80, $80, $80, $00, $80
    db $80, $C0, $27, $80, $80, $80, $80, $80, $80, $40, $C0, $00, $01, $01, $03, $01
    db $03, $06, $04, $02, $04, $00, $06, $07, $07, $04, $07, $01, $01, $02, $03, $02
    db $03, $07, $05, $07, $00, $07, $00, $07, $07, $04, $07, $5D, $FF, $E4, $EB, $D8
    db $FF, $32, $3B, $36, $FE, $30, $3B, $AE, $2C, $E3, $93, $D0, $D6, $50, $D2, $40
    db $F0, $EC, $FF, $E9, $FF, $EF, $3F, $F7, $3F, $FC, $9F, $03, $04, $03, $04, $00
    db $03, $01, $01, $00, $00, $01, $03, $00, $01, $00, $01, $04, $07, $04, $07, $03
    db $03, $01, $02, $00, $03, $01, $03, $00, $01, $00, $01, $73, $CB, $DE, $66, $1A
    db $66, $C0, $FF, $60, $7F, $F3, $FE, $1F, $3D, $CD, $FD, $7C, $CF, $7F, $C7, $3F
    db $E3, $FF, $20, $7F, $B0, $FE, $FC, $1D, $FD, $DD, $2E, $7F, $00, $03, $7F, $03
    db $03, $3F, $00, $03, $02, $DD, $3F, $03, $03, $DF, $DC, $30, $01, $03, $00, $01
    db $00, $01, $00, $01, $00, $01, $00, $01, $30, $03, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $00, $D0, $69, $C6, $A9, $66, $B9, $34, $C7, $0D, $E4
    db $1C, $7B, $49, $A7, $37, $7F, $00, $7F, $20, $BB, $20, $BF, $98, $CF, $CF, $FE
    db $FC, $7F, $79, $FE, $86, $FE, $7E, $00, $00, $01, $00, $01, $00, $01, $00, $01
    db $00, $03, $01, $05, $03, $07, $01, $05, $00, $01, $01, $01, $01, $01, $01, $01
    db $01, $03, $03, $05, $06, $07, $04, $05, $06, $00, $80, $C0, $80, $C0, $80, $C0
    db $80, $C0, $00, $E0, $80, $BF, $C9, $EE, $9B, $BC, $00, $40, $C0, $40, $C0, $40
    db $C0, $40, $C0, $E0, $E0, $BF, $7F, $EC, $37, $BC, $67, $E0, $00, $3B, $10, $39
    db $28, $3F, $17, $1F, $0F, $0F, $E0, $3B, $3B, $29, $39, $37, $3F, $18, $1F, $0F
    db $0F, $E0, $41, $E6, $8E, $DF, $81, $C1, $40, $C0, $80, $80, $E0, $E4, $FF, $5F
    db $DF, $41, $C1, $C0, $C0, $80, $80, $16, $C1, $41, $3E, $42, $42, $BE, $3E, $1C
    db $9D, $42, $81, $69, $86, $00, $78, $EF, $C1, $FF, $FF, $BD, $FF, $C1, $FF, $62
    db $FF, $7E, $FF, $79, $FE, $87, $78, $00, $A0, $C0, $60, $00, $70, $74, $8C, $8A
    db $06, $A2, $0E, $6C, $1F, $F4, $1F, $C0, $E0, $80, $A0, $B0, $F0, $7C, $84, $FE
    db $02, $FE, $02, $FF, $0F, $F4, $1F, $81, $00, $FF, $00, $81, $7E, $00, $FF, $00
    db $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
    db $00, $FF, $C3, $FF, $FF, $FF, $FF, $D0, $3F, $D8, $37, $B8, $67, $20, $FC, $00
    db $F8, $40, $F0, $80, $F0, $80, $F0, $F0, $1F, $F0, $1F, $E3, $3F, $EC, $3C, $C8
    db $78, $C0, $F0, $90, $F0, $B0, $F0, $00, $10, $38, $08, $1C, $08, $1C, $04, $0E
    db $04, $0E, $02, $07, $02, $07, $02, $07, $00, $28, $38, $14, $1C, $14, $1C, $0A
    db $0E, $0A, $0E, $05, $07, $05, $07, $05, $07, $3F, $00, $37, $01, $EE, $3F, $37
    db $37, $EC, $FF, $00, $00, $03, $01, $03, $00, $02, $01, $0F, $08, $1D, $1C, $1F
    db $0F, $0F, $07, $07, $00, $03, $03, $03, $02, $02, $03, $0F, $0F, $15, $1D, $13
    db $1F, $08, $0F, $07, $07, $00, $5B, $7C, $CC, $DF, $C3, $D3, $EC, $FC, $60, $E0
    db $E0, $E0, $C0, $C0, $80, $80, $00, $7C, $A7, $DE, $33, $D3, $3F, $FC, $FC, $A0
    db $E0, $20, $E0, $40, $C0, $80, $80, $16, $C1, $41, $3E, $42, $42, $BE, $3E, $1C
    db $9D, $42, $81, $69, $86, $00, $78, $EF, $C1, $FF, $FF, $BD, $FF, $C1, $FF, $62
    db $FF, $7E, $FF, $79, $FE, $87, $78, $00, $A0, $C0, $60, $00, $70, $74, $8C, $8A
    db $06, $A2, $0E, $6C, $1E, $F4, $1F, $C0, $E0, $80, $A0, $B0, $F0, $7C, $84, $FE
    db $02, $FE, $02, $FE, $0E, $F5, $1F, $81, $00, $FF, $00, $81, $7E, $00, $FF, $00
    db $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
    db $00, $FF, $C3, $FF, $FF, $FF, $FF, $D7, $38, $D7, $38, $AC, $73, $20, $FF, $00
    db $FB, $40, $F0, $80, $F0, $80, $F0, $F8, $1F, $F0, $1F, $E0, $3F, $EE, $3F, $CB
    db $7B, $E0, $F0, $90, $F0, $B0, $F0, $BB, $FF, $27, $D7, $1A, $FD, $4F, $DC, $6C
    db $7C, $0C, $DC, $BD, $34, $D7, $C9, $0A, $6B, $0A, $4B, $03, $0F, $37, $FE, $97
    db $FC, $F7, $FC, $EF, $FC, $3F, $F9, $80, $80, $00, $80, $00, $C0, $E0, $20, $40
    db $20, $00, $60, $C0, $F0, $20, $D8, $00, $80, $80, $80, $C0, $C0, $E0, $20, $E0
    db $00, $E0, $00, $F0, $F0, $08, $F8, $AE, $93, $7B, $66, $59, $66, $03, $FC, $07
    db $FC, $CE, $79, $FB, $BC, $BE, $B1, $7E, $F3, $FE, $E3, $FC, $C7, $FC, $07, $FC
    db $0F, $78, $3F, $B8, $BF, $B1, $7F, $F0, $0C, $F8, $04, $98, $64, $00, $FC, $00
    db $CC, $80, $C0, $00, $80, $00, $80, $04, $FC, $04, $FC, $04, $FC, $44, $FC, $CC
    db $CC, $80, $C0, $00, $80, $00, $80, $BB, $FF, $27, $D7, $1A, $FD, $4F, $DC, $6C
    db $7C, $0C, $DC, $BD, $34, $D7, $C9, $0A, $6B, $0A, $4B, $03, $0F, $37, $FE, $97
    db $FC, $F7, $FC, $EF, $FC, $3F, $F9, $80, $80, $00, $80, $00, $C0, $E0, $20, $40
    db $20, $00, $7C, $EC, $F0, $3C, $C0, $00, $80, $80, $80, $C0, $C0, $E0, $20, $E0
    db $00, $FC, $1C, $E0, $FC, $00, $FC, $AE, $93, $7A, $67, $59, $66, $01, $FE, $05
    db $FE, $CF, $7C, $FB, $BC, $B6, $B9, $7E, $F3, $FE, $E3, $FC, $C7, $FC, $07, $FC
    db $0F, $7C, $3F, $B8, $BF, $B0, $7F, $7C, $80, $F8, $04, $C0, $3C, $80, $78, $00
    db $C0, $80, $C0, $00, $80, $00, $80, $00, $FC, $00, $FC, $04, $FC, $38, $F8, $40
    db $C0, $C0, $C0, $80, $80, $80, $80, $05, $92, $25, $92, $6C, $93, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $22, $1C, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
    db $81, $FF, $FF, $FF, $00, $FF, $00, $40, $20, $80, $60, $00, $E0, $00, $C0, $00
    db $F0, $00, $D0, $40, $20, $40, $C0, $E0, $20, $E0, $20, $E0, $60, $C0, $40, $F0
    db $F0, $F0, $10, $E0, $20, $C0, $C0, $16, $C1, $41, $3E, $42, $42, $BE, $3E, $1C
    db $9D, $42, $81, $69, $86, $00, $78, $EF, $C1, $FF, $FF, $BD, $FF, $C1, $FF, $62
    db $FF, $7E, $FF, $79, $FE, $87, $78, $00, $A0, $C0, $60, $00, $70, $74, $8C, $8A
    db $06, $A2, $0E, $6C, $1C, $F4, $1C, $C0, $E0, $80, $A0, $B0, $F0, $7C, $84, $FE
    db $02, $FE, $02, $FC, $0C, $F4, $1C, $14, $2B, $04, $3B, $00, $FF, $10, $C7, $01
    db $78, $00, $7F, $7C, $7E, $6E, $7F, $3F, $20, $3F, $20, $FF, $F8, $EF, $87, $3E
    db $78, $07, $47, $39, $3B, $00, $19, $D0, $06, $B8, $02, $54, $2A, $10, $EC, $80
    db $78, $00, $8C, $C8, $F6, $20, $2E, $EE, $06, $FE, $02, $FE, $02, $FC, $84, $F8
    db $78, $FC, $8C, $3E, $F6, $D6, $FA, $4E, $77, $12, $7F, $00, $FD, $16, $7E, $2E
    db $7E, $04, $6D, $24, $FD, $19, $DA, $00, $11, $00, $01, $02, $83, $61, $63, $41
    db $7F, $7A, $7F, $5B, $FF, $67, $FE, $10, $F0, $40, $E8, $88, $D8, $7A, $86, $45
    db $83, $89, $07, $A6, $1E, $5A, $26, $08, $38, $10, $B8, $28, $78, $7E, $82, $7F
    db $81, $FF, $01, $E6, $1E, $C6, $3E, $00, $1B, $36, $1F, $1F, $11, $1F, $1D, $13
    db $1D, $13, $0B, $0E, $0F, $0A, $0B, $0F, $00, $3F, $32, $1F, $1F, $11, $1F, $11
    db $1F, $11, $1F, $0F, $0A, $0F, $0A, $0F, $0B, $00, $5D, $FD, $F9, $F9, $1E, $FE
    db $E8, $18, $08, $F8, $28, $18, $C8, $38, $78, $F8, $00, $DD, $63, $F9, $E7, $1E
    db $FE, $08, $F8, $F8, $F8, $F8, $08, $F8, $08, $F8, $78, $C0, $09, $0F, $12, $1F
    db $2D, $3C, $77, $78, $F0, $FF, $3F, $3F, $C0, $0F, $09, $1F, $13, $3F, $2C, $7F
    db $78, $FF, $F8, $3F, $3F, $C0, $30, $F0, $90, $70, $D0, $30, $D0, $30, $38, $F8
    db $E0, $E0, $C0, $F0, $30, $F0, $10, $F0, $10, $F0, $30, $F8, $78, $E0, $E0, $00
    db $01, $0E, $00, $07, $00, $07, $07, $08, $09, $10, $0E, $11, $00, $1F, $00, $0F
    db $00, $0F, $0A, $07, $07, $04, $07, $0F, $08, $1F, $10, $1F, $10, $1F, $1B, $0F
    db $09, $00, $24, $DB, $00, $FF, $00, $EF, $00, $CF, $00, $C7, $00, $C3, $00, $C7
    db $00, $9F, $00, $FF, $49, $FF, $FF, $AB, $6C, $4B, $CC, $C5, $47, $C3, $42, $C5
    db $C6, $9B, $9C, $E0, $04, $1B, $0E, $61, $3E, $C1, $00, $FF, $7F, $7F, $E0, $1F
    db $19, $7F, $61, $FF, $C1, $FF, $C3, $7F, $7F, $E0, $00, $BF, $40, $FF, $60, $FF
    db $FE, $FE, $F8, $F8, $E0, $A7, $B8, $EE, $F1, $FF, $FF, $FE, $FE, $F8, $F8, $00
    db $09, $36, $00, $1F, $00, $07, $00, $07, $00, $07, $01, $1A, $01, $3E, $00, $3F
    db $00, $3F, $32, $1F, $1F, $05, $07, $05, $07, $07, $05, $1B, $1A, $27, $3E, $3B
    db $27, $00, $1E, $FF, $00, $E1, $00, $FE, $E0, $18, $00, $F8, $20, $18, $C0, $38
    db $00, $F8, $00, $DF, $61, $E1, $FF, $1E, $FE, $08, $F8, $F8, $F8, $F8, $08, $F8
    db $08, $F8, $78, $C0, $00, $3F, $00, $1F, $01, $1C, $67, $78, $E0, $FF, $3F, $3F
    db $C0, $2D, $33, $13, $1F, $1F, $1C, $7F, $78, $FF, $F8, $3F, $3F, $C0, $00, $F0
    db $80, $70, $C0, $30, $C0, $30, $18, $F8, $E0, $E0, $C0, $F0, $30, $F0, $10, $F0
    db $10, $F0, $30, $F8, $78, $E0, $E0, $00, $04, $7B, $00, $3F, $00, $3F, $00, $3F
    db $00, $3F, $00, $1F, $00, $3F, $00, $7F, $00, $7F, $69, $3F, $3F, $2D, $33, $2E
    db $31, $37, $3F, $1B, $17, $2D, $33, $5D, $63, $00, $90, $6C, $00, $FC, $00, $F8
    db $70, $8C, $24, $C3, $38, $47, $00, $3F, $00, $1F, $00, $FC, $24, $FC, $FC, $08
    db $F8, $84, $FC, $FF, $C1, $7F, $41, $3F, $2F, $1F, $13, $E0, $00, $FF, $00, $FF
    db $02, $7F, $FE, $FF, $3F, $3F, $E0, $BB, $C7, $87, $FF, $7F, $7F, $FF, $FF, $3F
    db $3F, $E0, $08, $37, $1C, $C3, $7C, $82, $00, $FC, $F8, $F8, $E0, $3F, $31, $FF
    db $C1, $FE, $82, $FC, $84, $F8, $F8, $00, $09, $36, $00, $1F, $00, $07, $07, $08
    db $09, $10, $0E, $11, $00, $1F, $00, $6F, $00, $3F, $32, $1F, $1F, $04, $07, $08
    db $0F, $1F, $10, $1F, $10, $1F, $1B, $6F, $69, $00, $1D, $DD, $00, $E2, $00, $FE
    db $00, $FE, $00, $FE, $00, $FE, $00, $FC, $00, $FC, $00, $9D, $63, $C2, $FE, $3E
    db $FE, $4A, $F6, $DA, $66, $DA, $66, $DC, $FC, $EC, $DC, $C0, $04, $FB, $2E, $C1
    db $3E, $C1, $01, $7F, $FF, $FF, $3F, $3F, $C0, $FF, $F8, $FF, $80, $FF, $81, $7F
    db $63, $FF, $FF, $3F, $3F, $C0, $00, $FC, $00, $FC, $00, $F8, $80, $F0, $F8, $F8
    db $E0, $E0, $C0, $F4, $8C, $F4, $8C, $88, $F8, $F0, $F0, $F8, $F8, $E0, $E0, $00
    db $FF, $FF, $00, $3F, $0C, $33, $0E, $32, $00, $1E, $10, $21, $1E, $21, $36, $3F
    db $00, $FF, $FF, $21, $3F, $31, $3F, $22, $3E, $1E, $1E, $3F, $21, $3F, $21, $3F
    db $37, $00, $FE, $FE, $0C, $73, $00, $7F, $3A, $7F, $32, $3E, $00, $3E, $00, $3F
    db $00, $3F, $00, $FE, $FE, $7F, $41, $7F, $41, $7F, $7B, $3E, $32, $3E, $22, $3F
    db $21, $3F, $31, $C0, $22, $3E, $0D, $23, $05, $03, $3D, $43, $43, $7F, $3E, $3E
    db $C0, $3E, $22, $3F, $21, $3F, $01, $7F, $43, $7F, $47, $3E, $3E, $E0, $21, $3F
    db $FF, $FF, $FF, $FF, $FE, $FE, $FC, $FC, $E0, $3F, $39, $FF, $FF, $FF, $FF, $FE
    db $FE, $FC, $FC, $00, $FF, $FF, $00, $3F, $0C, $32, $00, $3E, $10, $23, $1C, $23
    db $1E, $3F, $3C, $32, $00, $FF, $FF, $31, $3F, $22, $3E, $3E, $3E, $3F, $21, $3F
    db $21, $3F, $3F, $3E, $32, $00, $FF, $FF, $00, $7C, $18, $24, $00, $3E, $12, $61
    db $0E, $71, $3A, $7F, $12, $3E, $00, $FF, $FF, $44, $7C, $04, $3C, $3E, $3E, $7F
    db $41, $7F, $41, $7F, $7B, $3E, $32, $C0, $70, $4E, $44, $3E, $47, $7F, $3F, $3F
    db $1F, $1F, $0F, $0F, $C0, $72, $4E, $46, $3E, $47, $7F, $3F, $3F, $1F, $1F, $0F
    db $0F, $C0, $04, $3A, $0E, $31, $CE, $F1, $F1, $FF, $FF, $FF, $FC, $FC, $C0, $3E
    db $22, $3F, $21, $FF, $F1, $FF, $F9, $FF, $FF, $FC, $FC, $1C, $5D, $21, $23, $1F
    db $1F, $00, $07, $00, $07, $06, $07, $04, $07, $00, $07, $5C, $63, $21, $3F, $1F
    db $1F, $07, $04, $07, $04, $07, $06, $07, $04, $07, $04, $FF, $00, $6D, $B6, $FF
    db $FF, $00, $F3, $00, $F3, $E3, $F2, $40, $E3, $04, $E6, $FF, $00, $FF, $24, $FF
    db $FF, $F3, $13, $F0, $13, $F2, $F3, $E3, $63, $E7, $24, $00, $07, $07, $08, $08
    db $0F, $1F, $1F, $1F, $1F, $0F, $0F, $07, $07, $00, $00, $07, $00, $0F, $08, $0F
    db $08, $1F, $1F, $1F, $1F, $0F, $0F, $07, $07, $00, $00, $05, $E6, $87, $67, $7F
    db $FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF, $FF, $00, $00, $E7, $24, $E7, $67, $FF
    db $FF, $FF, $FE, $FF, $FE, $FF, $FF, $FF, $FF, $00, $00, $B9, $BA, $43, $46, $3F
    db $3F, $06, $07, $06, $07, $07, $04, $00, $07, $07, $08, $B9, $C6, $43, $7E, $3F
    db $3F, $06, $07, $06, $07, $04, $07, $07, $07, $0F, $08, $FE, $01, $6D, $DB, $FF
    db $FF, $00, $C7, $44, $C7, $C0, $47, $0B, $CC, $2B, $EC, $FF, $00, $FF, $49, $FF
    db $FF, $00, $C7, $44, $C7, $47, $C7, $CF, $C8, $EF, $28, $06, $09, $0D, $0F, $08
    db $0F, $1E, $01, $3F, $3F, $2F, $3F, $1F, $1F, $0F, $0F, $0F, $08, $0F, $0D, $0F
    db $08, $1F, $00, $20, $20, $3F, $3F, $1F, $1F, $0F, $0F, $2F, $EF, $E6, $E7, $C5
    db $C6, $7D, $FE, $7D, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $EF, $2F, $E7, $E6, $C7
    db $C4, $FF, $7C, $FF, $7E, $7F, $7F, $FF, $FF, $FF, $FF, $00, $0D, $53, $CD, $33
    db $A1, $3F, $E1, $BB, $ED, $20, $ED, $0A, $FF, $00, $7F, $80, $00, $E0, $42, $30
    db $70, $86, $4E, $0C, $48, $09, $F2, $47, $F3, $80, $7F, $08, $7F, $00, $04, $5E
    db $60, $0C, $6C, $50, $2C, $52, $FA, $03, $F1, $0E, $FC, $33, $8A, $53, $00, $6A
    db $CE, $4C, $9C, $B1, $9C, $32, $DE, $05, $F9, $2A, $FB, $43, $8F, $B5, $D9, $F0
    db $6D, $B6, $6B, $90, $12, $6B, $00, $12, $F0, $80, $C9, $A5, $C8, $7D, $69, $12
    db $12, $F8, $98, $64, $80, $78, $00, $C0, $F8, $64, $FC, $78, $F8, $C0, $C0, $00
    db $01, $00, $01, $00, $18, $08, $1C, $04, $0C, $22, $65, $10, $37, $0C, $1B, $01
    db $01, $01, $00, $18, $19, $1C, $04, $08, $06, $67, $46, $37, $2D, $19, $15, $00
    db $00, $00, $80, $00, $C1, $41, $63, $60, $55, $82, $DC, $1F, $60, $7D, $FC, $00
    db $00, $80, $80, $C1, $41, $62, $A3, $56, $94, $CE, $6D, $68, $FF, $81, $93, $04
    db $0F, $00, $06, $04, $01, $0D, $12, $1F, $38, $E3, $DC, $0F, $73, $14, $12, $0E
    db $0A, $06, $07, $13, $07, $13, $1E, $20, $2F, $D4, $3F, $70, $7C, $0B, $06, $0D
    db $53, $CD, $33, $A1, $3F, $E1, $BB, $ED, $20, $ED, $0A, $FF, $00, $7F, $80, $E0
    db $42, $30, $70, $86, $4E, $0C, $48, $09, $F2, $47, $F3, $80, $7F, $08, $7F, $00
    db $20, $20, $40, $E0, $00, $C2, $04, $46, $00, $84, $20, $B8, $A3, $33, $C6, $3B
    db $00, $20, $00, $E0, $A0, $42, $42, $46, $C2, $8C, $8C, $B8, $88, $12, $F0, $B3
    db $F5, $8F, $00, $40, $80, $C0, $00, $80, $8F, $40, $40, $40, $40, $80, $80, $00
    db $04, $5E, $60, $0C, $6C, $50, $2C, $52, $FA, $03, $F1, $0E, $FC, $33, $8A, $53
    db $00, $6A, $CE, $4C, $9C, $B1, $9C, $32, $DE, $05, $F9, $2A, $FB, $43, $8F, $B5
    db $D9, $FF, $FF, $04, $00, $01, $00, $01, $04, $08, $02, $08, $01, $07, $00, $22
    db $18, $37, $04, $01, $01, $01, $01, $00, $04, $0C, $0A, $07, $04, $23, $13, $33
    db $2B, $01, $80, $80, $00, $E1, $20, $B3, $03, $6D, $11, $4C, $7E, $01, $CF, $0D
    db $03, $A1, $A1, $92, $D2, $5C, $6C, $58, $6B, $25, $FF, $22, $F0, $00, $00, $16
    db $01, $0C, $0D, $02, $17, $30, $E3, $DC, $0F, $71, $07, $13, $07, $13, $00, $1D
    db $1C, $0C, $0E, $23, $0E, $2C, $27, $D5, $37, $71, $7F, $0B, $07, $1B, $17, $00
    db $2C, $B2, $AC, $33, $A1, $BF, $DE, $7F, $80, $3F, $FF, $FF, $FF, $FF, $FF, $FF
    db $00, $81, $D0, $C3, $43, $00, $50, $21, $C0, $3F, $C0, $FF, $FF, $FF, $FF, $FF
    db $FF, $00, $00, $01, $00, $02, $01, $06, $07, $0B, $0B, $13, $0F, $3E, $25, $7E
    db $0A, $5E, $00, $01, $01, $03, $02, $04, $04, $0B, $0B, $17, $17, $27, $26, $6E
    db $4E, $64, $67, $00, $00, $E0, $80, $90, $80, $68, $40, $B4, $90, $EB, $E3, $7E
    db $5A, $C9, $9C, $E2, $00, $E0, $E0, $70, $90, $18, $28, $0C, $04, $27, $23, $70
    db $78, $C5, $E3, $DA, $C6, $E0, $0E, $9F, $04, $BD, $04, $B7, $03, $CC, $0C, $30
    db $E0, $E1, $91, $CA, $80, $FB, $87, $FF, $CF, $7C, $7C, $F0, $D8, $C4, $A0, $98
    db $00, $F0, $80, $00, $F0, $B4, $8C, $78, $38, $F0, $F0, $80, $80, $00, $00, $00
    db $80, $00, $41, $41, $E3, $60, $D5, $02, $5C, $1F, $60, $7D, $1C, $00, $00, $80
    db $80, $41, $C1, $A2, $E2, $D6, $95, $4F, $6D, $60, $7F, $00, $63, $20, $40, $00
    db $E0, $00, $C6, $04, $42, $00, $84, $20, $B8, $80, $10, $C6, $3B, $40, $60, $E0
    db $A0, $46, $46, $46, $C6, $84, $8C, $B8, $88, $10, $F0, $73, $F5, $ED, $73, $AD
    db $F3, $E1, $FF, $FE, $FE, $F2, $FE, $F4, $FC, $DB, $F8, $E7, $E0, $00, $90, $C0
    db $80, $C0, $C2, $E2, $E1, $FE, $F1, $FC, $F3, $E8, $C7, $C4, $1F, $44, $3E, $00
    db $5C, $6C, $00, $EC, $52, $FA, $03, $F1, $0E, $FC, $33, $8A, $52, $BA, $FE, $6C
    db $CC, $40, $9C, $32, $9E, $2D, $F9, $8A, $FB, $43, $8F, $B4, $98, $6B, $04, $5D
    db $00, $3D, $41, $3C, $42, $3E, $40, $3F, $40, $3F, $40, $3F, $40, $04, $7F, $00
    db $7F, $41, $7E, $42, $7F, $40, $7F, $40, $7F, $40, $7F, $40, $7F, $FF, $00, $7E
    db $80, $BC, $40, $A9, $90, $69, $68, $12, $11, $85, $02, $FB, $04, $00, $FF, $80
    db $FF, $40, $FF, $90, $7F, $68, $97, $11, $EF, $02, $FF, $04, $FF, $3F, $40, $3F
    db $40, $7F, $00, $7F, $80, $71, $80, $7C, $80, $3F, $40, $01, $3E, $40, $7F, $40
    db $7F, $00, $7F, $80, $FF, $80, $FF, $80, $FF, $40, $7F, $3E, $3F, $FF, $00, $FF
    db $00, $FF, $00, $FF, $00, $E1, $00, $07, $00, $FE, $01, $F3, $0F, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $01, $FF, $0F, $FF, $00, $07, $05
    db $01, $02, $00, $00, $03, $00, $0C, $03, $13, $23, $43, $6C, $0F, $07, $07, $01
    db $06, $00, $03, $03, $03, $0C, $0F, $13, $1C, $43, $7C, $0F, $70, $00, $E0, $60
    db $98, $50, $56, $A2, $49, $09, $0C, $52, $FE, $A0, $FE, $01, $FF, $E0, $E0, $98
    db $78, $56, $AE, $49, $F7, $0C, $F3, $FE, $01, $FE, $01, $FF, $00, $2A, $5F, $28
    db $10, $1D, $20, $1E, $20, $3F, $00, $3F, $00, $3F, $00, $77, $08, $5F, $70, $10
    db $3F, $20, $3F, $20, $3F, $00, $3F, $00, $3F, $00, $3F, $08, $7F, $D7, $FF, $AD
    db $AC, $01, $00, $A3, $00, $D7, $00, $AB, $00, $DF, $00, $EF, $00, $FF, $00, $AC
    db $53, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $0A, $11, $16
    db $20, $1E, $20, $36, $41, $3F, $40, $3B, $40, $7F, $80, $7F, $80, $11, $1F, $20
    db $3F, $20, $3F, $41, $7F, $40, $7F, $40, $7F, $80, $FF, $80, $FF, $FF, $00, $BF
    db $40, $5E, $20, $74, $48, $35, $B4, $89, $08, $C2, $01, $CD, $02, $00, $FF, $40
    db $FF, $20, $FF, $48, $BF, $B4, $CB, $08, $F7, $01, $FF, $02, $FF, $7F, $80, $7F
    db $00, $5F, $20, $0E, $30, $17, $18, $F9, $FE, $FF, $FF, $1F, $1F, $80, $FF, $00
    db $7F, $20, $7F, $30, $3F, $18, $1F, $FE, $FF, $FF, $FF, $1F, $1F, $FF, $00, $FF
    db $00, $FF, $00, $3C, $00, $01, $00, $FE, $01, $FF, $FF, $FF, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $01, $FF, $FF, $FF, $FF, $FF, $36, $40, $27
    db $40, $2E, $41, $2F, $40, $3F, $40, $3F, $40, $3F, $40, $7F, $80, $40, $7F, $40
    db $7F, $41, $7F, $40, $7F, $40, $7F, $40, $7F, $40, $7F, $80, $FF, $5F, $20, $6F
    db $50, $38, $24, $19, $98, $C1, $00, $FE, $01, $F9, $06, $FF, $00, $20, $FF, $50
    db $BF, $24, $DF, $98, $E7, $00, $FF, $01, $FF, $06, $FF, $00, $FF, $7F, $80, $7F
    db $80, $7F, $80, $3E, $40, $3F, $40, $1F, $20, $6F, $70, $18, $1F, $80, $FF, $80
    db $FF, $80, $FF, $40, $7F, $40, $7F, $20, $3F, $70, $7F, $1F, $1F, $FF, $00, $FF
    db $00, $FE, $00, $F9, $00, $03, $00, $FF, $00, $FF, $00, $FE, $01, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $01, $FF, $00, $01, $05
    db $01, $00, $04, $00, $03, $00, $04, $0B, $13, $1A, $03, $0A, $14, $01, $01, $01
    db $06, $04, $07, $03, $03, $04, $07, $13, $1C, $03, $1C, $14, $1F, $00, $FC, $8A
    db $F9, $8C, $56, $62, $83, $E8, $FF, $00, $FF, $B5, $FF, $2B, $2B, $FC, $FC, $F9
    db $07, $56, $F9, $83, $FC, $FF, $00, $FF, $00, $FF, $00, $2B, $D4, $0B, $04, $07
    db $08, $07, $08, $07, $08, $07, $08, $0D, $12, $1E, $21, $3F, $40, $04, $0F, $08
    db $0F, $08, $0F, $08, $0F, $08, $0F, $12, $1F, $21, $3F, $40, $7F, $40, $00, $A8
    db $00, $F5, $00, $EA, $00, $F7, $00, $FB, $00, $FF, $00, $C7, $38, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $38, $FF, $1B, $60, $5D
    db $80, $38, $84, $7A, $84, $7F, $80, $7D, $82, $7E, $81, $7F, $80, $60, $7F, $80
    db $FF, $84, $FF, $84, $FF, $80, $FF, $82, $FF, $81, $FF, $80, $FF, $E3, $1C, $FA
    db $04, $F4, $08, $5C, $25, $59, $5A, $23, $20, $87, $00, $67, $80, $1C, $FF, $04
    db $FF, $08, $FF, $25, $FB, $5A, $A7, $20, $DF, $00, $FF, $80, $FF, $7F, $80, $7F
    db $80, $7F, $80, $3D, $42, $32, $4C, $33, $4C, $05, $39, $00, $1A, $80, $FF, $80
    db $FF, $80, $FF, $43, $7E, $4F, $7C, $4F, $7C, $3E, $38, $1F, $1A, $FF, $00, $F1
    db $00, $B3, $4C, $3F, $C0, $BF, $40, $9F, $60, $01, $7F, $1F, $BF, $00, $FF, $00
    db $FF, $4C, $FF, $C0, $FF, $C0, $7F, $E0, $7F, $FF, $7F, $FF, $BF, $00, $00, $00
    db $00, $00, $03, $02, $04, $04, $09, $0A, $13, $04, $17, $06, $27, $00, $00, $00
    db $00, $03, $03, $04, $07, $09, $0E, $13, $1C, $17, $18, $27, $38, $00, $3F, $35
    db $CC, $52, $50, $28, $96, $80, $81, $56, $FE, $22, $FF, $DD, $FF, $3F, $3F, $CC
    db $F3, $50, $AE, $96, $7E, $81, $7F, $FE, $01, $FF, $00, $FF, $00, $0F, $20, $00
    db $2F, $17, $28, $32, $08, $12, $28, $13, $26, $0A, $31, $15, $69, $20, $3F, $2F
    db $3F, $2E, $3A, $0F, $3B, $2F, $3B, $25, $3D, $31, $3F, $69, $7E, $83, $00, $00
    db $FF, $27, $D8, $12, $A8, $66, $20, $FE, $53, $00, $FF, $A3, $BE, $00, $FF, $FF
    db $FF, $FF, $DE, $EF, $EE, $9B, $9A, $AD, $8D, $FF, $FE, $BE, $41, $2B, $A0, $5D
    db $C0, $38, $84, $5A, $84, $3F, $80, $7D, $82, $7F, $80, $7F, $80, $A0, $DF, $C0
    db $BF, $84, $FF, $84, $FF, $80, $FF, $82, $FF, $80, $FF, $80, $FF, $F3, $0C, $FE
    db $00, $FC, $00, $7C, $05, $69, $7A, $3B, $38, $83, $00, $C7, $00, $0C, $FF, $00
    db $FF, $00, $FF, $05, $FB, $7A, $87, $38, $C7, $00, $FF, $00, $FF, $7F, $80, $7F
    db $80, $7B, $80, $3E, $40, $3F, $40, $3F, $40, $0F, $30, $07, $18, $80, $FF, $80
    db $FF, $80, $FF, $40, $7F, $40, $7F, $40, $7F, $30, $3F, $18, $1F, $FF, $00, $FD
    db $00, $FF, $00, $FF, $00, $9F, $00, $FF, $00, $FF, $00, $F8, $07, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $07, $FF, $35, $50, $28
    db $44, $3A, $44, $3F, $40, $3D, $42, $3E, $41, $3F, $40, $3F, $40, $50, $6F, $44
    db $7F, $44, $7F, $40, $7F, $42, $7F, $41, $7F, $40, $7F, $40, $7F, $FA, $04, $F4
    db $08, $5C, $25, $51, $5A, $23, $20, $87, $00, $67, $80, $FF, $00, $04, $FF, $08
    db $FF, $25, $FB, $5A, $A7, $20, $DF, $00, $FF, $80, $FF, $00, $FF, $7F, $80, $7E
    db $80, $7F, $80, $7F, $80, $3F, $40, $3F, $40, $35, $3F, $38, $3E, $80, $FF, $80
    db $FF, $80, $FF, $80, $FF, $40, $7F, $40, $7F, $3A, $3A, $3F, $3E, $FE, $00, $EF
    db $00, $3E, $01, $F9, $06, $E5, $1F, $DF, $3F, $1F, $BF, $5F, $FF, $00, $FF, $00
    db $FF, $01, $FF, $07, $FE, $1F, $FF, $3F, $FF, $FF, $BF, $FF, $FF, $00, $00, $00
    db $00, $01, $02, $03, $05, $04, $09, $02, $0B, $03, $13, $07, $10, $00, $00, $00
    db $00, $02, $03, $05, $06, $09, $0E, $0B, $0C, $13, $1C, $10, $1F, $00, $3F, $51
    db $9F, $31, $6A, $46, $C1, $17, $FF, $00, $FF, $AD, $FF, $81, $00, $3F, $3F, $9F
    db $E0, $6A, $9F, $C1, $3F, $FF, $00, $FF, $00, $FF, $00, $00, $FF, $00, $17, $0B
    db $14, $19, $04, $19, $04, $09, $13, $05, $18, $1A, $24, $2B, $08, $17, $1F, $17
    db $1D, $07, $1D, $07, $1D, $12, $1E, $18, $1F, $24, $3F, $08, $37, $7E, $81, $93
    db $6C, $09, $54, $33, $10, $FF, $29, $00, $FF, $D1, $DF, $E3, $1C, $81, $FF, $7F
    db $6F, $F7, $F7, $CD, $CD, $D6, $C6, $FF, $FF, $DF, $20, $1C, $FF, $00, $01, $01
    db $01, $05, $08, $01, $13, $15, $5F, $60, $FF, $55, $7F, $82, $02, $01, $01, $01
    db $02, $08, $0F, $13, $1C, $5F, $60, $FF, $80, $7F, $80, $02, $FD, $00, $F0, $20
    db $E8, $D0, $F4, $00, $7C, $04, $7A, $B8, $82, $5A, $C1, $A8, $81, $F0, $F0, $E8
    db $18, $F4, $0C, $7C, $FC, $7A, $FE, $82, $7E, $C1, $3F, $81, $7F, $08, $F0, $3C
    db $41, $1F, $34, $21, $14, $2A, $00, $2A, $57, $41, $7F, $22, $3E, $F0, $FF, $7F
    db $51, $3F, $3E, $1F, $3E, $1D, $3C, $41, $69, $7F, $3E, $3E, $41, $11, $00, $FF
    db $00, $7F, $80, $7F, $80, $FF, $00, $7B, $00, $73, $00, $ED, $0C, $00, $FF, $00
    db $FF, $80, $FF, $80, $FF, $00, $FF, $00, $FF, $00, $FF, $0C, $F3, $1F, $20, $1F
    db $00, $0F, $10, $06, $09, $01, $0E, $04, $08, $0A, $0A, $05, $14, $20, $3F, $00
    db $1F, $10, $1F, $09, $0F, $0E, $0F, $08, $0F, $0A, $05, $14, $1B, $EF, $00, $DF
    db $00, $FF, $00, $FF, $00, $7F, $00, $FF, $00, $FF, $00, $FF, $00, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $1F, $20, $1F
    db $20, $1F, $23, $90, $27, $94, $E8, $05, $1F, $18, $36, $05, $1C, $20, $3F, $20
    db $3F, $23, $3C, $E7, $3F, $6F, $78, $12, $12, $2D, $24, $1B, $18, $FF, $00, $BF
    db $00, $7F, $00, $DF, $00, $FF, $00, $7F, $00, $5F, $20, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $80, $7F, $C0, $3F, $E0, $3F, $FF, $FF, $05, $02, $07
    db $00, $03, $04, $03, $04, $03, $08, $05, $09, $04, $08, $07, $08, $02, $07, $00
    db $07, $04, $07, $04, $07, $08, $0F, $09, $0E, $08, $0F, $08, $0F, $FE, $00, $FB
    db $00, $EF, $10, $17, $E0, $9F, $00, $BF, $80, $7F, $00, $FF, $00, $00, $FF, $00
    db $FF, $10, $FF, $E0, $FF, $00, $FF, $80, $7F, $00, $FF, $00, $FF, $07, $08, $07
    db $08, $07, $08, $0F, $13, $08, $77, $48, $C4, $0B, $78, $01, $0F, $08, $0F, $08
    db $0F, $08, $0F, $1C, $10, $6E, $66, $BB, $80, $77, $70, $0F, $0F, $FF, $00, $7F
    db $00, $FD, $00, $63, $00, $5F, $20, $1F, $60, $60, $FF, $FF, $FF, $00, $FF, $00
    db $FF, $00, $FF, $C0, $3F, $E0, $3F, $E0, $7F, $FF, $FF, $FF, $FF, $0E, $10, $0F
    db $10, $07, $08, $07, $08, $07, $08, $03, $04, $01, $05, $02, $04, $10, $1F, $10
    db $1F, $08, $0F, $08, $0F, $08, $0F, $04, $07, $05, $06, $04, $07, $57, $00, $EF
    db $00, $DF, $00, $FF, $00, $BF, $00, $9F, $00, $3F, $00, $3F, $00, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $03, $00, $01
    db $02, $01, $02, $01, $00, $00, $01, $00, $00, $BF, $BF, $01, $01, $00, $03, $02
    db $03, $02, $03, $00, $01, $01, $01, $00, $00, $BF, $BF, $01, $01, $FF, $00, $FF
    db $00, $FF, $00, $FF, $00, $F1, $00, $6F, $80, $7B, $87, $89, $F8, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $80, $FF, $84, $FC, $F7, $F0, $89, $CF, $C9
    db $CC, $36, $3C, $22, $0C, $10, $FF, $3F, $C0, $97, $C1, $66, $60, $C0, $44, $46
    db $96, $66, $66, $64, $94, $66, $66, $66, $69, $4E, $DE, $96, $60, $C1, $60, $C1
    db $FF, $01, $02, $05, $01, $03, $FF, $07, $0A, $1A, $34, $CA, $94, $68, $F0, $90
    db $0E, $1E, $3E, $02, $FC, $06, $F8, $0C, $F0, $18, $7F, $E0, $70, $0F, $1A, $17
    db $26, $28, $5C, $58, $D6, $0F, $1F, $01, $1E, $3C, $02, $04, $78, $70, $08, $FB
    db $60, $80, $80, $E0, $80, $80, $8C, $3B, $3B, $53, $95, $33, $B5, $FF, $6E, $85
    db $75, $E0, $C3, $DB, $A4, $E2, $E7, $CB, $E2, $A3, $53, $8F, $A4, $A3, $DD, $E2
    db $9D, $5B, $EC, $DD, $0F, $3B, $44, $D2, $C0, $50, $E3, $24, $B4, $44, $C0, $00
    db $E3, $BF, $B4, $DB, $D0, $CB, $B2, $3B, $42, $68, $E4, $F8, $80, $AC, $C5, $F1
    db $08, $C8, $F0, $D2, $BF, $DD, $A6, $7C, $87, $7B, $F9, $87, $E4, $DF, $F3, $8E
    db $31, $F8, $87, $FE, $85, $EF, $80, $08, $0F, $2E, $60, $21, $29, $2D, $16, $29
    db $3D, $17, $FB, $51, $BE, $10, $F0, $1F, $D1, $1F, $B9, $D7, $80, $39, $1B, $EF
    db $8E, $85, $55, $5F, $68, $8E, $55, $2F, $D3, $5F, $F8, $85, $57, $F7, $0A, $11
    db $53, $2E, $3E, $04, $2C, $18, $5C, $B7, $58, $5B, $E0, $40, $FE, $B2, $6C, $EE
    db $D5, $BE, $E6, $BF, $4F, $69, $F7, $A8, $31, $CF, $E1, $7C, $82, $CC, $70, $7C
    db $03, $63, $35, $75, $0D, $6F, $60, $C0, $80, $DE, $B0, $7F, $9E, $E3, $9F, $FE
    db $BD, $CB, $18, $F7, $B8, $D7, $23, $61, $65, $58, $DA, $18, $F9, $1D, $D7, $01
    db $8F, $20, $DD, $E2, $05, $F8, $C3, $3F, $35, $FA, $0E, $F9, $BD, $76, $88, $E4
    db $E7, $7D, $82, $7A, $7B, $DE, $E7, $FB, $E9, $BF, $21, $29, $64, $EF, $F8, $82
    db $82, $7F, $84, $E6, $F9, $C0, $BA, $F5, $77, $DE, $3F, $95, $D6, $A4, $BF, $C0
    db $D9, $C4, $E7, $B9, $B2, $81, $9A, $CB, $E8, $E4, $8C, $EF, $8C, $BF, $C4, $FE
    db $A7, $ED, $9E, $BD, $C6, $FB, $E4, $FF, $94, $FF, $90, $28, $C4, $54, $FC, $20
    db $20, $C0, $90, $FE, $9E, $30, $D1, $41, $FD, $0E, $C3, $F6, $1F, $FF, $0B, $FF
    db $DF, $FF, $0F, $FF, $01, $75, $8F, $63, $9E, $FE, $01, $8B, $9B, $C9, $C2, $AD
    db $F5, $B0, $B7, $EC, $EF, $CC, $B4, $D8, $D7, $A5, $A5, $FF, $E4, $DF, $B4, $FE
    db $80, $BC, $E0, $FF, $9C, $FF, $80, $FC, $A0, $EE, $D8, $93, $8D, $19, $FF, $04
    db $1B, $44, $D3, $42, $F1, $70, $0F, $EF, $A8, $7C, $0B, $FD, $02, $F8, $07, $EF
    db $10, $3F, $00, $DE, $21, $F8, $07, $57, $00, $F6, $01, $91, $75, $5F, $FF, $19
    db $84, $98, $0B, $46, $A8, $0A, $86, $0B, $10, $A8, $24, $44, $8C, $F0, $BF, $80
    db $3E, $01, $FE, $0F, $7C, $01, $8A, $F4, $4E, $F0, $BC, $F0, $40, $3F, $C1, $0F
    db $75, $0B, $30, $0E, $FF, $80, $80, $80, $80, $80, $F0, $80, $3C, $E0, $1C, $F0
    db $88, $FC, $C6, $FE, $14, $61, $3F, $11, $3E, $0F, $1C, $01, $02, $1E, $0C, $06
    db $02, $81, $01, $0E, $80, $C0, $40, $60, $20, $30, $1E, $18, $CE, $3E, $3F, $F8
    db $04, $10, $F0, $80, $01, $02, $80, $0C, $8E, $68, $0A, $18, $09, $E5, $EF, $14
    db $40, $CB, $89, $0C, $08, $0B, $8F, $1F, $3E, $07, $07, $08, $03, $02, $03, $0E
    db $C3, $80, $30, $20, $1C, $18, $06, $04, $03, $7B, $FE, $8B, $06, $C7, $FB, $D0
    db $3F, $CC, $BF, $67, $10, $1F, $08, $7E, $99, $3B, $04, $0E, $01, $03, $80, $E0
    db $C0, $30, $20, $BC, $0C, $0F, $01, $18, $10, $0E, $0C, $70, $03, $02, $01, $8B
    db $E6, $60, $BD, $40, $BD, $60, $BE, $0B, $CF, $C9, $7D, $16, $07, $03, $03, $01
    db $08, $10, $04, $75, $0E, $01, $03, $20, $21, $60, $40, $C0, $80, $D3, $C0, $21
    db $81, $A0, $20, $C0, $40, $C0, $8F, $3B, $3B, $53, $B3, $B5, $F2, $5F, $55, $99
    db $66, $86, $65, $55, $55, $C3, $6B, $14, $8D, $AB, $A2, $84, $52, $7B, $8C, $14
    db $BB, $76, $84, $7F, $FB, $A4, $2A, $54, $C7, $83, $3C, $11, $58, $22, $A7, $54
    db $83, $D8, $EF, $BF, $D9, $40, $01, $CF, $1E, $DE, $02, $C2, $09, $0B, $A0, $B2
    db $01, $93, $41, $53, $CB, $30, $02, $37, $E9, $F1, $3F, $C8, $79, $CF, $6C, $7E
    db $04, $7D, $7D, $01, $04, $04, $C0, $3D, $7D, $4F, $C2, $BF, $82, $FA, $87, $07
    db $FE, $08, $0B, $C5, $81, $3F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $DB, $A4
    db $F7, $EE, $CC, $F5, $ED, $D9, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $A4, $FF
    db $EE, $99, $F7, $9B, $CB, $B6, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $76, $89
    db $CE, $DC, $B5, $26, $46, $F6, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $89, $FF
    db $DC, $33, $26, $DB, $FE, $99, $F4, $EF, $1A, $97, $C1, $61, $80, $F8, $84, $E8
    db $D3, $E3, $88, $E0, $9A, $B3, $FD, $82, $FC, $A7, $7A, $8C, $FB, $87, $F8, $97
    db $F3, $8C, $FB, $87, $F9, $86, $00, $EF, $10, $FF, $08, $0F, $1E, $11, $10, $18
    db $9D, $BD, $01, $2F, $03, $E2, $94, $7B, $10, $EF, $F0, $1F, $FF, $E0, $7B, $EF
    db $FE, $43, $FF, $D0, $96, $7D, $8F, $B4, $0A, $66, $0C, $BE, $99, $4A, $DF, $0C
    db $06, $48, $0C, $06, $94, $C3, $20, $10, $20, $28, $30, $08, $3C, $10, $3A, $C6
    db $20, $10, $20, $08, $10, $24, $1C, $22, $02, $1C, $18, $14, $1F, $15, $1E, $11
    db $1F, $10, $12, $3F, $2F, $DF, $1C, $02, $7F, $1E, $01, $1F, $20, $1F, $FF, $80
    db $80, $80, $80, $80, $8B, $B6, $66, $0A, $D0, $A0, $A2, $FF, $F8, $EF, $1F, $F3
    db $10, $18, $8C, $84, $06, $08, $05, $46, $20, $30, $28, $10, $84, $D8, $52, $C6
    db $49, $10, $30, $0C, $08, $18, $28, $2C, $10, $18, $18, $0E, $40, $50, $60, $48
    db $00, $10, $24, $3E, $22, $2C, $32, $04, $4F, $86, $47, $CE, $BF, $EE, $A3, $D6
    db $5B, $26, $DE, $9F, $36, $4F, $A7, $68, $7F, $B8, $B7, $B3, $6B, $84, $24, $A7
    db $40, $8F, $F0, $FB, $0A, $1E, $14, $1F, $1F, $0F, $9F, $BF, $2F, $09, $BE, $BF
    db $5D, $4F, $1D, $9E, $AF, $B1, $AE, $AF, $B0, $6F, $F0, $6F, $A0, $AF, $10, $FE
    db $8E, $5F, $FE, $EE, $E6, $86, $E7, $14, $0F, $F5, $8D, $5F, $E4, $F5, $40, $02
    db $3F, $12, $23, $24, $09, $CE, $C1, $C7, $0C, $0E, $09, $03, $02, $11, $DE, $E6
    db $C6, $1C, $FB, $34, $3C, $F5, $F4, $EC, $F3, $32, $10, $20, $20, $E0, $20, $40
    db $02, $82, $01, $03, $02, $01, $03, $02, $E8, $18, $F0, $10, $D0, $30, $E2, $22
    db $45, $C5, $86, $84, $87, $FE, $FC, $20, $20, $E0, $9C, $FC, $FB, $09, $13, $EB
    db $79, $02, $07, $15, $02, $14, $06, $FC, $E3, $F5, $7D, $F8, $08, $1F, $0B, $10
    db $03, $61, $FA, $27, $24, $9E, $BD, $9A, $E7, $E2, $3A, $33, $FD, $80, $C0, $F6
    db $04, $FC, $60, $01, $3D, $C0, $01, $7F, $E3, $23, $95, $56, $6F, $77, $77, $18
    db $77, $19, $79, $48, $37, $35, $35, $14, $41, $33, $73, $35, $14, $17, $30, $C5
    db $E5, $3B, $CC, $FC, $9C, $98, $E0, $D8, $3C, $1E, $21, $FE, $8F, $C0, $FD, $C6
    db $F6, $0F, $FB, $67, $07, $C7, $C0, $20, $01, $7B, $82, $FE, $4C, $D1, $B9, $D5
    db $BB, $FA, $9E, $E6, $9A, $A9, $91, $BF, $81, $87, $79, $B3, $01, $FE, $E1, $1E
    db $EC, $84, $49, $30, $A9, $07, $95, $04, $3B, $FF, $41, $EC, $DF, $FB, $61, $81
    db $8E, $16, $A6, $12, $C5, $33, $74, $A2, $1C, $C1, $7F, $87, $F8, $16, $FE, $22
    db $3F, $A5, $BD, $90, $E9, $A8, $A8, $E6, $D7, $A1, $DA, $AB, $BC, $93, $A0, $BB
    db $DC, $EE, $D0, $DE, $A4, $EF, $D4, $FC, $80, $FC, $84, $BC, $C0, $FC, $C0, $F4
    db $80, $85, $91, $4B, $DF, $FF, $1F, $0B, $27, $89, $A7, $BA, $A6, $34, $DC, $22
    db $DC, $71, $0F, $3F, $00, $FF, $00, $DF, $00, $5F, $00, $5F, $01, $0F, $03, $03
    db $00, $E6, $92, $E3, $CF, $D9, $9E, $82, $96, $B1, $CD, $E9, $9A, $C0, $F7, $FF
    db $FF, $FF, $81, $F7, $83, $E6, $83, $F9, $80, $F2, $80, $C4, $80, $C8, $80, $FF
    db $FF, $04, $07, $FF, $FF, $FF, $B6, $04, $60, $DC, $5A, $18, $B6, $8E, $ED, $FF
    db $FF, $FB, $FF, $FF, $FF, $B6, $FF, $BF, $00, $25, $00, $49, $00, $13, $00, $FF
    db $FF, $8B, $14, $19, $FF, $66, $80, $96, $66, $09, $CF, $C9, $00, $04, $C6, $A1
    db $B3, $11, $19, $88, $DF, $84, $EF, $E3, $9F, $9C, $FC, $40, $C0, $FF, $7F, $FC
    db $80, $FC, $C0, $07, $08, $B8, $10, $F0, $80, $60, $20, $E0, $40, $C0, $80, $1F
    db $C4, $3C, $C8, $38, $10, $F0, $E0, $C0, $80, $C0, $90, $6F, $FF, $41, $9F, $FF
    db $19, $FF, $60, $C2, $60, $C2, $60, $C2, $60, $C2, $08, $F8, $EE, $78, $8F, $31
    db $F0, $23, $F3, $D0, $08, $1C, $0A, $DD, $08, $78, $FE, $EF, $08, $1E, $FC, $71
    db $30, $48, $00, $48, $B0, $40, $8C, $CB, $4B, $31, $71, $08, $3D, $1A, $7F, $39
    db $7E, $10, $F3, $DE, $87, $3F, $77, $80, $FB, $E0, $68, $9B, $FF, $38, $38, $70
    db $F0, $70, $8D, $09, $1F, $FF, $F8, $0F, $09, $FF, $FF, $18, $0C, $FC, $90, $03
    db $40, $6E, $60, $27, $76, $BD, $93, $FA, $30, $60, $25, $A5, $FB, $BF, $BC, $FE
    db $EF, $7F, $98, $E7, $23, $0C, $CB, $7E, $F5, $6B, $C3, $73, $04, $7E, $1B, $B2
    db $FB, $FB, $F4, $04, $7F, $54, $EF, $19, $C0, $8C, $5E, $FF, $F5, $FF, $F9, $E5
    db $DF, $FF, $9F, $EE, $E0, $01, $26, $61, $42, $EF, $76, $9D, $C1, $26, $6D, $EF
    db $07, $4B, $E6, $45, $1E, $17, $B8, $C7, $1E, $81, $0C, $03, $1C, $1D, $02, $F9
    db $59, $03, $10, $F4, $DF, $64, $92, $46, $BF, $12, $0B, $DD, $82, $C6, $A0, $70
    db $40, $C0, $F1, $DF, $9B, $9F, $AD, $72, $99, $7F, $1C, $CC, $3C, $81, $B5, $ED
    db $FA, $21, $BE, $19, $86, $18, $57, $11, $0F, $D2, $CF, $CD, $F6, $03, $02, $E6
    db $B6, $C9, $E6, $26, $24, $1B, $00, $08, $C8, $E0, $68, $78, $F0, $70, $98, $60
    db $18, $E8, $90, $40, $B8, $C0, $D0, $21, $34, $CC, $14, $8C, $04, $0C, $84, $8C
    db $04, $04, $0C, $10, $08, $38, $8E, $88, $55, $55, $F8, $8E, $55, $58, $55, $FE
    db $86, $58, $55, $70, $25, $30, $32, $0C, $1C, $24, $84, $90, $05, $07, $40, $9D
    db $9F, $E8, $2D, $3D, $CF, $6C, $F7, $64, $AA, $7F, $BF, $7E, $E1, $7E, $E1, $25
    db $38, $7E, $82, $80, $44, $60, $6C, $62, $60, $63, $2D, $6F, $60, $4A, $86, $FB
    db $DC, $7A, $BF, $FE, $93, $9C, $3F, $DD, $90, $F0, $9F, $60, $25, $E5, $8A, $10
    db $20, $E0, $D7, $DF, $50, $73, $21, $FB, $A8, $BB, $B0, $FD, $F5, $7F, $20, $3A
    db $FD, $3A, $F4, $AF, $7C, $87, $EC, $57, $99, $E0, $3D, $3F, $02, $7F, $01, $87
    db $43, $C7, $03, $D7, $25, $98, $EF, $C7, $FA, $82, $FD, $7E, $F8, $FB, $BC, $DE
    db $F9, $7F, $DA, $3F, $9E, $EF, $94, $DC, $A9, $AB, $B6, $B7, $C8, $91, $92, $9F
    db $A4, $A3, $81, $E2, $FE, $85, $DF, $E7, $BA, $D7, $B6, $CD, $BA, $F7, $BC, $E7
    db $F0, $DF, $F3, $9C, $08, $E0, $00, $10, $20, $20, $B0, $D0, $C0, $E0, $02, $80
    db $BC, $BC, $60, $DC, $10, $FF, $F0, $FF, $D0, $FF, $F3, $0F, $F7, $1F, $F0, $7F
    db $C3, $7F, $BF, $43, $81, $C1, $88, $89, $E0, $E3, $A2, $E8, $8E, $86, $A1, $B9
    db $88, $AB, $80, $81, $DB, $FE, $9A, $F7, $F9, $9E, $EF, $F4, $87, $FD, $BF, $C6
    db $BF, $F4, $AF, $FE, $40, $7C, $A6, $A6, $08, $EF, $E0, $0F, $11, $1F, $A2, $B2
    db $00, $BF, $A1, $AF, $FC, $83, $59, $FF, $F8, $17, $F0, $1F, $FD, $E2, $EF, $5D
    db $FC, $43, $FF, $50, $91, $60, $96, $60, $88, $1C, $14, $4E, $FE, $FF, $60, $86
    db $1A, $FF, $F1, $98, $EB, $FF, $C0, $80, $01, $10, $08, $F0, $EF, $F7, $0E, $2E
    db $14, $52, $36, $34, $07, $01, $09, $2D, $2B, $05, $83, $91, $E3, $25, $03, $DD
    db $E9, $07, $FD, $03, $F8, $DE, $D8, $F8, $6C, $13, $D8, $02, $41, $51, $7F, $1F
    db $70, $EF, $40, $8D, $80, $F0, $1E, $DF, $E1, $E1, $3F, $0E, $0A, $06, $12, $E6
    db $9E, $80, $9C, $0C, $09, $04, $EC, $54, $DC, $28, $18, $F1, $07, $F9, $99, $67
    db $F2, $0E, $00, $C4, $3C, $96, $B5, $35, $0A, $09, $F1, $09, $64, $46, $44, $1F
    db $15, $55, $D1, $FF, $1C, $06, $60, $61, $C0, $F9, $F0, $B7, $2C, $36, $C0, $07
    db $FE, $0F, $7E, $47, $78, $FE, $07, $0F, $27, $18, $1E, $EC, $FC, $06, $E0, $BC
    db $C0, $F0, $01, $03, $08, $FC, $E1, $03, $BF, $0F, $3E, $FD, $1E, $F7, $D7, $7E
    db $78, $30, $F8, $FC, $F0, $FE, $FD, $F7, $DE, $80, $E0, $A0, $80, $04, $07, $84
    db $3E, $05, $C6, $54, $2B, $FC, $83, $91, $E8, $EF, $0B, $85, $05, $0B, $40, $19
    db $65, $64, $1B, $2B, $66, $66, $1C, $30, $58, $18, $5C, $74, $44, $54, $18, $30
    db $36, $3F, $10, $18, $91, $C7, $02, $E6, $BA, $CE, $A2, $28, $44, $20, $28, $57
    db $68, $D0, $88, $F7, $2B, $7C, $FF, $7F, $07, $E0, $F4, $80, $82, $91, $C5, $55
    db $6D, $A8, $BB, $61, $40, $C7, $30, $F9, $60, $FE, $ED, $7E, $BB, $7C, $AB, $10
    db $C7, $FF, $7D, $B6, $9F, $CF, $C0, $89, $EF, $FD, $99, $DF, $F5, $59, $F1, $F0
    db $00, $5A, $5F, $A7, $E3, $C2, $2D, $34, $FA, $3E, $13, $54, $58, $98, $E7, $4C
    db $BB, $4A, $A3, $04, $1B, $11, $0E, $13, $0C, $C3, $A3, $7C, $07, $7B, $E4, $60
    db $70, $38, $C8, $30, $20, $70, $C0, $30, $20, $B0, $F1, $62, $C7, $20, $B0, $48
    db $C0, $38, $E0, $10, $C0, $30, $E1, $11, $E2, $13, $D0, $34, $00, $38, $37, $54
    db $2F, $08, $4D, $40, $61, $3E, $7F, $D0, $BE, $3F, $5E, $E1, $F0, $19, $C7, $08
    db $87, $18, $DF, $30, $B0, $DF, $1F, $60, $9E, $E1, $3E, $05, $39, $CF, $49, $F9
    db $4D, $DE, $50, $9F, $90, $CF, $D0, $80, $BE, $60, $0F, $C0, $30, $D7, $20, $EE
    db $31, $AF, $70, $DF, $7F, $8D, $3B, $3B, $5E, $3B, $3B, $55, $52, $55, $E6, $85
    db $95, $50, $C3, $6A, $15, $C4, $A0, $A0, $82, $51, $79, $AC, $15, $A0, $7F, $82
    db $F9, $A6, $54, $2A, $32, $16, $38, $8A, $C4, $26, $A7, $2A, $96, $ED, $C4, $7F
    db $A7, $D9, $40, $01, $6F, $51, $06, $56, $8A, $C2, $A9, $03, $8A, $BA, $11, $17
    db $F3, $53, $C9, $90, $BE, $F9, $41, $BF, $40, $C9, $77, $EE, $FD, $48, $61, $1C
    db $7D, $15, $7F, $02, $03, $04, $06, $06, $0E, $13, $E1, $7D, $C9, $82, $66, $9B
    db $07, $FC, $02, $0F, $F9, $E1, $FE, $01, $3F, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $DB, $A4, $F6, $EF, $AF, $B6, $A3, $57, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $A4, $FF, $EF, $99, $F6, $D9, $57, $EC, $FF, $FF, $FF, $FF, $DD, $FF, $FF
    db $FF, $3A, $41, $52, $44, $39, $AA, $0E, $3E, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $41, $FF, $E4, $BB, $AA, $D7, $3E, $D1, $C2, $DB, $52, $9B, $97, $A0, $B4
    db $FB, $80, $AC, $C4, $F0, $84, $B8, $82, $CF, $D9, $A6, $F8, $A7, $FB, $CC, $FB
    db $87, $FC, $D7, $FB, $8F, $F8, $C7, $FE, $B5, $00, $EF, $80, $EE, $E0, $01, $C0
    db $AE, $20, $2A, $04, $04, $14, $04, $0F, $E0, $50, $BF, $11, $FF, $FE, $1F, $BF
    db $71, $3F, $DF, $3B, $FF, $2F, $FB, $20, $DF, $93, $B8, $60, $A4, $44, $60, $C0
    db $40, $C0, $60, $86, $E6, $68, $9E, $9E, $EF, $18, $86, $EE, $E3, $F0, $7C, $38
    db $87, $3C, $43, $45, $06, $F7, $08, $82, $C0, $C0, $38, $40, $80, $3E, $40, $C0
    db $20, $E0, $80, $10, $41, $3D, $F6, $60, $40, $20, $60, $40, $20, $C0, $3E, $40
    db $F6, $3F, $7F, $3F, $BF, $C0, $7F, $D0, $30, $09, $D8, $B8, $48, $78, $28, $3C
    db $1C, $18, $0C, $20, $2C, $64, $6E, $08, $A4, $08, $8C, $04, $C0, $E2, $06, $F6
    db $02, $FE, $9D, $03, $8B, $66, $9E, $DE, $90, $CB, $06, $69, $9E, $90, $CB, $8E
    db $10, $38, $78, $18, $68, $44, $54, $44, $68, $04, $50, $1C, $7C, $6C, $96, $C2
    db $EE, $92, $BA, $FE, $D6, $AA, $AA, $C6, $D8, $20, $18, $10, $28, $38, $10, $50
    db $74, $6C, $C8, $44, $4C, $64, $38, $28, $54, $44, $FE, $82, $C6, $BA, $F0, $FE
    db $89, $C0, $0B, $0C, $14, $0C, $16, $64, $96, $86, $E8, $18, $62, $63, $7E, $75
    db $1B, $F2, $14, $E0, $1D, $9E, $01, $84, $0B, $06, $09, $80, $C0, $40, $E0, $80
    db $C0, $43, $BE, $63, $9D, $4B, $7F, $BA, $77, $6F, $60, $04, $BF, $7B, $C4, $33
    db $17, $E0, $0E, $01, $0D, $02, $8F, $07, $08, $90, $0F, $40, $0B, $04, $08, $07
    db $E0, $20, $80, $E0, $F0, $50, $40, $B0, $F0, $60, $10, $B0, $C8, $D8, $28, $D0
    db $E8, $E0, $80, $60, $40, $B0, $80, $70, $60, $90, $00, $C0, $38, $20, $D8, $E0
    db $18, $8A, $69, $E9, $0C, $B6, $96, $46, $0E, $90, $CB, $0C, $28, $44, $54, $5C
    db $64, $54, $18, $10, $10, $28, $38, $10, $50, $0C, $D6, $AA, $EE, $82, $08, $64
    db $20, $28, $38, $54, $44, $FE, $82, $DD, $6C, $7C, $44, $7C, $44, $74, $10, $D8
    db $18, $C6, $BA, $FE, $D6, $AA, $EE, $82, $6C, $44, $30, $34, $2C, $38, $28, $3F
    db $45, $90, $40, $9F, $51, $80, $7F, $87, $7D, $85, $7D, $85, $FD, $FD, $FD, $FD
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FD, $FD, $FD, $FD, $FD, $FD, $FD, $FD
    db $00, $00, $00, $FF, $42, $00, $7F, $1C, $57, $14, $F7, $14, $F7, $F7, $F7, $F7
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F7, $F7, $F7, $F7, $F7, $F7, $F7, $F7
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $3F, $43, $90, $4F, $90, $43, $90, $63, $90, $46, $90, $44, $91, $50, $91, $5A
    db $98, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EF, $FF, $E7
    db $FF, $1B, $00, $3F, $00, $ED, $00, $16, $00, $06, $E0, $04, $F0, $0D, $F1, $1B
    db $E3, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $FF, $FC
    db $FF, $5C, $9C, $5E, $9E, $4F, $9F, $67, $97, $63, $93, $45, $91, $48, $90, $42
    db $90, $E3, $FF, $E1, $FF, $F0, $FF, $F8, $FF, $FC, $FF, $FE, $FF, $FF, $FF, $FF
    db $FF, $37, $07, $AF, $0F, $7E, $1E, $BC, $BC, $F9, $F8, $F4, $F0, $EE, $E0, $55
    db $40, $F8, $FF, $F0, $FF, $E1, $FF, $43, $FF, $07, $FF, $0F, $FF, $1F, $FF, $BF
    db $FF, $9D, $78, $72, $13, $02, $9F, $19, $42, $37, $F1, $63, $0F, $9F, $14, $23
    db $78, $72, $13, $02, $9F, $19, $42, $37, $F1, $63, $0F, $9F, $14, $23, $FB, $01
    db $01, $FE, $01, $78, $FF, $FE, $86, $3F, $3F, $E0, $60, $20, $1F, $C0, $88, $DF
    db $C0, $5F, $20, $3F, $77, $FB, $01, $01, $FE, $81, $62, $FF, $FE, $1C, $3F, $3F
    db $E0, $60, $20, $1F, $C0, $80, $DF, $C0, $5F, $20, $3F, $7F, $3F, $00, $FF, $7F
    db $80, $42, $80, $60, $9F, $62, $90, $44, $90, $56, $91, $58, $99, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EF, $FF, $E7, $FF, $00, $FF, $FF
    db $00, $08, $00, $00, $FF, $41, $00, $0C, $E0, $09, $F1, $07, $F3, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $FF, $FC, $FF, $5D, $9C, $5E
    db $9E, $4F, $9F, $47, $97, $43, $93, $45, $91, $40, $90, $68, $90, $E3, $FF, $E1
    db $FF, $F0, $FF, $F8, $FF, $FC, $FF, $FE, $FF, $FF, $FF, $FF, $FF, $07, $E7, $6F
    db $0F, $DE, $1E, $BC, $BC, $FA, $F8, $F0, $F0, $ED, $E0, $54, $40, $F8, $FF, $F0
    db $FF, $E1, $FF, $43, $FF, $07, $FF, $0F, $FF, $1F, $FF, $BF, $FF, $96, $84, $44
    db $98, $45, $53, $88, $96, $84, $4D, $ED, $88, $EE, $A4, $0C, $18, $0C, $14, $0C
    db $18, $0C, $10, $7F, $DE, $7E, $F8, $03, $FD, $01, $01, $01, $FF, $01, $07, $FD
    db $01, $01, $01, $EC, $50, $E0, $C0, $A0, $80, $60, $E0, $20, $A0, $60, $E0, $E6
    db $F0, $E0, $20, $A0, $60, $60, $A0, $40, $02, $01, $EE, $01, $02, $03, $01, $10
    db $E0, $EE, $E0, $D0, $30, $E0, $92, $96, $61, $97, $88, $3F, $F2, $A5, $80, $96
    db $08, $08, $65, $F6, $2F, $F2, $B6, $9E, $FF, $FE, $01, $FC, $FE, $01, $FF, $FE
    db $01, $01, $FE, $E5, $C0, $A2, $02, $E4, $04, $18, $E0, $64, $80, $C0, $E0, $20
    db $12, $F2, $14, $F4, $18, $FA, $E2, $E6, $02, $1E, $FE, $0E, $C3, $01, $01, $11
    db $F0, $06, $01, $3C, $03, $B0, $08, $AC, $01, $F8, $01, $F0, $04, $1C, $1E, $E4
    db $D0, $C8, $22, $88, $68, $08, $F8, $B0, $90, $70, $68, $E0, $02, $FE, $C4, $3C
    db $08, $04, $FC, $20, $D8, $88, $78, $08, $F8, $18, $90, $9D, $41, $78, $37, $F2
    db $A5, $88, $65, $57, $06, $4F, $43, $2C, $1E, $9E, $BE, $02, $FE, $03, $FE, $FC
    db $FE, $01, $03, $FD, $01, $03, $01, $FE, $FC, $3F, $C1, $07, $80, $C1, $C0, $A2
    db $02, $E4, $04, $18, $38, $E0, $F4, $C0, $C0, $F8, $7F, $DF, $3F, $1C, $FC, $18
    db $FA, $E2, $C6, $12, $0E, $FE, $0F, $E3, $FC, $01, $06, $01, $3C, $03, $B0, $08
    db $AC, $01, $E0, $04, $1C, $1E, $E4, $10, $08, $88, $68, $28, $F8, $0A, $80, $B0
    db $90, $70, $68, $E0, $42, $FE, $02, $04, $FC, $24, $DC, $20, $88, $78, $08, $F8
    db $18, $92, $26, $68, $25, $05, $01, $78, $83, $1F, $2A, $58, $E9, $6E, $EE, $66
    db $48, $52, $C1, $E2, $FC, $F9, $A2, $12, $C4, $40, $A7, $A0, $18, $87, $27, $C0
    db $03, $05, $FE, $4A, $FD, $38, $BF, $18, $DF, $C7, $E7, $C0, $F8, $DF, $80, $40
    db $C0, $3F, $7F, $80, $FE, $C0, $80, $7F, $20, $38, $00, $78, $27, $08, $10, $11
    db $16, $18, $1B, $08, $0C, $05, $06, $13, $03, $43, $7F, $BE, $40, $20, $3F, $1F
    db $10, $18, $1C, $7F, $70, $E1, $80, $7F, $80, $60, $80, $3C, $C0, $0D, $10, $F5
    db $EA, $80, $E0, $7F, $93, $82, $D5, $53, $24, $F2, $69, $55, $BF, $14, $4F, $5F
    db $3C, $16, $52, $F5, $53, $53, $C2, $A1, $FC, $19, $18, $EF, $FE, $7C, $C5, $38
    db $AB, $03, $64, $80, $FB, $03, $E7, $83, $C6, $01, $7C, $03, $E0, $3E, $F0, $6A
    db $48, $92, $E4, $D0, $B6, $81, $A0, $9F, $BF, $1C, $EF, $F1, $EB, $F5, $FB, $E5
    db $21, $7F, $33, $B0, $3A, $B8, $FE, $7C, $01, $83, $78, $C7, $30, $39, $C7, $FD
    db $BF, $40, $C0, $A0, $7F, $61, $F8, $81, $7F, $92, $D6, $86, $69, $66, $0A, $89
    db $88, $0A, $88, $09, $55, $80, $C0, $66, $60, $B8, $80, $11, $40, $D0, $A0, $A8
    db $40, $68, $AB, $A3, $6F, $C3, $CB, $04, $7C, $90, $01, $D0, $30, $A8, $58, $68
    db $98, $EB, $1B, $EC, $1F, $CF, $3F, $7C, $FC, $F0, $FE, $A0, $60, $20, $A0, $E0
    db $A0, $FC, $60, $20, $A0, $50, $78, $68, $7C, $3C, $98, $9F, $E5, $E7, $1D, $03
    db $88, $F8, $84, $FC, $DF, $E3, $F8, $1E, $1F, $03, $80, $C0, $B9, $60, $80, $A0
    db $80, $40, $C0, $A0, $E0, $E0, $80, $8C, $68, $86, $77, $70, $88, $08, $38, $0A
    db $53, $98, $0A, $83, $AB, $06, $4F, $02, $4B, $01, $09, $02, $7A, $6A, $EB, $75
    db $1C, $00, $EB, $AD, $4F, $49, $4B, $4D, $09, $0E, $7A, $7D, $9B, $FC, $7D, $7E
    db $1C, $1F, $40, $03, $06, $0B, $02, $0A, $01, $89, $05, $8E, $82, $D5, $09, $DF
    db $02, $EE, $8A, $04, $FB, $0C, $FA, $0D, $F9, $8E, $88, $F7, $58, $50, $EE, $F1
    db $01, $08, $0F, $02, $07, $01, $0F, $04, $1C, $1F, $3F, $18, $38, $08, $28, $83
    db $0F, $04, $07, $08, $0F, $13, $1F, $27, $3F, $28, $38, $38, $3E, $8C, $AD, $40
    db $D1, $3F, $1F, $6D, $F3, $FC, $31, $1F, $90, $A6, $60, $98, $89, $80, $CB, $66
    db $04, $66, $96, $96, $88, $99, $E9, $D0, $C3, $C0, $80, $A0, $A0, $70, $E0, $30
    db $80, $FE, $BD, $DD, $C0, $60, $20, $10, $7E, $C3, $81, $86, $FE, $81, $1F, $60
    db $02, $83, $81, $BD, $CA, $49, $80, $A9, $60, $C0, $50, $80, $FC, $80, $FE, $BC
    db $FB, $CA, $79, $C9, $B9, $69, $57, $D0, $30, $80, $80, $C0, $C0, $80, $A0, $20
    db $F7, $A0, $80, $40, $60, $20, $E0, $80, $A0, $8B, $96, $60, $88, $88, $86, $D8
    db $66, $66, $68, $78, $C8, $02, $02, $05, $01, $02, $0F, $09, $1F, $17, $38, $2F
    db $70, $CF, $02, $05, $07, $02, $03, $0F, $10, $20, $40, $A0, $20, $20, $50, $53
    db $13, $AF, $87, $7C, $C9, $A6, $D0, $FC, $F8, $7E, $80, $20, $50, $70, $53, $73
    db $AC, $BC, $68, $F8, $B4, $FC, $57, $7C, $2B, $3E, $3E, $21, $7F, $18, $99, $86
    db $88, $89, $93, $95, $06, $A7, $80, $40, $E7, $81, $FE, $86, $F8, $88, $F9, $89
    db $F3, $93, $F5, $97, $E7, $A5, $00, $9C, $9F, $05, $E7, $24, $7C, $7D, $C3, $F8
    db $85, $F4, $8E, $89, $FB, $70, $75, $50, $7B, $1F, $E7, $43, $40, $80, $03, $01
    db $02, $03, $07, $02, $8D, $06, $3F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8
    db $F8, $F8, $F8, $F8, $F8, $F0, $F0, $00, $F8, $00, $F8, $00, $F8, $00, $F8, $00
    db $F8, $00, $F8, $00, $F8, $00, $F0, $FC, $FC, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $FC, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $3F, $FF, $3B, $BF, $3B, $FF, $0B, $FF, $FF
    db $FF, $55, $FF, $FF, $FF, $FF, $FF, $FF, $00, $7B, $20, $4B, $00, $9B, $00, $FF
    db $AA, $55, $00, $FF, $00, $FF, $00, $FF, $F8, $78, $F8, $78, $F8, $78, $F8, $F8
    db $F8, $58, $F8, $F8, $F8, $F8, $F0, $F0, $00, $78, $00, $78, $00, $78, $00, $F8
    db $A0, $58, $00, $F8, $00, $F8, $00, $F0, $FC, $FC, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $FC, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $3F, $1F, $1F, $1F, $1F, $1F, $1F, $1F
    db $1F, $1F, $1F, $1F, $1F, $1F, $1F, $0F, $0F, $00, $1F, $00, $1F, $00, $1F, $00
    db $1F, $00, $1F, $00, $1F, $00, $1F, $00, $0F, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $3F, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $1F, $1E, $1F, $1E, $1F, $1E
    db $1F, $1F, $1F, $1D, $1F, $1F, $1F, $1F, $0F, $0F, $00, $1E, $00, $1E, $00, $1E
    db $00, $1F, $02, $1D, $00, $1F, $00, $1F, $00, $0F, $FF, $ED, $FF, $ED, $FF, $21
    db $FF, $FF, $FF, $55, $FF, $FF, $FF, $FF, $FF, $FF, $00, $ED, $00, $ED, $00, $33
    db $00, $FF, $AA, $55, $00, $FF, $00, $FF, $00, $FF, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $3F, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $FF, $00, $FF, $00, $FF, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $E0, $E0, $F0, $F0, $F8, $F8, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $E0, $00, $F0, $00, $F8, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $F8, $F8, $F8, $F8, $F8
    db $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $00, $F8, $00, $F8, $00
    db $F8, $00, $F8, $00, $F8, $00, $F8, $00, $F8, $00, $F8, $3F, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $FF, $00, $FF, $00, $FF, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $E0, $E0, $F0, $F0, $F8, $F8, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $E0, $00, $F0, $00, $F8, $FF, $FF, $FF, $55
    db $FF, $FF, $FF, $0B, $FF, $6A, $FF, $7B, $FF, $78, $FF, $7A, $00, $FF, $AA, $55
    db $00, $FF, $00, $9B, $00, $6A, $00, $79, $00, $78, $00, $7B, $F8, $F8, $F8, $58
    db $F8, $F8, $F8, $78, $F8, $78, $F8, $F8, $F8, $78, $F8, $78, $00, $F8, $A0, $58
    db $00, $F8, $00, $78, $00, $F8, $00, $F8, $00, $F8, $00, $78, $3F, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $07, $07, $0F, $0F, $1F, $1F, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $07, $00, $0F, $00, $1F, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $FF, $00, $FF, $00, $FF, $1F, $1F, $1F
    db $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $00, $1F, $00
    db $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $00, $1F, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $3F, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $0F, $0F, $1F, $1F, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $00, $0F, $00, $1F, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $00, $FF, $00, $FF, $1F, $1F
    db $1F, $1D, $1F, $1F, $1F, $1E, $1F, $1E, $1F, $1E, $1F, $1E, $1F, $1E, $00, $1F
    db $02, $1D, $00, $1F, $00, $1E, $00, $1E, $00, $1E, $00, $1E, $00, $1E, $FF, $FF
    db $FF, $55, $FF, $FF, $FF, $E1, $FF, $ED, $FF, $ED, $FF, $ED, $FF, $ED, $00, $FF
    db $AA, $55, $00, $FF, $00, $F3, $00, $ED, $00, $ED, $00, $ED, $00, $ED, $3F, $1E
    db $1C, $1F, $1F, $1F, $1D, $1F, $1F, $1D, $1C, $1F, $1F, $1F, $1F, $0F, $0F, $00
    db $1D, $00, $1F, $00, $1D, $00, $1F, $02, $1C, $00, $1F, $00, $1F, $00, $0F, $7F
    db $2F, $FF, $FF, $D7, $47, $FF, $FF, $8F, $0F, $FF, $FF, $FF, $FF, $FF, $FF, $80
    db $2F, $00, $FF, $20, $4F, $00, $FF, $20, $5F, $00, $FF, $00, $FF, $00, $FF, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F
    db $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F
    db $1E, $1C, $1F, $1F, $1E, $1C, $1F, $1F, $1D, $1D, $1F, $1F, $1F, $1F, $0F, $0F
    db $00, $1D, $00, $1F, $00, $1D, $00, $1F, $02, $1D, $00, $1F, $00, $1F, $00, $0F
    db $5F, $0F, $FF, $FF, $D7, $07, $FF, $FF, $CF, $4F, $FF, $FF, $FF, $FF, $FF, $FF
    db $A0, $0F, $00, $FF, $00, $2F, $00, $FF, $20, $5F, $00, $FF, $00, $FF, $00, $FF
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $3F, $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $0F, $0F, $1F
    db $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $00, $0F, $00
    db $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF
    db $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $00, $FF, $00
    db $FF, $1E, $1C, $1F, $1F, $1E, $1C, $1F, $1F, $1F, $1D, $1F, $1F, $1D, $1C, $1F
    db $1F, $01, $1C, $00, $1F, $01, $1C, $00, $1F, $00, $1D, $00, $1F, $02, $1C, $00
    db $1F, $CF, $87, $FF, $FF, $9F, $0F, $FF, $FF, $B7, $27, $FF, $FF, $2F, $0F, $FF
    db $FF, $20, $97, $00, $FF, $20, $4F, $00, $FF, $40, $2F, $00, $FF, $40, $9F, $00
    db $FF, $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $0F, $0F
    db $1F, $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $00, $0F
    db $00, $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF
    db $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $00, $FF
    db $00, $FF, $1E, $1C, $1F, $1F, $1E, $1C, $1F, $1F, $1E, $1C, $1F, $1F, $1D, $1C
    db $1F, $1F, $01, $1C, $00, $1F, $01, $1C, $00, $1F, $01, $1C, $00, $1F, $02, $1C
    db $00, $1F, $4F, $0F, $FF, $FF, $97, $87, $FF, $FF, $9F, $0F, $FF, $FF, $2F, $07
    db $FF, $FF, $A0, $1F, $00, $FF, $28, $C7, $00, $FF, $60, $0F, $00, $FF, $40, $97
    db $00, $FF, $3F, $40, $3F, $80, $7F, $90, $60, $89, $40, $90, $06, $A1, $10, $A2
    db $09, $80, $15, $FF, $80, $FF, $BF, $FF, $FF, $F6, $F6, $EF, $E9, $DE, $C6, $DD
    db $D4, $FF, $EA, $02, $FC, $01, $FE, $03, $06, $51, $32, $09, $A0, $51, $08, $31
    db $44, $01, $08, $FF, $01, $FF, $FD, $FF, $FF, $AF, $8F, $F7, $57, $AF, $A3, $CF
    db $8B, $FF, $77, $84, $20, $98, $06, $A9, $20, $A2, $09, $C0, $30, $9D, $09, $86
    db $4E, $C0, $3F, $FB, $DB, $E7, $E0, $D6, $D6, $FD, $F4, $FF, $FF, $F5, $FB, $F9
    db $BF, $FF, $FF, $01, $D0, $0D, $80, $55, $30, $35, $40, $13, $0C, $EB, $C0, $73
    db $30, $03, $FC, $FF, $2F, $F3, $73, $AB, $8B, $CF, $8F, $FF, $FF, $AF, $DF, $CF
    db $FD, $FF, $FF, $3F, $40, $3F, $80, $7F, $90, $60, $89, $56, $88, $22, $A4, $01
    db $81, $28, $A8, $04, $FF, $80, $FF, $BF, $FF, $FF, $E2, $E0, $F7, $D5, $DB, $DA
    db $FE, $D6, $D7, $D3, $02, $FC, $01, $FE, $03, $06, $21, $DA, $29, $44, $05, $28
    db $81, $54, $11, $A8, $FF, $01, $FF, $FD, $FF, $FF, $97, $07, $D7, $93, $FB, $D3
    db $7F, $2B, $EF, $03, $82, $28, $80, $16, $AA, $00, $A2, $0F, $C0, $30, $9D, $09
    db $86, $4E, $C0, $3F, $FD, $D1, $FF, $E9, $D5, $D5, $FF, $F0, $FF, $FF, $F5, $FB
    db $F9, $BF, $FF, $FF, $65, $00, $C1, $0C, $45, $90, $4D, $78, $13, $0C, $EB, $C0
    db $73, $30, $03, $FC, $9B, $93, $3F, $33, $BB, $23, $FF, $87, $FF, $FF, $AF, $DF
    db $CF, $FD, $FF, $FF, $3F, $FF, $FF, $5F, $5F, $AA, $AA, $55, $55, $AA, $AA, $00
    db $00, $00, $00, $00, $00, $00, $00, $A0, $00, $55, $00, $AA, $00, $55, $00, $FF
    db $00, $FF, $00, $FF, $00, $F9, $FC, $FB, $FC, $A9, $AC, $4B, $4C, $0A, $0C, $0B
    db $0C, $09, $0C, $0D, $04, $07, $07, $07, $07, $57, $07, $B7, $07, $F7, $07, $F7
    db $07, $F7, $07, $FF, $0F, $1C, $1C, $FB, $FF, $ED, $E2, $FE, $12, $3B, $1E, $2F
    db $1F, $BB, $1F, $FF, $FF, $FF, $03, $FF, $FF, $FF, $F1, $E9, $F3, $E1, $FF, $F1
    db $FF, $FF, $FF, $FF, $FF, $7F, $38, $E9, $F0, $C1, $00, $8E, $00, $95, $08, $9D
    db $00, $4C, $9F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F3, $F3
    db $F3, $FF, $FF, $FF, $FF, $3F, $37, $97, $37, $97, $32, $92, $31, $91, $30, $90
    db $10, $B0, $18, $B8, $21, $91, $F8, $E0, $F8, $E0, $FD, $E0, $FE, $E0, $FF, $E0
    db $FF, $E0, $F7, $E0, $FE, $F0, $FF, $FF, $F5, $F5, $AA, $AA, $55, $55, $0A, $0A
    db $00, $00, $00, $00, $80, $80, $00, $00, $0A, $00, $55, $00, $AA, $00, $F5, $00
    db $FF, $00, $FF, $00, $7F, $00, $8C, $1E, $8B, $07, $03, $80, $10, $80, $10, $80
    db $08, $90, $7F, $B8, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EF, $EF
    db $EF, $EF, $FF, $FF, $FF, $FF, $38, $38, $CF, $FF, $37, $4B, $7B, $48, $EC, $78
    db $BC, $7C, $E9, $7C, $FF, $FF, $FF, $C0, $FF, $FF, $FF, $87, $A7, $CF, $87, $FF
    db $C7, $FF, $FF, $FF, $FF, $FF, $3F, $92, $48, $00, $B3, $00, $14, $20, $40, $1C
    db $22, $0A, $51, $0C, $81, $0B, $A0, $6D, $25, $FF, $4C, $FF, $EB, $DF, $9F, $E3
    db $C1, $F5, $A4, $F3, $50, $F4, $54, $01, $5C, $0B, $14, $A1, $14, $0B, $FC, $1A
    db $6C, $23, $5C, $41, $24, $0D, $84, $FF, $A7, $F7, $E7, $5F, $4F, $F7, $07, $E7
    db $87, $DF, $87, $BF, $9F, $FF, $7F, $00, $00, $7B, $7F, $ED, $E2, $FE, $12, $3B
    db $1E, $2F, $1F, $BB, $1F, $FF, $FF, $FF, $E3, $FF, $FF, $FF, $F1, $E9, $F3, $E1
    db $FF, $F1, $FF, $FF, $FF, $FF, $FF, $7F, $38, $E9, $F0, $C1, $00, $8E, $00, $95
    db $08, $9D, $00, $4C, $9F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $F3, $F3, $F3, $FF, $FF, $FF, $FF, $3F, $4C, $21, $A2, $05, $0C, $12, $A1, $0A
    db $28, $D5, $00, $4B, $60, $13, $83, $20, $B3, $82, $5D, $58, $F3, $E1, $5E, $54
    db $D7, $02, $FF, $B4, $9F, $8C, $7C, $54, $21, $14, $0B, $74, $81, $54, $1B, $EC
    db $8A, $7C, $23, $1C, $41, $24, $0D, $84, $DF, $CF, $F7, $87, $7F, $2F, $E7, $07
    db $77, $07, $DF, $C7, $BF, $9F, $FF, $7F, $00, $00, $FB, $FF, $ED, $E2, $FE, $12
    db $3B, $1E, $2F, $1F, $BB, $1F, $FF, $FF, $FF, $E3, $FF, $FF, $FF, $F1, $E9, $F3
    db $E1, $FF, $F1, $FF, $FF, $FF, $FF, $FF, $7F, $38, $E9, $F0, $C1, $00, $8E, $00
    db $95, $08, $9D, $00, $4C, $9F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $F3, $F3, $F3, $FF, $FF, $FF, $FF, $3F, $8A, $10, $82, $2D, $10, $C0, $46
    db $01, $28, $81, $60, $12, $04, $93, $80, $21, $75, $65, $7D, $40, $EF, $2E, $B9
    db $38, $D7, $56, $9F, $8D, $FB, $48, $7F, $5E, $09, $A4, $43, $2C, $91, $4C, $9B
    db $0C, $8A, $3C, $63, $1C, $01, $A4, $0D, $44, $F7, $17, $BF, $97, $6F, $27, $67
    db $67, $77, $47, $9F, $07, $FF, $5F, $FF, $BF, $00, $00, $FB, $FF, $ED, $E2, $FE
    db $12, $3B, $1E, $2F, $1F, $BB, $1F, $FF, $FF, $FF, $E3, $FF, $FF, $FF, $F1, $E9
    db $F3, $E1, $FF, $F1, $FF, $FF, $FF, $FF, $FF, $7F, $38, $E9, $F0, $C1, $00, $8E
    db $00, $95, $08, $9D, $00, $4C, $9F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $F3, $F3, $F3, $FF, $FF, $FF, $FF, $3F, $28, $93, $29, $94, $25, $80
    db $27, $88, $27, $88, $06, $A1, $04, $A0, $20, $98, $F7, $E4, $F6, $E2, $FA, $FA
    db $F8, $F0, $F8, $F0, $F9, $F8, $FB, $EB, $FF, $F7, $42, $A1, $80, $23, $42, $20
    db $2E, $40, $00, $D0, $CE, $11, $30, $0F, $12, $09, $BD, $1C, $7F, $5C, $BD, $9D
    db $D1, $91, $FF, $2F, $31, $20, $CF, $C0, $ED, $E4, $8C, $1E, $8B, $07, $03, $80
    db $10, $80, $10, $80, $08, $90, $7F, $B8, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $EF, $EF, $EF, $EF, $FF, $FF, $FF, $FF, $18, $04, $CF, $FF, $37, $4B
    db $7B, $48, $EC, $78, $BC, $7C, $E9, $7C, $FF, $FF, $E7, $E3, $FF, $FF, $FF, $87
    db $A7, $CF, $87, $FF, $C7, $FF, $FF, $FF, $FF, $FF, $3F, $23, $98, $28, $97, $29
    db $80, $20, $85, $21, $8C, $04, $A3, $08, $A9, $20, $98, $FC, $E4, $F7, $E0, $F6
    db $F6, $FF, $FA, $FE, $F2, $FB, $F8, $F7, $E6, $FF, $F6, $10, $23, $14, $A1, $60
    db $1B, $A0, $55, $00, $ED, $8B, $30, $02, $51, $82, $48, $EF, $CC, $EB, $4A, $9F
    db $00, $5F, $0A, $FF, $12, $74, $44, $FD, $A8, $7D, $25, $8C, $1E, $8B, $07, $03
    db $80, $10, $80, $10, $80, $08, $90, $7F, $B8, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $EF, $EF, $EF, $EF, $FF, $FF, $FF, $FF, $18, $05, $CF, $FF, $37
    db $4B, $7B, $48, $EC, $78, $BC, $7C, $E9, $7C, $FF, $FF, $E7, $E2, $FF, $FF, $FF
    db $87, $A7, $CF, $87, $FF, $C7, $FF, $FF, $FF, $FF, $FF, $3F, $24, $91, $28, $94
    db $28, $82, $20, $85, $21, $88, $06, $A1, $0A, $A8, $21, $99, $FB, $EA, $F7, $E1
    db $F7, $F5, $FF, $FA, $FE, $F6, $F9, $F8, $F5, $E5, $FE, $F6, $01, $AC, $54, $01
    db $88, $50, $00, $46, $02, $30, $01, $A4, $53, $08, $80, $48, $FE, $52, $AB, $AA
    db $77, $25, $FF, $99, $FD, $CD, $FE, $1A, $AC, $A4, $7F, $37, $8C, $1E, $8B, $07
    db $03, $80, $10, $80, $10, $80, $08, $90, $7F, $B8, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $EF, $EF, $EF, $EF, $FF, $FF, $FF, $FF, $00, $01, $CF, $FF
    db $37, $4B, $7B, $48, $EC, $78, $BC, $7C, $E9, $7C, $FF, $FF, $FF, $C6, $FF, $FF
    db $FF, $87, $A7, $CF, $87, $FF, $C7, $FF, $FF, $FF, $FF, $FF, $3F, $FF, $00, $00
    db $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $00, $FF, $FF, $FF, $14, $00, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $FE, $00, $00
    db $00, $EB, $14, $F3, $00, $DD, $F8, $8D, $88, $01, $0C, $03, $F4, $01, $01, $FF
    db $FF, $F3, $F3, $FF, $FF, $FF, $FF, $FF, $7F, $FF, $0F, $0F, $07, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $F3, $FC, $F9
    db $FC, $FB, $FC, $F9, $FC, $F9, $FC, $F9, $FC, $F9, $FC, $F9, $FC, $07, $07, $07
    db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $3F, $7F, $80
    db $80, $80, $6F, $90, $4F, $80, $33, $9F, $31, $91, $20, $90, $03, $A2, $80, $80
    db $FF, $FF, $CF, $CF, $FF, $FF, $FF, $FF, $FF, $FE, $FF, $F0, $FC, $E0, $FF, $00
    db $00, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $80, $7F, $FF, $7F, $00, $00
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $80, $00, $17, $B2
    db $97, $B6, $17, $B6, $37, $97, $37, $97, $37, $97, $37, $97, $37, $97, $F8, $E0
    db $F8, $E0, $F9, $E0, $F8, $E0, $F8, $E0, $F8, $E0, $F8, $E0, $F8, $E0, $FF, $7F
    db $FF, $7F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00
    db $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $FF
    db $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $88, $73, $0C, $20, $08, $13, $14
    db $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $77, $04, $F3, $D1, $F7, $E4, $FE
    db $00, $00, $00, $EB, $14, $F3, $00, $DD, $F8, $8D, $88, $01, $3C, $13, $1C, $01
    db $01, $FF, $FF, $F3, $F3, $FF, $FF, $FF, $FF, $FF, $7F, $EF, $CF, $EF, $67, $04
    db $19, $00, $9B, $04, $C1, $C1, $04, $00, $EC, $02, $94, $15, $0A, $0D, $02, $FB
    db $E2, $FF, $64, $FB, $3A, $3E, $3A, $FF, $13, $FD, $69, $EA, $E0, $F2, $F0, $0B
    db $14, $41, $8C, $03, $0C, $41, $84, $09, $94, $09, $14, $21, $DC, $61, $14, $F7
    db $E7, $BF, $37, $FF, $F7, $BF, $3F, $F7, $67, $F7, $E7, $DF, $07, $9F, $8B, $3F
    db $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $88, $77, $48, $A4, $91, $4A
    db $14, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $77, $00, $B7, $13, $6E, $24
    db $FE, $00, $00, $00, $EB, $14, $F3, $00, $DD, $F8, $8D, $88, $01, $BC, $73, $1C
    db $01, $01, $FF, $FF, $F3, $F3, $FF, $FF, $FF, $FF, $FF, $7F, $EF, $4F, $8F, $87
    db $62, $90, $07, $18, $89, $66, $C0, $0E, $44, $B1, $00, $11, $6C, $00, $0B, $34
    db $9D, $05, $F8, $E0, $76, $10, $3F, $31, $BB, $0A, $FF, $EE, $93, $92, $F4, $C0
    db $0B, $54, $A1, $4C, $53, $8C, $11, $E4, $09, $B4, $49, $B4, $01, $FC, $01, $74
    db $F7, $27, $5F, $17, $AF, $27, $EF, $0F, $F7, $47, $B7, $07, $FF, $07, $FF, $8F
    db $3F, $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $88, $77, $55, $AE, $8A
    db $45, $14, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $77, $00, $AA, $00, $75
    db $10, $FE, $00, $00, $00, $EB, $14, $F3, $00, $DD, $F8, $8D, $88, $41, $BC, $93
    db $3C, $01, $01, $FF, $FF, $F3, $F3, $FF, $FF, $FF, $FF, $FF, $7F, $AF, $0F, $6F
    db $47, $18, $A0, $01, $54, $11, $A8, $50, $8D, $01, $56, $01, $A8, $20, $52, $C8
    db $15, $E7, $43, $FE, $AA, $EE, $46, $AF, $20, $FE, $A8, $FE, $56, $DF, $09, $37
    db $22, $2B, $F4, $41, $24, $03, $94, $91, $44, $01, $AC, $11, $64, $21, $8C, $09
    db $54, $D7, $07, $BF, $9F, $FF, $6F, $6F, $2F, $FF, $57, $EF, $8F, $DF, $57, $F7
    db $A7, $3F, $7F, $80, $80, $80, $6F, $90, $4F, $80, $33, $9F, $38, $90, $24, $99
    db $04, $A1, $80, $80, $FF, $FF, $CF, $CF, $FF, $FF, $FF, $FF, $FF, $FE, $FB, $F2
    db $FB, $EA, $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $10, $EF, $80, $35
    db $00, $82, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EF, $00, $7F, $4A
    db $FF, $7D, $08, $A0, $82, $A9, $0F, $B0, $25, $98, $29, $94, $22, $9C, $30, $83
    db $28, $82, $F7, $F7, $FD, $F4, $F0, $E0, $FA, $E2, $F6, $E2, $FD, $E1, $EF, $E8
    db $F7, $F5, $00, $10, $09, $A4, $C0, $14, $85, $2A, $20, $D7, $A0, $59, $00, $02
    db $42, $05, $FF, $EF, $F6, $52, $3F, $2B, $7A, $50, $DF, $08, $5F, $06, $FF, $FD
    db $BD, $B8, $3F, $7F, $80, $80, $80, $6F, $90, $4F, $80, $33, $9F, $38, $90, $24
    db $99, $04, $A2, $80, $80, $FF, $FF, $CF, $CF, $FF, $FF, $FF, $FF, $FF, $FE, $FB
    db $F2, $FB, $E9, $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $10, $EF, $20
    db $00, $80, $5B, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EF, $00, $DF
    db $CF, $7F, $24, $09, $A4, $80, $AB, $04, $B8, $24, $8B, $20, $8A, $38, $80, $38
    db $86, $20, $8B, $F6, $F2, $FF, $F4, $FB, $E2, $FB, $F0, $FF, $F5, $E7, $E7, $E7
    db $E1, $FF, $F4, $20, $5B, $48, $86, $80, $59, $18, $01, $81, $2E, $02, $D1, $00
    db $66, $B0, $09, $DF, $84, $B7, $31, $7F, $26, $E7, $E4, $7E, $50, $FD, $2C, $FF
    db $99, $4F, $46, $3F, $7F, $80, $80, $80, $6F, $90, $4F, $80, $33, $9F, $38, $90
    db $25, $9A, $00, $A4, $80, $80, $FF, $FF, $CF, $CF, $FF, $FF, $FF, $FF, $FF, $FE
    db $FA, $F0, $FF, $E9, $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $10, $EF
    db $C9, $BF, $00, $8D, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EF, $00
    db $36, $00, $FF, $52, $04, $A3, $85, $A8, $00, $B2, $28, $84, $21, $8A, $24, $92
    db $32, $88, $21, $88, $FB, $F8, $FA, $F2, $FF, $ED, $F7, $F3, $FE, $F4, $FB, $E1
    db $ED, $E5, $FE, $F6, $0A, $70, $00, $22, $20, $DB, $10, $C4, $48, $02, $03, $50
    db $D0, $09, $04, $50, $F5, $85, $FF, $5C, $DF, $00, $EF, $2B, $B7, $B5, $FC, $2C
    db $2F, $26, $FB, $A3, $91, $A4, $8E, $89, $09, $4A, $D8, $90, $94, $E8, $E8, $09
    db $EE, $98, $90, $CF, $C8, $DF, $01, $03, $02, $03, $01, $03, $FF, $03, $02, $03
    db $BF, $A0, $C0, $40, $E0, $E0, $40, $E0, $7F, $E0, $20, $60, $E0, $E0, $80, $8F
    db $53, $95, $3A, $29, $62, $A8, $C2, $86, $C2, $68, $0C, $26, $0C, $FB, $BE, $03
    db $2F, $F3, $4F, $54, $53, $7F, $30, $13, $4F, $F8, $FF, $F0, $F8, $F0, $FC, $FC
    db $E0, $90, $94, $5A, $5F, $2E, $9E, $9E, $EE, $80, $59, $95, $DF, $3E, $6E, $9E
    db $30, $11, $D9, $0C, $C3, $E3, $E3, $C3, $91, $81, $C1, $C5, $38, $30, $EF, $76
    db $EB, $F7, $E7, $66, $02, $3C, $E3, $AC, $0D, $20, $F9, $FC, $F6, $F5, $F4, $86
    db $85, $F8, $E1, $0C, $0D, $F4, $05, $F5, $FB, $F0, $FD, $7D, $11, $0F, $FD, $03
    db $05, $FB, $F3, $C3, $A7, $E3, $EB, $CB, $28, $16, $04, $D3, $E2, $8B, $E7, $BE
    db $EF, $F7, $20, $1C, $8B, $FC, $FD, $42, $F6, $F5, $F4, $08, $FD, $29, $38, $37
    db $D4, $FC, $FD, $01, $F5, $FB, $E2, $FD, $F5, $21, $DF, $05, $0B, $FD, $03, $91
    db $49, $44, $5C, $0F, $5E, $E8, $55, $AF, $2E, $84, $55, $95, $36, $05, $55, $F3
    db $99, $6A, $2F, $1F, $1F, $0F, $40, $54, $44, $A7, $90, $4F, $D9, $9F, $CB, $B0
    db $1F, $80, $AF, $08, $C7, $87, $D7, $C7, $C7, $22, $1B, $03, $A6, $58, $5F, $80
    db $C7, $CF, $31, $ED, $DF, $84, $78, $CF, $7F, $0F, $3F, $2F, $1F, $0F, $30, $3B
    db $31, $10, $0F, $1F, $0C, $80, $9F, $BF, $DF, $9F, $91, $80, $90, $E0, $8C, $F3
    db $E7, $A7, $D7, $87, $E7, $A7, $87, $15, $44, $40, $D7, $87, $1D, $0C, $EF, $DF
    db $CF, $EF, $DF, $CF, $B0, $08, $40, $38, $0C, $90, $A4, $06, $89, $09, $46, $E8
    db $90, $94, $48, $80, $9E, $89, $0C, $FC, $80, $BF, $01, $02, $01, $02, $03, $DF
    db $03, $01, $02, $03, $02, $03, $BB, $A0, $40, $80, $A0, $20, $40, $E0, $E0, $97
    db $E0, $20, $20, $60, $A0, $20, $E0, $E0, $C0, $94, $C1, $3A, $0C, $02, $A0, $C0
    db $88, $80, $C0, $66, $62, $93, $95, $82, $9A, $8C, $06, $6E, $6B, $FF, $FF, $E0
    db $F0, $F8, $E0, $F0, $B6, $F8, $49, $BF, $64, $9F, $2B, $F7, $A6, $03, $9B, $92
    db $B6, $BB, $9B, $96, $92, $30, $13, $3D, $54, $57, $78, $F8, $F8, $78, $80, $F8
    db $78, $E0, $80, $F8, $96, $C1, $88, $80, $C0, $66, $60, $C0, $3A, $0C, $02, $A8
    db $9D, $8B, $6A, $6B, $5F, $53, $95, $58, $82, $90, $FF, $07, $0F, $1F, $07, $0F
    db $FF, $1F, $F6, $1F, $1E, $1E, $1F, $1F, $01, $1E, $F7, $1E, $1F, $D2, $7F, $40
    db $40, $12, $F6, $CA, $80, $76, $24, $AD, $2D, $B6, $A4, $C0, $5B, $91, $35, $B5
    db $8E, $E9, $EE, $9E, $9E, $95, $9E, $AE, $C0, $E5, $EE, $EE, $99, $A0, $05, $29
    db $B1, $59, $91, $79, $A1, $3B, $B3, $39, $B1, $69, $49, $91, $67, $C1, $FE, $E1
    db $C1, $C3, $FC, $C1, $FE, $E1, $08, $8D, $84, $4D, $44, $DD, $C4, $9D, $84, $8D
    db $1C, $05, $CC, $C5, $DD, $C4, $0D, $83, $7F, $43, $BF, $C3, $3F, $83, $7F, $03
    db $C3, $3F, $70, $7D, $B1, $69, $29, $59, $91, $38, $B0, $39, $B1, $C1, $FE, $E5
    db $E1, $C0, $C1, $FE, $D8, $C5, $CC, $8D, $84, $9D, $65, $DD, $C4, $9D, $CD, $8D
    db $84, $C3, $3F, $83, $7F, $40, $C3, $3F, $83, $7F, $93, $79, $73, $73, $A6, $96
    db $2F, $2A, $98, $D8, $98, $96, $66, $96, $80, $C2, $60, $CF, $B0, $FF, $7B, $0B
    db $55, $7B, $FD, $0B, $AA, $78, $38, $7D, $F8, $B8, $F8, $58, $F8, $F0, $80, $38
    db $DF, $B8, $F8, $A0, $58, $F8, $F0, $FC, $F8, $FC, $8D, $4E, $25, $5A, $56, $F7
    db $EE, $55, $D2, $59, $F2, $F5, $55, $88, $78, $D5, $04, $D3, $E3, $F3, $C3, $E3
    db $D1, $C1, $9E, $C3, $FB, $22, $FE, $E3, $E7, $26, $3C, $E3, $06, $05, $84, $0C
    db $F0, $F1, $F6, $F5, $F0, $F1, $E4, $E5, $8C, $D4, $21, $05, $FB, $D0, $F5, $F9
    db $FD, $FB, $F9, $1D, $FB, $15, $0B, $F1, $0F, $56, $E1, $21, $EB, $CB, $F3, $D3
    db $C3, $31, $C2, $74, $E5, $DB, $82, $D9, $18, $3B, $EF, $F7, $F7, $EF, $E7, $C1
    db $20, $1C, $FE, $01, $F6, $F5, $F1, $F0, $F6, $F5, $04, $F1, $5D, $EC, $DC, $3D
    db $12, $13, $01, $50, $FD, $FB, $F9, $FD, $FB, $F9, $E5, $1B, $0D, $03, $13, $ED
    db $B5

; ============================================================================
; ROM BANK $F1
; ============================================================================

; Range: $F16000-$F16085 (134 bytes)
; Function/storage: AUXILIARY_DIALOGUE, ENEMY_PRIZE_PROFILE_HELPER

org $FF3000
DogMazeConnection_MapData:
    db $00, $00, $80, $46, $17, $00, $00, $02, $00, $00, $00, $00, $00, $A8, $00, $09
    db $68, $0A, $69, $9A, $14, $18, $6B, $19, $6C, $9A, $14, $06, $76, $07, $77, $9D
    db $14, $05, $31, $07, $33, $A0, $14, $17, $6D, $19, $6F, $A3, $14, $14, $5D, $16
    db $5F, $A6, $14, $37, $02, $38, $05, $A9, $14, $29, $02, $2A, $05, $AC, $14, $05
    db $11, $07, $13, $AF, $14, $1A, $03, $1C, $05, $B2, $14, $17, $31, $19, $33, $B5
    db $14, $17, $3B, $19, $3D, $B8, $14, $08, $4D, $0A, $4F, $BB, $14, $13, $49, $15
    db $4B, $BE, $14, $08, $56, $0A, $58, $C1, $14, $03, $67, $05, $69, $C4, $14, $19
    db $7C, $1B, $7E, $C7, $14, $35, $7C, $37, $7E, $CA, $14, $2A, $5A, $2C, $5C, $CD
    db $14, $26, $4A, $28, $4C, $D0, $14, $28, $3B, $2A, $3D, $D3, $14, $28, $2B, $2A
    db $2D, $D6, $14, $41, $3D, $43, $3F, $D9, $14, $0F, $68, $10, $69, $DC, $14, $09
    db $6D, $0A, $6E, $DF, $14, $16, $71, $17, $72, $E2, $14, $09, $72, $0A, $73, $E5
    db $14, $0E, $79, $0F, $7A, $E8, $14, $00, $00, $06, $54, $01, $55, $01, $1B, $01
    db $83, $00, $1C, $01, $18, $01, $00, $AB, $00, $00, $A8, $00, $AF, $19, $22, $FC
    db $A9, $FC, $59, $03, $D3, $F2, $01, $00, $32, $0B, $D8, $F4, $23, $0D, $DC, $03
    db $26, $FC, $D2, $F2, $01, $00, $32, $0B, $D8, $F4, $CC, $09, $01, $00, $A1, $ED
    db $FC, $FF, $01, $00, $B4, $13, $0B, $00, $01, $00, $A4, $FE, $A3, $ED, $01, $00
    db $87, $12, $01, $00, $FF, $F5, $32, $0B, $01, $00, $A1, $F6, $01, $00, $29, $FE
    db $09, $0A, $01, $00, $FA, $F5, $39, $03, $9D, $FE, $F4, $07, $43, $00, $01, $00
    db $47, $F9, $01, $00, $EC, $FF, $A1, $FB, $01, $00, $1E, $12, $01, $00, $78, $EC
    db $01, $00, $08, $FA, $C2, $0B, $9F, $FB, $01, $00, $5D, $04, $01, $00, $0E, $FA
    db $01, $00, $B6, $0C, $EC, $F5, $91, $F7, $C1, $0B, $01, $00, $0F, $FA, $01, $00
    db $2F, $FA, $1F, $0B, $06, $00, $01, $00, $86, $08, $CE, $F4, $87, $F7, $AC, $13
    db $CF, $F4, $8A, $F7, $3F, $12, $01, $00, $C5, $ED, $3C, $12, $01, $00, $C4, $ED
    db $01, $00, $01, $00, $02, $2D, $00, $00, $06, $09, $00, $00, $06, $1B, $00, $FF
    db $01, $A2, $0B, $01, $2F, $0B, $01, $A1, $0B, $01, $2F, $0B, $01, $B3, $19, $03
    db $2F, $0B, $01, $A1, $0B, $01, $2F, $0B, $01, $A2, $0B, $01, $2F, $0B, $01, $A1
    db $0B, $03, $2F, $0B, $03, $00, $00, $06, $00, $0C, $00, $03, $46, $00, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $08, $46, $10, $46, $18, $46, $08, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $20, $46
    db $28, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $30, $46, $38, $46, $40, $46, $48, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $50, $46, $58, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $60, $46, $68, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $70, $46
    db $78, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $80, $46, $88, $46, $78, $46, $90, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $08, $46, $20, $46, $40, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $60, $46, $98, $46, $A0, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $A8, $46
    db $B0, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $B8, $46, $B8, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $C8, $46, $D0, $46, $B0, $46, $D8, $46, $E0, $46, $48, $46, $B8, $46, $B8, $46
    db $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46
    db $B8, $46, $B8, $46, $B8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $08, $46, $98, $46
    db $A0, $46, $E8, $46, $F0, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $F8, $46, $F8, $46
    db $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $00, $47
    db $08, $47, $10, $47, $18, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $20, $47
    db $28, $47, $30, $47, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $40, $47, $48, $47, $B8, $46, $B8, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $50, $47, $58, $47, $60, $47, $68, $47, $70, $47, $90, $46, $B8, $46, $08, $46
    db $68, $46, $08, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46
    db $B8, $46, $08, $46, $68, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $60, $46, $08, $46, $B8, $46, $B8, $46, $B8, $46, $08, $46, $60, $46
    db $68, $46, $78, $47, $80, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $88, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $90, $47
    db $98, $47, $A0, $47, $00, $46, $00, $46, $00, $46, $38, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $A8, $47, $B8, $46, $B8, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $B0, $47, $B8, $47, $C0, $47, $C8, $47, $D0, $47, $68, $47, $B8, $46, $98, $46
    db $A0, $46, $A0, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46
    db $B8, $46, $98, $46, $A0, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $98, $46, $A0, $46, $B8, $46, $B8, $46, $B8, $46, $98, $46, $98, $46
    db $A0, $46, $B8, $47, $C0, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $D8, $47, $E0, $47, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $E8, $47, $F0, $47
    db $00, $46, $00, $46, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $47
    db $08, $47, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $B8, $46, $B8, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $B0, $47, $90, $47, $98, $47, $08, $47, $08, $47, $F8, $47, $00, $47, $08, $47
    db $00, $48, $08, $47, $F8, $47, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $00, $47, $08, $47, $88, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $08, $47, $08, $47, $F8, $47, $00, $47, $08, $47, $18, $47, $10, $47
    db $18, $47, $08, $48, $10, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $18, $48, $20, $48, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $28, $48, $30, $48
    db $00, $46, $00, $46, $38, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $48
    db $40, $48, $00, $46, $00, $46, $00, $46, $38, $47, $00, $46, $00, $46, $38, $47
    db $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $48, $48, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $50, $48, $58, $48, $58, $48, $58, $48, $60, $48, $68, $48, $00, $46, $00, $46
    db $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $38, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $70, $48, $78, $48, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $80, $48, $88, $48
    db $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $38, $47, $38, $47, $00, $46, $00, $46, $38, $47
    db $00, $46, $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $40, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $38, $48, $B8, $46, $B8, $46, $B8, $46, $08, $46, $30, $46
    db $E0, $46, $90, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $20, $47, $28, $47, $30, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $20, $47, $28, $47
    db $30, $47, $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $38, $47
    db $00, $46, $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $98, $48, $60, $46, $08, $46, $08, $46, $08, $46, $80, $46
    db $A0, $48, $A8, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $B0, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $90, $47, $98, $47, $A0, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $90, $47, $98, $47
    db $A0, $47, $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $B8, $48, $00, $46, $00, $46, $38, $47, $00, $46, $48, $48, $38, $47, $38, $47
    db $38, $47, $38, $47, $48, $48, $38, $47, $00, $46, $00, $46, $00, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $08, $47, $98, $46, $08, $46, $08, $46, $08, $46, $50, $47
    db $D0, $47, $C0, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $C8, $48, $D0, $48, $D8, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $18, $47, $10, $47
    db $00, $46, $00, $46, $98, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $E0, $48, $00, $46, $00, $46, $38, $47, $00, $46, $38, $47, $00, $46, $38, $47
    db $00, $46, $00, $46, $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $10, $47, $08, $47, $F8, $47, $E8, $48, $F0, $48, $F8, $48
    db $00, $49, $08, $49, $48, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $10, $49, $00, $46, $68, $46, $B0, $48
    db $18, $49, $20, $49, $28, $49, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $30, $49
    db $00, $46, $00, $46, $08, $47, $68, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $68, $46, $08, $46, $08, $46, $08, $46, $08, $46, $68, $46
    db $08, $47, $00, $46, $00, $46, $38, $47, $00, $46, $38, $47, $00, $46, $38, $47
    db $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $38, $49, $90, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $40, $49, $60, $46, $48, $49, $50, $49
    db $58, $49, $60, $46, $60, $49, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $68, $49, $70, $49, $78, $49, $80, $49, $00, $46, $00, $46, $00, $46, $08, $47
    db $00, $46, $00, $46, $18, $47, $60, $46, $68, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $98, $46, $A0, $46, $A0, $46, $08, $46, $08, $46, $98, $46, $A0, $46
    db $38, $48, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $00, $46, $38, $47
    db $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $30, $46, $88, $49
    db $90, $49, $98, $49, $A0, $49, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $40, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $A8, $49, $D8, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $B0, $49, $B8, $49, $C0, $49, $C8, $49, $D0, $49, $D8, $49, $E0, $49, $E8, $49
    db $F0, $49, $A0, $46, $F8, $49, $60, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $4A, $08, $4A, $10, $4A, $18, $4A, $B8, $46, $00, $46, $00, $46, $38, $48
    db $00, $46, $00, $46, $88, $47, $00, $48, $08, $47, $F8, $47, $F8, $46, $F8, $46
    db $20, $4A, $A8, $48, $28, $4A, $F0, $48, $30, $4A, $00, $47, $08, $47, $F8, $47
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $00, $46, $38, $47
    db $38, $47, $38, $47, $00, $46, $38, $47, $38, $47, $38, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $60, $46, $08, $46, $B8, $46, $B8, $46, $B8, $46, $80, $46, $38, $4A
    db $A8, $49, $40, $4A, $48, $4A, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46
    db $B8, $46, $60, $46, $E0, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $50, $4A, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $58, $4A, $60, $4A, $68, $4A, $F0, $48, $A8, $48, $C0, $48, $08, $49, $00, $49
    db $70, $4A, $78, $4A, $80, $4A, $A8, $48, $88, $4A, $90, $4A, $F8, $46, $F8, $46
    db $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $F8, $46, $F8, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $08, $46, $08, $46
    db $98, $4A, $98, $46, $A0, $4A, $A8, $4A, $B0, $4A, $08, $46, $08, $46, $F8, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $08, $49, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $48, $48, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $98, $46, $A0, $46, $B8, $46, $B8, $46, $B8, $46, $50, $47, $D0, $47
    db $B8, $4A, $C0, $4A, $C8, $4A, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46
    db $B8, $46, $98, $46, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $08, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $D0, $4A, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $D0, $4A, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $D8, $4A, $E0, $4A, $00, $46, $00, $46, $00, $46, $08, $46, $08, $46
    db $E8, $4A, $F0, $4A, $F8, $4A, $00, $4B, $08, $4B, $A0, $46, $08, $46, $F8, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $F0, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $B8, $48, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $18, $47, $08, $47, $F8, $47, $F8, $46, $10, $4B, $A8, $48, $18, $4B
    db $20, $4B, $28, $4B, $A8, $49, $30, $4B, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $00, $47, $08, $47, $10, $47, $48, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46
    db $38, $4B, $08, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $40, $4B, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $40, $4B, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $A8, $49, $A8, $48, $00, $46, $00, $46, $00, $46, $F8, $46, $10, $4B
    db $48, $4B, $50, $4B, $58, $4B, $60, $4B, $68, $4B, $A8, $49, $70, $4B, $F8, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $50, $4A, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $38, $47, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $88, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $48, $90, $46, $B8, $46, $B8, $46, $B8, $46, $60, $46
    db $98, $46, $A0, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $78, $4B, $80, $4B, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $10, $4A, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $30, $46, $E0, $46, $88, $4B, $90, $4B, $00, $46
    db $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $48, $08, $47, $F8, $47, $F8, $46, $00, $47, $08, $47
    db $88, $47, $00, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $08, $46, $08, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $98, $4B, $A0, $4B, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $80, $46, $A0, $48, $E8, $46, $78, $46, $00, $46
    db $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $E0, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $A8, $4B, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $40, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $18, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $10, $46, $18, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $40, $4B, $00, $46, $00, $46, $00, $46
    db $00, $46, $20, $47, $28, $47, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $C8, $46, $B0, $4B, $A8, $46, $B0, $46, $00, $46
    db $00, $46, $00, $46, $E0, $48, $68, $46, $08, $46, $08, $46, $08, $46, $68, $46
    db $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $48, $47, $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $88, $4B, $90, $4B, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $88, $4B, $90, $4B, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $40, $4B, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $90, $47, $98, $47, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $18, $47, $10, $47, $20, $47, $28, $47, $30, $47
    db $00, $46, $00, $46, $08, $47, $68, $46, $98, $46, $08, $46, $98, $46, $A0, $46
    db $10, $47, $00, $46, $00, $46, $00, $46, $00, $46, $B8, $4B, $C0, $4B, $00, $46
    db $00, $46, $A8, $47, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $C8, $4B, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $40, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $88, $46, $78, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $70, $46, $78, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $10, $49, $00, $46, $10, $49, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $90, $48, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $88, $47, $00, $48, $90, $47, $98, $47, $A0, $47
    db $00, $46, $00, $46, $00, $48, $08, $47, $F8, $47, $00, $47, $08, $47, $18, $47
    db $00, $48, $00, $46, $00, $46, $00, $46, $00, $46, $D0, $4B, $F0, $46, $00, $46
    db $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $38, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $46, $D8, $4B, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $98, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $D0, $46, $B0, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $A8, $46, $B0, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $E0, $4B, $E8, $4B, $F0, $4B, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F0, $48, $60, $46
    db $68, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $60, $46, $68, $46, $F8, $4B, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $10, $47, $60, $46, $08, $46, $08, $46, $68, $46, $A8, $46, $B0, $46, $00, $46
    db $00, $46, $48, $48, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $00, $46, $38, $46, $D8, $4B, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $E8, $46, $00, $4C, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $08, $4C, $10, $4C, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $18, $4C, $20, $4C, $30, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $28, $4C, $20, $47, $28, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $30, $4C, $38, $4C, $40, $4C, $08, $46, $08, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $80, $4B, $98, $46
    db $A0, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $68, $46, $98, $46, $A0, $46, $08, $47, $00, $46, $00, $46, $00, $46, $10, $4A
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $08, $47, $98, $46, $A0, $46, $98, $46, $A0, $46, $20, $47, $28, $47, $30, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $E8, $46, $48, $4C, $00, $46, $00, $46
    db $00, $46, $00, $46, $30, $46, $A8, $46, $50, $4C, $E0, $46, $48, $46, $B8, $46
    db $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46
    db $B8, $46, $78, $4A, $10, $4C, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $E0, $48, $00, $46, $00, $46, $00, $46, $00, $46, $10, $4C, $10, $4C
    db $30, $46, $90, $47, $98, $47, $A0, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $58, $4C, $90, $47, $98, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $60, $4C, $68, $4C, $70, $4C, $08, $46, $08, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $78, $4C, $80, $4C
    db $A8, $49, $70, $4B, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $F8, $46, $00, $47, $08, $47, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $08, $47, $08, $47, $08, $47, $88, $4C, $00, $48, $90, $47, $98, $47, $A0, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $A8, $46, $B0, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $80, $46, $90, $4C, $98, $4C, $A0, $48, $90, $46, $B8, $46
    db $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $A0, $4C
    db $A8, $4C, $F0, $48, $10, $4C, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $08, $47, $08, $46, $08, $46, $08, $46, $08, $46, $B0, $4C, $B0, $4C
    db $80, $46, $18, $47, $10, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $18, $47, $10, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $B8, $4C, $C0, $4C, $B8, $4C, $70, $4B, $F8, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $C8, $4C, $D0, $4C
    db $D8, $4C, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $10, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $20, $47, $28, $47, $30, $47, $00, $46
    db $00, $46, $00, $46, $C8, $46, $B8, $47, $C0, $47, $D0, $47, $68, $47, $B8, $46
    db $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $B8, $46, $E0, $4C
    db $E8, $4C, $88, $4A, $10, $4C, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $18, $47, $08, $46, $08, $46, $08, $46, $08, $46, $B0, $4C, $B0, $4C
    db $C8, $46, $08, $47, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $08, $46
    db $08, $46, $60, $46, $68, $46, $88, $47, $00, $48, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $78, $4A, $78, $4C, $A8, $48, $70, $4B, $F8, $46, $08, $46
    db $08, $46, $60, $46, $68, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F0, $4C, $F8, $4C
    db $00, $4D, $08, $46, $08, $46, $08, $46, $60, $46, $68, $46, $08, $46, $08, $46
    db $08, $47, $08, $46, $08, $4D, $08, $46, $08, $46, $08, $4D, $08, $46, $08, $46
    db $08, $4D, $08, $46, $08, $46, $08, $4D, $08, $46, $08, $46, $60, $46, $68, $46
    db $08, $46, $08, $46, $60, $46, $68, $46, $90, $47, $98, $47, $A0, $47, $00, $46
    db $00, $46, $00, $46, $B0, $47, $90, $47, $98, $47, $18, $47, $08, $47, $F8, $47
    db $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $10, $4B
    db $00, $49, $80, $4B, $10, $4C, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $88, $47, $00, $48, $08, $47, $F8, $47, $F8, $46, $00, $47, $08, $47
    db $08, $47, $08, $47, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $08, $46
    db $98, $46, $98, $46, $A0, $46, $18, $47, $10, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $A8, $49, $A8, $48, $A8, $48, $70, $4B, $F8, $46, $08, $46
    db $68, $46, $98, $46, $A0, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $10, $4D, $18, $4D
    db $68, $47, $08, $46, $08, $46, $08, $46, $98, $46, $60, $46, $68, $46, $08, $46
    db $10, $47, $60, $46, $20, $4D, $60, $46, $60, $46, $20, $4D, $08, $46, $08, $46
    db $28, $4D, $08, $46, $08, $46, $28, $4D, $08, $46, $68, $46, $98, $46, $A0, $46
    db $08, $46, $08, $46, $98, $46, $A0, $46, $18, $47, $10, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $10, $4C, $10, $4C, $10, $4C, $10, $4C, $10, $4C, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $10, $4C
    db $10, $4C, $10, $4C, $10, $4C, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $47
    db $30, $4D, $18, $47, $10, $47, $88, $47, $00, $48, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $38, $4D, $38, $4D, $40, $4D, $48, $4D, $F8, $46, $00, $47
    db $08, $47, $88, $47, $00, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $49, $C0, $4C
    db $08, $49, $88, $4A, $90, $4A, $20, $4A, $A8, $48, $28, $4A, $F0, $48, $50, $4D
    db $10, $4B, $88, $4A, $58, $4D, $00, $49, $20, $4B, $60, $4D, $70, $4B, $F8, $46
    db $68, $4D, $F8, $46, $F8, $46, $68, $4D, $20, $4A, $A8, $48, $78, $4C, $A8, $48
    db $70, $4B, $00, $47, $08, $47, $70, $4D, $88, $47, $00, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $40, $48
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $10, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $A0, $4B, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $78, $4D
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $10, $4A, $00, $46, $00, $46, $80, $4D, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $A8, $49, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $46, $08, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $A8, $48
    db $88, $4D, $90, $4D, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $E0, $48, $08, $46, $08, $46, $08, $46, $08, $46, $00, $46
    db $00, $46, $00, $46, $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $68, $46
    db $A0, $4A, $60, $46, $98, $4D, $A0, $4D, $68, $46, $08, $46, $08, $46, $60, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $A8, $4D, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $68, $46, $08, $46, $08, $46
    db $68, $46, $08, $46, $10, $49, $60, $46, $08, $46, $10, $49, $68, $46, $08, $46
    db $10, $49, $60, $46, $08, $46, $10, $49, $68, $46, $08, $46, $08, $46, $10, $4C
    db $08, $46, $08, $46, $08, $46, $10, $49, $60, $46, $68, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $78, $4B
    db $B0, $4D, $B8, $4D, $68, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $68, $46, $98, $46, $08, $47, $68, $46, $08, $46, $08, $46, $08, $46, $00, $46
    db $00, $46, $00, $46, $08, $47, $48, $46, $00, $46, $00, $46, $00, $46, $C0, $4D
    db $C8, $4D, $D0, $4D, $D8, $4D, $E0, $4D, $A0, $46, $08, $46, $08, $46, $A0, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $98, $46, $E0, $48, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $A0, $46, $60, $46, $08, $46
    db $A0, $46, $08, $46, $60, $49, $98, $46, $08, $46, $60, $49, $A0, $46, $08, $46
    db $60, $49, $98, $46, $08, $46, $60, $49, $A0, $46, $08, $46, $08, $46, $E8, $4D
    db $08, $46, $08, $46, $08, $46, $F0, $4D, $98, $46, $A0, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $4D
    db $F8, $48, $C0, $48, $F8, $48, $A8, $48, $70, $4B, $F8, $46, $00, $47, $08, $47
    db $18, $47, $00, $48, $10, $47, $08, $47, $F8, $47, $F8, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $10, $47, $90, $46, $00, $46, $00, $46, $00, $46, $00, $4E
    db $08, $4E, $48, $4B, $10, $4E, $18, $4E, $A8, $49, $70, $4B, $68, $4A, $F0, $48
    db $70, $4B, $F8, $46, $F8, $46, $F8, $46, $00, $47, $08, $47, $08, $47, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $47, $F8, $47, $20, $4A
    db $A8, $48, $50, $4D, $20, $4E, $A8, $49, $70, $4B, $20, $4E, $A8, $48, $50, $4D
    db $20, $4E, $A8, $49, $70, $4B, $20, $4E, $A8, $48, $70, $4B, $F8, $46, $28, $4E
    db $F8, $46, $F8, $46, $00, $47, $30, $4E, $18, $47, $10, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $00, $48, $D8, $46, $00, $46, $00, $46, $00, $46, $88, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $38, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $88, $47, $00, $48, $00, $46, $00, $46, $00, $46, $08, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $38, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $10, $46, $18, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $10, $46, $18, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $18, $47, $10, $47, $00, $46, $00, $46, $00, $46, $40, $48
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $08, $46, $98, $46, $A0, $46, $98, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $98, $46, $98, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $40, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $38, $46, $D8, $4B, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $46, $D8, $4B, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $88, $4B, $90, $4B, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $88, $47, $00, $48, $00, $46, $00, $46, $00, $46, $F8, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $30, $46, $18, $47, $18, $47, $08, $47, $F8, $47, $F8, $46
    db $F8, $46, $F8, $46, $F8, $46, $00, $47, $08, $47, $08, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $70, $46, $78, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $C8, $48, $00, $46, $00, $46, $E8, $46, $48, $4C, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $4E, $40, $4E, $00, $46, $00, $46, $00, $46
    db $98, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $20, $47, $28, $47, $00, $46, $00, $46, $00, $46, $F8, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $80, $46, $10, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $90, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $A8, $46, $B0, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $48, $4E, $00, $46, $00, $46, $A8, $46, $B0, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $50, $4E, $58, $4E, $60, $46, $60, $46, $68, $46
    db $08, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $90, $47, $98, $47, $00, $46, $00, $46, $00, $46, $F8, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $C8, $46, $00, $48, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $68, $46
    db $08, $46, $08, $46, $08, $46, $60, $46, $68, $46, $F0, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $60, $4E, $68, $4E, $30, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $70, $4E, $00, $46, $28, $4C, $18, $4C, $20, $4C, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $28, $4C, $20, $47, $28, $47, $98, $46, $98, $46, $A0, $46
    db $10, $47, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $90, $48
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $88, $47, $00, $48, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $A0, $46
    db $08, $46, $08, $46, $08, $46, $98, $46, $A0, $46, $18, $4B, $00, $46, $00, $46
    db $00, $46, $00, $46, $90, $47, $98, $47, $78, $4E, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $80, $4E, $30, $46, $E0, $46, $90, $47, $98, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $58, $4C, $90, $47, $98, $47, $88, $47, $88, $47, $00, $48
    db $00, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $98, $48, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $A8, $48
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $88, $47, $00, $48, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $A8, $48
    db $70, $4B, $88, $4E, $20, $4A, $A8, $48, $98, $4B, $A0, $4B, $00, $46, $00, $46
    db $00, $46, $00, $46, $18, $47, $10, $47, $60, $46, $68, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $60, $46, $68, $46, $68, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $90, $4E, $80, $46, $A0, $48, $18, $47, $10, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $47, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $60, $46, $68, $46, $88, $4A
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $20, $47, $28, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F0, $48
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $88, $47, $00, $48, $98, $46, $A0, $46, $60, $46, $08, $46
    db $08, $46, $08, $46, $60, $46, $A0, $46, $98, $46, $A0, $46, $A0, $46, $60, $46
    db $60, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $98, $4E, $C8, $46, $A0, $4E, $A8, $4E, $B0, $4E, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $10, $47, $98, $46
    db $A0, $46, $68, $46, $08, $46, $08, $46, $60, $46, $98, $46, $A0, $46, $C0, $4C
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $90, $47, $98, $47, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $49
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $18, $47, $10, $47, $08, $47, $08, $47, $08, $47, $08, $47
    db $F8, $47, $00, $47, $08, $47, $10, $47, $18, $47, $10, $47, $18, $47, $10, $47
    db $08, $47, $F8, $47, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $00, $47
    db $B8, $4E, $08, $47, $C0, $4E, $C8, $4E, $D0, $4E, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $48, $88, $47
    db $08, $47, $F8, $47, $F8, $46, $20, $4A, $A8, $48, $88, $4A, $F8, $4D, $A0, $4B
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $C0, $48
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $F8, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $88, $4A
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $10, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $D8, $4E, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $E0, $4E
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $A8, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $40, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $A8, $48, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $10, $4C, $E8, $4E
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $A0, $4B, $60, $46, $60, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $68, $46, $60, $46, $60, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $60, $46, $68, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $10, $4C, $F0, $4E
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $10, $46, $18, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $78, $4C, $68, $46, $A0, $46, $60, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $98, $46, $98, $46, $A0, $46, $98, $46, $98, $46
    db $A0, $46, $68, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $60, $46, $98, $46, $A0, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $4E
    db $00, $46, $00, $46, $00, $46, $00, $4F, $38, $46, $D8, $4B, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $08, $4F, $10, $4F, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $98, $4B, $F8, $4D, $A8, $48, $A8, $48, $90, $4A, $F8, $46, $F8, $46, $F8, $46
    db $F8, $46, $10, $4B, $A8, $48, $A8, $49, $80, $4B, $00, $49, $80, $4B, $20, $4B
    db $C0, $4C, $A8, $48, $A8, $48, $70, $4B, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $F8, $46, $F8, $46, $00, $47, $08, $47, $88, $47, $00, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $18, $4F
    db $20, $4F, $00, $46, $98, $4D, $28, $4F, $D0, $4B, $F0, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $30, $4F, $38, $4F, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $88, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $40, $4F
    db $48, $4F, $50, $4F, $58, $4F, $60, $4F, $68, $4F, $B0, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $70, $4F, $78, $4F, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $47, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46
    db $08, $46, $98, $46, $A0, $46, $80, $4F, $20, $47, $28, $47, $30, $47, $00, $46
    db $00, $46, $00, $46, $28, $4C, $60, $4E, $68, $4E, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $40, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46
    db $00, $47, $08, $47, $08, $47, $00, $48, $90, $47, $98, $47, $A0, $47, $00, $46
    db $00, $46, $00, $46, $88, $4F, $90, $47, $98, $47, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $90, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $18, $47, $10, $47, $48, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $08, $46, $A8, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $08, $47, $08, $47, $90, $46, $08, $46, $08, $46
    db $08, $46, $08, $46, $08, $46, $60, $46, $68, $46, $A8, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $48, $40, $48, $68, $47, $08, $46, $08, $46
    db $08, $46, $08, $46, $68, $46, $98, $46, $A0, $46, $78, $4C, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46, $F8, $46
    db $10, $4B, $A8, $48, $00, $49, $80, $4B, $38, $49, $28, $4A, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F8, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $90, $4F, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $88, $4A, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $E8, $47, $F0, $47, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F0, $48, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $98, $4F, $38, $4F, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $F0, $48, $A0, $46, $68, $46
    db $08, $46, $08, $46, $08, $46, $08, $46, $68, $46, $80, $48, $88, $48, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $80, $4B, $98, $46, $A0, $46
    db $98, $46, $08, $46, $08, $46, $98, $46, $A0, $46, $A0, $4F, $A8, $4F, $30, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $08, $49, $78, $4A, $08, $49
    db $A8, $48, $50, $4D, $00, $47, $88, $47, $00, $48, $08, $48, $10, $48, $A0, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46, $C0, $46
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46, $00, $46
    db $00, $46, $00, $46, $00, $46, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47, $38, $47
    db $01, $00, $00, $83, $04, $03, $E0, $07, $97, $4B, $20, $1A, $80, $01, $95, $2B
    db $9B, $48, $E6, $80, $1C, $29, $18, $DA, $44, $34, $00, $EC, $01, $31, $86, $D2
    db $B1, $A0, $0D, $20, $01, $A0, $03, $C0, $03, $E1, $2E, $86, $00, $BC, $00, $42
    db $20, $12, $10, $19, $90, $05, $D0, $08, $30, $00, $10, $02, $68, $50, $A5, $96
    db $E0, $01, $08, $0E, $C0, $03, $A0, $00, $58, $02, $4A, $58, $35, $80, $43, $80
    db $04, $90, $0A, $C8, $0D, $F6, $05, $85, $00, $0B, $01, $74, $69, $B4, $80, $4F
    db $00, $0B, $04, $0B, $2B, $0D, $A2, $49, $40, $72, $50, $49, $2C, $AB, $51, $2C
    db $04, $D1, $02, $88, $41, $42, $9C, $69, $44, $82, $0B, $0C, $D4, $43, $81, $50
    db $70, $4B, $4C, $9B, $51, $28, $D4, $49, $A0, $BE, $69, $45, $32, $C9, $4A, $B2
    db $50, $A5, $20, $01, $20, $5E, $A0, $2C, $42, $81, $E9, $97, $7A, $7D, $1A, $8F
    db $56, $A0, $1E, $20, $0F, $50, $84, $6A, $21, $5A, $8A, $34, $24, $1B, $21, $6C
    db $A2, $5A, $AC, $94, $40, $70, $08, $0E, $C4, $1C, $C2, $05, $54, $06, $78, $4A
    db $BD, $32, $8F, $48, $42, $C8, $18, $60, $0D, $90, $05, $F9, $60, $A0, $80, $DF
    db $08, $64, $92, $1D, $04, $08, $98, $04, $8C, $82, $42, $00, $9D, $2C, $74, $13
    db $D1, $04, $08, $28, $4A, $A0, $92, $C0, $97, $08, $4B, $C4, $29, $01, $4D, $08
    db $A8, $00, $BC, $28, $9A, $90, $A3, $90, $37, $C0, $17, $E8, $0E, $74, $0A, $EA
    db $53, $81, $C4, $41, $38, $1F, $54, $90, $0E, $E0, $0C, $11, $09, $C0, $81, $64
    db $82, $62, $1E, $89, $40, $00, $50, $20, $E4, $15, $B2, $0A, $29, $06, $2C, $42
    db $B4, $80, $58, $30, $3D, $94, $2A, $1B, $08, $0A, $70, $85, $4C, $A1, $92, $88
    db $74, $A0, $35, $21, $06, $C6, $86, $E4, $25, $52, $89, $60, $6D, $87, $8D, $24
    db $84, $06, $A0, $7C, $D2, $40, $E4, $80, $2E, $50, $15, $E8, $1D, $72, $0B, $F9
    db $71, $A0, $80, $8F, $29, $40, $2D, $02, $0A, $02, $34, $0D, $99, $04, $F4, $25
    db $D0, $5A, $04, $16, $85, $A9, $09, $A8, $86, $F0, $C3, $4A, $50, $40, $83, $08
    db $82, $40, $2C, $23, $4D, $90, $49, $41, $D2, $41, $ED, $20, $6B, $80, $79, $42
    db $58, $21, $E1, $A1, $41, $68, $90, $58, $55, $A2, $11, $68, $0C, $18, $51, $A0
    db $B2, $8B, $44, $9A, $D0, $11, $90, $0D, $79, $42, $A5, $02, $3C, $09, $64, $A4
    db $38, $60, $19, $F2, $87, $59, $21, $96, $49, $54, $94, $23, $A5, $2C, $12, $50
    db $59, $3D, $12, $49, $74, $96, $80, $21, $40, $0C, $F2, $84, $1C, $C4, $30, $70
    db $89, $6C, $2A, $5A, $26, $D3, $D6, $C2, $B5, $A0, $8B, $61, $37, $90, $9B, $48
    db $4D, $64, $28, $54, $01, $BA, $89, $E9, $41, $22, $30, $CD, $24, $33, $4D, $0C
    db $E1, $44, $38, $91, $0C, $54, $40, $55, $27, $50, $15, $29, $78, $A1, $9E, $41
    db $5C, $04, $43, $C9, $10, $D4, $44, $05, $7A, $1A, $8A, $84, $02, $1B, $02, $14
    db $E0, $44, $60, $51, $10, $39, $97, $22, $20, $2C, $B0, $E4, $54, $05, $62, $02
    db $BD, $20, $A7, $85, $0A, $19, $6E, $86, $6B, $21, $9A, $A8, $66, $13, $29, $86
    db $CA, $41, $A3, $00, $71, $4C, $56, $43, $85, $90, $E2, $64, $31, $5D, $0F, $20
    db $B1, $80, $59, $83, $CA, $12, $48, $65, $2C, $D9, $49, $20, $BB, $84, $5C, $21
    db $A0, $CA, $68, $B2, $82, $E3, $01, $7C, $85, $3A, $19, $60, $86, $6B, $A1, $9C
    db $01, $70, $05, $33, $98, $30, $43, $17, $18, $0C, $4C, $3D, $58, $8F, $46, $22
    db $9D, $8C, $B0, $63, $06, $16, $14, $4C, $60, $CB, $CA, $89, $CC, $18, $18, $0C
    db $84, $3D, $90, $CF, $70, $C6, $04, $62, $E0, $2D, $D0, $19, $38, $0A, $84, $86
    db $06, $02, $D1, $01, $5D, $80, $A8, $C0, $68, $A0, $2E, $12, $19, $F8, $0B, $9C
    db $06, $42, $00, $31, $21, $AA, $96, $03, $18, $2E, $70, $1B, $28, $0B, $24, $05
    db $76, $23, $70, $10, $A7, $8F, $14, $6A, $60, $37, $70, $15, $48, $0C, $64, $05
    db $62, $43, $4B, $01, $BC, $90, $D3, $C0, $6E, $E0, $2C, $73, $16, $40, $8A, $EC
    db $06, $D2, $43, $93, $10, $20, $00, $55, $80, $5C, $82, $31, $F0, $15, $E9, $D4
    db $06, $72, $03, $8D, $21, $D4, $90, $CF, $48, $71, $60, $31, $F0, $1C, $7A, $0E
    db $04, $06, $C2, $02, $F9, $21, $79, $80, $C5, $C8, $71, $A8, $39, $50, $1D, $3A
    db $0F, $3C, $07, $56, $14, $6A, $60, $D5, $40, $7A, $A0, $35, $D0, $1D, $F9, $0E
    db $FC, $87, $8A, $03, $E9, $21, $57, $90, $FE, $48, $59, $E0, $30, $10, $15, $49
    db $0F, $24, $48, $08, $3E, $68, $40, $E6, $C0, $83, $21, $80, $E6, $0D, $24, $07
    db $B2, $43, $0F, $28, $14, $62, $09, $09, $1D, $18, $10, $B4, $05, $BA, $04, $0D
    db $09, $04, $62, $41, $09, $1D, $38, $10, $E4, $07, $EE, $1A, $CA, $61, $01, $C0
    db $5E, $E4, $2B, $92, $1E, $E8, $49, $A1, $24, $01, $41, $C4, $80, $E6, $48, $75
    db $E8, $34, $F0, $22, $29, $0D, $A4, $AD, $D4, $C1, $9B, $A0, $FF, $40, $7D, $60
    db $38, $B2, $C0, $0F, $60, $FC, $83, $AE, $01, $E3, $18, $CB, $C2, $05, $4D, $80
    db $53, $43, $EA, $23, $72, $11, $C6, $B1, $10, $C0, $7D, $24, $3F, $D0, $17, $08
    db $12, $9C, $08, $D6, $22, $BC, $31, $D2, $88, $C0, $04, $84, $E4, $37, $F2, $1E
    db $38, $50, $07, $B8, $63, $01, $21, $E0, $90, $F9, $D0, $62, $E2, $3B, $63, $21
    db $28, $0A, $B4, $06, $36, $44, $DD, $21, $60, $87, $3A, $19, $E0, $1C, $62, $8E
    db $7C, $05, $A6, $43, $41, $2C, $64, $30, $86, $E0, $38, $50, $27, $68, $0B, $A4
    db $85, $5A, $04, $05, $02, $07, $80, $AC, $C0, $58, $20, $3B, $10, $27, $C8, $0B
    db $5C, $28, $90, $CB, $11, $28, $07, $19, $4C, $B1, $53, $28, $84, $A6, $12, $3B
    db $91, $29, $40, $66, $A1, $62, $C6, $14, $D0, $79, $96, $2E, $61, $1C, $C0, $8E
    db $25, $1F, $88, $15, $07, $CA, $A5, $E5, $63, $A2, $B8, $01, $59, $6E, $00, $57
    db $F7, $A0, $16, $24, $0A, $DE, $45, $90, $22, $B1, $E9, $62, $1C, $AD, $E3, $50
    db $2D, $78, $95, $F1, $4A, $F6, $E5, $B0, $22, $DC, $59, $5D, $E8, $BB, $30, $5E
    db $73, $2C, $50, $17, $80, $CA, $FB, $65, $F2, $52, $ED, $C1, $58, $7C, $BC, $0A
    db $61, $3F, $2B, $A7, $97, $CF, $23, $85, $FC, $F2, $B8, $B1, $83, $70, $BF, $78
    db $65, $D0, $34, $9B, $1A, $26, $0C, $C2, $66, $1E, $B3, $0F, $C1, $7A, $D4, $B5
    db $02, $6C, $BF, $35, $32, $1B, $2A, $8C, $1D, $E6, $D3, $F3, $88, $69, $86, $F8
    db $C2, $FC, $69, $5F, $33, $86, $17, $50, $4C, $9B, $47, $47, $08, $99, $C4, $BC
    db $D5, $F8, $72, $BE, $3A, $D8, $97, $18, $4B, $5A, $87, $2F, $F3, $BA, $51, $95
    db $18, $FA, $24, $7C, $28, $88, $00, $00, $01, $01, $77, $02, $12, $00, $01, $01
    db $69, $0F, $9C, $00, $01, $01, $6F, $09, $A1, $00, $08, $08, $FF, $78, $00, $78
    db $00, $70, $09, $78, $09, $00, $09, $08, $09, $78, $00, $78, $00, $FF, $78, $00
    db $78, $00, $10, $09, $18, $09, $28, $00, $88, $0C, $78, $00, $78, $00, $FF, $78
    db $00, $78, $00, $20, $09, $A8, $09, $98, $08, $28, $09, $78, $00, $78, $00, $FF
    db $30, $09, $38, $09, $40, $09, $D0, $01, $C0, $16, $C8, $16, $D0, $16, $D8, $16
    db $FF, $E0, $16, $08, $01, $48, $01, $C0, $0E, $48, $01, $B8, $0A, $68, $0F, $B0
    db $0D, $FF, $E0, $16, $08, $01, $D8, $01, $D0, $01, $D8, $01, $E8, $16, $F0, $16
    db $F8, $16, $FF, $80, $16, $88, $16, $90, $16, $C0, $0E, $48, $01, $98, $16, $A0
    db $16, $A8, $16, $FF, $F8, $01, $F8, $01, $80, $16, $B0, $16, $B0, $16, $B8, $16
    db $F8, $01, $F8, $01, $01, $01, $01, $70, $00, $01, $01, $01, $70, $00, $70, $00
    db $00, $13, $39, $16, $3C, $01, $5C, $02, $1E, $01, $1B, $0A, $0F, $04, $0F, $05
    db $05, $00, $3B, $24, $3E, $21, $5D, $56, $1E, $11, $1F, $10, $0F, $00, $0F, $08
    db $07, $00, $00, $08, $99, $66, $FF, $40, $7C, $E7, $10, $92, $88, $C6, $D7, $BB
    db $FF, $00, $AB, $00, $FF, $10, $FF, $99, $7C, $BF, $F7, $18, $9A, $6D, $D7, $38
    db $FF, $00, $FF, $00, $F8, $00, $03, $00, $03, $00, $04, $F8, $03, $02, $03, $03
    db $04, $04, $F0, $08, $1D, $91, $B1, $00, $76, $00, $80, $F0, $FF, $00, $F7, $08
    db $76, $76, $80, $80, $03, $03, $03, $07, $04, $0F, $04, $0F, $02, $07, $08, $0F
    db $18, $1D, $02, $1F, $03, $03, $07, $04, $0F, $08, $0F, $08, $07, $04, $0F, $04
    db $1F, $04, $1F, $04, $81, $81, $BD, $FF, $6A, $FF, $66, $FF, $F3, $FF, $A1, $FF
    db $91, $FB, $85, $FF, $81, $81, $FF, $76, $FF, $34, $FF, $30, $FF, $20, $FF, $62
    db $FF, $62, $FF, $62, $10, $1D, $0A, $1B, $0A, $1F, $0B, $1F, $1A, $3F, $18, $3B
    db $30, $39, $38, $3B, $1D, $07, $1B, $15, $1F, $15, $1F, $14, $3F, $24, $3B, $26
    db $39, $06, $3B, $06, $50, $76, $52, $FB, $C3, $F3, $20, $F7, $24, $FF, $14, $FF
    db $08, $3C, $00, $1C, $7E, $A3, $FF, $A1, $FF, $20, $FF, $00, $FF, $00, $FF, $08
    db $FF, $10, $FF, $08, $40, $FE, $4A, $FE, $20, $7A, $0A, $BE, $00, $1A, $00, $0C
    db $08, $98, $00, $18, $EF, $94, $D7, $A8, $7B, $4C, $BF, $B0, $1B, $1C, $0F, $08
    db $9F, $90, $1F, $10, $01, $3F, $29, $3F, $02, $2F, $24, $3E, $08, $2D, $00, $18
    db $08, $0C, $00, $0C, $FB, $14, $F5, $0A, $EF, $19, $FE, $0A, $ED, $15, $F8, $08
    db $FC, $04, $FC, $04, $10, $3C, $14, $3F, $23, $7F, $24, $67, $20, $6C, $23, $7C
    db $13, $7D, $25, $7C, $3F, $28, $3F, $28, $7F, $44, $7F, $43, $7C, $47, $7F, $44
    db $7F, $64, $69, $56, $04, $1E, $14, $FE, $E0, $FE, $08, $FE, $02, $13, $E2, $5B
    db $E2, $3F, $44, $9F, $FE, $0A, $FE, $0A, $FE, $12, $FE, $E2, $1F, $F1, $FF, $11
    db $FF, $11, $DF, $33, $00, $01, $01, $02, $02, $07, $00, $07, $02, $07, $02, $07
    db $04, $0B, $08, $1F, $01, $01, $03, $02, $07, $05, $07, $06, $07, $04, $07, $04
    db $0F, $08, $1F, $10, $00, $C0, $00, $E0, $20, $F0, $00, $F0, $20, $F0, $20, $F0
    db $10, $F8, $08, $DC, $C0, $C0, $E0, $20, $F0, $D0, $F0, $30, $F0, $10, $F0, $10
    db $F8, $08, $FC, $04, $18, $3F, $12, $3F, $19, $3D, $18, $3F, $02, $4F, $08, $5B
    db $04, $7D, $38, $7E, $3F, $20, $3F, $20, $3F, $20, $3F, $20, $6F, $70, $7B, $74
    db $7D, $7A, $7F, $44, $0C, $FE, $04, $D6, $0C, $FE, $34, $E6, $92, $F7, $08, $ED
    db $10, $5F, $0E, $3F, $FE, $02, $FE, $02, $FE, $02, $F6, $0A, $F7, $0D, $EF, $17
    db $DF, $2F, $FF, $11, $00, $10, $BF, $1A, $BF, $36, $BE, $22, $BE, $36, $BF, $0B
    db $5F, $42, $5E, $5A, $7F, $00, $BF, $E0, $BF, $E0, $BF, $C8, $BF, $CC, $BF, $CE
    db $7F, $66, $7F, $66, $7F, $66, $00, $20, $FC, $32, $7E, $12, $7E, $52, $FE, $53
    db $7B, $13, $FF, $06, $FF, $65, $FF, $00, $FC, $03, $FE, $01, $FE, $21, $FE, $21
    db $FF, $20, $FF, $20, $FF, $21, $FF, $23, $C0, $72, $7F, $3C, $3F, $0E, $0F, $01
    db $03, $03, $03, $01, $01, $C0, $7F, $7C, $3F, $3C, $0F, $0C, $03, $02, $03, $02
    db $01, $01, $80, $63, $FF, $C3, $FF, $4B, $FF, $25, $FF, $A4, $BE, $1A, $3E, $18
    db $1C, $80, $FF, $27, $FF, $67, $FF, $E7, $FF, $C3, $BE, $82, $3E, $26, $1C, $1C
    db $00, $00, $00, $00, $00, $0B, $00, $06, $04, $0E, $1A, $1F, $07, $2F, $2E, $7E
    db $00, $00, $00, $00, $0B, $0B, $07, $04, $0F, $08, $1F, $00, $3F, $20, $7E, $41
    db $00, $02, $20, $3C, $A0, $F6, $40, $63, $82, $D6, $EA, $FF, $DC, $9F, $8B, $6F
    db $02, $02, $3C, $1C, $FE, $42, $FF, $01, $FF, $00, $FF, $00, $DF, $20, $EF, $30
    db $19, $7A, $52, $71, $E9, $E2, $79, $ED, $50, $C4, $40, $D8, $40, $C9, $40, $DF
    db $7B, $46, $73, $0C, $EB, $14, $FD, $86, $D7, $A8, $DF, $B0, $CF, $B0, $DF, $B0
    db $63, $83, $39, $C5, $11, $FB, $8E, $FC, $86, $CC, $04, $C4, $00, $E6, $00, $FC
    db $E3, $1C, $FD, $02, $FB, $0C, $FE, $01, $FE, $01, $FC, $03, $FE, $03, $FC, $03
    db $00, $05, $FF, $43, $EF, $C0, $CF, $25, $E7, $00, $B7, $65, $ED, $75, $7F, $E3
    db $FF, $00, $FF, $00, $FF, $04, $FF, $07, $FF, $C2, $BF, $A3, $FD, $E1, $7E, $E3
    db $FE, $65, $00, $A0, $F0, $00, $F0, $C0, $F0, $C0, $F0, $40, $F0, $00, $70, $C0
    db $F0, $80, $F0, $00, $F0, $10, $F0, $B0, $F0, $30, $F0, $30, $F0, $B0, $F0, $F0
    db $70, $B0, $30, $F0, $F8, $61, $EF, $F7, $FF, $00, $10, $F8, $FD, $E6, $FF, $E4
    db $10, $10, $FC, $40, $E0, $80, $C0, $FC, $60, $A0, $C0, $C0, $00, $00, $01, $00
    db $0E, $4C, $FF, $11, $9B, $20, $B1, $20, $EB, $BA, $EF, $E5, $F7, $00, $01, $01
    db $0E, $0E, $FF, $B3, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $F7, $08, $07, $00
    db $80, $80, $80, $00, $C0, $80, $A0, $30, $F0, $07, $80, $80, $80, $00, $C0, $40
    db $E0, $20, $F0, $00, $00, $D3, $2B, $68, $92, $C6, $31, $FC, $FE, $31, $33, $00
    db $31, $00, $79, $08, $FF, $00, $FB, $0C, $FA, $05, $F7, $08, $FE, $03, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $00, $80, $D0, $D0, $F8, $50, $78, $50, $78, $B0
    db $38, $30, $B8, $30, $70, $20, $F0, $00, $F0, $10, $F8, $08, $78, $88, $78, $88
    db $B8, $48, $B8, $C8, $70, $C0, $F0, $D0, $00, $6C, $FF, $69, $FF, $48, $FF, $09
    db $FF, $E1, $FB, $F1, $FF, $F5, $FF, $35, $3F, $00, $FF, $90, $FF, $90, $FF, $91
    db $FF, $90, $FF, $98, $FF, $F8, $FF, $F8, $3F, $38, $00, $90, $FF, $81, $DF, $86
    db $9F, $C8, $CF, $01, $ED, $47, $EF, $50, $FF, $E3, $F7, $00, $FF, $00, $FF, $08
    db $FF, $09, $FF, $06, $FE, $C7, $FF, $E2, $FF, $E3, $FF, $71, $F0, $28, $3F, $08
    db $1F, $17, $1F, $07, $07, $F0, $3F, $30, $1F, $10, $1F, $18, $07, $07, $F0, $FB
    db $FF, $FF, $FF, $32, $B2, $80, $80, $F0, $FF, $71, $FF, $7D, $B2, $B2, $80, $80
    db $03, $00, $08, $00, $07, $08, $1F, $1A, $3F, $65, $6F, $67, $7F, $03, $08, $08
    db $07, $07, $1F, $10, $3F, $20, $7F, $00, $7F, $00, $03, $00, $02, $90, $BC, $22
    db $73, $41, $EB, $7A, $EF, $F5, $F7, $03, $02, $02, $FC, $2C, $FF, $01, $FF, $00
    db $FF, $00, $F7, $08, $00, $4F, $FE, $58, $F9, $58, $FB, $5D, $F1, $7A, $F7, $70
    db $F2, $70, $F6, $6C, $FF, $00, $FF, $80, $F9, $86, $FB, $85, $FD, $82, $FF, $84
    db $F3, $8C, $F7, $8C, $FF, $90, $00, $5B, $23, $E9, $15, $C4, $F2, $1D, $FF, $11
    db $33, $00, $31, $00, $79, $00, $FF, $00, $7B, $84, $FD, $02, $F6, $09, $FF, $02
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $80, $FF, $89, $DF, $06, $9F, $14
    db $3F, $16, $DF, $45, $FF, $14, $BF, $05, $FF, $00, $FF, $00, $FF, $00, $FF, $89
    db $7F, $8B, $FF, $8F, $FF, $8E, $FF, $8E, $FF, $86, $00, $80, $C0, $80, $D0, $C0
    db $D0, $40, $D0, $C0, $D0, $00, $90, $10, $90, $90, $F0, $00, $C0, $70, $D0, $70
    db $D0, $30, $D0, $30, $D0, $30, $D0, $70, $F0, $70, $F0, $70, $80, $4C, $FF, $27
    db $FF, $57, $FF, $38, $F8, $30, $F0, $E0, $E0, $C0, $C0, $80, $FF, $07, $FF, $4F
    db $FF, $2F, $F8, $28, $F0, $30, $E0, $20, $C0, $C0, $FC, $F0, $F0, $E0, $E0, $FC
    db $F0, $F0, $E0, $E0, $01, $00, $82, $20, $7C, $40, $F6, $21, $63, $C2, $D6, $E4
    db $DF, $27, $57, $01, $82, $82, $FC, $5C, $FE, $02, $FF, $00, $FF, $00, $FF, $00
    db $77, $C8, $1F, $00, $80, $00, $C0, $00, $80, $1F, $80, $80, $C0, $40, $C0, $00
    db $00, $59, $25, $C8, $34, $84, $F2, $1C, $FE, $11, $33, $00, $31, $00, $79, $00
    db $FF, $00, $7D, $86, $FC, $03, $F6, $09, $FE, $03, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $00, $80, $E0, $80, $E0, $A0, $E0, $60, $70, $60, $70, $60, $F0, $60
    db $60, $40, $C0, $00, $E0, $20, $E0, $20, $E0, $00, $70, $90, $70, $90, $F0, $90
    db $60, $90, $C0, $B0, $00, $1A, $3B, $01, $3D, $04, $3F, $0C, $3F, $09, $3F, $02
    db $3F, $08, $38, $06, $3F, $00, $3B, $24, $3D, $36, $3F, $33, $3F, $33, $3F, $36
    db $3F, $3C, $3F, $36, $33, $3C, $00, $80, $BF, $11, $9F, $0E, $3F, $21, $7F, $62
    db $F7, $7A, $FF, $7A, $FB, $7C, $FF, $00, $FF, $00, $FF, $00, $FF, $11, $FF, $1E
    db $F7, $14, $FF, $3C, $FB, $3C, $FF, $38, $FC, $28, $3F, $10, $1C, $FC, $39, $37
    db $1C, $1C, $F8, $7B, $FF, $BF, $FF, $40, $C0, $F8, $FF, $3C, $FF, $7F, $C0, $C0
    db $03, $00, $0B, $02, $07, $04, $0F, $0D, $1F, $02, $17, $11, $3F, $03, $0B, $0B
    db $07, $04, $0F, $08, $1F, $10, $1F, $10, $3F, $20, $01, $00, $E1, $10, $3E, $22
    db $7B, $10, $B1, $21, $EB, $BA, $EF, $EF, $DF, $01, $E1, $E1, $FE, $2E, $FF, $01
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $27, $3F, $35, $7C, $28, $79, $26
    db $73, $2C, $75, $30, $76, $30, $32, $10, $3F, $00, $3F, $00, $7D, $42, $79, $46
    db $77, $49, $7D, $42, $77, $4C, $33, $0C, $3F, $2C, $00, $4D, $31, $68, $92, $8E
    db $30, $FD, $FF, $31, $33, $00, $31, $00, $79, $00, $FF, $00, $7D, $82, $FA, $05
    db $BE, $41, $FF, $02, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $14, $3F, $16
    db $3F, $1C, $3F, $00, $3F, $05, $3D, $09, $3F, $14, $3E, $1C, $3F, $00, $3F, $28
    db $3F, $28, $3F, $23, $3F, $33, $33, $3E, $3B, $36, $3F, $2A, $3F, $26, $00, $90
    db $DF, $9C, $9F, $0C, $3F, $26, $7F, $6A, $FF, $3A, $FF, $7A, $FF, $7E, $FF, $00
    db $FF, $00, $FF, $00, $FF, $12, $FF, $18, $FF, $1C, $FF, $1C, $FF, $3C, $FF, $38
    db $F8, $1C, $1F, $03, $03, $01, $01, $F8, $1F, $1E, $03, $02, $01, $01, $F0, $FC
    db $FF, $7C, $FF, $33, $37, $03, $03, $F0, $FF, $78, $FF, $F8, $37, $34, $03, $03
    db $03, $00, $05, $01, $03, $02, $07, $02, $0F, $01, $0B, $08, $0F, $03, $05, $05
    db $03, $02, $07, $04, $0F, $08, $0F, $08, $0F, $00, $03, $00, $E0, $08, $9F, $10
    db $B8, $88, $DD, $1D, $EF, $F7, $DF, $03, $E0, $E0, $FF, $17, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $00, $09, $1F, $0A, $1E, $14, $1C, $1E, $3B, $14, $31, $10
    db $3E, $10, $3A, $10, $3F, $00, $1F, $10, $1E, $11, $1C, $03, $3F, $21, $35, $2A
    db $3F, $2C, $3B, $2C, $3F, $2C, $00, $4A, $32, $AC, $51, $4C, $BE, $E3, $FF, $21
    db $33, $00, $31, $00, $79, $00, $FF, $00, $7A, $85, $FD, $02, $FE, $03, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $FF, $0F, $80, $C6, $C4, $E7, $18
    db $B9, $2C, $BC, $0F, $C6, $C6, $E7, $A3, $FF, $CD, $FA, $DD, $00, $02, $03, $03
    db $03, $06, $07, $75, $77, $78, $7B, $70, $7F, $30, $3F, $2F, $3F, $00, $03, $03
    db $03, $00, $07, $04, $77, $78, $5F, $50, $7F, $40, $3F, $00, $3F, $3A, $00, $08
    db $FA, $05, $1F, $01, $3F, $E3, $FF, $C3, $FF, $01, $FF, $01, $FF, $C3, $FF, $00
    db $FE, $85, $FF, $00, $FF, $00, $FF, $80, $7F, $C0, $FF, $00, $FF, $00, $FF, $00
    db $00, $40, $80, $20, $8C, $BC, $C7, $B6, $C6, $00, $EA, $00, $90, $00, $10, $E0
    db $E0, $00, $C0, $A0, $AC, $DC, $FF, $43, $F6, $49, $EA, $FE, $90, $F0, $10, $F0
    db $E0, $E0, $EF, $00, $80, $E7, $00, $80, $80, $C0, $FE, $FF, $FF, $FE, $FF, $FF
    db $FF, $FF, $00, $80, $D6, $C4, $FE, $04, $BE, $08, $7F, $22, $FC, $02, $E0, $42
    db $40, $FF, $81, $00, $FE, $83, $FE, $03, $FE, $03, $FF, $07, $FC, $1E, $E0, $FE
    db $40, $7E, $81, $FF, $00, $00, $7F, $20, $7F, $10, $7F, $08, $1D, $08, $1F, $11
    db $3F, $22, $3F, $83, $FF, $00, $7F, $C0, $7F, $C0, $7F, $E0, $1F, $10, $1F, $10
    db $3F, $20, $3F, $01, $FF, $C7, $F8, $FF, $FF, $FE, $FF, $FF, $FF, $F8, $FF, $FF
    db $FF, $FF, $FF, $FF, $F8, $87, $9F, $1E, $FE, $88, $F8, $F8, $FF, $0F, $FE, $0E
    db $F8, $F8, $FC, $12, $17, $0B, $0B, $FC, $1F, $01, $0B, $0F, $00, $7E, $FE, $29
    db $29, $21, $3F, $00, $07, $00, $0F, $00, $0F, $06, $0F, $09, $0F, $00, $FE, $81
    db $29, $57, $3F, $3E, $07, $04, $0F, $08, $0F, $08, $0F, $09, $0F, $0F, $FC, $03
    db $03, $0F, $0F, $FC, $03, $03, $0F, $0F, $FC, $FF, $FF, $FF, $FF, $FC, $FF, $FF
    db $FF, $FF, $03, $18, $3E, $22, $E7, $B9, $FF, $47, $CF, $80, $D2, $E0, $E6, $03
    db $3E, $26, $FF, $C1, $FF, $00, $FF, $00, $FE, $01, $FE, $01, $07, $00, $80, $80
    db $C0, $40, $E0, $A0, $E0, $40, $50, $07, $80, $80, $C0, $40, $E0, $20, $E0, $00
    db $50, $B0, $00, $C0, $DE, $01, $A3, $00, $BE, $61, $7F, $C1, $D7, $82, $AE, $82
    db $FE, $02, $3E, $00, $FE, $01, $FF, $80, $FE, $81, $7F, $80, $FF, $00, $FE, $01
    db $FE, $01, $7E, $81, $00, $B0, $BC, $2A, $2F, $CD, $CF, $5B, $5F, $51, $73, $80
    db $B6, $C1, $DD, $01, $3F, $00, $BC, $4C, $2F, $D1, $CF, $30, $5F, $A0, $7F, $A0
    db $BF, $60, $FF, $00, $3F, $C0, $00, $20, $D0, $00, $C0, $50, $66, $5E, $C3, $7B
    db $E3, $20, $B5, $00, $C0, $00, $C0, $00, $F0, $50, $C0, $70, $F6, $2E, $DF, $21
    db $FB, $24, $B5, $7F, $C0, $40, $C0, $40, $D7, $00, $80, $00, $40, $C7, $80, $80
    db $00, $C0, $40, $60, $F8, $3F, $FF, $20, $E0, $00, $80, $F8, $FF, $7F, $E0, $60
    db $80, $80, $FE, $80, $80, $FE, $80, $80, $00, $04, $7C, $00, $B0, $20, $F0, $20
    db $FF, $00, $E2, $08, $E9, $50, $C0, $3F, $E0, $00, $FC, $0B, $F0, $1F, $F0, $1F
    db $FF, $1F, $E2, $27, $E9, $2F, $C0, $1F, $E0, $7F, $00, $00, $7F, $10, $7F, $08
    db $FF, $04, $5F, $02, $C7, $02, $83, $00, $83, $FA, $FF, $00, $7F, $E0, $7F, $E0
    db $FF, $F0, $5F, $D8, $C7, $C4, $83, $80, $83, $82, $FF, $FC, $F8, $FF, $FF, $FF
    db $FF, $FF, $FF, $F8, $FF, $7F, $FF, $FF, $FF, $FF, $F8, $FC, $FC, $F0, $FF, $FC
    db $FF, $F8, $FF, $F8, $FF, $F8, $FF, $FF, $FC, $24, $2F, $16, $16, $FC, $3F, $03
    db $16, $1E, $00, $FC, $FD, $52, $53, $4C, $7F, $02, $03, $00, $07, $00, $07, $04
    db $0F, $28, $3E, $00, $FD, $02, $53, $AE, $7F, $7E, $03, $00, $07, $04, $07, $04
    db $0F, $08, $3F, $30, $FC, $07, $07, $1F, $1F, $FC, $07, $07, $1F, $1F, $F8, $C0
    db $F9, $D1, $FE, $1F, $1F, $F8, $FF, $E0, $FF, $E0, $1F, $1F, $07, $20, $7C, $E4
    db $EE, $92, $9F, $0F, $AF, $03, $53, $07, $7C, $5C, $FE, $02, $FF, $01, $FF, $00
    db $FB, $04, $3F, $00, $80, $40, $E0, $3F, $80, $80, $E0, $20, $00, $84, $BC, $05
    db $0D, $87, $FF, $0C, $3C, $0A, $FA, $0C, $FC, $0A, $FA, $00, $B8, $00, $FC, $03
    db $FD, $02, $FF, $00, $FC, $03, $FA, $05, $FC, $03, $FA, $05, $F8, $0F, $00, $C4
    db $DF, $AB, $AF, $11, $13, $70, $73, $00, $35, $A0, $BF, $00, $37, $40, $7F, $00
    db $DF, $3B, $AF, $50, $1F, $E0, $7F, $80, $3F, $E0, $BF, $40, $3F, $E0, $7F, $A0
    db $1F, $00, $03, $03, $07, $01, $01, $1F, $03, $03, $07, $04, $01, $01, $0F, $00
    db $01, $00, $BF, $23, $77, $5B, $7B, $0F, $01, $01, $BF, $BE, $FF, $C0, $F7, $B8
    db $00, $04, $07, $06, $06, $0C, $0E, $EB, $EF, $F1, $F7, $E0, $FF, $60, $7F, $5F
    db $7F, $00, $07, $07, $07, $00, $0F, $08, $EF, $F1, $BE, $A1, $FF, $80, $7F, $00
    db $7F, $74, $00, $11, $F5, $0B, $3F, $03, $7F, $C7, $FF, $86, $FE, $03, $FF, $02
    db $FF, $86, $FE, $00, $FD, $0A, $FF, $00, $FF, $00, $FF, $00, $FF, $80, $FF, $00
    db $FF, $00, $FF, $00, $FF, $FF, $7C, $41, $7F, $00, $01, $07, $07, $7C, $7F, $7E
    db $01, $01, $07, $06, $FC, $03, $03, $0F, $0F, $FC, $03, $03, $0F, $0F, $F8, $FE
    db $FF, $FE, $FF, $03, $03, $F8, $FF, $FC, $FF, $FC, $03, $03, $00, $00, $E6, $00
    db $F7, $0E, $D3, $8B, $F3, $80, $F5, $00, $F0, $00, $70, $40, $F0, $00, $E6, $3E
    db $F7, $1F, $FF, $01, $FB, $04, $F5, $1F, $F0, $90, $70, $10, $F0, $80, $E9, $00
    db $80, $00, $80, $00, $40, $E1, $80, $80, $80, $C0, $00, $E0, $40, $60, $F8, $87
    db $9F, $00, $F8, $80, $F0, $F8, $FF, $0F, $F8, $08, $F0, $F0, $FF, $FF, $00, $80
    db $FE, $C0, $FE, $45, $FF, $40, $FF, $40, $FD, $40, $FD, $88, $FE, $8F, $DF, $00
    db $FE, $03, $FE, $03, $FF, $82, $FF, $87, $FD, $87, $FD, $87, $FE, $06, $FF, $07
    db $40, $10, $3F, $08, $7F, $04, $EF, $01, $03, $00, $15, $00, $18, $FE, $FE, $40
    db $3F, $E0, $7F, $F0, $EF, $F8, $03, $1E, $15, $1D, $18, $18, $FE, $FE, $F8, $1F
    db $3F, $3F, $DF, $FF, $FF, $F8, $FF, $0F, $FF, $1F, $FF, $FF, $F8, $FF, $FF, $FE
    db $FF, $FF, $FF, $F8, $FF, $FF, $FF, $FF, $FF, $FF, $01, $18, $7E, $C2, $CF, $81
    db $D3, $00, $A7, $81, $CF, $C3, $C7, $83, $BF, $01, $7E, $66, $FF, $01, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $07, $00, $80, $C0, $C0, $40, $E0, $40
    db $50, $30, $3C, $07, $80, $80, $C0, $00, $E0, $20, $50, $B0, $3C, $CC, $00, $E2
    db $EA, $43, $D7, $06, $BE, $47, $6F, $06, $FE, $0E, $9E, $82, $BE, $84, $DE, $00
    db $FE, $01, $FF, $80, $FE, $81, $7F, $80, $FE, $81, $FE, $81, $FE, $05, $FE, $03
    db $00, $58, $5F, $5D, $5F, $F1, $F3, $00, $33, $80, $BD, $80, $B7, $40, $7F, $00
    db $3F, $00, $5F, $A3, $5F, $A0, $FF, $00, $3F, $E0, $BF, $60, $BF, $60, $7F, $A0
    db $3F, $E0, $03, $01, $01, $01, $01, $00, $01, $00, $01, $04, $07, $06, $06, $03
    db $01, $01, $01, $01, $01, $01, $01, $01, $07, $07, $07, $00, $03, $00, $8D, $88
    db $CF, $31, $73, $59, $79, $10, $F5, $0A, $3F, $03, $8D, $8D, $CF, $46, $FF, $9A
    db $F5, $BA, $FD, $0B, $FF, $01, $00, $0C, $0E, $EB, $EF, $F1, $F7, $E0, $FF, $60
    db $7F, $5F, $7F, $24, $2F, $16, $16, $00, $0F, $08, $EF, $F1, $BE, $A1, $FF, $80
    db $7F, $00, $7F, $74, $3F, $03, $16, $1E, $00, $02, $7F, $C6, $FE, $87, $FF, $03
    db $FF, $03, $FF, $86, $FE, $FD, $FD, $53, $53, $00, $FF, $01, $FE, $01, $FF, $80
    db $FF, $00, $FF, $00, $FE, $01, $FD, $03, $53, $AE, $00, $4F, $C1, $45, $E1, $00
    db $FA, $0C, $EC, $80, $FC, $40, $FC, $00, $3C, $C2, $FE, $00, $CF, $30, $E5, $3A
    db $FA, $1F, $FC, $00, $FC, $04, $FC, $84, $3C, $24, $FE, $E2, $F8, $00, $C0, $80
    db $80, $00, $A0, $F8, $C0, $C0, $80, $60, $A0, $B0, $F8, $E3, $E7, $87, $FF, $E0
    db $FC, $F8, $FF, $C3, $FF, $C3, $FC, $FC, $FD, $80, $80, $FD, $80, $80, $00, $40
    db $EF, $60, $FF, $30, $7F, $04, $FF, $00, $47, $00, $87, $04, $07, $FC, $FC, $00
    db $FF, $80, $FF, $80, $7F, $C8, $FF, $F8, $47, $C4, $87, $84, $07, $00, $FF, $F0
    db $00, $18, $BF, $88, $FF, $04, $FF, $02, $EF, $41, $F7, $40, $ED, $20, $E8, $77
    db $EF, $00, $BF, $E0, $FF, $70, $FF, $38, $EF, $3C, $F7, $3E, $ED, $3D, $E8, $38
    db $EF, $3F, $F8, $F0, $F9, $F1, $FE, $FF, $FF, $F8, $FF, $E0, $FF, $E0, $FF, $FF
    db $F8, $FF, $FF, $FF, $FF, $FF, $FF, $F8, $FF, $7F, $FF, $7F, $FF, $FF, $FC, $24
    db $2F, $16, $16, $FC, $3F, $03, $16, $1E, $40, $FC, $FD, $51, $53, $42, $7F, $00
    db $06, $00, $04, $00, $07, $1F, $1F, $40, $FD, $03, $53, $AF, $7F, $7F, $06, $07
    db $04, $07, $07, $07, $1F, $1F, $FC, $07, $07, $1F, $1F, $FC, $07, $07, $1F, $1F
    db $F8, $FF, $FF, $FF, $FF, $03, $03, $F8, $FF, $FF, $FF, $FF, $03, $03, $03, $00
    db $3C, $24, $FE, $C1, $CF, $80, $D3, $81, $A7, $83, $D7, $03, $3C, $3C, $FE, $C2
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $1F, $80, $80, $80, $C0, $C0, $E0, $1F
    db $80, $00, $C0, $40, $E0, $20, $00, $C0, $C2, $81, $B7, $E2, $FE, $42, $E6, $41
    db $DF, $63, $77, $40, $FE, $41, $C7, $00, $FE, $01, $FF, $00, $FE, $01, $FE, $81
    db $FF, $80, $7F, $80, $FE, $81, $FF, $80, $00, $A0, $B0, $70, $7E, $9E, $9F, $C9
    db $EB, $00, $13, $40, $5D, $80, $97, $00, $1F, $00, $B0, $50, $7E, $8E, $9F, $61
    db $EF, $30, $1F, $F0, $5F, $B0, $9F, $70, $1F, $F0, $0F, $01, $01, $01, $01, $00
    db $01, $00, $01, $0F, $01, $01, $01, $01, $01, $01, $01, $01, $0F, $00, $8D, $88
    db $CF, $31, $73, $58, $79, $0F, $8D, $8D, $CF, $46, $FF, $9A, $F5, $BB, $00, $04
    db $07, $06, $06, $0C, $0E, $EB, $EF, $F1, $F7, $E0, $FF, $60, $7F, $5F, $7F, $00
    db $07, $07, $07, $00, $0F, $08, $EF, $F1, $BE, $A1, $FF, $80, $7F, $00, $7F, $74
    db $00, $10, $F5, $0A, $3F, $02, $7F, $C6, $FE, $87, $FF, $03, $FF, $03, $FF, $86
    db $FE, $00, $FD, $0B, $FF, $01, $FF, $01, $FE, $01, $FF, $80, $FF, $00, $FF, $00
    db $FE, $01, $00, $18, $C3, $0F, $C1, $4D, $F1, $00, $CA, $40, $E0, $00, $E0, $20
    db $E0, $FE, $FE, $00, $DB, $27, $CF, $30, $FD, $32, $CA, $4F, $E0, $20, $E0, $20
    db $E0, $20, $FE, $3E, $F1, $00, $C0, $80, $80, $00, $A0, $F1, $C0, $C0, $80, $60
    db $A0, $B0, $FC, $3F, $FF, $E0, $E0, $FC, $FF, $FF, $E0, $E0, $FF, $FF, $00, $D8
    db $DD, $2C, $EF, $66, $FF, $02, $87, $02, $83, $00, $03, $03, $03, $FE, $FF, $00
    db $DF, $20, $EF, $D0, $FF, $F8, $87, $84, $83, $80, $03, $02, $03, $02, $FF, $FC
    db $00, $08, $EF, $3A, $F3, $1E, $FB, $20, $FF, $20, $F7, $20, $F7, $19, $FF, $1E
    db $3F, $00, $EF, $10, $F3, $1C, $FB, $1C, $FF, $1E, $F7, $16, $F7, $16, $FF, $0E
    db $FF, $0F, $F8, $F8, $FE, $FC, $FF, $FF, $FF, $F8, $FF, $F8, $FF, $F8, $FF, $FF
    db $F8, $3F, $7F, $7F, $BF, $FC, $FC, $F8, $FF, $1F, $FF, $1F, $FC, $FC, $FE, $0B
    db $0B, $FE, $0B, $0F, $00, $28, $29, $20, $3F, $00, $18, $00, $11, $08, $1A, $10
    db $33, $32, $76, $0F, $7F, $00, $29, $57, $3F, $3F, $18, $1F, $11, $1F, $1A, $17
    db $33, $2F, $76, $4E, $7F, $7F, $FC, $03, $03, $0F, $0F, $FC, $03, $03, $0F, $0F
    db $F8, $FF, $FF, $FF, $FF, $03, $03, $F8, $FF, $FF, $FF, $FF, $03, $03, $03, $00
    db $70, $38, $FE, $23, $67, $41, $E9, $C1, $D3, $60, $FB, $03, $70, $70, $FE, $86
    db $FF, $00, $FF, $00, $FF, $00, $FF, $80, $0F, $00, $80, $80, $C0, $80, $A0, $20
    db $30, $0F, $80, $80, $C0, $40, $A0, $60, $30, $D0, $00, $41, $E1, $40, $D7, $30
    db $7F, $A0, $F5, $A0, $AB, $A0, $FF, $10, $5F, $10, $98, $00, $FF, $80, $FF, $80
    db $7F, $C0, $FF, $40, $BF, $40, $FF, $40, $5F, $E0, $9F, $E0, $00, $88, $8E, $32
    db $3F, $1B, $1F, $11, $33, $00, $3D, $00, $AF, $81, $FF, $50, $FF, $00, $8E, $76
    db $3F, $C1, $1F, $E0, $3F, $E0, $3F, $E0, $BF, $E0, $FF, $60, $FF, $20, $4F, $00
    db $01, $01, $03, $02, $03, $4F, $01, $01, $03, $02, $03, $03, $0F, $01, $DF, $92
    db $BB, $AC, $BF, $08, $FA, $0F, $DF, $DE, $FF, $61, $FB, $DD, $FE, $85, $00, $03
    db $03, $06, $07, $75, $77, $78, $7B, $70, $7F, $30, $3F, $2F, $3F, $12, $17, $00
    db $03, $00, $07, $04, $77, $78, $5F, $50, $7F, $40, $3F, $00, $3F, $3A, $1F, $01
    db $00, $05, $1F, $01, $3F, $E3, $FF, $C3, $FF, $01, $FF, $01, $FF, $C3, $FF, $7E
    db $FE, $00, $FF, $00, $FF, $00, $FF, $80, $7F, $C0, $FF, $00, $FF, $00, $FF, $00
    db $FE, $81, $FF, $FF, $08, $40, $7F, $00, $03, $00, $02, $00, $04, $00, $08, $00
    db $10, $00, $1F, $00, $7F, $7F, $03, $03, $02, $03, $00, $03, $04, $07, $08, $0F
    db $10, $1F, $1F, $1F, $FC, $01, $01, $07, $07, $FC, $01, $01, $07, $07, $F8, $FF
    db $FF, $FF, $FF, $01, $01, $F8, $FF, $FF, $FF, $FF, $01, $01, $00, $80, $D0, $00
    db $40, $10, $E6, $6E, $E3, $AB, $F3, $40, $C5, $80, $80, $C0, $C0, $00, $D0, $70
    db $C0, $78, $F6, $2E, $EF, $31, $FB, $74, $C5, $CF, $80, $80, $C0, $C0, $D7, $00
    db $80, $00, $40, $C7, $80, $80, $00, $C0, $40, $60, $FC, $FF, $FF, $FF, $FF, $FC
    db $FF, $FF, $FF, $FF, $FC, $C0, $C0, $80, $80, $FC, $C0, $C0, $80, $80, $00, $11
    db $FF, $09, $7F, $09, $7F, $08, $7F, $00, $5F, $00, $4F, $40, $C3, $7E, $FF, $00
    db $FF, $E8, $7F, $F0, $7F, $F0, $7F, $F0, $5F, $D8, $4F, $CC, $C3, $C2, $FF, $FF
    db $00, $51, $FF, $0C, $DF, $01, $87, $86, $C7, $40, $EF, $09, $EF, $06, $EF, $D9
    db $FF, $00, $FF, $A0, $DF, $D0, $87, $86, $C7, $40, $EF, $28, $EF, $20, $EF, $29
    db $FF, $3F, $F8, $FF, $FF, $FF, $FF, $FF, $FF, $F8, $FF, $FF, $FF, $FF, $FF, $FF
    db $F8, $FF, $FF, $FF, $FF, $E0, $E0, $F8, $FF, $FF, $FF, $FF, $E0, $E0, $01, $00
    db $78, $08, $9C, $3C, $7E, $C3, $CF, $81, $A7, $C1, $D5, $81, $A3, $01, $78, $78
    db $FC, $84, $FE, $02, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $0F, $00, $C0, $40
    db $60, $20, $30, $50, $5C, $0F, $C0, $C0, $60, $A0, $30, $D0, $5C, $AC, $00, $61
    db $7F, $41, $FF, $43, $D3, $42, $6E, $00, $BF, $20, $B3, $20, $39, $38, $FF, $00
    db $7F, $80, $FF, $80, $FF, $80, $7E, $81, $BF, $C1, $BF, $C0, $3F, $C0, $FF, $C0
    db $00, $9A, $9F, $6D, $6F, $AB, $AF, $90, $99, $50, $5E, $40, $CF, $20, $BF, $01
    db $9F, $00, $9F, $61, $6F, $90, $AF, $50, $9F, $60, $5F, $A0, $DF, $A0, $BF, $C0
    db $9F, $E0, $03, $01, $01, $01, $01, $00, $01, $00, $01, $04, $07, $06, $06, $03
    db $01, $01, $01, $01, $01, $01, $01, $01, $07, $07, $07, $00, $03, $00, $8C, $89
    db $CF, $31, $73, $59, $79, $10, $F4, $0A, $3F, $03, $8C, $8C, $CF, $46, $FF, $9A
    db $F5, $BA, $FC, $0B, $FF, $01, $00, $0C, $0E, $EB, $EF, $F1, $F7, $E0, $FF, $60
    db $7F, $5F, $7F, $24, $2F, $16, $16, $00, $0F, $08, $EF, $F1, $BE, $A1, $FF, $80
    db $7F, $00, $7F, $74, $3F, $03, $16, $1E, $00, $02, $7F, $C6, $FE, $87, $FF, $03
    db $FF, $03, $FF, $86, $FE, $FD, $FD, $50, $53, $00, $FF, $01, $FE, $01, $FF, $80
    db $FF, $00, $FF, $00, $FE, $01, $FD, $03, $53, $AF, $FF, $FF, $03, $00, $01, $01
    db $01, $03, $03, $03, $03, $04, $05, $06, $07, $03, $01, $01, $01, $01, $03, $02
    db $03, $02, $05, $06, $07, $04, $03, $02, $03, $03, $03, $02, $02, $05, $05, $0C
    db $0F, $08, $0B, $03, $03, $03, $03, $02, $03, $03, $07, $06, $0F, $08, $0F, $00
    db $00, $0B, $0B, $17, $D7, $9E, $FE, $83, $93, $C5, $CD, $D3, $FB, $12, $F6, $0D
    db $FF, $00, $0B, $0C, $D7, $D8, $FE, $31, $F3, $DC, $AD, $DA, $FB, $0C, $F6, $0D
    db $FF, $02, $00, $18, $19, $CE, $DF, $C7, $E7, $E0, $EF, $E0, $FF, $23, $3F, $5E
    db $5F, $2D, $2D, $00, $1F, $10, $DF, $E4, $FB, $C6, $BF, $A0, $FF, $A0, $3F, $40
    db $5F, $61, $2D, $33, $00, $0C, $FD, $04, $FE, $04, $FC, $0A, $FB, $3E, $FF, $FA
    db $FB, $26, $AE, $24, $37, $00, $FD, $03, $FE, $03, $FC, $03, $FB, $07, $FF, $07
    db $FB, $07, $AE, $DF, $37, $37, $FC, $1F, $1F, $07, $07, $FC, $1F, $1F, $07, $07
    db $FC, $FF, $FF, $FF, $FF, $FC, $FF, $FF, $FF, $FF, $FF, $FF, $1F, $01, $01, $03
    db $03, $06, $07, $1F, $01, $01, $03, $02, $07, $04, $03, $01, $01, $01, $01, $01
    db $01, $02, $02, $06, $07, $04, $05, $03, $01, $01, $01, $01, $01, $01, $03, $03
    db $07, $04, $07, $00, $00, $06, $07, $0F, $6F, $4F, $FF, $C4, $CC, $62, $66, $E9
    db $FD, $08, $FA, $06, $FF, $00, $07, $04, $6F, $60, $FF, $90, $FC, $6B, $D6, $ED
    db $FD, $06, $FA, $07, $FF, $01, $00, $0C, $0C, $0F, $0F, $0B, $0B, $10, $1F, $20
    db $3F, $71, $7F, $6F, $6F, $76, $76, $00, $0F, $08, $0F, $0A, $0D, $13, $1F, $00
    db $3F, $20, $7F, $60, $4F, $50, $76, $79, $00, $06, $FE, $02, $FF, $83, $FF, $04
    db $FF, $18, $FF, $F8, $FF, $13, $D7, $94, $9F, $00, $FE, $01, $FF, $01, $FF, $01
    db $FF, $02, $FF, $04, $FF, $04, $D7, $EC, $9F, $9F, $FC, $0F, $0F, $07, $07, $FC
    db $0F, $0F, $07, $07, $FC, $FF, $FF, $FF, $FF, $FC, $FF, $FF, $FF, $FF, $FF, $FF
    db $1F, $00, $01, $03, $03, $06, $07, $1F, $01, $01, $03, $02, $07, $04, $03, $04
    db $06, $04, $07, $04, $05, $05, $05, $08, $0E, $00, $01, $03, $06, $06, $07, $05
    db $07, $06, $07, $06, $0F, $0C, $07, $08, $00, $06, $07, $0E, $6F, $4F, $7F, $41
    db $49, $E2, $E6, $68, $FC, $08, $FA, $06, $FF, $00, $07, $00, $6F, $68, $7F, $18
    db $79, $6E, $D6, $ED, $FC, $07, $FA, $07, $FF, $01, $00, $08, $0C, $0F, $0F, $C3
    db $E7, $E0, $EF, $E0, $FF, $21, $3F, $7E, $7F, $2D, $2D, $00, $0F, $00, $0F, $12
    db $FD, $C3, $BF, $A0, $FF, $A0, $3F, $40, $7F, $41, $2D, $33, $00, $06, $FE, $02
    db $FF, $82, $FE, $05, $FD, $1E, $FF, $FA, $FB, $27, $AF, $2F, $3F, $00, $FE, $01
    db $FF, $01, $FE, $01, $FD, $03, $FF, $03, $FB, $07, $AF, $DE, $3F, $3C, $FC, $1F
    db $1F, $0F, $0F, $FC, $1F, $1F, $0F, $0F, $F8, $FC, $FE, $FC, $FF, $0F, $0F, $F8
    db $FF, $F8, $FF, $F8, $0F, $0F, $FF, $FF, $07, $00, $01, $01, $01, $03, $03, $06
    db $07, $06, $07, $07, $01, $01, $01, $01, $03, $02, $07, $04, $07, $04, $03, $04
    db $06, $04, $07, $04, $05, $06, $07, $0C, $0E, $18, $1C, $03, $06, $06, $07, $05
    db $07, $06, $07, $00, $0F, $08, $1F, $10, $00, $0F, $0F, $0F, $3F, $22, $3A, $21
    db $25, $F0, $F0, $34, $FC, $06, $7F, $03, $7F, $00, $0F, $08, $3F, $38, $3A, $0D
    db $3D, $36, $E8, $F7, $FC, $03, $FF, $01, $FF, $00, $00, $1C, $1E, $1F, $1F, $11
    db $1B, $20, $3F, $60, $7F, $F0, $FF, $FE, $FF, $DD, $DD, $00, $1F, $18, $0F, $19
    db $1E, $01, $3F, $00, $7F, $40, $FF, $E0, $BF, $A1, $DD, $E3, $00, $03, $3F, $81
    db $FF, $C1, $FF, $02, $FE, $0E, $FF, $FA, $FB, $26, $AE, $2F, $3F, $00, $FF, $00
    db $FF, $00, $FF, $80, $FE, $01, $FF, $03, $FB, $07, $AE, $DE, $3F, $3F, $FC, $7F
    db $7F, $1F, $1F, $FC, $7F, $7F, $1F, $1F, $F8, $FF, $FF, $FF, $FF, $01, $01, $F8
    db $FF, $FF, $FF, $FE, $01, $01, $FF, $FF, $1F, $00, $01, $03, $03, $07, $07, $1F
    db $01, $01, $03, $02, $07, $04, $03, $02, $03, $02, $03, $02, $02, $03, $03, $06
    db $07, $0C, $0E, $03, $03, $03, $03, $02, $03, $03, $03, $00, $07, $04, $0F, $08
    db $00, $07, $07, $07, $1F, $13, $1F, $11, $93, $78, $F8, $1A, $FE, $03, $3F, $01
    db $3F, $00, $07, $04, $1F, $1C, $1F, $04, $9F, $9A, $F4, $7B, $FE, $01, $FF, $00
    db $FF, $00, $00, $0E, $0F, $0F, $0F, $70, $71, $78, $7B, $78, $7F, $38, $3F, $2F
    db $2F, $16, $16, $00, $0F, $0C, $0F, $04, $7F, $70, $6F, $68, $7F, $68, $3F, $20
    db $2F, $30, $16, $19, $00, $01, $1F, $C0, $FF, $E0, $FF, $01, $FF, $07, $FF, $7D
    db $FD, $12, $D6, $97, $9F, $00, $FF, $00, $FF, $80, $7F, $C0, $FF, $00, $FF, $01
    db $FD, $03, $D6, $EE, $9F, $9F, $FC, $0F, $0F, $07, $07, $FC, $0F, $0F, $07, $07
    db $F8, $FF, $FF, $FF, $FF, $01, $01, $F8, $FF, $FF, $FF, $FF, $01, $01, $FF, $FF
    db $0F, $01, $01, $03, $03, $07, $07, $06, $07, $0F, $01, $01, $03, $02, $07, $04
    db $07, $04, $03, $04, $06, $04, $07, $04, $05, $05, $05, $08, $0E, $08, $09, $03
    db $06, $06, $07, $05, $07, $06, $07, $06, $0F, $0C, $0F, $00, $00, $0F, $0F, $1F
    db $7F, $4F, $7F, $45, $4D, $E2, $E6, $69, $FD, $08, $FA, $06, $FF, $00, $0F, $08
    db $7F, $70, $7F, $10, $7D, $6A, $D6, $ED, $FD, $06, $FA, $07, $FF, $01, $00, $18
    db $1C, $1F, $1F, $13, $17, $20, $3F, $40, $7F, $E1, $FF, $DE, $DF, $ED, $ED, $00
    db $1F, $10, $1F, $12, $1D, $23, $3F, $00, $7F, $40, $FF, $C0, $9F, $A1, $ED, $F3
    db $00, $06, $FE, $02, $FF, $82, $FE, $05, $FD, $1E, $FF, $FA, $FB, $27, $AF, $27
    db $3F, $00, $FE, $01, $FF, $01, $FE, $01, $FD, $03, $FF, $03, $FB, $07, $AF, $DF
    db $3F, $3F, $FC, $1F, $1F, $07, $07, $FC, $1F, $1F, $07, $07, $F8, $FF, $FF, $FF
    db $FF, $01, $01, $F8, $FF, $FF, $FF, $FF, $01, $01, $41, $7B, $46, $7F, $28, $3B
    db $01, $19, $26, $2F, $03, $2F, $23, $2F, $23, $3F, $7B, $0C, $7F, $08, $3B, $06
    db $19, $26, $3F, $01, $3F, $01, $3F, $01, $3F, $01, $66, $7E, $66, $FF, $42, $E7
    db $DB, $FF, $34, $FF, $18, $FF, $DA, $FF, $E2, $E6, $3C, $E7, $FF, $00, $FF, $00
    db $EF, $2C, $FF, $99, $FF, $81, $FF, $BD, $FE, $C3, $22, $2F, $02, $37, $12, $3E
    db $11, $39, $0A, $5F, $02, $72, $00, $3F, $00, $0F, $3F, $01, $3F, $21, $3E, $21
    db $3F, $20, $7F, $40, $7F, $50, $3F, $32, $0F, $0F, $FF, $FF, $FF, $FF, $7F, $FF
    db $7F, $7F, $BF, $FF, $BF, $FF, $BE, $FE, $98, $98, $FF, $FF, $FF, $FF, $FF, $FF
    db $7F, $FF, $FF, $7F, $FF, $7F, $FE, $7E, $98, $98, $00, $00, $00, $00, $01, $01
    db $00, $02, $00, $04, $01, $07, $0E, $0E, $00, $1B, $00, $00, $00, $01, $01, $00
    db $02, $03, $04, $07, $07, $06, $0F, $00, $1F, $10, $00, $FE, $EE, $FE, $C0, $CE
    db $2B, $2B, $00, $E2, $88, $DE, $18, $5D, $1A, $BF, $FE, $FE, $FE, $11, $CE, $3F
    db $2B, $D4, $E7, $F8, $FF, $00, $FF, $00, $FF, $00, $02, $1F, $00, $2F, $0F, $2F
    db $21, $3B, $02, $73, $02, $7F, $04, $7F, $06, $7E, $1F, $05, $3F, $28, $3E, $21
    db $3B, $04, $7B, $44, $7F, $44, $7F, $48, $7E, $49, $46, $EF, $BD, $FF, $04, $FB
    db $00, $C3, $00, $81, $00, $99, $00, $FF, $6E, $7E, $EF, $B9, $FF, $66, $FF, $42
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $7E, $C3, $00, $42, $E7, $DB, $FF, $34
    db $FF, $18, $FF, $5A, $7F, $22, $67, $3E, $7E, $7F, $FF, $00, $FF, $00, $EF, $2C
    db $FF, $99, $FF, $81, $7F, $BD, $7F, $C3, $7E, $FE, $FF, $FF, $00, $14, $FE, $FC
    db $FE, $7C, $FE, $78, $FC, $78, $FC, $08, $FC, $70, $F8, $00, $70, $00, $FE, $62
    db $FE, $02, $FE, $82, $FC, $84, $FC, $84, $FC, $F4, $F8, $88, $70, $70, $80, $7F
    db $7F, $BF, $FF, $BF, $FF, $BF, $FF, $FF, $FF, $7E, $7E, $18, $18, $80, $7F, $FF
    db $FF, $7F, $FF, $7F, $FF, $7F, $FF, $FF, $7E, $7E, $18, $18, $E0, $80, $80, $80
    db $80, $E0, $E0, $F0, $F0, $80, $80, $E0, $80, $80, $80, $80, $E0, $E0, $F0, $F0
    db $80, $80, $00, $FE, $D6, $D6, $E1, $F1, $0F, $EF, $98, $DC, $20, $F5, $46, $EF
    db $BD, $FF, $FE, $FE, $D6, $29, $F1, $1E, $EF, $F0, $FF, $00, $FF, $81, $EF, $B9
    db $FF, $66, $00, $00, $00, $00, $00, $80, $00, $C0, $40, $F0, $80, $E8, $00, $EC
    db $44, $F4, $00, $00, $00, $00, $80, $80, $C0, $C0, $F0, $30, $F8, $48, $FC, $44
    db $FC, $00, $04, $FB, $00, $C3, $00, $81, $00, $99, $00, $FF, $6E, $7E, $66, $7E
    db $66, $FF, $FF, $42, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $7E, $C3, $3C, $E7
    db $FF, $00, $84, $FC, $A0, $EE, $40, $CE, $40, $FE, $00, $DE, $62, $7E, $80, $DE
    db $60, $FE, $7C, $A0, $FE, $02, $DE, $22, $FE, $22, $DE, $32, $7E, $90, $DE, $32
    db $FE, $12, $00, $26, $2F, $18, $3B, $1D, $1D, $14, $15, $16, $16, $08, $1D, $0A
    db $1F, $11, $39, $00, $2F, $38, $3B, $26, $1D, $02, $15, $0B, $16, $09, $1D, $13
    db $1F, $11, $3F, $20, $00, $66, $FF, $42, $E7, $DB, $FF, $34, $FF, $18, $FF, $5A
    db $FE, $20, $E7, $7F, $7F, $00, $FF, $00, $FF, $00, $EF, $2C, $FF, $99, $FF, $81
    db $FE, $BD, $FF, $C3, $7F, $FF, $E0, $0A, $5F, $02, $72, $00, $3F, $00, $0F, $03
    db $03, $E0, $7F, $40, $7F, $50, $3F, $32, $0F, $0F, $03, $03, $80, $BF, $FF, $BF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $18, $18, $80, $FF, $7F, $FF, $7F
    db $FF, $7F, $FF, $FF, $FF, $FF, $FF, $FF, $18, $18, $00, $00, $00, $00, $01, $01
    db $02, $03, $00, $02, $00, $0F, $00, $0B, $00, $1B, $00, $00, $00, $01, $01, $02
    db $03, $00, $03, $04, $0F, $0C, $0F, $0B, $1F, $12, $00, $7F, $E7, $E7, $81, $81
    db $0A, $AF, $10, $54, $20, $7B, $3A, $BF, $46, $EF, $7F, $7F, $E7, $18, $81, $7E
    db $EF, $11, $F7, $08, $FF, $00, $FF, $00, $EF, $B9, $12, $1B, $01, $1F, $11, $33
    db $12, $3B, $12, $3F, $1C, $3F, $16, $3E, $11, $3B, $1F, $00, $1E, $11, $3B, $24
    db $3B, $24, $3F, $24, $3F, $28, $3E, $29, $3B, $2C, $BD, $FF, $04, $FB, $00, $C3
    db $00, $81, $00, $99, $00, $FF, $6E, $7E, $66, $7E, $FF, $66, $FF, $42, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $7E, $C3, $3C, $E7, $66, $7E, $66, $FF, $42, $E7
    db $DB, $FF, $34, $FF, $18, $FF, $5B, $FF, $63, $67, $3C, $E7, $FF, $00, $FF, $00
    db $EF, $2C, $FF, $99, $FF, $81, $FF, $BD, $7F, $C3, $82, $DE, $62, $FE, $10, $FC
    db $80, $9C, $60, $F4, $C0, $F4, $C4, $F4, $44, $FC, $DE, $30, $FE, $10, $FC, $60
    db $9C, $60, $FC, $80, $FC, $80, $FC, $80, $FC, $80, $FF, $FF, $FF, $FF, $FE, $FF
    db $FE, $FE, $FD, $FF, $FD, $FF, $7F, $7F, $19, $19, $FF, $FF, $FF, $FF, $FF, $FF
    db $FE, $FF, $FF, $FE, $FF, $FE, $7F, $7E, $19, $19, $04, $F4, $40, $EC, $48, $7C
    db $88, $9C, $50, $FA, $40, $4E, $00, $FC, $00, $F0, $FC, $C0, $FC, $84, $7C, $84
    db $FC, $04, $FE, $02, $FE, $0A, $FC, $4C, $F0, $F0, $00, $7F, $77, $7F, $CB, $DB
    db $10, $56, $05, $67, $08, $6A, $28, $BD, $F5, $FF, $7F, $7F, $7F, $88, $DB, $34
    db $F6, $0F, $F7, $08, $FB, $04, $FF, $00, $FF, $00, $00, $00, $00, $00, $80, $80
    db $00, $00, $40, $E0, $40, $E0, $00, $A0, $10, $78, $00, $00, $00, $80, $80, $40
    db $00, $C0, $E0, $A0, $E0, $20, $E0, $20, $F8, $08, $42, $EF, $BD, $FF, $04, $FB
    db $00, $C3, $00, $81, $00, $99, $00, $FF, $6E, $7E, $EF, $BD, $FF, $66, $FF, $42
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $7E, $C3, $08, $E8, $20, $FC, $D0, $F4
    db $A4, $FC, $40, $CE, $40, $FE, $00, $DE, $60, $7E, $F8, $E0, $FC, $14, $7C, $A4
    db $FC, $00, $DE, $22, $FE, $22, $DE, $32, $7E, $92, $80, $18, $3B, $1D, $3F, $1C
    db $3F, $1C, $1F, $1C, $1F, $0C, $1F, $0C, $0F, $80, $3B, $26, $3F, $22, $3F, $23
    db $1F, $03, $1F, $03, $1F, $13, $0F, $03, $00, $42, $E7, $DB, $FF, $34, $FF, $18
    db $FF, $5A, $FE, $62, $E6, $3C, $BE, $FE, $FF, $00, $FF, $00, $EF, $2C, $FF, $99
    db $FF, $81, $FE, $BD, $FE, $C3, $BE, $BF, $FF, $FF, $E0, $01, $01, $07, $07, $0F
    db $0F, $0F, $0F, $01, $01, $E0, $01, $01, $07, $07, $0F, $0F, $0F, $0F, $01, $01
    db $80, $FE, $FE, $FD, $FF, $FD, $FF, $FF, $FF, $FF, $FF, $7E, $7E, $18, $18, $80
    db $FE, $FF, $FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF, $7E, $7E, $18, $18, $00, $00
    db $00, $00, $00, $01, $01, $05, $06, $0E, $08, $1B, $00, $1F, $12, $17, $00, $00
    db $00, $00, $01, $01, $05, $06, $0F, $08, $1F, $10, $1F, $12, $1F, $00, $00, $7F
    db $77, $7F, $0B, $8B, $10, $D6, $0D, $6F, $08, $AD, $46, $EF, $BD, $FF, $7F, $7F
    db $7F, $88, $8B, $F4, $F6, $0F, $FF, $00, $FF, $81, $EF, $B9, $FF, $66, $01, $1F
    db $01, $33, $02, $3B, $02, $3F, $04, $3F, $16, $3E, $11, $3B, $16, $3F, $1E, $01
    db $3B, $24, $3B, $24, $3F, $24, $3F, $28, $3E, $29, $3B, $2C, $3F, $28, $04, $FB
    db $00, $C3, $00, $81, $00, $99, $00, $FF, $6E, $7E, $66, $7E, $66, $FF, $FF, $42
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $7E, $C3, $3C, $E7, $FF, $00, $00, $06
    db $3F, $08, $7B, $09, $7F, $00, $7F, $24, $7E, $24, $7E, $34, $3E, $18, $3E, $00
    db $3F, $48, $7B, $46, $7F, $46, $7F, $47, $7E, $43, $7E, $43, $3E, $03, $3E, $27
    db $00, $66, $FF, $42, $E7, $DB, $FF, $34, $FF, $18, $FF, $5A, $7F, $62, $E7, $FD
    db $FF, $00, $FF, $00, $FF, $00, $EF, $2C, $FF, $99, $FF, $81, $7F, $BD, $FF, $C3
    db $FF, $FE, $C0, $01, $19, $01, $01, $03, $03, $0F, $0F, $1F, $1F, $1E, $1E, $C0
    db $19, $19, $01, $01, $03, $03, $0F, $0F, $1F, $1F, $1E, $1E, $80, $FD, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7E, $7E, $18, $18, $80, $FF, $FE, $FF, $FE
    db $FF, $FF, $FF, $FF, $FF, $FF, $7E, $7E, $18, $18, $00, $00, $00, $00, $01, $01
    db $02, $02, $04, $07, $02, $06, $01, $07, $08, $0B, $00, $00, $00, $01, $01, $02
    db $02, $01, $07, $03, $07, $04, $07, $02, $0F, $02, $00, $FE, $EE, $FE, $D0, $D7
    db $07, $6F, $84, $D7, $0C, $6E, $39, $FD, $C7, $EF, $FE, $FE, $FE, $11, $D7, $2F
    db $6F, $F8, $F7, $08, $FF, $00, $FF, $00, $EF, $B9, $02, $1F, $11, $37, $01, $3B
    db $02, $33, $02, $3F, $24, $7F, $06, $7E, $01, $3B, $1F, $10, $3E, $21, $3B, $24
    db $3B, $24, $3F, $24, $7F, $48, $7E, $49, $3B, $4C, $BD, $FF, $04, $FB, $00, $C3
    db $00, $81, $00, $99, $00, $FF, $6E, $7E, $66, $7E, $FF, $66, $FF, $42, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $7E, $C3, $3C, $E7, $49, $79, $48, $7B, $20, $39
    db $05, $1D, $25, $2F, $2E, $2F, $2B, $3F, $29, $2D, $79, $06, $7B, $06, $39, $06
    db $1D, $22, $3F, $02, $3F, $04, $3F, $04, $3D, $06, $7E, $FF, $A2, $FD, $80, $E0
    db $00, $C0, $00, $C0, $00, $C0, $00, $E6, $82, $FF, $FF, $13, $7F, $81, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $03, $2F, $25, $7D, $22, $72
    db $15, $BF, $05, $E5, $01, $7F, $01, $1F, $00, $00, $3F, $24, $7D, $42, $7E, $41
    db $FF, $81, $FF, $A1, $7F, $65, $1F, $1F, $00, $00, $84, $96, $59, $DF, $B9, $F9
    db $50, $71, $80, $B1, $B0, $B1, $D1, $DF, $CE, $DF, $96, $79, $CF, $39, $FF, $00
    db $7F, $80, $BF, $C0, $BF, $C0, $DF, $E0, $D7, $F7, $00, $00, $00, $00, $01, $01
    db $00, $02, $00, $04, $01, $07, $0E, $0E, $00, $1B, $00, $00, $00, $01, $01, $00
    db $02, $03, $04, $07, $07, $06, $0F, $00, $1F, $10, $00, $FE, $EE, $FE, $C0, $CE
    db $2B, $2B, $00, $E2, $88, $CE, $48, $5D, $32, $BF, $FE, $FE, $FE, $11, $CE, $3F
    db $2B, $D4, $E7, $F8, $EF, $10, $FF, $00, $FF, $00, $01, $1F, $0B, $2F, $03, $2F
    db $25, $37, $07, $7F, $0B, $7B, $0E, $7F, $08, $79, $1F, $08, $3F, $20, $3F, $20
    db $3F, $00, $7F, $40, $7B, $44, $7F, $41, $79, $47, $77, $FF, $EE, $FF, $F7, $FF
    db $F7, $FF, $DD, $DD, $AB, $AB, $91, $91, $60, $F4, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $DD, $22, $AB, $54, $91, $6E, $F4, $7F, $00, $7E, $FF, $A2, $FD, $80
    db $E0, $00, $C0, $00, $C0, $00, $C0, $00, $E6, $82, $FF, $00, $FF, $13, $7F, $81
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $A4, $E6, $44
    db $F6, $94, $F6, $20, $64, $20, $74, $00, $6C, $10, $78, $30, $F8, $00, $E6, $1A
    db $B6, $5A, $F6, $0A, $E4, $1C, $F4, $1C, $EC, $1C, $F8, $08, $F8, $08, $00, $8D
    db $9F, $59, $D9, $06, $F0, $A6, $F0, $8E, $AE, $BE, $BF, $C4, $DF, $2C, $2C, $00
    db $9F, $70, $CF, $39, $F9, $00, $F9, $00, $AE, $D1, $B7, $D7, $DF, $F5, $2C, $33
    db $E0, $30, $B8, $B0, $B0, $20, $A0, $A0, $A0, $C0, $C0, $C0, $B8, $C8, $30, $D0
    db $A0, $60, $A0, $60, $C0, $40, $00, $80, $00, $FE, $D6, $D6, $E1, $F1, $0F, $EF
    db $98, $DC, $00, $75, $00, $AE, $CA, $FF, $FE, $FE, $D6, $29, $F1, $1E, $EF, $F0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $00, $00, $00, $00, $80, $00, $C0
    db $40, $F0, $00, $E8, $48, $E8, $00, $DC, $00, $00, $00, $00, $80, $80, $C0, $C0
    db $F0, $30, $F8, $08, $F8, $00, $FC, $04, $6D, $FF, $F7, $FF, $E7, $EF, $B5, $BD
    db $DB, $DB, $A9, $A9, $94, $94, $60, $F4, $FF, $00, $FF, $00, $EF, $10, $BD, $42
    db $DB, $24, $A9, $56, $94, $6B, $F4, $7F, $C4, $CC, $A0, $EE, $E0, $FE, $D0, $FE
    db $F0, $FE, $72, $76, $D0, $F6, $80, $E6, $FC, $00, $FE, $02, $FE, $02, $FE, $02
    db $FE, $02, $76, $88, $F6, $2A, $E6, $BA, $20, $23, $12, $33, $11, $17, $11, $13
    db $1A, $1B, $0A, $1F, $0C, $1F, $36, $3F, $23, $3E, $33, $2C, $16, $0D, $13, $0C
    db $1B, $04, $1F, $14, $1F, $18, $3F, $28, $81, $A9, $BD, $FF, $44, $FF, $00, $C3
    db $00, $81, $00, $81, $00, $81, $00, $99, $A9, $FF, $FF, $66, $FF, $02, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $22, $3B, $26, $2E, $13, $13, $0E, $0F
    db $03, $03, $01, $01, $01, $01, $00, $00, $3B, $2C, $2E, $39, $13, $1C, $0F, $0E
    db $03, $03, $01, $01, $01, $01, $00, $00, $08, $FF, $34, $7E, $66, $7E, $44, $E7
    db $01, $C7, $45, $C7, $83, $C7, $4D, $7D, $FF, $00, $7E, $C3, $3C, $E7, $FF, $00
    db $FF, $00, $FF, $01, $FF, $01, $7D, $83, $00, $00, $00, $00, $01, $01, $02, $03
    db $00, $02, $00, $07, $04, $0D, $01, $1B, $00, $00, $00, $01, $01, $02, $03, $00
    db $03, $04, $07, $04, $0F, $08, $1F, $10, $00, $7F, $E7, $E7, $81, $81, $0A, $AF
    db $10, $54, $00, $7B, $48, $DE, $6D, $FF, $7F, $7F, $E7, $18, $81, $7E, $EF, $11
    db $F7, $08, $FF, $00, $FF, $00, $FF, $00, $13, $1B, $05, $17, $17, $3F, $17, $3F
    db $1F, $3F, $17, $37, $17, $37, $15, $37, $1F, $00, $1F, $10, $3F, $20, $3F, $20
    db $3F, $20, $37, $28, $37, $28, $37, $2A, $F7, $FF, $EF, $FF, $EF, $FF, $F7, $FF
    db $DF, $DF, $FB, $FB, $95, $95, $28, $28, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $DF, $20, $FB, $04, $95, $6A, $28, $D7, $72, $FF, $89, $FF, $03, $07, $01, $03
    db $00, $03, $00, $03, $00, $67, $21, $FF, $FF, $8C, $FE, $05, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $92, $9E, $12, $DE, $40, $DC, $00, $1C
    db $80, $D4, $14, $B4, $54, $FC, $94, $B4, $9E, $60, $DE, $60, $DC, $20, $1C, $E0
    db $DC, $60, $BC, $60, $FC, $20, $BC, $60, $D1, $F9, $9A, $9B, $6D, $0F, $63, $0B
    db $EF, $EF, $EF, $FF, $44, $F4, $28, $E8, $F9, $0E, $F3, $9C, $9F, $00, $9B, $07
    db $EF, $17, $7F, $77, $F4, $5C, $E8, $18, $40, $F4, $E8, $FC, $88, $DC, $90, $BA
    db $80, $CE, $00, $FC, $00, $00, $00, $00, $FC, $24, $FC, $44, $FC, $84, $FE, $02
    db $FE, $4A, $FC, $CC, $00, $00, $00, $00, $00, $7F, $77, $7F, $CB, $DB, $10, $56
    db $05, $67, $28, $6A, $14, $BD, $AF, $FF, $7F, $7F, $7F, $88, $DB, $34, $F6, $0F
    db $F7, $08, $FB, $04, $FF, $00, $FF, $00, $00, $00, $00, $00, $80, $80, $00, $00
    db $40, $E0, $40, $E0, $10, $D0, $80, $E8, $00, $00, $00, $80, $80, $40, $00, $C0
    db $E0, $A0, $E0, $20, $F0, $00, $F8, $08, $F7, $FF, $EF, $FF, $EF, $FF, $D5, $DD
    db $33, $3B, $AC, $AC, $51, $51, $02, $53, $FF, $00, $FF, $00, $FF, $00, $DD, $22
    db $3B, $C4, $AC, $53, $51, $AE, $53, $FE, $48, $F8, $C0, $FC, $E0, $F4, $A4, $EC
    db $E0, $FE, $D0, $FE, $70, $FE, $10, $9E, $F8, $10, $FC, $04, $FC, $04, $FC, $00
    db $FE, $02, $FE, $02, $FE, $82, $9E, $E2, $0A, $2F, $04, $3F, $00, $2F, $08, $0E
    db $08, $0E, $18, $1E, $0C, $1E, $00, $13, $2F, $31, $3B, $35, $2F, $30, $0F, $10
    db $0F, $10, $1F, $10, $1F, $10, $13, $1C, $02, $8F, $89, $FF, $03, $07, $01, $03
    db $00, $03, $00, $03, $00, $67, $21, $FF, $8F, $FC, $FE, $05, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $0C, $1D, $05, $05, $0D, $0F, $0E, $0F
    db $01, $01, $00, $01, $01, $01, $00, $01, $1D, $13, $04, $0B, $0F, $0C, $0F, $0C
    db $01, $02, $01, $02, $01, $00, $01, $01, $D1, $F9, $9A, $FB, $11, $9F, $05, $0D
    db $0B, $0B, $0B, $0B, $1E, $FE, $E4, $F4, $F9, $0E, $F3, $9C, $FF, $00, $FD, $03
    db $FB, $07, $FB, $07, $FE, $06, $74, $7C, $00, $00, $00, $00, $00, $01, $01, $05
    db $01, $05, $06, $0E, $08, $1B, $14, $1E, $00, $00, $00, $00, $01, $01, $05, $06
    db $05, $06, $0F, $08, $1F, $10, $1F, $00, $00, $7F, $77, $7F, $0B, $8B, $10, $D6
    db $10, $D6, $0D, $6F, $08, $AC, $20, $6B, $7F, $7F, $7F, $88, $8B, $F4, $F6, $0F
    db $F6, $0F, $FF, $00, $FF, $00, $FF, $00, $02, $17, $03, $3F, $05, $3F, $0F, $3F
    db $0F, $3F, $1D, $3D, $0A, $2E, $02, $2E, $1F, $00, $3F, $20, $3F, $20, $3F, $20
    db $3F, $20, $3D, $22, $2E, $35, $2E, $3B, $DE, $FF, $ED, $FF, $FF, $FF, $EB, $FB
    db $B5, $B5, $2A, $2A, $51, $51, $02, $53, $FF, $00, $FF, $00, $FF, $00, $FB, $04
    db $B5, $4A, $2A, $D5, $51, $AE, $53, $FE, $81, $89, $81, $E7, $44, $FF, $00, $C3
    db $00, $81, $00, $81, $00, $81, $00, $99, $89, $FF, $E7, $7E, $FF, $02, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $0C, $CC, $4C, $CC, $8C, $EC, $AC, $EC
    db $48, $C8, $40, $E8, $00, $D8, $2C, $FC, $CC, $70, $CC, $30, $6C, $B0, $EC, $10
    db $C8, $30, $E8, $38, $D8, $38, $FC, $14, $08, $FF, $34, $7E, $66, $66, $1E, $C7
    db $98, $C3, $BA, $BA, $79, $7D, $92, $FE, $FF, $00, $7E, $C3, $3C, $E7, $E7, $00
    db $E7, $00, $BA, $45, $5D, $DF, $FE, $D6, $44, $DC, $64, $74, $E8, $E8, $F0, $F0
    db $E0, $E0, $80, $80, $00, $00, $00, $00, $DC, $34, $74, $9C, $E8, $38, $F0, $70
    db $E0, $E0, $80, $80, $00, $00, $00, $00, $00, $FE, $EE, $FE, $D0, $D7, $07, $6F
    db $84, $D7, $0C, $6E, $28, $FD, $EF, $FF, $FE, $FE, $FE, $11, $D7, $2F, $6F, $F8
    db $F7, $08, $FF, $00, $FF, $00, $FF, $00, $00, $00, $00, $00, $00, $80, $80, $C0
    db $20, $70, $10, $D8, $00, $E8, $08, $CC, $00, $00, $00, $00, $80, $80, $C0, $40
    db $F0, $10, $F8, $08, $F8, $08, $FC, $04, $77, $FF, $EE, $FF, $F7, $FF, $FF, $FF
    db $AF, $BF, $EB, $EB, $94, $94, $29, $29, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $BF, $40, $EB, $14, $94, $6B, $29, $D6, $44, $FC, $C0, $F4, $A4, $EE, $E4, $FE
    db $D4, $FE, $74, $7E, $EC, $EE, $AC, $EE, $FC, $00, $FC, $04, $FE, $02, $FE, $02
    db $FE, $02, $7E, $82, $EE, $12, $EE, $52, $00, $1F, $1F, $7F, $7F, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $7F, $7F, $7F, $7F, $00, $1F, $1F, $7F, $7F, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $7F, $7F, $7F, $7F, $00, $E0, $E0, $F8, $F8, $FC
    db $FC, $FC, $FC, $FC, $FC, $FC, $FC, $F8, $F8, $F8, $F8, $00, $E0, $E0, $F8, $F8
    db $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC, $F8, $F8, $F8, $F8, $F0, $3F, $3F, $03
    db $03, $03, $03, $01, $01, $F0, $3F, $3F, $03, $03, $03, $03, $01, $01, $FC, $F0
    db $F0, $80, $80, $FC, $F0, $F0, $80, $80, $00, $08, $08, $1C, $01, $17, $16, $1E
    db $10, $39, $33, $7F, $1C, $7F, $58, $DE, $08, $08, $1C, $14, $17, $1E, $1F, $08
    db $3F, $20, $7F, $40, $7F, $40, $FF, $80, $00, $02, $42, $E7, $B8, $FD, $65, $E7
    db $C3, $EB, $1A, $FF, $A6, $FF, $40, $4C, $02, $02, $E7, $E5, $FD, $47, $FF, $02
    db $FF, $00, $FF, $E0, $FF, $40, $FD, $02, $90, $FC, $50, $D4, $50, $FF, $47, $FF
    db $17, $7F, $03, $67, $20, $65, $20, $7F, $FF, $08, $F7, $88, $FF, $89, $FF, $98
    db $7F, $48, $7F, $45, $7D, $47, $7F, $47, $00, $47, $E1, $E5, $00, $BF, $19, $7F
    db $38, $F8, $A8, $FC, $C8, $FF, $AE, $5F, $FF, $02, $FD, $02, $FF, $13, $FF, $16
    db $FB, $14, $FF, $34, $FF, $BE, $5F, $F8, $00, $04, $04, $0F, $0C, $0C, $09, $1D
    db $10, $36, $00, $3D, $32, $3E, $25, $2D, $04, $04, $0F, $0B, $0F, $08, $1F, $10
    db $3F, $20, $3F, $20, $3E, $01, $3D, $02, $00, $01, $19, $9B, $52, $FB, $D8, $FD
    db $20, $F5, $94, $FF, $AA, $FB, $64, $65, $01, $01, $9B, $9A, $FF, $21, $FF, $20
    db $FF, $40, $FF, $20, $FB, $54, $65, $9A, $1C, $5D, $2C, $7F, $0C, $5E, $04, $5E
    db $0C, $2F, $00, $2B, $04, $1F, $02, $1E, $5D, $62, $7F, $40, $5F, $70, $5F, $70
    db $2F, $30, $2B, $34, $1F, $13, $1E, $19, $00, $FD, $21, $27, $01, $23, $31, $73
    db $41, $DF, $81, $BF, $90, $FA, $C3, $EB, $FD, $22, $FF, $00, $FF, $00, $FF, $40
    db $FF, $88, $FF, $08, $FA, $0D, $EB, $9C, $00, $03, $0F, $05, $0F, $04, $04, $00
    db $04, $00, $02, $00, $02, $00, $03, $00, $03, $00, $0F, $08, $0F, $08, $07, $00
    db $07, $04, $03, $02, $03, $02, $03, $02, $03, $02, $00, $83, $EF, $01, $DE, $08
    db $FE, $E2, $FE, $52, $FB, $C3, $D3, $81, $C3, $81, $C3, $00, $FF, $44, $FF, $C6
    db $FF, $C6, $FF, $0C, $FB, $28, $D3, $10, $C3, $42, $C3, $42, $F0, $00, $03, $00
    db $07, $04, $07, $02, $03, $F0, $03, $02, $07, $04, $07, $00, $03, $03, $F0, $81
    db $C3, $00, $C3, $C3, $C3, $00, $81, $F0, $C3, $42, $C3, $42, $C3, $00, $81, $81
    db $00, $01, $00, $03, $01, $07, $04, $0E, $08, $1F, $10, $1D, $05, $37, $12, $3F
    db $01, $01, $03, $03, $07, $06, $0F, $08, $1F, $10, $1F, $00, $3F, $20, $3F, $20
    db $81, $C3, $80, $FF, $59, $F9, $20, $7A, $10, $35, $20, $F2, $14, $75, $A8, $B9
    db $C3, $42, $FF, $37, $FF, $00, $FF, $00, $FF, $00, $F3, $1C, $75, $AA, $B9, $56
    db $06, $16, $35, $7D, $14, $BC, $10, $B4, $44, $D7, $6C, $ED, $34, $77, $02, $37
    db $1E, $21, $7D, $42, $BC, $E3, $B4, $EB, $D7, $BA, $ED, $92, $77, $4A, $37, $38
    db $0A, $3A, $45, $75, $92, $FE, $01, $93, $00, $11, $10, $39, $08, $FF, $20, $EF
    db $3A, $F5, $75, $BA, $FE, $01, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $04
    db $00, $0C, $CC, $28, $AC, $28, $EC, $68, $E8, $E0, $F0, $B0, $F0, $30, $F0, $20
    db $E0, $00, $CC, $70, $AC, $54, $EC, $54, $E8, $10, $F0, $10, $F0, $10, $F0, $10
    db $E0, $00, $FF, $FF, $80, $20, $E0, $20, $E0, $00, $E0, $00, $E0, $A0, $E0, $20
    db $E0, $A0, $E0, $80, $E0, $00, $E0, $00, $E0, $20, $E0, $20, $20, $C0, $60, $80
    db $E0, $60, $FF, $FF, $00, $18, $39, $1A, $1A, $02, $1B, $03, $0F, $03, $03, $06
    db $07, $02, $03, $02, $03, $00, $39, $27, $1A, $05, $1B, $1D, $0F, $0C, $03, $04
    db $07, $04, $03, $00, $03, $00, $00, $00, $88, $08, $9C, $0C, $FF, $40, $F7, $A3
    db $F7, $A2, $EF, $62, $EF, $60, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $12
    db $FF, $62, $FF, $43, $FF, $43, $FF, $43, $C0, $02, $03, $00, $03, $00, $03, $02
    db $03, $02, $03, $00, $01, $C0, $03, $00, $03, $02, $03, $02, $02, $01, $03, $00
    db $01, $01, $80, $06, $FF, $30, $FD, $08, $DD, $E8, $E9, $23, $EB, $A2, $E3, $02
    db $03, $80, $FF, $63, $FD, $65, $DD, $55, $29, $C1, $6A, $89, $E3, $60, $03, $03
    db $00, $00, $40, $40, $E0, $00, $60, $C0, $C0, $80, $90, $40, $D0, $40, $60, $20
    db $70, $00, $40, $40, $E0, $A0, $60, $A0, $C0, $20, $90, $70, $D0, $B0, $E0, $30
    db $F0, $10, $FF, $FF, $00, $10, $58, $88, $FC, $80, $BE, $CF, $FF, $04, $5F, $8E
    db $BF, $6A, $7F, $9C, $9E, $00, $F8, $08, $FC, $04, $FE, $06, $FF, $00, $7F, $80
    db $BF, $40, $7F, $85, $9E, $62, $CF, $00, $80, $00, $80, $CF, $80, $80, $80, $80
    db $00, $01, $01, $03, $00, $03, $01, $01, $00, $04, $00, $01, $00, $04, $04, $0E
    db $01, $01, $03, $02, $03, $02, $01, $02, $04, $07, $01, $07, $05, $06, $0F, $08
    db $00, $1C, $00, $A2, $14, $7F, $80, $BE, $F7, $F7, $0A, $9B, $10, $5D, $08, $1A
    db $1C, $1C, $A2, $BE, $7F, $E3, $BE, $41, $F7, $08, $9B, $F5, $FF, $00, $FF, $00
    db $08, $1D, $1A, $1E, $11, $3B, $68, $7D, $10, $FA, $39, $FD, $2A, $7E, $1C, $3C
    db $1F, $10, $1F, $00, $3F, $20, $7F, $00, $FE, $81, $FD, $82, $7E, $41, $3C, $23
    db $10, $59, $44, $DC, $93, $BB, $29, $39, $85, $9D, $40, $7E, $00, $7F, $88, $C9
    db $FF, $08, $FD, $12, $BB, $4C, $39, $D6, $9D, $72, $7E, $99, $7F, $88, $FF, $00
    db $FE, $16, $16, $FE, $16, $1E, $3C, $52, $53, $4C, $7C, $00, $01, $00, $02, $3C
    db $53, $AF, $7C, $7C, $01, $01, $02, $03, $FF, $FF, $F8, $07, $07, $7F, $7F, $7F
    db $7F, $F8, $07, $07, $7F, $7F, $7F, $7F, $3F, $01, $01, $06, $07, $3F, $01, $01
    db $07, $07, $03, $00, $01, $00, $01, $04, $3F, $5E, $FF, $50, $7F, $13, $F3, $03
    db $01, $01, $01, $00, $3F, $3E, $FF, $81, $FF, $BF, $F3, $0C, $00, $06, $06, $0C
    db $0E, $EB, $EF, $F1, $F7, $E0, $FF, $60, $7F, $5F, $7F, $24, $2F, $00, $07, $00
    db $0F, $08, $EF, $F1, $BE, $A1, $FF, $80, $7F, $00, $7F, $74, $3F, $03, $00, $00
    db $3E, $08, $7C, $C6, $FE, $86, $FE, $02, $FE, $03, $FF, $86, $FE, $FD, $FD, $00
    db $FF, $00, $FC, $03, $FE, $01, $FE, $81, $FE, $01, $FF, $00, $FE, $01, $FD, $03
    db $FE, $16, $16, $FE, $16, $1E, $7C, $52, $53, $4C, $7C, $01, $01, $7C, $53, $AF
    db $7C, $7C, $01, $01, $FF, $FF, $F0, $07, $07, $3F, $3F, $3F, $3F, $01, $01, $F0
    db $07, $07, $3F, $3F, $3F, $3F, $01, $01, $3F, $01, $01, $06, $07, $3F, $01, $01
    db $07, $07, $0B, $00, $01, $04, $3F, $5E, $FF, $50, $7F, $13, $F3, $03, $01, $01
    db $01, $00, $3F, $3E, $FF, $81, $FF, $BF, $F3, $0C, $00, $06, $06, $0C, $0E, $EB
    db $EF, $F1, $F7, $E0, $FF, $60, $7F, $5F, $7F, $24, $2F, $00, $07, $00, $0F, $08
    db $EF, $F1, $BE, $A1, $FF, $80, $7F, $00, $7F, $74, $3F, $03, $00, $00, $3E, $08
    db $7C, $C6, $FE, $86, $FE, $02, $FE, $03, $FF, $86, $FE, $FD, $FD, $00, $FF, $00
    db $FC, $03, $FE, $01, $FE, $81, $FE, $01, $FF, $00, $FE, $01, $FD, $03, $07, $01
    db $01, $06, $07, $06, $06, $0C, $0E, $EB, $EF, $07, $01, $01, $07, $07, $07, $00
    db $0F, $08, $EF, $F1, $01, $04, $3E, $5E, $FF, $50, $7F, $13, $F3, $00, $3E, $08
    db $7C, $C6, $FE, $01, $3E, $3E, $FF, $81, $FF, $BF, $F3, $0C, $FF, $00, $FC, $03
    db $FE, $01, $C0, $F1, $F7, $E0, $FF, $60, $7F, $5F, $7F, $24, $2F, $16, $16, $C0
    db $BE, $A1, $FF, $80, $7F, $00, $7F, $74, $3F, $03, $16, $1E, $00, $86, $FE, $02
    db $FE, $03, $FF, $86, $FE, $FD, $FD, $52, $52, $4C, $7C, $00, $01, $00, $FE, $81
    db $FE, $01, $FF, $00, $FE, $01, $FD, $03, $52, $AE, $7C, $7C, $01, $01, $F0, $08
    db $1F, $08, $1F, $07, $0F, $00, $07, $F0, $1F, $10, $1F, $10, $0F, $08, $07, $07
    db $F8, $02, $FF, $25, $FF, $00, $E0, $F8, $FF, $00, $FF, $1A, $E0, $E0, $FF, $FF
    db $F1, $7F, $7F, $7F, $7F, $0F, $0F, $F1, $7F, $7F, $7F, $7F, $0F, $0F, $00, $00
    db $00, $00, $01, $01, $06, $07, $06, $06, $0C, $0E, $EB, $EF, $F1, $F7, $00, $00
    db $00, $00, $01, $01, $07, $07, $07, $00, $0F, $08, $EF, $F1, $BE, $A1, $04, $3E
    db $5E, $FF, $D0, $FF, $13, $F3, $00, $3E, $08, $7C, $C6, $FE, $86, $FE, $3E, $3E
    db $FF, $81, $FF, $3F, $F3, $0C, $FF, $00, $FC, $03, $FE, $01, $FE, $81, $E0, $FF
    db $60, $7F, $5F, $7F, $24, $2F, $16, $37, $06, $1F, $09, $1F, $04, $0F, $FF, $80
    db $7F, $00, $7F, $74, $3F, $03, $37, $3F, $1F, $19, $1F, $16, $0F, $08, $02, $FE
    db $03, $FF, $86, $FE, $FC, $FD, $50, $52, $4A, $FF, $00, $8A, $00, $F7, $FE, $01
    db $FF, $00, $FE, $01, $FD, $03, $52, $AF, $FF, $FC, $FF, $00, $FF, $00, $00, $0F
    db $0F, $3F, $3F, $7F, $7F, $FF, $FF, $FF, $FF, $FF, $FF, $7F, $7F, $3F, $3F, $00
    db $0F, $0F, $3F, $3F, $7F, $7F, $FF, $FF, $FF, $FF, $FF, $FF, $7F, $7F, $3F, $3F
    db $00, $C0, $C0, $F8, $F8, $F8, $F8, $FC, $FC, $FE, $FE, $FE, $FE, $FC, $FC, $F0
    db $F0, $00, $C0, $C0, $F8, $F8, $F8, $F8, $FC, $FC, $FE, $FE, $FE, $FE, $FC, $FC
    db $F0, $F0, $FF, $FF, $FF, $FF, $01, $00, $80, $60, $60, $00, $F0, $80, $F8, $84
    db $EC, $A0, $FC, $40, $FA, $01, $80, $80, $E0, $00, $F0, $10, $F8, $20, $FC, $A0
    db $FC, $04, $BA, $56, $FF, $FF, $00, $54, $FE, $24, $EE, $24, $FE, $40, $68, $16
    db $7F, $01, $E9, $32, $FA, $19, $FF, $00, $FE, $02, $EE, $12, $FE, $12, $68, $9C
    db $7F, $89, $E9, $1E, $F8, $0F, $FE, $37, $9F, $00, $80, $00, $80, $9F, $80, $80
    db $80, $80, $00, $0C, $1D, $1E, $1E, $0E, $1E, $01, $17, $09, $1B, $08, $1B, $08
    db $0D, $08, $0B, $00, $1D, $13, $1E, $01, $1E, $11, $17, $18, $1F, $10, $1F, $10
    db $0F, $00, $0F, $00, $60, $DA, $FF, $0C, $FF, $6D, $FF, $00, $63, $1C, $3E, $00
    db $80, $00, $FF, $0C, $FF, $C0, $FF, $DE, $7F, $E1, $3E, $BE, $00, $80, $00, $80
    db $80, $80, $80, $00, $0D, $00, $0F, $11, $39, $0A, $5F, $02, $72, $00, $3F, $00
    db $0F, $80, $0F, $08, $0F, $08, $3F, $20, $7F, $40, $7F, $50, $3F, $32, $0F, $0F
    db $C4, $00, $80, $00, $80, $80, $C0, $80, $C0, $80, $80, $C0, $80, $80, $80, $80
    db $00, $80, $C0, $40, $C0, $40, $80, $00, $07, $01, $03, $04, $0F, $00, $0D, $01
    db $1F, $00, $2F, $07, $03, $02, $0F, $09, $0F, $09, $1F, $10, $2F, $30, $00, $00
    db $04, $0A, $6B, $0C, $2E, $00, $89, $7F, $FF, $63, $F7, $5E, $FF, $82, $FD, $00
    db $04, $04, $6B, $75, $FF, $00, $FF, $00, $FF, $00, $F7, $5C, $FF, $33, $7F, $A1
    db $00, $10, $3D, $19, $3D, $09, $2F, $02, $07, $32, $77, $40, $CD, $23, $AF, $45
    db $7D, $00, $3D, $22, $3D, $22, $2F, $32, $07, $1C, $77, $4C, $CD, $BE, $8F, $FC
    db $3D, $7B, $00, $80, $E1, $00, $C0, $00, $CC, $B7, $BF, $33, $BF, $00, $DE, $00
    db $D2, $2D, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $BF, $61, $9E, $73, $DE, $21
    db $DE, $21, $F7, $16, $00, $05, $2F, $02, $17, $00, $0B, $00, $09, $04, $0D, $00
    db $09, $04, $15, $14, $1C, $00, $2F, $3A, $17, $1D, $0B, $0F, $09, $0F, $0D, $0B
    db $09, $0F, $15, $1B, $1C, $03, $80, $32, $FF, $85, $FF, $02, $DF, $00, $06, $00
    db $02, $00, $02, $00, $02, $00, $FF, $FD, $FF, $7A, $DF, $DD, $06, $07, $02, $03
    db $02, $03, $02, $03, $00, $03, $FC, $0C, $1D, $00, $1C, $FC, $1D, $13, $1C, $1C
    db $FE, $00, $02, $FE, $02, $03, $00, $06, $01, $0F, $0D, $3F, $22, $7F, $02, $67
    db $04, $57, $04, $BF, $1A, $BE, $06, $06, $0F, $0D, $3F, $30, $7D, $42, $77, $48
    db $77, $48, $BF, $C8, $BE, $D1, $00, $01, $8E, $DF, $7A, $FF, $09, $F7, $01, $87
    db $00, $03, $00, $33, $DD, $FD, $01, $01, $DF, $72, $FF, $CC, $FE, $85, $FF, $00
    db $FF, $00, $FF, $00, $FD, $86, $48, $FE, $00, $B7, $2C, $BF, $14, $B7, $3F, $7F
    db $3C, $7F, $1F, $7F, $0E, $3F, $FE, $91, $B7, $D8, $BF, $D0, $B7, $CC, $7F, $40
    db $7F, $43, $7F, $61, $3F, $31, $CC, $FD, $00, $7B, $00, $4B, $B4, $FF, $6B, $FF
    db $30, $FF, $B7, $FF, $03, $8F, $79, $CE, $7B, $84, $7B, $84, $DF, $58, $FF, $30
    db $FF, $03, $FF, $7A, $FF, $84, $01, $C0, $E0, $80, $F8, $B8, $FC, $44, $FC, $50
    db $F6, $22, $EA, $28, $FF, $01, $E0, $20, $F8, $B8, $FC, $04, $BC, $50, $FE, $02
    db $EE, $10, $FF, $11, $FF, $FF, $00, $40, $6F, $10, $7B, $01, $E9, $30, $FB, $1C
    db $FF, $F6, $FF, $43, $E7, $02, $FF, $00, $6F, $99, $7F, $89, $EF, $18, $FF, $08
    db $FF, $30, $FF, $00, $FF, $80, $FF, $81, $03, $00, $80, $00, $80, $80, $C0, $80
    db $C0, $80, $C0, $00, $80, $03, $80, $80, $80, $80, $C0, $40, $C0, $40, $C0, $40
    db $80, $80, $00, $00, $00, $01, $00, $03, $03, $07, $0E, $0F, $08, $09, $01, $15
    db $15, $3F, $00, $00, $01, $01, $03, $03, $07, $04, $0F, $00, $0D, $02, $1D, $12
    db $3F, $22, $08, $7F, $CC, $DD, $63, $F7, $5E, $FF, $82, $FD, $80, $E1, $00, $C0
    db $00, $CC, $7F, $77, $FF, $00, $F7, $5C, $FF, $33, $7F, $A1, $FF, $00, $FF, $00
    db $FF, $00, $06, $3F, $22, $77, $00, $6D, $43, $CF, $4C, $ED, $49, $FF, $52, $7F
    db $11, $7F, $3F, $24, $7F, $44, $7D, $46, $FF, $84, $FD, $83, $FF, $86, $7F, $01
    db $7F, $60, $B7, $BF, $33, $BF, $00, $DE, $00, $D2, $2D, $FF, $DA, $FF, $8C, $FF
    db $2D, $7F, $BF, $61, $9E, $73, $DE, $21, $DE, $21, $F7, $16, $FF, $0C, $FF, $C0
    db $7F, $DE, $00, $10, $7F, $05, $EF, $35, $FF, $39, $FF, $F0, $FF, $20, $F9, $20
    db $7B, $22, $77, $00, $7F, $89, $EF, $18, $FF, $08, $FF, $30, $FF, $00, $FF, $C0
    db $7F, $40, $7F, $41, $87, $00, $80, $80, $80, $00, $80, $00, $80, $87, $80, $80
    db $80, $00, $80, $80, $80, $80, $F0, $01, $BF, $25, $E5, $12, $7F, $00, $1C, $F0
    db $FF, $80, $FF, $80, $7F, $65, $1C, $1C, $FF, $FF, $00, $12, $3F, $00, $3D, $23
    db $3F, $05, $3D, $27, $3F, $03, $77, $01, $7B, $21, $7F, $00, $3F, $24, $3D, $26
    db $3F, $04, $3D, $23, $3F, $00, $7F, $40, $7F, $40, $7F, $40, $00, $33, $BF, $00
    db $DE, $00, $D2, $2D, $FF, $DA, $FF, $8C, $FF, $2D, $BF, $00, $A3, $00, $9E, $73
    db $DE, $21, $DE, $21, $F7, $16, $FF, $0C, $FF, $C0, $BF, $9E, $BF, $A1, $C0, $11
    db $3B, $11, $37, $20, $3F, $29, $29, $12, $3F, $00, $1E, $C0, $3F, $20, $3F, $20
    db $3F, $00, $3F, $00, $3F, $29, $1E, $1E, $E0, $00, $9E, $00, $80, $00, $40, $00
    db $C0, $00, $80, $E0, $9E, $9E, $80, $80, $C0, $40, $C0, $40, $80, $80, $1F, $00
    db $02, $03, $07, $06, $07, $1F, $02, $03, $07, $04, $07, $00, $00, $04, $0C, $08
    db $1E, $00, $1F, $08, $48, $7F, $FF, $B6, $FF, $0E, $2F, $0C, $BE, $00, $0C, $08
    db $1E, $12, $1F, $1B, $48, $77, $FF, $80, $FF, $49, $FF, $00, $FF, $00, $00, $04
    db $0F, $08, $1D, $01, $1B, $00, $1B, $00, $15, $01, $19, $11, $3F, $16, $3F, $00
    db $0F, $09, $1F, $11, $1F, $10, $1F, $10, $1D, $12, $1D, $12, $3F, $22, $3F, $24
    db $00, $80, $DD, $40, $F7, $5E, $FF, $82, $FD, $80, $E1, $00, $C0, $00, $CC, $B7
    db $BF, $00, $FF, $00, $F7, $5C, $FF, $33, $7F, $A1, $FF, $00, $FF, $00, $FF, $00
    db $BF, $61, $00, $33, $7F, $34, $7E, $5D, $FF, $19, $FB, $F9, $FF, $75, $7F, $28
    db $3F, $08, $1F, $00, $7F, $48, $7E, $4B, $FF, $88, $FF, $88, $FF, $88, $7F, $78
    db $3F, $30, $1F, $10, $00, $09, $EB, $04, $FF, $0A, $9F, $46, $FF, $0E, $FF, $26
    db $FF, $56, $FF, $7E, $FF, $00, $FB, $C6, $FF, $83, $BF, $C3, $FF, $87, $FF, $C7
    db $FF, $8B, $FF, $EF, $FF, $EF, $FC, $07, $0F, $03, $03, $FC, $0F, $08, $03, $03
    db $F8, $FE, $FF, $FF, $FF, $30, $30, $F8, $FF, $DF, $FF, $FF, $30, $30, $00, $00
    db $00, $01, $02, $07, $06, $0E, $1D, $1D, $02, $1F, $21, $32, $00, $3D, $00, $00
    db $01, $01, $07, $05, $0F, $08, $1F, $00, $1F, $10, $3F, $00, $3D, $22, $00, $26
    db $00, $7A, $89, $8D, $12, $BA, $24, $59, $49, $91, $E6, $09, $02, $3E, $26, $26
    db $7E, $78, $EF, $10, $FF, $00, $FF, $18, $D9, $36, $EF, $18, $3E, $FD, $2F, $2C
    db $0A, $78, $64, $73, $60, $79, $12, $7F, $36, $7F, $3B, $7F, $3A, $7F, $3F, $00
    db $7A, $45, $77, $0A, $79, $0E, $7F, $4C, $7F, $48, $7F, $40, $7F, $41, $76, $FF
    db $18, $99, $10, $38, $08, $3C, $00, $FF, $28, $FF, $62, $EF, $CB, $DF, $FF, $89
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $04, $FF, $04, $00, $00
    db $01, $03, $00, $16, $06, $0F, $15, $3F, $1A, $1E, $3C, $3D, $1C, $3D, $00, $00
    db $03, $02, $17, $14, $0F, $08, $3F, $20, $1E, $01, $3D, $03, $3D, $22, $07, $9C
    db $F1, $BB, $4C, $FF, $39, $FF, $F7, $FF, $41, $7F, $08, $18, $10, $3C, $9C, $9B
    db $BF, $40, $FF, $00, $FF, $00, $FF, $00, $7F, $98, $FF, $00, $FF, $00, $08, $39
    db $12, $33, $2A, $2B, $2B, $2F, $0A, $6E, $7B, $FB, $5B, $DF, $59, $DB, $39, $26
    db $33, $2C, $2B, $34, $2F, $34, $6E, $75, $FB, $94, $DF, $A4, $DB, $A4, $28, $FF
    db $10, $F7, $A5, $EF, $90, $B7, $20, $73, $12, $37, $24, $3E, $91, $BD, $FF, $10
    db $FF, $24, $FF, $42, $BF, $61, $7F, $C3, $3F, $E1, $3E, $C3, $BD, $46, $00, $30
    db $FC, $A8, $FC, $30, $FC, $38, $78, $20, $F8, $A7, $F7, $A3, $FF, $EB, $FF, $00
    db $FC, $84, $FC, $44, $FC, $C4, $78, $40, $F8, $C0, $FF, $C7, $FF, $C7, $FF, $87
    db $9F, $80, $80, $80, $80, $9F, $80, $80, $80, $80, $F8, $C6, $FE, $84, $FE, $F8
    db $FC, $F8, $FE, $82, $FE, $C2, $FC, $C4, $FF, $FF, $1C, $00, $01, $00, $01, $07
    db $07, $07, $07, $03, $03, $1C, $01, $01, $01, $01, $07, $07, $07, $07, $03, $03
    db $00, $61, $FD, $A0, $FB, $69, $FF, $F4, $FF, $13, $F7, $1D, $BF, $17, $FF, $5F
    db $FF, $00, $FF, $10, $FF, $18, $FF, $10, $FF, $08, $F7, $84, $FF, $8E, $FF, $8F
    db $FF, $87, $FC, $01, $01, $00, $01, $FC, $01, $01, $01, $01, $F0, $8F, $FF, $87
    db $FF, $7F, $FF, $07, $07, $F0, $FF, $07, $FF, $0F, $FF, $8F, $07, $07, $00, $00
    db $80, $50, $F0, $50, $74, $94, $BC, $28, $6F, $4C, $7C, $96, $BE, $21, $27, $00
    db $80, $80, $F0, $20, $F4, $24, $FC, $08, $FF, $07, $7C, $83, $BE, $41, $3F, $C2
    db $0F, $00, $80, $80, $C0, $40, $E0, $80, $E0, $0F, $80, $80, $C0, $40, $E0, $20
    db $E0, $20, $00, $54, $5E, $A3, $AF, $48, $CF, $21, $67, $04, $36, $02, $26, $0C
    db $FE, $18, $FD, $00, $5E, $A1, $AF, $50, $CF, $32, $E7, $1C, $F6, $1A, $E6, $1C
    db $FE, $12, $FD, $85, $FA, $80, $C0, $00, $80, $F8, $C0, $40, $00, $80, $80, $80
    db $00, $00, $01, $01, $00, $01, $02, $03, $03, $07, $04, $1F, $14, $3E, $20, $77
    db $00, $00, $01, $00, $01, $01, $03, $01, $07, $04, $1F, $12, $3F, $28, $77, $4C
    db $20, $29, $20, $7E, $A2, $E3, $84, $AE, $40, $55, $AC, $FE, $6A, $EE, $D5, $D7
    db $29, $09, $7F, $5E, $FB, $44, $FF, $00, $FF, $00, $FE, $03, $EE, $15, $D7, $2A
    db $11, $77, $0D, $2F, $02, $1F, $05, $07, $06, $07, $00, $07, $00, $05, $00, $01
    db $77, $48, $2F, $32, $1F, $19, $07, $02, $07, $01, $07, $07, $05, $05, $01, $01
    db $41, $47, $28, $AE, $10, $9F, $02, $12, $00, $62, $82, $A7, $83, $FF, $C0, $FD
    db $C7, $3E, $AE, $57, $9F, $62, $1F, $E0, $7F, $C0, $BF, $40, $FF, $40, $FF, $04
    db $00, $24, $65, $20, $6E, $22, $7F, $31, $7F, $30, $7D, $2C, $7C, $20, $7E, $1C
    db $3E, $00, $7D, $42, $7F, $46, $7F, $44, $7F, $46, $7D, $45, $60, $5C, $76, $4A
    db $3E, $22, $00, $48, $6F, $22, $E3, $42, $FB, $22, $FF, $86, $DF, $06, $9F, $1A
    db $1F, $02, $3F, $00, $EF, $33, $EF, $11, $FF, $31, $FF, $51, $DF, $51, $9F, $91
    db $23, $3D, $37, $29, $FE, $02, $1E, $FE, $1E, $1E, $FC, $1C, $3E, $20, $3C, $FC
    db $3E, $22, $3C, $3C, $00, $3F, $3F, $7F, $7F, $FF, $FF, $FF, $FF, $1F, $1F, $1F
    db $1F, $0D, $0D, $01, $01, $00, $3F, $3F, $7F, $7F, $FF, $FF, $FF, $FF, $1F, $1F
    db $1F, $1F, $0D, $0D, $01, $01, $00, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FE
    db $FE, $FC, $FC, $FC, $FC, $D8, $D8, $00, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $FF
    db $FE, $FE, $FC, $FC, $FC, $FC, $D8, $D8, $FF, $FF, $FE, $C0, $C0, $FE, $C0, $C0
    db $00, $60, $94, $A9, $94, $DD, $25, $AF, $8A, $DB, $5A, $DF, $8D, $AF, $4B, $CB
    db $60, $60, $E9, $1D, $FD, $09, $FF, $02, $FF, $01, $DF, $A0, $AF, $50, $CB, $B4
    db $40, $C0, $80, $E0, $60, $70, $20, $30, $30, $B0, $80, $D0, $C0, $F0, $20, $F0
    db $C0, $80, $E0, $60, $F0, $10, $F0, $10, $F0, $00, $F0, $10, $F0, $10, $F0, $10
    db $95, $95, $61, $E1, $12, $F2, $89, $99, $00, $8C, $84, $CC, $C4, $FE, $00, $7F
    db $95, $6A, $E1, $9E, $F2, $8D, $F9, $06, $FC, $07, $FC, $03, $FE, $03, $FF, $23
    db $80, $D0, $40, $E0, $C0, $E0, $00, $A0, $80, $80, $80, $C0, $00, $C0, $00, $40
    db $D0, $30, $E0, $20, $E0, $20, $A0, $60, $80, $40, $C0, $40, $C0, $C0, $40, $40
    db $01, $00, $01, $01, $03, $01, $03, $04, $06, $00, $04, $00, $06, $01, $07, $01
    db $01, $01, $03, $02, $03, $02, $07, $00, $07, $04, $07, $04, $07, $04, $00, $80
    db $C2, $40, $F7, $88, $B8, $21, $2B, $50, $D5, $EA, $FF, $5A, $FB, $75, $F5, $00
    db $C2, $42, $F7, $B7, $FE, $31, $FF, $00, $FF, $80, $FF, $00, $FB, $05, $F5, $0A
    db $88, $02, $03, $00, $03, $01, $03, $00, $01, $00, $01, $00, $01, $80, $03, $00
    db $03, $02, $03, $02, $00, $01, $01, $01, $01, $01, $01, $01, $00, $D0, $D1, $EB
    db $EB, $A4, $A7, $88, $8C, $80, $98, $90, $B9, $10, $BF, $20, $FF, $00, $D1, $2F
    db $EB, $14, $A7, $58, $8F, $70, $9F, $70, $BF, $60, $BF, $E0, $FF, $C1, $01, $00
    db $40, $A0, $E0, $20, $70, $50, $DC, $10, $FE, $2E, $7E, $4C, $4E, $01, $40, $40
    db $E0, $40, $F0, $10, $FC, $0C, $FE, $06, $7E, $80, $7E, $82, $FF, $FF, $00, $24
    db $3F, $4D, $DF, $1E, $7F, $25, $6F, $2B, $FF, $2D, $FF, $E4, $FF, $70, $F8, $00
    db $3F, $C1, $DF, $20, $FF, $20, $EF, $12, $FF, $14, $FF, $12, $FF, $1B, $F8, $88
    db $80, $00, $40, $00, $E0, $40, $E0, $00, $C0, $80, $80, $80, $C0, $00, $80, $80
    db $40, $40, $E0, $E0, $E0, $20, $C0, $40, $80, $00, $C0, $40, $80, $80, $07, $01
    db $03, $02, $06, $01, $03, $04, $05, $07, $0F, $07, $03, $02, $07, $04, $03, $04
    db $07, $00, $0F, $08, $00, $00, $13, $00, $BD, $44, $C6, $09, $5D, $84, $AE, $52
    db $FE, $D4, $DD, $AA, $AE, $00, $13, $13, $BF, $BC, $F7, $88, $FF, $00, $FF, $00
    db $FE, $05, $DD, $2A, $AE, $55, $00, $06, $5E, $15, $7F, $4E, $FF, $56, $FF, $3A
    db $7F, $35, $7D, $05, $3F, $01, $03, $00, $5F, $50, $7F, $60, $FF, $80, $FF, $89
    db $7F, $45, $7D, $4A, $3F, $3A, $03, $02, $00, $80, $9F, $44, $64, $00, $C4, $84
    db $CE, $88, $FF, $90, $FB, $B2, $FB, $D8, $FF, $00, $9F, $64, $7F, $80, $FF, $80
    db $FF, $00, $FF, $00, $FF, $09, $FF, $01, $FF, $21, $80, $05, $0F, $06, $0F, $01
    db $03, $01, $07, $02, $03, $01, $03, $00, $01, $80, $0F, $08, $0F, $09, $03, $02
    db $07, $04, $03, $01, $03, $02, $01, $01, $00, $00, $87, $E4, $FE, $70, $FC, $28
    db $FE, $90, $FF, $20, $FF, $24, $FF, $28, $7F, $00, $87, $78, $FF, $10, $FF, $88
    db $FF, $50, $FF, $60, $FF, $C0, $FF, $C2, $7F, $47, $FF, $FF, $00, $31, $7F, $20
    db $3F, $0C, $1E, $0C, $7E, $2E, $7F, $20, $7F, $1E, $3E, $00, $1E, $00, $7F, $42
    db $3F, $03, $3E, $02, $7E, $42, $61, $5F, $73, $4D, $3E, $20, $1E, $1E, $01, $21
    db $21, $FF, $FF, $7F, $7F, $87, $87, $0F, $0F, $1F, $1F, $78, $78, $01, $21, $21
    db $FF, $FF, $7F, $7F, $87, $87, $0F, $0F, $1F, $1F, $78, $78, $00, $C0, $C0, $F0
    db $F0, $FF, $FF, $FF, $FF, $FC, $FC, $FE, $FE, $FF, $FF, $63, $63, $00, $C0, $C0
    db $F0, $F0, $FF, $FF, $FF, $FF, $FC, $FC, $FE, $FE, $FF, $FF, $63, $63, $FE, $20
    db $20, $FE, $20, $20, $F8, $C0, $C0, $60, $60, $40, $40, $F8, $C0, $C0, $60, $60
    db $40, $40, $00, $F0, $44, $4C, $01, $47, $42, $E7, $61, $FF, $00, $BF, $20, $BF
    db $14, $7F, $F0, $4F, $FC, $03, $FF, $02, $FF, $01, $FF, $00, $FF, $90, $FF, $10
    db $FF, $08, $AA, $FE, $54, $FE, $08, $FC, $A0, $FC, $D0, $F8, $A0, $F8, $80, $F0
    db $80, $C0, $FE, $40, $FE, $A8, $FC, $74, $FC, $0C, $F8, $28, $F8, $58, $F0, $70
    db $C0, $40, $22, $FF, $91, $FF, $40, $EF, $06, $4F, $06, $0F, $0E, $0F, $00, $1F
    db $0F, $1F, $FF, $1C, $FF, $28, $EF, $A8, $4F, $48, $0F, $08, $00, $0F, $19, $16
    db $1F, $10, $80, $C0, $80, $C0, $80, $80, $00, $00, $00, $C0, $80, $C0, $80, $C0
    db $00, $80, $C0, $40, $C0, $40, $80, $00, $80, $00, $C0, $40, $C0, $40, $C0, $40
    db $80, $80, $00, $00, $18, $08, $1C, $90, $BC, $88, $FC, $08, $7E, $06, $7F, $90
    db $F7, $02, $FB, $00, $18, $18, $1C, $14, $BC, $24, $FC, $64, $FE, $06, $FF, $79
    db $FF, $61, $FF, $60, $3F, $00, $20, $80, $C0, $3F, $20, $20, $C0, $40, $00, $64
    db $65, $91, $FB, $68, $FB, $00, $F5, $69, $F9, $9A, $FA, $01, $F1, $0A, $DA, $00
    db $FF, $00, $FF, $00, $FB, $04, $F5, $6A, $F9, $96, $FA, $65, $F1, $FE, $DA, $F5
    db $00, $80, $F0, $20, $B0, $50, $58, $A0, $E0, $28, $3C, $90, $FC, $28, $78, $40
    db $FE, $00, $F0, $70, $F0, $10, $F8, $08, $E0, $00, $FC, $04, $FC, $04, $78, $80
    db $FE, $0C, $1F, $00, $01, $02, $03, $07, $07, $1F, $01, $01, $03, $03, $07, $04
    db $00, $00, $60, $40, $E0, $21, $F5, $4C, $FF, $40, $F8, $E0, $FB, $B4, $FE, $10
    db $F7, $00, $60, $60, $E0, $A0, $F5, $94, $FF, $93, $FF, $80, $FF, $03, $FF, $4A
    db $FF, $E2, $00, $07, $07, $02, $07, $01, $03, $00, $05, $02, $06, $01, $07, $07
    db $0F, $02, $03, $00, $07, $04, $07, $05, $03, $02, $05, $06, $07, $04, $07, $00
    db $0F, $08, $03, $00, $00, $0A, $9A, $C4, $CF, $43, $57, $A8, $FE, $6B, $EF, $D5
    db $D7, $42, $46, $A9, $AD, $00, $FF, $80, $FF, $00, $FF, $00, $FE, $03, $EF, $14
    db $D7, $2A, $C6, $3D, $AD, $56, $00, $5D, $FD, $D2, $D2, $4C, $FC, $C3, $FF, $FE
    db $FF, $FC, $FE, $FC, $FF, $FE, $FF, $00, $FD, $A3, $D2, $EE, $FC, $FC, $FF, $3F
    db $FF, $FF, $FF, $FE, $FF, $FE, $FF, $FF, $00, $82, $FF, $02, $6E, $00, $76, $43
    db $EF, $81, $CF, $51, $FF, $11, $97, $05, $FF, $00, $FF, $C1, $7E, $40, $7E, $42
    db $FF, $81, $FF, $03, $FF, $03, $FF, $83, $FF, $93, $FE, $07, $07, $FE, $07, $07
    db $FE, $84, $FC, $FE, $FC, $FC, $00, $C0, $C0, $40, $E0, $40, $E0, $40, $E0, $40
    db $B0, $50, $9A, $29, $CF, $0E, $D7, $00, $C0, $00, $E0, $20, $E0, $20, $E0, $20
    db $F0, $30, $DA, $2A, $EF, $14, $FF, $00, $1F, $00, $40, $00, $80, $C0, $E0, $1F
    db $40, $40, $80, $80, $E0, $20, $80, $09, $FF, $86, $FF, $80, $FA, $90, $F0, $1F
    db $3F, $1F, $FF, $00, $E0, $80, $FF, $00, $FF, $18, $FA, $1A, $F0, $00, $FF, $0F
    db $FF, $0F, $E0, $E0, $DC, $60, $F0, $00, $C0, $E0, $E0, $DC, $F0, $10, $C0, $C0
    db $E0, $E0, $00, $B6, $05, $FF, $00, $B4, $11, $DB, $04, $AE, $70, $F8, $20, $77
    db $10, $EF, $B6, $B6, $FF, $DA, $FF, $A0, $FF, $80, $FF, $00, $FF, $80, $7F, $C0
    db $FF, $E0, $00, $00, $40, $C0, $00, $D0, $00, $70, $00, $F0, $C0, $DF, $73, $CF
    db $08, $4F, $00, $00, $C0, $80, $D0, $50, $F0, $30, $F0, $10, $DF, $3F, $FF, $00
    db $CF, $30, $C0, $FF, $30, $6F, $52, $FF, $41, $F7, $40, $FF, $E0, $FB, $40, $F7
    db $60, $F7, $FF, $20, $FF, $40, $FF, $A0, $FF, $A0, $FF, $A1, $FF, $01, $FF, $A1
    db $FF, $81, $50, $DC, $18, $DC, $58, $DC, $38, $BD, $D8, $DF, $C0, $ED, $E2, $ED
    db $E1, $FF, $DF, $20, $DF, $20, $DF, $20, $BF, $40, $DF, $20, $EF, $38, $EF, $1C
    db $FF, $1E, $7F, $03, $03, $7F, $03, $03, $03, $00, $01, $00, $03, $01, $07, $03
    db $3F, $B3, $FF, $D0, $FF, $03, $01, $01, $03, $02, $07, $06, $3F, $3C, $FF, $CC
    db $FF, $3F, $00, $05, $05, $06, $06, $0C, $0E, $E8, $EE, $F1, $F5, $E8, $FF, $60
    db $7F, $5B, $7D, $00, $05, $06, $07, $00, $0F, $08, $EE, $F1, $BC, $A3, $FF, $80
    db $7F, $07, $70, $70, $00, $13, $F3, $00, $3E, $08, $7C, $46, $7E, $87, $FF, $43
    db $FF, $03, $FF, $06, $FE, $00, $F3, $0C, $FF, $00, $FC, $03, $7E, $81, $FF, $80
    db $FF, $00, $FF, $00, $FE, $81, $00, $40, $E0, $40, $E0, $40, $E0, $40, $B0, $50
    db $98, $4C, $99, $07, $A0, $16, $D8, $00, $E0, $20, $E0, $20, $E0, $20, $F0, $30
    db $D8, $2C, $DD, $33, $E7, $38, $DE, $39, $1F, $00, $80, $80, $E0, $C0, $C0, $1F
    db $80, $80, $E0, $60, $C0, $30, $C0, $44, $E5, $40, $A0, $60, $E0, $3F, $FF, $7F
    db $FF, $00, $80, $C0, $E5, $27, $E0, $20, $E0, $20, $FF, $7F, $FF, $7F, $80, $80
    db $EE, $00, $50, $E0, $E0, $EE, $50, $D8, $E0, $E0, $00, $AA, $97, $12, $FF, $F4
    db $FF, $0D, $9F, $08, $3F, $94, $A5, $C0, $E3, $C8, $DF, $00, $FF, $00, $FF, $F8
    db $FF, $08, $FF, $10, $3F, $F0, $BF, $60, $EF, $30, $DF, $30, $00, $D8, $DC, $68
    db $CC, $08, $4D, $48, $CF, $00, $CD, $44, $CB, $42, $5F, $E0, $EB, $00, $DF, $20
    db $EF, $10, $CF, $30, $CF, $30, $CF, $38, $CF, $38, $5F, $BC, $EB, $18, $80, $D0
    db $FB, $58, $FF, $15, $5F, $01, $FF, $30, $FF, $7E, $FE, $C0, $C0, $80, $FF, $20
    db $FF, $E0, $FF, $00, $FF, $00, $FF, $47, $FE, $FE, $C0, $C0, $C0, $C0, $CB, $80
    db $DB, $1A, $FF, $74, $FC, $F0, $FF, $1C, $1F, $C0, $CB, $18, $DB, $7A, $FF, $FC
    db $FF, $F8, $FF, $F8, $1F, $1F, $03, $01, $01, $01, $01, $03, $03, $3A, $3B, $3C
    db $3D, $3A, $3F, $03, $01, $01, $01, $00, $03, $02, $3B, $3C, $2F, $28, $3F, $20
    db $00, $2A, $3F, $F4, $FF, $44, $7C, $80, $8F, $02, $9F, $11, $9F, $61, $7F, $10
    db $FF, $00, $3F, $30, $FF, $CF, $7C, $83, $FF, $00, $FF, $00, $9F, $60, $3F, $E0
    db $FF, $00, $E0, $38, $7F, $36, $FF, $59, $FE, $BE, $FF, $0F, $0F, $E0, $7F, $41
    db $FC, $9C, $F8, $90, $FF, $FC, $0F, $0F, $80, $00, $FF, $C0, $7F, $54, $BC, $F8
    db $F8, $E8, $FF, $F6, $FF, $07, $07, $80, $FF, $C0, $3F, $21, $3F, $28, $FF, $70
    db $FF, $F0, $FF, $F9, $07, $07, $00, $00, $BC, $00, $DC, $00, $FC, $00, $EF, $00
    db $7F, $00, $1F, $00, $83, $00, $83, $00, $FC, $04, $FC, $04, $FC, $80, $FF, $C1
    db $7F, $E0, $1F, $9C, $83, $82, $83, $82, $06, $00, $08, $00, $80, $00, $40, $00
    db $C0, $00, $C0, $00, $C0, $06, $08, $08, $80, $80, $C0, $40, $C0, $00, $C0, $40
    db $C0, $40, $F0, $80, $87, $F0, $FF, $E8, $FF, $FE, $FF, $F0, $87, $84, $FF, $F8
    db $FF, $F0, $FF, $F1, $F0, $00, $C0, $00, $C0, $00, $80, $C0, $C0, $F0, $C0, $40
    db $C0, $40, $80, $80, $C0, $C0, $C0, $8F, $9F, $C0, $EF, $08, $DF, $09, $1F, $0E
    db $1F, $00, $0E, $C0, $9F, $7C, $EF, $28, $DF, $D0, $1F, $10, $1F, $11, $0E, $0E
    db $00, $48, $FD, $18, $FF, $20, $FF, $00, $E4, $00, $04, $00, $02, $02, $06, $06
    db $0E, $00, $FD, $87, $FF, $07, $FF, $1F, $E4, $E7, $04, $07, $02, $03, $06, $05
    db $0E, $09, $E0, $3F, $3F, $FF, $FF, $FF, $FF, $3F, $3F, $03, $03, $E0, $3F, $3F
    db $FF, $FF, $FF, $FF, $3F, $3F, $03, $03, $E0, $EC, $FD, $FF, $FF, $FF, $FF, $FF
    db $FF, $F8, $F8, $E0, $FD, $F3, $FF, $FF, $FF, $FF, $FF, $FF, $F8, $F8, $F8, $1B
    db $1F, $0E, $0E, $01, $01, $F8, $1F, $11, $0E, $0A, $01, $00, $EC, $00, $01, $00
    db $01, $40, $40, $EC, $01, $01, $01, $01, $40, $00, $FF, $FF, $F9, $1F, $1F, $1F
    db $1F, $F9, $1F, $1F, $1F, $1F, $04, $0D, $03, $37, $98, $9E, $20, $F8, $E8, $F8
    db $18, $7C, $30, $FF, $E8, $FD, $0F, $08, $3F, $30, $FF, $00, $FF, $F0, $FF, $10
    db $FF, $20, $FF, $C0, $FF, $00, $00, $C0, $C0, $D0, $20, $2C, $10, $50, $18, $BC
    db $14, $D7, $28, $A8, $14, $D6, $C0, $C0, $D0, $30, $EC, $1C, $F0, $08, $FC, $04
    db $F7, $0B, $E8, $14, $D6, $2A, $F0, $F6, $A0, $EF, $F0, $F9, $60, $F7, $90, $FF
    db $58, $7D, $82, $FF, $10, $1F, $FF, $00, $FF, $00, $FF, $00, $FF, $80, $FF, $E0
    db $7F, $60, $FF, $FC, $1F, $FF, $6C, $6D, $28, $A9, $55, $D5, $4B, $EB, $03, $E3
    db $05, $F5, $01, $F9, $C8, $FD, $ED, $13, $A9, $56, $D5, $2A, $EB, $34, $E3, $3C
    db $F5, $1A, $F9, $0E, $FD, $07, $07, $01, $01, $06, $07, $06, $06, $0C, $0E, $E8
    db $EE, $07, $01, $01, $07, $07, $07, $00, $0F, $08, $EE, $F1, $01, $04, $3E, $5E
    db $FF, $50, $7F, $13, $F3, $00, $3E, $08, $7C, $46, $7E, $01, $3E, $3E, $FF, $81
    db $FF, $BF, $F3, $0C, $FF, $00, $FC, $03, $7E, $81, $00, $F1, $F5, $E8, $FF, $60
    db $7F, $56, $7B, $0A, $0B, $0B, $0F, $16, $17, $17, $1D, $00, $BC, $A3, $FF, $80
    db $7F, $07, $60, $60, $0D, $0F, $09, $07, $1A, $0E, $11, $00, $00, $83, $FF, $40
    db $FF, $03, $FF, $06, $FE, $1D, $FD, $52, $D2, $CC, $FC, $40, $41, $00, $FF, $80
    db $FF, $00, $FF, $00, $FE, $81, $FD, $83, $D2, $AE, $FC, $7C, $41, $C1, $00, $00
    db $FE, $00, $77, $00, $3F, $80, $8F, $80, $A3, $C0, $D3, $60, $F3, $20, $71, $00
    db $FE, $C0, $7F, $E1, $3F, $F0, $8F, $4C, $A3, $62, $D3, $32, $F3, $92, $71, $50
    db $01, $00, $80, $00, $40, $00, $C0, $00, $C0, $20, $E0, $00, $E0, $30, $F0, $01
    db $80, $80, $C0, $40, $C0, $00, $C0, $40, $E0, $60, $E0, $20, $F0, $10, $FE, $00
    db $31, $FE, $31, $31, $F8, $30, $F0, $70, $F0, $20, $60, $F8, $F0, $10, $F0, $90
    db $60, $60, $5F, $00, $80, $20, $F0, $5F, $80, $80, $F0, $10, $7F, $00, $20, $7F
    db $20, $20, $00, $80, $F8, $80, $8C, $80, $CF, $81, $CE, $80, $D7, $00, $EE, $00
    db $DE, $00, $EE, $00, $F8, $08, $FC, $04, $FF, $03, $FF, $02, $FF, $01, $FE, $82
    db $FE, $82, $FE, $82, $80, $00, $B4, $12, $7F, $FD, $0F, $F2, $DF, $0C, $BF, $00
    db $54, $00, $02, $80, $B4, $B4, $7F, $C9, $FF, $00, $FF, $00, $BF, $F1, $54, $54
    db $02, $02, $02, $06, $01, $1B, $4C, $CF, $10, $FC, $06, $FE, $14, $5E, $01, $B7
    db $04, $FE, $07, $04, $1F, $18, $FF, $80, $FF, $F8, $FF, $F8, $FF, $00, $FF, $00
    db $FF, $00, $00, $E0, $A0, $E8, $10, $1E, $08, $28, $04, $5E, $02, $6B, $10, $D5
    db $0A, $EA, $E0, $60, $E8, $18, $FE, $06, $F8, $04, $FE, $02, $FB, $05, $F5, $0B
    db $EA, $15, $A8, $FF, $02, $FF, $C6, $C6, $00, $43, $C4, $F7, $02, $C3, $0F, $CF
    db $16, $56, $FF, $00, $FF, $FC, $C7, $38, $43, $FC, $F7, $F8, $C3, $FC, $CF, $F0
    db $56, $69, $24, $34, $15, $D5, $08, $E8, $27, $F7, $40, $F0, $D2, $DA, $E0, $E0
    db $A0, $A4, $F4, $0B, $D5, $2A, $E8, $17, $F7, $18, $F0, $1F, $DA, $2D, $E0, $1F
    db $A4, $5F, $00, $C0, $00, $79, $69, $7F, $35, $BF, $10, $1B, $50, $DC, $05, $7D
    db $72, $76, $C0, $C0, $F9, $B9, $FE, $87, $FA, $CF, $FF, $EC, $FF, $AF, $7E, $7B
    db $77, $7D, $00, $00, $02, $DF, $0F, $7F, $08, $BF, $40, $DF, $4C, $FE, $04, $67
    db $81, $FB, $00, $00, $DF, $DF, $FF, $60, $FF, $9F, $BF, $DF, $BF, $40, $FF, $80
    db $7F, $80, $79, $7B, $74, $7F, $30, $7F, $2B, $3D, $05, $05, $05, $07, $0B, $0B
    db $0B, $0E, $5F, $52, $7F, $41, $7F, $43, $30, $30, $06, $07, $04, $03, $0D, $07
    db $08, $00, $D3, $FF, $00, $FF, $41, $FF, $03, $FF, $16, $7E, $C9, $C9, $66, $FE
    db $A0, $A0, $FF, $00, $FF, $FF, $FF, $80, $7F, $40, $FE, $C1, $C9, $B7, $7E, $3E
    db $A0, $60, $00, $06, $FE, $59, $FD, $C0, $DB, $43, $EF, $8C, $CC, $00, $9E, $10
    db $1C, $04, $0D, $00, $FE, $81, $FD, $A7, $DB, $FF, $EF, $EC, $CF, $40, $9F, $90
    db $1F, $00, $0F, $08, $00, $40, $F7, $62, $EF, $90, $F7, $02, $D7, $04, $7E, $30
    db $7C, $C0, $F0, $80, $C0, $00, $FF, $81, $FF, $81, $FF, $61, $FF, $01, $FE, $02
    db $FC, $0C, $F0, $30, $C0, $40, $FC, $01, $07, $00, $03, $FC, $07, $04, $03, $03
    db $FE, $00, $80, $FE, $80, $80, $07, $00, $08, $00, $2D, $04, $1F, $3F, $43, $7C
    db $B7, $07, $08, $08, $2D, $2D, $1F, $32, $7F, $C0, $FF, $80, $0F, $00, $20, $80
    db $C0, $60, $F0, $B0, $F8, $0F, $20, $20, $C0, $40, $F0, $10, $F8, $08, $00, $43
    db $EF, $80, $D5, $80, $C0, $80, $C0, $00, $C0, $00, $80, $80, $C0, $80, $C0, $00
    db $EF, $BC, $D5, $55, $C0, $40, $C0, $40, $C0, $C0, $80, $80, $C0, $40, $C0, $40
    db $FA, $00, $E0, $00, $80, $FA, $E0, $60, $80, $80, $00, $00, $36, $36, $7E, $54
    db $FD, $83, $A7, $06, $47, $82, $96, $20, $6A, $C3, $F7, $00, $36, $36, $7E, $48
    db $FF, $81, $FF, $00, $FF, $01, $FE, $01, $FE, $01, $FF, $00, $07, $00, $40, $00
    db $88, $08, $FC, $5C, $7F, $02, $1F, $07, $40, $40, $88, $88, $FC, $F4, $7F, $83
    db $1F, $E1, $00, $03, $E7, $C1, $EF, $21, $73, $63, $EF, $41, $F7, $63, $FF, $C3
    db $FF, $63, $FF, $00, $FF, $E0, $FF, $20, $FF, $40, $FF, $80, $FF, $80, $FF, $80
    db $FF, $04, $FF, $80, $00, $21, $77, $40, $CB, $40, $C7, $41, $EF, $C0, $D7, $80
    db $EF, $A0, $FE, $18, $FF, $00, $7F, $C0, $FF, $80, $FF, $80, $FF, $80, $FF, $01
    db $FF, $41, $FF, $40, $FF, $E0, $03, $03, $05, $05, $06, $06, $0C, $0E, $E8, $EE
    db $F1, $F5, $E8, $FF, $60, $7F, $03, $03, $05, $06, $07, $00, $0F, $08, $EE, $F1
    db $BC, $A3, $FF, $80, $7F, $07, $D0, $FF, $13, $F3, $00, $3E, $08, $7C, $46, $7E
    db $87, $FF, $43, $FF, $03, $FF, $FF, $3F, $F3, $0C, $FF, $00, $FC, $03, $7E, $81
    db $FF, $80, $FF, $00, $FF, $00, $5B, $7D, $25, $3A, $1B, $1F, $0F, $1F, $0B, $0F
    db $07, $0F, $06, $0F, $00, $06, $70, $70, $20, $00, $1F, $11, $1F, $1E, $0F, $04
    db $0F, $08, $0F, $09, $06, $06, $06, $FE, $59, $FD, $C0, $DB, $43, $EF, $8C, $CC
    db $00, $9E, $10, $1C, $04, $0D, $FE, $81, $FD, $A7, $DB, $FF, $EF, $EC, $CF, $40
    db $9F, $90, $1F, $00, $0F, $08, $00, $00, $38, $00, $58, $00, $B8, $00, $78, $00
    db $B8, $00, $F8, $00, $DE, $00, $FD, $00, $F8, $08, $F8, $00, $F8, $08, $F8, $08
    db $F8, $08, $F8, $00, $FE, $86, $FF, $C1, $FF, $FF, $00, $00, $3F, $00, $8F, $00
    db $4F, $80, $CF, $80, $C7, $00, $C7, $01, $03, $00, $01, $00, $3F, $30, $8F, $89
    db $4F, $C9, $CF, $48, $C7, $40, $C7, $C4, $03, $02, $01, $01, $03, $80, $80, $00
    db $80, $C0, $C0, $C0, $C0, $C0, $C0, $80, $80, $03, $80, $80, $80, $80, $C0, $40
    db $C0, $40, $C0, $40, $80, $80, $00, $40, $DF, $41, $FF, $C3, $DF, $6F, $7F, $1A
    db $FE, $FD, $FD, $EC, $FD, $54, $FE, $00, $DF, $20, $FF, $40, $FF, $40, $FF, $C0
    db $7E, $65, $FD, $42, $FD, $C3, $FE, $82, $00, $9E, $DF, $02, $C3, $48, $6B, $80
    db $83, $80, $93, $00, $5F, $00, $19, $00, $08, $00, $DF, $60, $C3, $7C, $6B, $B6
    db $83, $7E, $93, $7E, $5F, $DF, $19, $1F, $08, $0F, $00, $8C, $DC, $08, $8C, $08
    db $1C, $00, $FC, $20, $FC, $10, $F8, $C0, $F0, $00, $C0, $00, $FC, $00, $FC, $04
    db $FC, $00, $FC, $04, $FC, $04, $F8, $28, $F0, $30, $C0, $C0, $E0, $02, $02, $02
    db $06, $03, $03, $01, $03, $00, $01, $E0, $02, $05, $06, $05, $03, $00, $03, $02
    db $01, $01, $02, $03, $03, $00, $13, $01, $0D, $1A, $7A, $75, $F5, $3A, $FA, $7C
    db $FC, $02, $03, $02, $13, $13, $0D, $0E, $7A, $75, $F5, $8A, $FA, $C5, $FC, $83
    db $00, $AD, $FF, $CE, $FF, $7F, $7F, $51, $5F, $06, $27, $10, $3F, $10, $7D, $0F
    db $8F, $00, $F7, $37, $FF, $C0, $7F, $C0, $7F, $FF, $38, $FF, $36, $E6, $7F, $F0
    db $8F, $8F, $F8, $78, $FB, $30, $74, $00, $30, $F8, $FB, $87, $74, $4C, $30, $30
    db $80, $00, $01, $01, $03, $00, $03, $06, $07, $05, $07, $02, $07, $00, $03, $80
    db $01, $01, $03, $02, $03, $02, $07, $04, $07, $00, $07, $05, $03, $03, $07, $00
    db $08, $08, $0C, $0C, $1D, $04, $1E, $0A, $5E, $07, $08, $08, $0C, $04, $1D, $11
    db $1E, $12, $5E, $40, $FF, $FF, $00, $14, $3F, $14, $1E, $0E, $3B, $0C, $13, $8C
    db $EA, $0C, $F9, $08, $34, $00, $38, $00, $3F, $21, $1E, $02, $3F, $31, $1F, $11
    db $EE, $72, $FD, $33, $FC, $14, $F8, $08, $F7, $00, $80, $F7, $80, $80, $07, $40
    db $68, $8C, $EC, $A8, $FB, $56, $FF, $40, $EC, $07, $68, $28, $EC, $AD, $FF, $11
    db $BF, $40, $EF, $10, $0F, $40, $40, $00, $80, $80, $A0, $40, $78, $0F, $40, $40
    db $80, $80, $A0, $60, $F8, $18, $00, $50, $F0, $28, $E9, $20, $F9, $D1, $F7, $CA
    db $FF, $05, $FF, $1A, $FF, $39, $FB, $00, $FF, $00, $EF, $10, $FF, $18, $F7, $0C
    db $FF, $84, $FF, $00, $FF, $00, $FF, $10, $00, $20, $A0, $10, $78, $08, $AE, $40
    db $54, $A8, $AB, $12, $D3, $56, $56, $22, $A3, $00, $E0, $10, $F8, $08, $EE, $16
    db $D4, $2C, $AB, $54, $D3, $2C, $57, $A8, $A3, $5C, $07, $00, $01, $00, $01, $01
    db $03, $02, $03, $00, $01, $07, $01, $01, $01, $01, $03, $02, $03, $00, $01, $02
    db $07, $80, $80, $40, $C2, $40, $C9, $9E, $FF, $82, $FD, $07, $80, $00, $C2, $42
    db $C9, $09, $7F, $B3, $FF, $21, $00, $00, $01, $01, $01, $05, $07, $06, $07, $02
    db $0F, $00, $05, $03, $07, $01, $01, $00, $01, $02, $01, $02, $07, $06, $07, $04
    db $0F, $0C, $05, $06, $07, $04, $01, $02, $00, $88, $E3, $00, $F1, $00, $F3, $C0
    db $E1, $E1, $F3, $12, $FF, $10, $FF, $29, $D2, $00, $F7, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $61, $FF, $12, $FF, $00, $E7, $00, $1F, $00, $80, $80, $C0, $C0
    db $C0, $1F, $80, $80, $C0, $40, $C0, $00, $FF, $FF, $00, $40, $E0, $40, $E0, $40
    db $E0, $40, $B0, $50, $98, $4C, $99, $07, $A0, $16, $D8, $00, $E0, $20, $E0, $20
    db $E0, $20, $F0, $30, $D8, $2C, $DD, $33, $E7, $38, $DE, $39, $1F, $00, $80, $80
    db $E0, $C0, $C0, $1F, $80, $80, $E0, $60, $C0, $30, $07, $00, $D8, $11, $FB, $00
    db $D3, $44, $6D, $10, $BB, $07, $D8, $D8, $FB, $6A, $FF, $81, $FF, $00, $FF, $00
    db $0F, $00, $0F, $03, $6F, $28, $FF, $00, $CC, $0F, $0F, $0F, $6F, $70, $FF, $C0
    db $CF, $70, $00, $AA, $97, $12, $FF, $F4, $FF, $0D, $9F, $08, $3F, $94, $A5, $C0
    db $E3, $C8, $DF, $00, $FF, $00, $FF, $F8, $FF, $08, $FF, $10, $3F, $F0, $BF, $60
    db $EF, $30, $DF, $30, $00, $D8, $DC, $68, $CC, $08, $4D, $48, $CF, $00, $CD, $44
    db $CB, $42, $5F, $E0, $EB, $00, $DF, $20, $EF, $10, $CF, $30, $CF, $30, $CF, $38
    db $CF, $38, $5F, $BC, $EB, $18, $FF, $FF, $07, $00, $02, $00, $01, $00, $0A, $00
    db $0F, $04, $2E, $07, $02, $02, $01, $01, $0B, $0A, $0F, $0A, $2F, $28, $03, $01
    db $01, $01, $01, $03, $03, $3A, $3B, $3C, $3D, $3A, $3F, $03, $01, $01, $01, $00
    db $03, $02, $3B, $3C, $2F, $28, $3F, $20, $00, $2A, $3F, $F4, $FF, $44, $7C, $80
    db $8F, $02, $9F, $11, $9F, $61, $7F, $10, $FF, $00, $3F, $30, $FF, $CF, $7C, $83
    db $FF, $00, $FF, $00, $9F, $60, $3F, $E0, $FF, $00, $00, $A0, $F7, $18, $7E, $98
    db $FF, $E8, $CE, $F0, $7D, $F8, $FE, $70, $7E, $F1, $FF, $00, $F7, $0C, $7F, $84
    db $FF, $98, $EF, $10, $3F, $38, $7F, $30, $7F, $F8, $FF, $F8, $00, $00, $80, $80
    db $80, $00, $C0, $00, $C0, $00, $C0, $40, $E0, $20, $70, $40, $E8, $00, $80, $80
    db $80, $00, $C0, $40, $C0, $40, $C0, $40, $E0, $20, $F0, $10, $F8, $08, $F8, $F1
    db $FD, $FC, $FF, $C4, $C7, $F8, $FF, $F8, $FF, $F9, $C7, $C7, $F8, $00, $38, $00
    db $F0, $00, $C0, $F8, $F8, $28, $F0, $30, $C0, $C0, $00, $00, $0E, $09, $0B, $00
    db $1E, $00, $1B, $00, $1D, $10, $3B, $20, $73, $14, $BF, $00, $0E, $0B, $0F, $02
    db $1E, $11, $1F, $10, $1F, $10, $3F, $20, $7F, $40, $FF, $80, $00, $59, $FF, $80
    db $E9, $96, $FF, $76, $3F, $76, $E0, $F7, $FA, $69, $E9, $78, $F9, $00, $FF, $00
    db $EF, $10, $FB, $9B, $7F, $80, $CF, $C9, $E0, $40, $E6, $FF, $FF, $F0, $F8, $04
    db $E5, $01, $7F, $01, $1F, $F8, $FF, $A0, $7F, $64, $1F, $1F, $F0, $7F, $FF, $FF
    db $FF, $3F, $3F, $0F, $0F, $F0, $FF, $FF, $FF, $FF, $3F, $3F, $0F, $0F, $01, $00
    db $68, $40, $F0, $30, $38, $88, $AC, $20, $FA, $88, $AF, $ED, $FD, $01, $68, $68
    db $F0, $90, $F8, $08, $FC, $04, $FE, $02, $FF, $01, $FF, $00, $BF, $00, $80, $BF
    db $80, $80, $00, $FF, $FF, $1C, $DF, $61, $E7, $28, $FF, $16, $77, $34, $7F, $C0
    db $D7, $88, $BF, $00, $FF, $00, $DF, $E2, $FF, $9C, $FF, $00, $F7, $08, $FF, $08
    db $D7, $6C, $3F, $C4, $01, $00, $80, $80, $C0, $80, $C0, $80, $C0, $80, $C0, $00
    db $80, $00, $80, $01, $80, $80, $C0, $40, $C0, $40, $C0, $40, $C0, $40, $80, $80
    db $80, $80, $07, $00, $01, $01, $07, $01, $03, $01, $0F, $0D, $0F, $07, $01, $01
    db $07, $06, $03, $00, $0F, $0C, $0F, $00, $00, $00, $04, $04, $2E, $22, $B7, $48
    db $DB, $02, $8F, $11, $F5, $AC, $FF, $7F, $FF, $00, $04, $04, $2E, $2A, $BF, $91
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $00, $0F, $0F, $07, $0F, $08
    db $1E, $0A, $1E, $0E, $1E, $0A, $0F, $07, $0F, $01, $0F, $00, $0F, $00, $0F, $08
    db $1F, $13, $1E, $11, $1E, $11, $0F, $01, $0F, $0A, $0F, $0A, $00, $F1, $FB, $8F
    db $BF, $61, $7E, $40, $F0, $80, $E0, $C0, $EA, $30, $B9, $1F, $DF, $00, $FB, $0E
    db $BF, $79, $FF, $90, $FF, $00, $FF, $00, $FF, $00, $BF, $60, $CF, $39, $00, $61
    db $EB, $C5, $DF, $D1, $FB, $0D, $BF, $48, $F8, $73, $E3, $76, $37, $F0, $72, $00
    db $EB, $36, $9F, $E2, $FB, $06, $BF, $42, $F8, $CF, $F3, $0C, $97, $98, $33, $1C
    db $00, $80, $C0, $80, $80, $00, $80, $80, $80, $80, $80, $00, $C0, $C0, $E0, $08
    db $58, $00, $C0, $40, $80, $00, $80, $80, $80, $80, $80, $80, $C0, $C0, $E0, $20
    db $F8, $00, $F8, $B2, $BB, $7B, $FF, $84, $87, $F8, $3B, $FC, $FF, $7C, $87, $87
    db $F8, $90, $FC, $10, $FC, $D0, $F8, $F8, $FC, $04, $FC, $84, $F8, $B8, $00, $07
    db $0F, $06, $07, $06, $07, $06, $07, $02, $06, $07, $0F, $0D, $1F, $40, $69, $00
    db $0F, $09, $07, $01, $07, $01, $07, $05, $06, $07, $0F, $08, $1F, $10, $7F, $00
    db $00, $98, $DC, $8F, $EF, $2C, $7F, $C0, $F4, $4B, $7F, $3B, $1F, $BB, $B0, $BB
    db $FD, $00, $DF, $30, $E7, $1C, $7F, $80, $F7, $08, $7D, $CD, $3F, $C0, $A7, $64
    db $F0, $60, $F8, $25, $FF, $23, $FF, $2C, $7F, $F8, $FF, $80, $FF, $84, $7F, $77
    db $F8, $74, $F4, $7C, $FC, $8F, $8F, $F8, $F3, $FF, $FF, $F8, $8F, $8F, $03, $00
    db $40, $80, $90, $80, $F8, $40, $F8, $38, $3E, $96, $B7, $03, $40, $C0, $90, $70
    db $F8, $78, $F8, $98, $FE, $06, $FF, $01, $FF, $FF, $00, $B8, $FD, $6A, $6F, $1F
    db $1F, $82, $FE, $B1, $75, $11, $79, $0B, $3B, $19, $3F, $00, $FF, $01, $6F, $90
    db $1F, $E0, $FE, $E1, $FD, $4E, $F9, $06, $FB, $04, $FF, $06, $00, $00, $80, $00
    db $80, $00, $C0, $80, $80, $C0, $C0, $80, $C0, $C0, $C0, $80, $C0, $00, $80, $80
    db $80, $80, $C0, $C0, $80, $00, $C0, $00, $C0, $40, $C0, $00, $C0, $40, $3F, $00
    db $01, $01, $07, $3F, $01, $01, $07, $06, $03, $00, $17, $0D, $4F, $0A, $EA, $10
    db $FF, $A4, $EF, $02, $C7, $03, $17, $1F, $4F, $70, $EA, $F5, $FF, $ED, $FF, $00
    db $FF, $00, $00, $01, $03, $03, $07, $05, $0F, $0A, $0B, $0C, $1D, $04, $0C, $0E
    db $0E, $07, $0F, $00, $03, $02, $07, $04, $0F, $08, $0B, $04, $1D, $13, $0C, $0B
    db $0E, $01, $0F, $09, $00, $AD, $FD, $52, $DA, $60, $E5, $07, $DF, $30, $3F, $20
    db $78, $40, $70, $60, $F5, $00, $FD, $02, $DA, $25, $E5, $1F, $DF, $3C, $FF, $C8
    db $7F, $80, $7F, $80, $FF, $80, $00, $02, $FF, $10, $FF, $24, $6D, $00, $09, $00
    db $09, $00, $11, $00, $10, $20, $31, $00, $FF, $81, $FF, $83, $6D, $4B, $09, $0F
    db $09, $0F, $11, $1F, $10, $1F, $31, $3F, $00, $C7, $EF, $3E, $BF, $00, $06, $00
    db $02, $00, $02, $38, $3A, $FC, $FC, $FC, $FE, $00, $FF, $44, $BF, $B9, $06, $07
    db $02, $03, $02, $03, $3A, $3B, $FC, $FF, $FE, $FF, $FC, $23, $3F, $1F, $1F, $FC
    db $3F, $3F, $1F, $1F, $F0, $FF, $FF, $FF, $FF, $FC, $FC, $30, $30, $F0, $FF, $FF
    db $FF, $FF, $FC, $FC, $30, $30, $01, $0F, $1C, $3D, $23, $73, $02, $67, $04, $57
    db $16, $7F, $19, $7D, $48, $7E, $0F, $0D, $3D, $23, $7F, $5C, $77, $48, $77, $48
    db $7F, $58, $7D, $53, $7E, $11, $8E, $DF, $78, $FE, $0B, $F7, $01, $87, $00, $03
    db $01, $53, $86, $CE, $FC, $FD, $DF, $72, $FE, $CF, $FF, $84, $FF, $00, $FF, $00
    db $FF, $00, $FE, $03, $79, $CE, $42, $F7, $6C, $FF, $F5, $F7, $9B, $FB, $A3, $FF
    db $E0, $E7, $21, $E3, $40, $69, $F7, $98, $FF, $90, $F7, $0C, $FB, $0C, $FF, $07
    db $FF, $03, $FF, $C0, $7F, $00, $CD, $FF, $00, $4B, $B6, $FF, $39, $FF, $D7, $BB
    db $AA, $AB, $11, $FF, $44, $FF, $FF, $00, $7B, $84, $DF, $DC, $7D, $00, $83, $83
    db $D7, $FF, $83, $BA, $D7, $92, $00, $8F, $DF, $FA, $FA, $04, $04, $10, $10, $81
    db $B9, $00, $7C, $00, $69, $00, $29, $00, $FF, $88, $FA, $75, $04, $FB, $10, $EF
    db $B9, $7E, $7C, $FF, $69, $EF, $29, $EF, $C0, $40, $50, $00, $E0, $00, $20, $80
    db $A0, $00, $20, $00, $C0, $C0, $50, $B0, $E0, $E0, $20, $E0, $A0, $60, $20, $E0
    db $C0, $C0, $FC, $00, $01, $00, $82, $FC, $01, $EF, $82, $C6, $FF, $FF, $00, $A0
    db $F1, $FD, $16, $EE, $02, $0F, $01, $07, $03, $A7, $0C, $9D, $F8, $FB, $A0, $E0
    db $FD, $9E, $FF, $09, $FF, $00, $FF, $00, $FF, $00, $FD, $06, $F3, $9C, $00, $00
    db $C1, $C3, $08, $5F, $8B, $FF, $35, $7D, $00, $FF, $16, $76, $99, $F9, $00, $00
    db $C3, $02, $DF, $D4, $FC, $47, $4E, $F3, $FF, $E0, $79, $CF, $FF, $46, $9A, $FF
    db $01, $97, $6D, $FF, $72, $FE, $AE, $76, $54, $54, $27, $FF, $8F, $FF, $FF, $00
    db $F7, $08, $BF, $B9, $FA, $01, $06, $07, $AC, $FF, $07, $72, $AF, $24, $2C, $6F
    db $90, $D6, $88, $CC, $50, $DC, $90, $94, $C0, $C8, $B0, $B4, $E0, $E8, $6F, $D1
    db $D6, $6A, $CC, $B4, $DC, $A4, $94, $6C, $C8, $38, $B4, $4C, $E8, $18, $01, $08
    db $0C, $01, $1F, $0D, $1F, $9A, $FB, $40, $FF, $66, $F6, $09, $59, $01, $0C, $04
    db $1F, $12, $13, $1E, $F7, $6C, $FF, $80, $99, $EF, $7F, $76, $01, $38, $3B, $06
    db $A7, $04, $EF, $C8, $EE, $2C, $FE, $33, $FB, $91, $FD, $01, $3B, $07, $BF, $B9
    db $EF, $30, $2F, $F0, $FF, $70, $FB, $26, $FC, $23, $C0, $02, $0E, $01, $07, $01
    db $03, $00, $01, $00, $01, $00, $01, $C0, $0E, $09, $07, $04, $03, $02, $01, $01
    db $01, $01, $01, $01, $00, $C5, $EF, $18, $7E, $2B, $2F, $16, $1F, $5B, $DB, $A9
    db $A9, $7F, $FF, $3F, $BF, $00, $EF, $30, $7E, $A1, $2F, $D9, $1E, $E8, $DB, $A7
    db $A9, $57, $FF, $82, $BF, $C1, $00, $01, $87, $00, $03, $01, $53, $86, $CE, $FC
    db $FD, $CD, $FF, $00, $4B, $B6, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FE, $03
    db $79, $CE, $FF, $00, $7B, $84, $DF, $DC, $00, $50, $D8, $80, $B8, $80, $E8, $00
    db $B8, $48, $F8, $18, $BC, $D0, $FC, $EC, $FC, $00, $F8, $08, $B8, $48, $F8, $68
    db $B8, $68, $F8, $20, $BC, $64, $FC, $24, $FC, $C0, $80, $39, $FF, $D7, $BB, $AA
    db $AA, $93, $FF, $C6, $FE, $44, $6C, $00, $38, $80, $7D, $00, $83, $83, $D6, $FF
    db $83, $39, $D6, $92, $7C, $44, $38, $38, $E0, $40, $62, $00, $17, $01, $FF, $45
    db $FF, $3C, $7E, $E0, $7E, $C2, $7F, $81, $FF, $80, $FF, $A0, $7E, $6A, $00, $00
    db $00, $0A, $0B, $0F, $0D, $1F, $0A, $5F, $11, $3F, $24, $25, $23, $73, $00, $00
    db $0A, $0B, $0F, $04, $1F, $10, $5F, $50, $3F, $2D, $3D, $03, $7F, $5C, $00, $FA
    db $00, $62, $DE, $DF, $45, $D7, $00, $2F, $06, $57, $78, $FE, $0B, $F7, $FA, $FA
    db $62, $FE, $DF, $21, $DF, $20, $BF, $40, $57, $FA, $FE, $CF, $FF, $84, $02, $67
    db $04, $57, $16, $7F, $19, $7D, $48, $7E, $42, $F7, $2C, $FF, $D5, $F7, $77, $48
    db $77, $48, $7F, $58, $7D, $53, $7E, $11, $F7, $98, $FF, $90, $F7, $0C, $01, $87
    db $00, $03, $01, $53, $86, $CE, $FC, $FD, $CD, $FF, $00, $4B, $B6, $FF, $FF, $00
    db $FF, $00, $FF, $00, $FE, $03, $79, $CE, $FF, $00, $7B, $84, $DF, $DC, $00, $0D
    db $0F, $0A, $1F, $11, $3B, $21, $31, $01, $63, $C0, $FF, $A4, $FF, $42, $FF, $00
    db $0F, $08, $1F, $10, $3F, $20, $3F, $00, $7F, $40, $FF, $80, $FF, $00, $FF, $A5
    db $00, $D2, $D2, $E1, $E1, $D0, $D0, $40, $C0, $04, $84, $10, $90, $30, $B7, $32
    db $7E, $00, $D2, $2F, $E1, $1F, $D0, $2F, $C0, $BF, $84, $7F, $90, $EF, $B7, $CF
    db $7E, $4C, $FC, $18, $7E, $00, $18, $FC, $7E, $66, $18, $18, $80, $10, $36, $00
    db $44, $00, $48, $00, $88, $40, $C0, $20, $A8, $00, $60, $80, $36, $2E, $44, $7C
    db $48, $78, $88, $F8, $C0, $B8, $A8, $D8, $60, $60, $FF, $FF, $03, $00, $04, $00
    db $06, $04, $0F, $06, $BF, $1C, $7C, $20, $B3, $03, $04, $04, $06, $02, $0F, $09
    db $BF, $B9, $7C, $63, $FF, $90, $00, $00, $03, $00, $01, $00, $01, $01, $03, $00
    db $05, $05, $07, $02, $07, $0F, $0F, $00, $03, $03, $01, $01, $01, $01, $03, $02
    db $07, $00, $07, $00, $07, $04, $0F, $08, $00, $90, $D9, $13, $BB, $27, $7F, $48
    db $E9, $AF, $EF, $64, $ED, $53, $DB, $ED, $ED, $00, $D9, $6E, $FB, $0C, $FF, $08
    db $E9, $16, $EF, $10, $ED, $1A, $DB, $AC, $ED, $16, $01, $20, $20, $78, $78, $1F
    db $1F, $0F, $0F, $9F, $9F, $7F, $7F, $FF, $FF, $01, $20, $20, $78, $78, $1F, $1F
    db $0F, $0F, $9F, $9F, $7F, $7F, $FF, $FF, $00, $40, $40, $C0, $C0, $E3, $E3, $FF
    db $FF, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $00, $40, $40, $C0, $C0, $E3, $E3
    db $FF, $FF, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $21, $21, $FE, $21, $21
    db $F8, $F8, $F8, $F0, $F0, $70, $70, $F8, $F8, $F8, $F0, $F0, $70, $70, $00, $6B
    db $6F, $87, $F7, $02, $07, $01, $03, $00, $03, $01, $03, $E3, $FF, $03, $07, $00
    db $6F, $93, $F5, $F9, $06, $FC, $03, $FE, $03, $FD, $03, $FC, $FF, $1C, $07, $04
    db $00, $D4, $FE, $C2, $F7, $81, $E3, $C0, $F1, $00, $FF, $09, $7F, $10, $BF, $86
    db $9F, $00, $FE, $C2, $FF, $E1, $BF, $A0, $FF, $20, $FF, $C0, $7F, $C0, $BF, $A9
    db $9F, $19, $C0, $01, $05, $01, $05, $00, $04, $01, $01, $00, $04, $00, $01, $C0
    db $05, $06, $05, $06, $04, $07, $01, $06, $04, $07, $01, $01, $C0, $00, $86, $00
    db $80, $80, $C0, $00, $40, $00, $40, $00, $80, $C0, $86, $86, $80, $80, $C0, $40
    db $40, $C0, $40, $C0, $80, $80, $03, $00, $08, $00, $5C, $4C, $FF, $79, $FF, $C2
    db $FE, $00, $F1, $03, $08, $08, $5C, $54, $FF, $A1, $FF, $E6, $FE, $01, $FF, $00
    db $1F, $00, $80, $00, $C0, $80, $E0, $1F, $80, $80, $C0, $C0, $E0, $60, $00, $80
    db $F9, $1E, $FF, $02, $FE, $84, $FF, $00, $FF, $84, $FF, $49, $FD, $8F, $FF, $00
    db $FF, $00, $FF, $0E, $FE, $01, $FF, $00, $FF, $00, $FF, $03, $FE, $06, $FE, $03
    db $00, $C0, $C0, $58, $D8, $3C, $BC, $1C, $FC, $0C, $FC, $78, $F8, $0C, $7C, $8C
    db $DC, $00, $C0, $40, $D8, $38, $F4, $14, $FC, $04, $FC, $04, $F8, $80, $FC, $FC
    db $AC, $A4, $80, $00, $DE, $21, $FF, $AD, $7F, $C0, $E1, $B3, $B3, $C0, $DE, $FF
    db $FF, $80, $DE, $21, $FF, $00, $F7, $37, $E1, $9E, $B3, $CC, $DE, $FF, $FF, $E1
    db $80, $00, $C0, $00, $C0, $C0, $80, $C0, $C0, $40, $40, $C0, $C0, $C0, $C0, $80
    db $C0, $00, $C0, $00, $C0, $00, $C0, $40, $40, $C0, $C0, $C0, $C0, $C0, $FF, $FF
    db $FF, $FF, $FF, $FF, $01, $00, $01, $01, $03, $02, $05, $02, $07, $07, $0D, $03
    db $0F, $07, $1E, $01, $01, $01, $03, $02, $07, $04, $07, $04, $0F, $08, $0F, $08
    db $1F, $10, $03, $04, $07, $04, $07, $04, $05, $05, $05, $08, $0E, $08, $09, $03
    db $07, $07, $07, $05, $07, $06, $07, $06, $0F, $0C, $0F, $00, $00, $0F, $1F, $1F
    db $7F, $4D, $7D, $43, $4B, $E2, $E6, $69, $FD, $08, $FA, $06, $FF, $00, $1F, $10
    db $7F, $60, $7D, $12, $7B, $6C, $D6, $ED, $FD, $06, $FA, $07, $FF, $01, $00, $00
    db $24, $60, $F8, $04, $27, $02, $93, $01, $E1, $A0, $5F, $43, $E3, $81, $DF, $00
    db $24, $64, $F8, $98, $FF, $03, $FF, $01, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $0F, $80, $C0, $00, $80, $00, $40, $C0, $38, $0F, $C0, $40, $80, $80, $40, $C0
    db $F8, $38, $00, $40, $3D, $81, $FF, $60, $9F, $C1, $B7, $80, $8E, $22, $66, $C0
    db $FF, $61, $6F, $00, $7F, $80, $FF, $00, $FF, $00, $FF, $00, $BE, $41, $7E, $81
    db $FF, $01, $7F, $80, $00, $00, $1A, $8A, $8F, $53, $53, $51, $53, $F1, $F3, $C1
    db $D7, $01, $0E, $01, $1E, $00, $1A, $E6, $8F, $71, $5F, $A0, $5F, $A0, $FF, $00
    db $DF, $20, $1F, $E0, $1F, $E0, $00, $B0, $FF, $30, $BB, $30, $77, $21, $7B, $61
    db $E7, $C1, $FF, $83, $D7, $05, $FD, $00, $FF, $40, $BF, $E0, $7F, $E0, $7F, $E0
    db $FF, $80, $FF, $01, $FF, $51, $FD, $D3, $00, $01, $F6, $D0, $EF, $C4, $DF, $00
    db $DF, $E8, $FB, $FA, $FF, $FC, $FC, $F0, $FF, $00, $FF, $E0, $FF, $E0, $DF, $D8
    db $DF, $DC, $FB, $FA, $FF, $FC, $FF, $F8, $FF, $F8, $FE, $C4, $FC, $FE, $FC, $FC
    db $FE, $1C, $1F, $FE, $1F, $1F, $00, $40, $60, $30, $A6, $1E, $03, $5B, $E3, $40
    db $B5, $60, $E0, $3E, $FE, $7F, $FF, $00, $60, $B0, $B6, $CE, $9F, $61, $FB, $24
    db $F5, $3F, $E0, $20, $FE, $7E, $FF, $7F, $6B, $00, $80, $00, $40, $80, $80, $63
    db $80, $80, $00, $C0, $40, $60, $80, $80, $FE, $00, $80, $FE, $80, $80, $FF, $FF
    db $00, $00, $24, $60, $F8, $04, $27, $02, $93, $01, $E1, $A0, $5F, $43, $E3, $81
    db $DF, $00, $24, $64, $F8, $98, $FF, $03, $FF, $01, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $0F, $80, $C0, $00, $80, $00, $40, $C0, $38, $0F, $C0, $40, $80, $80
    db $40, $C0, $F8, $38, $00, $41, $3D, $80, $FF, $60, $9F, $C0, $B7, $80, $8E, $22
    db $66, $C0, $FF, $61, $6F, $00, $7F, $80, $FF, $00, $FF, $00, $FF, $00, $BE, $41
    db $7E, $81, $FF, $01, $7F, $80, $00, $00, $1A, $8A, $8F, $93, $93, $D1, $D3, $91
    db $93, $A1, $B7, $C1, $CE, $81, $9E, $00, $1A, $E6, $8F, $71, $9F, $60, $DF, $20
    db $9F, $60, $BF, $40, $DF, $20, $9F, $60, $00, $B0, $FF, $30, $BB, $30, $77, $21
    db $7B, $61, $E7, $C1, $FF, $83, $D7, $05, $FD, $00, $FF, $40, $BF, $E0, $7F, $E0
    db $7F, $E0, $FF, $80, $FF, $01, $FF, $51, $FD, $D3, $00, $01, $16, $D0, $EF, $C4
    db $DF, $00, $DF, $E8, $FB, $FA, $FF, $FC, $FC, $F0, $FF, $00, $1F, $E0, $FF, $E0
    db $DF, $D8, $DF, $DC, $FB, $FA, $FF, $FC, $FF, $F8, $FF, $F8, $FE, $C4, $FC, $FE
    db $FC, $FC, $FE, $1C, $1F, $FE, $1F, $1F, $00, $40, $60, $30, $A6, $1E, $03, $5B
    db $E3, $40, $B5, $60, $E0, $3E, $FE, $7F, $FF, $00, $60, $B0, $B6, $CE, $9F, $61
    db $FB, $24, $F5, $3F, $E0, $20, $FE, $7E, $FF, $7F, $6B, $00, $80, $00, $40, $80
    db $80, $63, $80, $80, $00, $C0, $40, $60, $80, $80, $FE, $00, $80, $FE, $80, $80
    db $FF, $FF, $FF, $FF, $01, $00, $01, $01, $03, $02, $05, $02, $07, $07, $0D, $03
    db $0F, $07, $1E, $01, $01, $01, $03, $02, $07, $04, $07, $04, $0F, $08, $0F, $08
    db $1F, $10, $03, $02, $03, $03, $03, $02, $02, $05, $05, $0C, $0F, $08, $0B, $03
    db $03, $03, $03, $02, $03, $03, $07, $06, $0F, $08, $0F, $00, $00, $0F, $1F, $1F
    db $FF, $9D, $FD, $8B, $9B, $C6, $CE, $D5, $FD, $12, $F6, $0C, $FE, $00, $1F, $10
    db $FF, $E0, $FD, $22, $FB, $D4, $AE, $D9, $FD, $0A, $F6, $0D, $FE, $03, $FF, $FF
    db $01, $00, $01, $01, $03, $02, $05, $02, $07, $07, $0D, $03, $0F, $07, $1E, $01
    db $01, $01, $03, $02, $07, $04, $07, $04, $0F, $08, $0F, $08, $1F, $10, $03, $04
    db $06, $04, $07, $04, $05, $05, $05, $00, $06, $00, $01, $03, $06, $06, $07, $05
    db $07, $06, $07, $06, $07, $04, $07, $08, $00, $0F, $1F, $1F, $7F, $4D, $7D, $43
    db $4B, $E2, $E6, $69, $FD, $08, $FA, $06, $FF, $00, $1F, $10, $7F, $60, $7D, $12
    db $7B, $6C, $D6, $ED, $FD, $06, $FA, $07, $FF, $01, $FF, $FF, $01, $00, $01, $01
    db $03, $02, $05, $02, $07, $07, $0D, $03, $0F, $07, $1E, $01, $01, $01, $03, $02
    db $07, $04, $07, $04, $0F, $08, $0F, $08, $1F, $10, $03, $04, $06, $04, $07, $04
    db $05, $06, $07, $0C, $0E, $18, $1C, $03, $06, $06, $07, $05, $07, $06, $07, $00
    db $0F, $08, $1F, $10, $00, $0F, $1F, $0F, $3F, $25, $3D, $23, $27, $F2, $F2, $35
    db $FD, $06, $7F, $03, $7F, $00, $1F, $10, $3F, $30, $3D, $0A, $3F, $34, $EA, $F5
    db $FD, $02, $FF, $01, $FF, $00, $00, $2C, $2C, $28, $28, $30, $31, $09, $29, $19
    db $39, $24, $74, $11, $BD, $06, $E6, $00, $2C, $13, $28, $17, $31, $0F, $29, $36
    db $39, $26, $7C, $43, $FD, $82, $FE, $A1, $00, $40, $F8, $80, $F0, $80, $F0, $00
    db $F3, $81, $FF, $CE, $CF, $EC, $EF, $E4, $FC, $00, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $CF, $38, $E7, $1C, $FF, $00, $FC, $03, $7F, $00, $1F, $FC
    db $7F, $64, $1F, $1F, $E0, $E0, $FC, $B8, $BC, $D9, $DF, $67, $6F, $16, $1F, $E0
    db $FF, $80, $BF, $C0, $DF, $E0, $6B, $7B, $1F, $1F, $00, $01, $00, $00, $01, $07
    db $00, $06, $0A, $0B, $0C, $1F, $12, $1F, $01, $37, $01, $01, $00, $00, $07, $06
    db $07, $04, $0F, $00, $1F, $10, $1F, $00, $3F, $20, $00, $00, $00, $EE, $29, $69
    db $10, $3D, $00, $53, $00, $95, $A5, $FF, $63, $FF, $00, $00, $EE, $EE, $EF, $10
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $65, $7F, $67, $7F, $4F, $7F
    db $4D, $7F, $1F, $7F, $1E, $7E, $5C, $7C, $3A, $7B, $7F, $40, $7F, $40, $7F, $40
    db $7F, $40, $7F, $40, $7E, $41, $7C, $43, $7B, $45, $D5, $FD, $EF, $FF, $5D, $5D
    db $2A, $3A, $02, $8A, $30, $FA, $BF, $FF, $51, $FE, $FD, $02, $FF, $00, $5D, $A2
    db $3A, $C5, $8A, $F5, $FA, $AF, $FF, $09, $BF, $40, $00, $40, $F8, $80, $F0, $80
    db $F0, $00, $F3, $81, $FF, $CE, $CF, $EC, $EC, $C9, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $CF, $38, $E7, $1C, $FF, $00, $00, $40, $74, $10
    db $30, $10, $38, $00, $30, $08, $F8, $C8, $CC, $D0, $D2, $D8, $FE, $00, $F4, $0C
    db $F0, $08, $F8, $08, $F0, $08, $F8, $00, $CC, $74, $96, $EA, $FE, $0A, $E0, $C3
    db $F8, $BF, $BF, $D2, $DF, $6D, $6F, $10, $10, $E0, $FC, $80, $BB, $CB, $DF, $EA
    db $6F, $72, $10, $1F, $F0, $70, $7C, $50, $D8, $60, $E0, $80, $80, $E0, $FC, $14
    db $D8, $B8, $E0, $A0, $80, $40, $00, $80, $00, $29, $2B, $2A, $2B, $32, $37, $0C
    db $2F, $1E, $3F, $22, $72, $17, $BF, $02, $E3, $00, $2B, $14, $2B, $14, $37, $0C
    db $2F, $30, $3F, $20, $7A, $45, $FF, $80, $FB, $A4, $00, $00, $C3, $00, $81, $00
    db $81, $00, $99, $08, $FF, $76, $7E, $66, $7E, $64, $E7, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $7E, $C3, $3C, $E7, $FF, $00, $F8, $02, $7F, $01
    db $1F, $01, $01, $F8, $7F, $66, $1F, $1F, $01, $01, $E0, $44, $C7, $83, $C7, $4D
    db $7D, $39, $7D, $32, $7E, $E0, $FF, $00, $FF, $00, $7D, $83, $5D, $DF, $7E, $7E
    db $00, $01, $00, $00, $01, $07, $00, $06, $0A, $0B, $0C, $1F, $12, $1F, $01, $37
    db $01, $01, $00, $00, $07, $06, $07, $04, $0F, $00, $1F, $10, $1F, $00, $3F, $20
    db $00, $00, $00, $EE, $29, $69, $10, $3D, $00, $53, $00, $95, $A5, $FF, $63, $FF
    db $00, $00, $EE, $EE, $EF, $10, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $65, $7F, $67, $7F, $4F, $7F, $5D, $7F, $1D, $7F, $18, $7B, $5A, $5B, $39, $7F
    db $7F, $40, $7F, $40, $7F, $40, $7F, $40, $7F, $42, $7B, $46, $5B, $64, $7E, $45
    db $D5, $FD, $EF, $FF, $5D, $5D, $2A, $3A, $04, $14, $81, $A9, $BD, $FF, $44, $FF
    db $FD, $02, $FF, $00, $5D, $A2, $3A, $C5, $14, $EB, $A9, $FF, $FF, $66, $FF, $02
    db $00, $02, $0F, $01, $07, $01, $07, $00, $67, $20, $FF, $D9, $F9, $9B, $9B, $33
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $F9, $0E, $F3, $9C
    db $FF, $00, $00, $28, $2C, $28, $28, $80, $C0, $A0, $B8, $00, $18, $88, $9C, $00
    db $1A, $C0, $CE, $00, $2C, $D4, $28, $D0, $C0, $78, $B8, $58, $18, $F8, $9C, $74
    db $1E, $F2, $DE, $6A, $E0, $63, $0F, $EB, $FB, $4E, $FE, $B4, $F4, $08, $08, $E0
    db $9F, $00, $7B, $77, $FE, $56, $F4, $4C, $08, $F8, $FC, $A0, $BC, $00, $F0, $FC
    db $BC, $CC, $F0, $F0, $00, $00, $00, $EE, $29, $69, $10, $3D, $00, $53, $00, $95
    db $A5, $FF, $63, $FF, $00, $00, $EE, $EE, $EF, $10, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $00, $00, $00, $40, $00, $80, $40, $60, $40, $E0, $80, $B0
    db $00, $D0, $40, $F8, $00, $00, $40, $40, $80, $80, $E0, $20, $E0, $20, $F0, $10
    db $F0, $00, $F8, $08, $D5, $FD, $EF, $FF, $5D, $5D, $2A, $3A, $0A, $2B, $04, $57
    db $75, $FF, $8A, $FF, $FD, $02, $FF, $00, $5D, $A2, $3A, $C5, $2B, $D5, $57, $FD
    db $FF, $88, $FD, $02, $A0, $F8, $E0, $FC, $F0, $FC, $A8, $FC, $F8, $FC, $74, $74
    db $78, $7C, $68, $EC, $F8, $08, $FC, $04, $FC, $04, $FC, $04, $FC, $04, $74, $88
    db $7C, $84, $EC, $94, $00, $24, $2F, $20, $26, $28, $2E, $08, $2E, $1C, $3F, $39
    db $79, $1D, $BD, $05, $E7, $00, $2F, $10, $27, $18, $2F, $10, $2F, $30, $3F, $20
    db $79, $47, $FC, $83, $F7, $A8, $00, $02, $0F, $01, $07, $01, $07, $00, $67, $20
    db $FF, $D9, $F9, $9B, $FB, $93, $9F, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $F9, $0E, $F3, $9C, $FF, $00, $E0, $05, $7F, $06, $1F, $01, $01, $00
    db $01, $00, $01, $E0, $7F, $6C, $1F, $1C, $01, $02, $01, $03, $01, $01, $E0, $03
    db $1F, $0B, $1B, $3E, $FE, $E4, $F4, $F8, $F8, $E0, $FF, $00, $FB, $07, $FE, $06
    db $74, $7C, $F8, $F8, $00, $29, $2B, $2A, $2B, $32, $37, $08, $2B, $1A, $3B, $22
    db $72, $17, $BF, $03, $E3, $00, $2B, $14, $2B, $14, $37, $0C, $2B, $34, $3B, $24
    db $7A, $45, $FF, $80, $FB, $A4, $00, $00, $C3, $00, $81, $00, $81, $00, $99, $08
    db $FF, $76, $7E, $66, $66, $4C, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $7E, $C3, $3C, $E7, $FF, $00, $FC, $03, $7F, $01, $1F, $FC, $7F, $66
    db $1F, $1F, $E0, $9C, $C7, $BA, $FE, $11, $7D, $A8, $FE, $44, $44, $E0, $E7, $00
    db $DE, $5D, $7D, $D7, $FE, $D6, $44, $7C, $00, $01, $F6, $D0, $EF, $CC, $DF, $04
    db $DF, $E8, $FB, $FA, $FF, $FC, $FC, $F0, $FF, $00, $FF, $E0, $FF, $E0, $DF, $D8
    db $DF, $DC, $FB, $FA, $FF, $FC, $FF, $F8, $FF, $F8, $00, $40, $60, $30, $A6, $1E
    db $03, $5B, $E3, $60, $B5, $60, $E0, $3E, $FE, $7F, $FF, $00, $60, $B0, $B6, $CE
    db $9F, $61, $FB, $24, $F5, $3F, $E0, $20, $FE, $7E, $FF, $7F, $FE, $1C, $1F, $FE
    db $1F, $1F, $FE, $00, $80, $FE, $80, $80, $B0, $0B, $0B, $0B, $0E, $0D, $0F, $07
    db $07, $03, $03, $B0, $0D, $07, $08, $00, $0F, $08, $07, $05, $03, $03, $00, $66
    db $FF, $A0, $A1, $81, $81, $03, $07, $08, $0C, $3F, $3F, $FF, $FF, $FF, $FF, $00
    db $7F, $3F, $A1, $61, $81, $80, $07, $04, $0C, $0F, $3F, $3F, $FF, $FF, $FF, $FF
    db $FF, $FF, $FE, $07, $07, $FE, $07, $07, $3F, $00, $03, $03, $03, $3F, $03, $03
    db $03, $00, $01, $00, $01, $01, $03, $02, $1F, $2F, $7F, $28, $BF, $09, $F9, $00
    db $1F, $01, $01, $01, $03, $02, $1F, $1F, $7F, $40, $FF, $DF, $F9, $86, $FF, $00
    db $00, $02, $07, $74, $77, $78, $7A, $74, $7F, $30, $3F, $2B, $3D, $05, $05, $05
    db $07, $00, $07, $04, $77, $78, $5E, $51, $7F, $40, $3F, $03, $30, $30, $06, $07
    db $04, $03, $00, $04, $3E, $23, $3F, $C3, $FF, $21, $FF, $01, $FF, $03, $FF, $0E
    db $FE, $A9, $E9, $00, $FE, $01, $3F, $C0, $7F, $C0, $FF, $00, $FF, $80, $7F, $40
    db $FE, $C1, $E9, $D7, $B8, $25, $3B, $1B, $1F, $0E, $0C, $03, $03, $B8, $23, $00
    db $1F, $11, $0C, $0E, $03, $03, $00, $DD, $FD, $D2, $D2, $4D, $7F, $03, $07, $08
    db $0C, $3F, $3F, $FF, $FF, $FF, $FF, $00, $FD, $23, $D2, $EF, $7F, $7E, $07, $04
    db $0C, $0F, $3F, $3F, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $07, $07, $FE, $07, $07
    db $7F, $00, $03, $7F, $03, $03, $01, $00, $01, $01, $03, $02, $05, $02, $0F, $07
    db $3F, $33, $FF, $D0, $FF, $01, $01, $01, $03, $02, $07, $04, $0F, $0C, $3F, $38
    db $FF, $CC, $FF, $3F, $00, $01, $07, $06, $06, $04, $0E, $E8, $EE, $F1, $F5, $E8
    db $FF, $60, $7F, $59, $7E, $00, $07, $06, $07, $00, $0F, $08, $EE, $F1, $BC, $A3
    db $FF, $80, $7F, $00, $72, $61, $00, $13, $F3, $00, $3E, $08, $7C, $46, $7E, $87
    db $FF, $43, $FF, $03, $FF, $86, $FE, $00, $F3, $0C, $FF, $00, $FC, $03, $7E, $81
    db $FF, $80, $FF, $00, $FF, $00, $FE, $01, $00, $38, $78, $28, $28, $2D, $2D, $31
    db $3B, $15, $3F, $11, $3F, $22, $72, $15, $BF, $00, $78, $47, $28, $17, $2D, $13
    db $3B, $07, $3F, $23, $3F, $23, $7E, $41, $FF, $80, $00, $EB, $DD, $55, $55, $C9
    db $FF, $E3, $FF, $63, $77, $FF, $FF, $FE, $FE, $7D, $FF, $00, $C1, $C1, $6B, $FF
    db $C1, $9C, $EB, $C9, $7F, $63, $FF, $FF, $FE, $FF, $FF, $FE, $F8, $05, $E5, $21
    db $7F, $05, $1F, $F8, $FF, $A0, $7F, $64, $1F, $1F, $E0, $7D, $FF, $FF, $FF, $FF
    db $FF, $FE, $FE, $7C, $7C, $E0, $FF, $FE, $FF, $FE, $FF, $FF, $FE, $FE, $7C, $7C
    db $00, $01, $00, $00, $01, $07, $00, $06, $0A, $0B, $10, $1E, $01, $19, $11, $3B
    db $01, $01, $00, $00, $07, $06, $07, $04, $0F, $00, $1E, $01, $1F, $1E, $3B, $2C
    db $00, $00, $00, $EE, $29, $69, $10, $3D, $00, $6B, $3C, $FF, $85, $FB, $00, $C3
    db $00, $00, $EE, $EE, $EF, $10, $FF, $00, $EF, $78, $FF, $E7, $FF, $42, $FF, $00
    db $0A, $3B, $6B, $7F, $6C, $7E, $64, $7F, $51, $5B, $06, $5F, $3A, $7B, $59, $5B
    db $3B, $24, $7F, $44, $7E, $49, $7F, $48, $5B, $6C, $5F, $68, $7B, $46, $5B, $66
    db $00, $81, $00, $A9, $C3, $E7, $7E, $7E, $66, $FF, $00, $A5, $DB, $FF, $9C, $FF
    db $FF, $00, $FF, $00, $FF, $81, $3C, $E7, $FF, $00, $BD, $42, $EF, $6E, $BE, $00
    db $00, $39, $79, $2B, $2B, $2C, $2D, $31, $3B, $15, $3F, $11, $3F, $22, $72, $15
    db $BF, $00, $79, $46, $2B, $15, $2D, $13, $3B, $07, $3F, $23, $3F, $23, $7E, $41
    db $FF, $80, $00, $FF, $FF, $D7, $FF, $BD, $BD, $E3, $E7, $7F, $7F, $FF, $FF, $FE
    db $FE, $7D, $FF, $00, $FF, $00, $83, $00, $BD, $E7, $FF, $C3, $7F, $7F, $FF, $FF
    db $FE, $FF, $FF, $FE, $F8, $05, $E5, $21, $7F, $05, $1F, $F8, $FF, $A0, $7F, $64
    db $1F, $1F, $F0, $7D, $FF, $FF, $FF, $FF, $FF, $38, $38, $F0, $FF, $FE, $FF, $FE
    db $FF, $FF, $38, $38, $00, $01, $00, $00, $01, $07, $00, $06, $0A, $0B, $09, $1F
    db $10, $1E, $01, $39, $01, $01, $00, $00, $07, $06, $07, $04, $0F, $00, $1F, $12
    db $1E, $01, $3F, $2E, $00, $00, $00, $EE, $29, $69, $10, $3D, $00, $53, $43, $EF
    db $3C, $FF, $85, $FB, $00, $00, $EE, $EE, $EF, $10, $FF, $00, $FF, $00, $EF, $38
    db $FF, $E7, $FF, $42, $01, $3B, $62, $7B, $6B, $7F, $6C, $7E, $54, $5F, $01, $5B
    db $36, $7F, $52, $5B, $3B, $24, $7B, $4C, $7F, $44, $7E, $49, $5F, $68, $5B, $6C
    db $7F, $48, $5B, $6E, $00, $C3, $00, $81, $00, $A9, $C3, $E7, $7E, $7E, $66, $FF
    db $00, $A5, $5A, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $81, $3C, $E7, $FF, $00
    db $BD, $42, $EF, $6E, $00, $00, $28, $14, $3E, $00, $29, $2D, $2F, $05, $2F, $7A
    db $FF, $8C, $9D, $08, $0D, $00, $28, $28, $3E, $02, $3B, $04, $3F, $28, $3F, $44
    db $EF, $A1, $9D, $53, $0D, $01, $02, $00, $20, $00, $A0, $60, $60, $00, $20, $00
    db $60, $10, $F0, $00, $F0, $00, $20, $20, $20, $00, $A0, $80, $60, $80, $60, $A0
    db $60, $A0, $F0, $80, $F0, $C0, $FC, $04, $0C, $08, $0C, $FC, $0C, $00, $0C, $04
    db $FC, $00, $90, $10, $10, $FC, $90, $80, $10, $00, $00, $00, $28, $14, $3E, $00
    db $29, $2D, $2F, $05, $2F, $5A, $7F, $4C, $7D, $25, $67, $00, $28, $28, $3E, $02
    db $3B, $04, $3F, $28, $3F, $04, $6F, $21, $7D, $13, $67, $00, $02, $00, $08, $00
    db $A0, $60, $60, $00, $20, $00, $60, $20, $E0, $00, $60, $00, $08, $08, $10, $00
    db $A0, $80, $60, $80, $60, $A0, $60, $A0, $E0, $80, $60, $00, $FE, $42, $63, $FE
    db $63, $21, $FC, $00, $60, $20, $20, $FC, $60, $40, $20, $00, $3F, $A0, $CC, $6C
    db $D7, $1F, $00, $E0, $EC, $1C, $FF, $03, $FF, $FF, $F8, $F6, $C6, $81, $EB, $FF
    db $FF, $F8, $F6, $09, $EB, $FF, $FF, $FF, $F9, $00, $80, $80, $80, $F8, $00, $80
    db $80, $C0, $80, $80, $01, $00, $80, $C0, $E0, $10, $54, $30, $F8, $A0, $EE, $C5
    db $FC, $D0, $FD, $01, $80, $80, $E0, $20, $F4, $04, $F8, $08, $FE, $03, $FD, $02
    db $FD, $23, $7F, $60, $60, $3F, $00, $C0, $60, $90, $00, $95, $FE, $B2, $F9, $48
    db $EA, $60, $E6, $2A, $F9, $5B, $FE, $90, $FE, $00, $EB, $00, $FF, $A2, $FB, $04
    db $AB, $54, $E7, $1C, $FB, $14, $FF, $0C, $FE, $0F, $EB, $9F, $00, $10, $D0, $18
    db $2C, $0C, $78, $00, $F0, $08, $F2, $02, $F0, $82, $78, $86, $7B, $00, $D0, $28
    db $FC, $04, $FC, $10, $F0, $0C, $FA, $06, $F2, $1C, $FA, $1D, $FF, $08, $00, $00
    db $00, $00, $00, $01, $00, $01, $02, $06, $00, $0D, $19, $1F, $1A, $1F, $00, $00
    db $00, $00, $01, $01, $01, $01, $07, $04, $0F, $08, $1F, $10, $1F, $11, $00, $40
    db $00, $3B, $5A, $FB, $04, $8F, $88, $DC, $A6, $EF, $EB, $EB, $FF, $FF, $40, $40
    db $3B, $3B, $FB, $84, $FF, $00, $FF, $00, $EF, $10, $EB, $14, $FF, $40, $2E, $2F
    db $15, $1F, $3E, $7F, $1C, $5D, $39, $7B, $28, $6F, $20, $27, $5C, $7D, $2F, $31
    db $1F, $22, $7F, $40, $5D, $62, $7B, $46, $6F, $54, $27, $5C, $7D, $02, $5E, $FF
    db $10, $EF, $80, $E1, $80, $E1, $00, $C8, $80, $CC, $7B, $FF, $00, $CC, $FF, $33
    db $FF, $21, $7F, $80, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $CC, $73, $01, $00
    db $80, $C0, $E0, $10, $54, $10, $F8, $A4, $EE, $C1, $FC, $C0, $FD, $01, $80, $80
    db $E0, $20, $F4, $04, $F8, $08, $FE, $03, $FD, $02, $FD, $23, $7F, $60, $60, $3F
    db $00, $C0, $60, $90, $00, $93, $FE, $B6, $FD, $40, $EC, $6C, $EC, $2A, $F9, $59
    db $F8, $90, $FA, $00, $EB, $00, $FF, $A0, $FF, $00, $AD, $52, $ED, $12, $FB, $14
    db $F9, $0E, $FA, $0F, $EB, $9F, $00, $10, $D0, $18, $2C, $0C, $78, $00, $F0, $08
    db $F2, $02, $F0, $82, $78, $86, $7B, $00, $D0, $28, $FC, $04, $FC, $10, $F0, $0C
    db $FA, $06, $F2, $1C, $FA, $1D, $FF, $08, $00, $24, $67, $20, $6E, $22, $7F, $21
    db $7F, $00, $3D, $10, $3C, $24, $7C, $20, $7E, $00, $7F, $40, $7F, $46, $7F, $44
    db $7F, $46, $3D, $25, $3C, $24, $68, $54, $76, $4A, $00, $58, $7E, $32, $F3, $42
    db $FB, $22, $FF, $82, $DF, $00, $9E, $04, $1E, $12, $1F, $00, $FE, $22, $FF, $01
    db $FF, $31, $FF, $51, $DF, $51, $9E, $92, $1E, $12, $2B, $35, $FC, $1C, $3E, $00
    db $1C, $FC, $3E, $22, $1C, $1C, $F8, $02, $3F, $1C, $3E, $00, $1C, $F8, $37, $29
    db $3E, $22, $1C, $1C, $00, $02, $00, $17, $08, $18, $21, $6B, $50, $D5, $2A, $7F
    db $9A, $BB, $75, $F5, $02, $02, $17, $17, $1E, $11, $7F, $40, $FF, $80, $7F, $80
    db $FB, $05, $F5, $0A, $00, $60, $00, $A8, $94, $DC, $24, $AE, $8A, $DB, $42, $DF
    db $85, $AF, $49, $C9, $60, $60, $E8, $88, $FC, $08, $FE, $02, $FF, $01, $DF, $A0
    db $AF, $50, $CF, $B0, $D0, $D1, $AA, $EB, $40, $E3, $C8, $CC, $40, $F8, $10, $B9
    db $10, $7F, $20, $3F, $F1, $0F, $EB, $15, $E3, $1C, $CF, $30, $FF, $90, $BF, $E0
    db $7F, $60, $3F, $01, $54, $D7, $29, $AB, $03, $E3, $88, $99, $03, $8F, $87, $CF
    db $C4, $FF, $00, $7F, $D7, $A8, $AB, $D4, $E3, $9C, $F9, $06, $FF, $04, $FF, $00
    db $FF, $03, $FF, $23, $F8, $04, $07, $02, $03, $01, $01, $F8, $06, $04, $03, $02
    db $01, $01, $F8, $10, $F0, $20, $60, $C0, $C0, $F8, $B0, $90, $E0, $20, $C0, $C0
    db $FF, $FF, $FF, $FF, $10, $30, $08, $38, $2B, $3F, $50, $7F, $10, $3C, $22, $3A
    db $04, $79, $18, $F1, $30, $20, $38, $28, $3F, $06, $6F, $14, $3F, $40, $3F, $40
    db $73, $40, $F3, $84, $08, $0C, $10, $1C, $D4, $FC, $48, $BE, $0A, $3E, $24, $7C
    db $22, $9F, $9A, $8F, $0C, $04, $1C, $14, $FC, $60, $F6, $2A, $FE, $00, $FC, $02
    db $CF, $01, $CF, $21, $55, $7B, $02, $BF, $66, $7E, $30, $3A, $1D, $3F, $0D, $0F
    db $04, $06, $0F, $0E, $71, $00, $BF, $C0, $7F, $00, $3B, $64, $3E, $26, $0F, $10
    db $07, $1B, $0C, $09, $A8, $DE, $40, $FC, $66, $7E, $0E, $5E, $B8, $F8, $98, $F8
    db $10, $B0, $F8, $B8, $8E, $00, $FC, $02, $FE, $00, $DE, $24, $F8, $E4, $F8, $08
    db $F0, $EC, $18, $C8, $F8, $00, $90, $00, $80, $00, $40, $F8, $90, $F0, $80, $F0
    db $40, $60, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FC, $00, $40, $00, $20, $FC
    db $40, $78, $20, $30, $FF, $FF, $FF, $FF, $00, $C0, $FC, $FC, $FC, $FE, $FE, $FF
    db $FF, $FE, $FF, $FB, $FB, $F6, $F7, $A9, $AB, $00, $FC, $3C, $FC, $02, $FE, $01
    db $FF, $00, $FF, $00, $FB, $04, $F7, $08, $AB, $54, $07, $00, $80, $80, $C0, $40
    db $E0, $A0, $F0, $00, $B0, $07, $80, $80, $C0, $40, $E0, $20, $F0, $10, $F0, $30
    db $00, $57, $57, $20, $2F, $02, $03, $40, $4F, $20, $AF, $01, $D3, $00, $90, $00
    db $90, $00, $57, $A8, $2F, $DE, $03, $FC, $4F, $BC, $AF, $DC, $D3, $F2, $90, $F0
    db $90, $F0, $C0, $00, $38, $08, $1C, $04, $4E, $14, $FE, $80, $FC, $20, $60, $C0
    db $F8, $18, $FC, $04, $FE, $02, $FE, $02, $FC, $1C, $60, $50, $00, $00, $01, $02
    db $07, $05, $0F, $0B, $1F, $01, $1D, $01, $39, $20, $71, $40, $E5, $00, $01, $01
    db $07, $04, $0F, $08, $1F, $10, $1F, $18, $3F, $30, $7F, $40, $FF, $80, $00, $7F
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $3F, $BF, $DF, $DF, $1F, $DF, $AB, $AB, $00
    db $FF, $80, $FF, $00, $FF, $00, $FF, $00, $BF, $40, $DF, $20, $DF, $E0, $AB, $54
    db $F0, $50, $FF, $02, $7F, $09, $0D, $00, $01, $F0, $FF, $80, $7F, $70, $0D, $14
    db $01, $01, $00, $14, $D4, $08, $C8, $42, $C2, $20, $27, $00, $CF, $00, $24, $00
    db $4C, $00, $48, $00, $D4, $6B, $C8, $77, $C2, $BD, $27, $DF, $CF, $FF, $24, $3C
    db $4C, $7C, $48, $78, $FF, $FF, $FF, $FF, $00, $00, $28, $00, $DD, $74, $8F, $3F
    db $F3, $0C, $A7, $03, $9F, $00, $85, $00, $C0, $00, $28, $28, $DD, $FD, $FF, $82
    db $FF, $40, $AF, $B0, $9F, $9C, $85, $85, $C0, $C0, $07, $80, $A0, $00, $C0, $E0
    db $F0, $30, $F8, $00, $60, $07, $A0, $20, $C0, $40, $F0, $10, $F8, $08, $60, $60
    db $01, $20, $6C, $1C, $BD, $C2, $F3, $81, $C5, $C1, $C3, $40, $E5, $82, $FA, $01
    db $7C, $44, $FD, $83, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FE, $01, $17, $00
    db $C0, $80, $C0, $68, $7C, $A0, $BE, $07, $C0, $C0, $00, $80, $C0, $40, $7C, $84
    db $BE, $42, $00, $40, $ED, $86, $B6, $00, $7F, $80, $CF, $00, $BF, $80, $FD, $C0
    db $EB, $94, $FD, $00, $FD, $02, $FE, $01, $FF, $00, $FF, $01, $FF, $00, $FF, $00
    db $FF, $00, $FF, $68, $00, $40, $63, $E0, $F3, $C0, $F3, $E0, $F5, $C0, $FB, $00
    db $F7, $80, $FF, $00, $FB, $00, $7F, $81, $FF, $00, $FF, $00, $FF, $00, $FF, $20
    db $FF, $60, $FF, $60, $FF, $70, $01, $01, $01, $01, $01, $01, $01, $01, $06, $07
    db $06, $06, $0C, $0F, $E9, $EE, $01, $01, $01, $01, $01, $01, $01, $01, $07, $07
    db $07, $00, $0E, $08, $EE, $F0, $00, $98, $98, $DC, $30, $73, $58, $78, $11, $F5
    db $4B, $7F, $8B, $7F, $46, $3F, $98, $98, $DC, $44, $FF, $9B, $F5, $BA, $FD, $0A
    db $FF, $00, $3F, $00, $3F, $80, $F4, $F7, $E0, $FF, $60, $7F, $57, $7B, $0B, $0F
    db $16, $17, $17, $1D, $1B, $1F, $BE, $A0, $FF, $80, $7F, $00, $61, $60, $09, $07
    db $1A, $0E, $11, $00, $1F, $11, $A3, $7F, $C1, $CF, $02, $9F, $05, $FF, $1D, $FD
    db $D0, $D3, $5E, $7F, $FF, $FF, $3F, $00, $FF, $00, $FF, $01, $FF, $02, $FD, $02
    db $D3, $2F, $7F, $F3, $FF, $E0, $00, $84, $CF, $12, $D7, $1A, $3F, $0A, $1F, $02
    db $0F, $02, $07, $00, $07, $00, $01, $00, $CF, $78, $D7, $EC, $3F, $24, $1F, $14
    db $0F, $0C, $07, $04, $07, $06, $01, $01, $00, $00, $A0, $40, $E0, $00, $C0, $00
    db $C0, $00, $C0, $60, $E0, $60, $E0, $E0, $E0, $00, $E0, $20, $E0, $20, $C0, $40
    db $C0, $40, $C0, $40, $E0, $20, $E0, $20, $E0, $20, $FF, $FF, $FE, $40, $C0, $FE
    db $C0, $C0, $1F, $00, $80, $00, $40, $40, $40, $1F, $80, $80, $40, $C0, $40, $80
    db $FF, $FF, $00, $C0, $9F, $A6, $EE, $90, $A9, $C0, $E6, $C0, $C0, $C0, $C8, $A0
    db $A1, $60, $60, $00, $DF, $1F, $FE, $41, $BF, $60, $FF, $20, $DF, $20, $CF, $30
    db $BF, $40, $7F, $C0, $01, $00, $80, $80, $C0, $40, $E0, $00, $F0, $10, $70, $20
    db $58, $10, $E8, $01, $80, $80, $C0, $40, $E0, $20, $F0, $10, $F0, $00, $F8, $08
    db $F8, $08, $7F, $00, $01, $7F, $01, $01, $07, $40, $66, $66, $77, $4C, $5C, $56
    db $5E, $44, $FD, $07, $66, $66, $77, $51, $7F, $66, $7D, $6E, $FF, $82, $00, $01
    db $01, $01, $03, $3A, $3B, $3C, $3D, $38, $3F, $18, $1F, $17, $1F, $09, $0B, $00
    db $01, $00, $03, $02, $3B, $3C, $2F, $28, $3F, $20, $1F, $00, $1F, $1D, $0F, $00
    db $00, $82, $8F, $00, $9F, $F1, $FF, $61, $FF, $00, $FF, $00, $FF, $E1, $FF, $3F
    db $FF, $00, $FF, $00, $FF, $00, $FF, $40, $BF, $60, $FF, $00, $FF, $00, $FF, $00
    db $FF, $C0, $00, $00, $80, $00, $F0, $E0, $E8, $08, $DC, $44, $EE, $80, $8F, $81
    db $C7, $42, $95, $00, $80, $80, $F0, $F0, $E8, $18, $FC, $44, $FE, $02, $BF, $41
    db $FF, $40, $FF, $00, $7F, $00, $80, $7F, $80, $80, $00, $21, $FE, $0D, $BB, $E2
    db $ED, $26, $AE, $60, $75, $40, $FF, $44, $F5, $64, $DF, $00, $FF, $18, $BF, $60
    db $FF, $01, $BF, $C0, $7F, $84, $FF, $24, $FF, $20, $FF, $80, $00, $00, $80, $00
    db $80, $00, $C0, $40, $E0, $20, $E0, $20, $60, $20, $E0, $20, $E0, $00, $80, $80
    db $80, $80, $C0, $C0, $E0, $20, $E0, $00, $E0, $00, $E0, $00, $E0, $00, $02, $06
    db $00, $07, $05, $07, $0A, $0F, $02, $07, $04, $07, $04, $0F, $1A, $1E, $06, $04
    db $07, $05, $07, $00, $0D, $02, $07, $08, $07, $08, $0F, $08, $1E, $11, $01, $01
    db $02, $0F, $32, $FF, $09, $F7, $01, $87, $00, $03, $00, $33, $DD, $FD, $01, $00
    db $0F, $0E, $FF, $CC, $FE, $85, $FF, $00, $FF, $00, $FF, $00, $FD, $86, $08, $1E
    db $00, $17, $0C, $1F, $03, $07, $00, $03, $01, $01, $00, $00, $00, $00, $1E, $11
    db $17, $18, $1F, $10, $07, $0C, $03, $03, $01, $01, $00, $00, $00, $00, $CC, $FD
    db $00, $4B, $B4, $FF, $6B, $FF, $31, $FF, $B5, $FF, $02, $8F, $34, $7E, $79, $CE
    db $7B, $84, $DF, $58, $FF, $30, $FF, $03, $FF, $7A, $FF, $85, $7F, $78, $00, $00
    db $80, $00, $F0, $E0, $E8, $08, $DC, $44, $EE, $80, $8F, $81, $C7, $42, $95, $00
    db $80, $80, $F0, $F0, $E8, $18, $FC, $44, $FE, $02, $BF, $41, $FF, $40, $FF, $00
    db $7F, $00, $80, $7F, $80, $80, $00, $01, $CE, $05, $9B, $C4, $FB, $48, $FD, $98
    db $FA, $08, $7F, $28, $BD, $24, $FC, $00, $FF, $00, $BF, $40, $FF, $03, $FF, $80
    db $FF, $00, $7F, $90, $BF, $50, $FF, $18, $00, $00, $80, $00, $80, $00, $80, $80
    db $C0, $40, $C0, $40, $C0, $00, $C0, $00, $C0, $00, $80, $80, $80, $80, $80, $80
    db $C0, $40, $C0, $00, $C0, $00, $C0, $00, $C0, $00, $4E, $B5, $55, $BF, $75, $AE
    db $24, $FF, $31, $6E, $20, $6E, $15, $7F, $51, $33, $CA, $80, $CA, $88, $DB, $8A
    db $DB, $8A, $5B, $0A, $5B, $4A, $6A, $6A, $6E, $02, $40, $A0, $40, $A0, $C0, $A0
    db $80, $E0, $80, $C0, $80, $C0, $00, $C0, $40, $80, $60, $20, $60, $20, $60, $20
    db $60, $20, $40, $00, $40, $40, $C0, $C0, $C0, $00, $04, $E2, $84, $EE, $E0, $EE
    db $44, $6E, $A4, $EE, $84, $CE, $7F, $7F, $0C, $0C, $FF, $82, $FB, $EA, $FF, $EE
    db $7F, $6E, $DF, $CE, $FF, $CE, $7F, $7F, $0C, $0C, $00, $E0, $20, $E0, $E0, $E0
    db $40, $C0, $A0, $E0, $20, $60, $C0, $C0, $00, $00, $E0, $20, $E0, $E0, $E0, $E0
    db $C0, $C0, $60, $60, $E0, $60, $C0, $C0, $00, $00, $00, $21, $2D, $4C, $29, $7B
    db $04, $73, $DA, $B3, $6D, $B3, $53, $9F, $1E, $5E, $21, $21, $6D, $4C, $56, $52
    db $5E, $52, $CC, $00, $C0, $80, $E0, $80, $61, $00, $00, $00, $00, $80, $00, $80
    db $00, $80, $C0, $40, $80, $40, $80, $40, $00, $80, $00, $00, $80, $80, $80, $80
    db $80, $80, $C0, $00, $C0, $40, $C0, $40, $80, $00, $52, $61, $04, $3B, $11, $24
    db $3B, $1F, $1F, $40, $3F, $44, $3B, $C0, $6A, $9F, $7F, $00, $3F, $31, $3F, $20
    db $20, $00, $60, $40, $40, $40, $C4, $80, $C4, $80, $80, $80, $00, $80, $00, $80
    db $80, $00, $00, $40, $80, $40, $80, $60, $C0, $20, $80, $00, $80, $80, $80, $80
    db $80, $00, $C0, $40, $40, $40, $60, $20, $60, $20, $00, $04, $CE, $44, $C3, $40
    db $83, $81, $C2, $01, $C3, $81, $C3, $83, $44, $87, $49, $00, $4B, $4A, $07, $03
    db $43, $03, $43, $02, $42, $42, $42, $42, $C7, $44, $CF, $41, $00, $18, $EC, $27
    db $DB, $70, $FE, $38, $F0, $18, $B0, $10, $B8, $10, $B8, $10, $38, $00, $34, $24
    db $3C, $18, $8E, $8E, $C8, $C0, $A8, $A0, $A8, $A8, $A8, $A8, $28, $28, $F0, $91
    db $5F, $BF, $7F, $7F, $FF, $C1, $C1, $F0, $DF, $51, $FF, $7F, $FF, $FF, $C1, $C1
    db $F0, $90, $A8, $F7, $EF, $EC, $FC, $E0, $90, $F0, $B8, $A8, $DF, $CF, $9C, $9C
    db $F0, $90, $FF, $FF, $00, $05, $1B, $08, $17, $0C, $19, $08, $1D, $08, $15, $08
    db $15, $18, $25, $10, $69, $00, $1E, $1A, $1F, $16, $15, $11, $15, $04, $1D, $04
    db $1D, $14, $3D, $24, $79, $09, $F8, $01, $01, $7F, $7F, $1F, $1F, $F8, $01, $01
    db $7F, $7F, $1F, $1F, $F0, $8C, $FD, $F9, $FF, $FB, $FD, $1B, $1C, $F0, $FD, $8D
    db $FE, $FE, $FE, $F8, $1F, $18, $00, $00, $03, $00, $02, $01, $03, $00, $02, $00
    db $07, $8D, $F6, $0D, $BE, $34, $47, $00, $03, $02, $03, $02, $02, $02, $03, $02
    db $07, $06, $F8, $70, $C3, $82, $78, $00, $01, $00, $C0, $40, $80, $00, $E0, $00
    db $E0, $80, $60, $20, $C0, $60, $F0, $01, $C0, $C0, $C0, $80, $A0, $A0, $A0, $A0
    db $20, $20, $60, $00, $10, $10, $FC, $03, $1D, $00, $03, $FC, $1E, $18, $03, $03
    db $00, $26, $6D, $79, $B7, $2F, $BC, $72, $3D, $18, $57, $1C, $3B, $0A, $1F, $0C
    db $13, $00, $DB, $49, $CE, $84, $C0, $80, $40, $00, $68, $40, $24, $20, $14, $10
    db $1E, $12, $00, $1F, $59, $29, $4F, $09, $66, $10, $7F, $00, $79, $00, $79, $46
    db $FF, $0F, $FF, $00, $66, $40, $7F, $40, $7F, $46, $6F, $66, $69, $69, $69, $49
    db $AF, $8F, $EF, $86, $00, $80, $A0, $40, $20, $00, $60, $80, $E0, $00, $E0, $00
    db $E0, $20, $F0, $00, $F0, $00, $60, $20, $E0, $20, $E0, $20, $60, $60, $60, $60
    db $60, $20, $50, $10, $70, $10, $80, $C6, $FF, $76, $5F, $76, $3F, $8F, $9F, $8F
    db $EF, $0F, $0F, $06, $06, $80, $EF, $C6, $6F, $46, $4F, $0F, $FF, $8F, $EF, $EF
    db $0F, $0F, $06, $06, $E0, $30, $F0, $E0, $A0, $E0, $C0, $10, $90, $10, $70, $E0
    db $70, $30, $60, $20, $20, $00, $F0, $10, $70, $70, $00, $10, $10, $30, $00, $39
    db $00, $39, $10, $36, $36, $19, $1F, $29, $36, $1F, $10, $10, $20, $20, $29, $29
    db $29, $29, $2F, $26, $20, $00, $30, $20, $29, $09, $00, $80, $80, $C0, $00, $C0
    db $00, $C0, $80, $C0, $C0, $80, $80, $40, $C0, $80, $80, $80, $40, $40, $40, $40
    db $40, $40, $40, $40, $40, $00, $C0, $40, $40, $00, $10, $26, $06, $10, $09, $36
    db $30, $59, $26, $6F, $19, $76, $40, $36, $49, $19, $39, $20, $19, $10, $3F, $36
    db $6F, $40, $5F, $40, $4F, $00, $4F, $00, $66, $00, $80, $40, $00, $80, $00, $C0
    db $C0, $A0, $40, $60, $80, $E0, $20, $C0, $20, $80, $C0, $40, $80, $80, $C0, $C0
    db $60, $20, $A0, $20, $20, $00, $20, $00, $60, $00, $03, $0C, $2D, $29, $5A, $00
    db $7F, $CC, $B3, $6D, $B3, $57, $9F, $03, $2D, $2D, $77, $52, $5E, $52, $C0, $00
    db $C0, $80, $E0, $80, $07, $00, $80, $00, $80, $C0, $40, $80, $40, $80, $40, $07
    db $80, $80, $80, $80, $C0, $00, $C0, $40, $C0, $40, $00, $3F, $5E, $4C, $73, $11
    db $24, $3B, $1F, $3F, $60, $3F, $44, $7B, $80, $6A, $9F, $00, $61, $00, $7F, $00
    db $3F, $20, $20, $00, $40, $40, $40, $40, $C4, $80, $C4, $80, $00, $00, $80, $80
    db $80, $00, $80, $80, $00, $80, $C0, $80, $40, $C0, $20, $C0, $20, $00, $80, $00
    db $80, $00, $80, $80, $80, $00, $40, $40, $40, $40, $60, $20, $60, $20, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $10, $10, $20, $00, $39, $09, $26
    db $16, $39, $36, $29, $09, $2F, $00, $00, $10, $10, $30, $20, $39, $29, $3F, $26
    db $20, $00, $3F, $09, $30, $20, $00, $00, $00, $80, $80, $40, $00, $C0, $00, $40
    db $80, $C0, $C0, $40, $00, $40, $00, $00, $80, $80, $C0, $40, $C0, $40, $C0, $40
    db $40, $00, $C0, $00, $C0, $40, $00, $36, $09, $16, $0F, $36, $36, $5F, $26, $69
    db $16, $76, $49, $3F, $49, $19, $3F, $26, $1F, $10, $3F, $36, $6F, $46, $5F, $40
    db $4F, $00, $46, $00, $66, $00, $00, $C0, $00, $80, $00, $C0, $C0, $A0, $40, $60
    db $80, $E0, $20, $C0, $20, $80, $C0, $40, $80, $80, $C0, $C0, $60, $20, $A0, $20
    db $20, $00, $20, $00, $60, $00, $00, $00, $03, $00, $02, $01, $03, $00, $02, $00
    db $07, $8D, $FE, $09, $BB, $34, $47, $00, $03, $02, $03, $02, $02, $02, $03, $02
    db $07, $06, $F8, $70, $C6, $82, $78, $00, $01, $00, $C0, $40, $80, $00, $E0, $00
    db $E0, $80, $60, $20, $C0, $60, $E0, $81, $C0, $C0, $C0, $80, $A0, $A0, $A0, $A0
    db $20, $20, $60, $00, $F8, $1B, $1B, $30, $2F, $00, $01, $F8, $1C, $18, $3F, $27
    db $01, $01, $00, $2C, $7A, $72, $AE, $1E, $B9, $A4, $3B, $30, $AE, $38, $77, $14
    db $7F, $19, $26, $00, $D6, $52, $DD, $88, $C0, $00, $C0, $00, $D1, $80, $49, $40
    db $69, $40, $3D, $24, $34, $EF, $2A, $FF, $7D, $BB, $46, $8C, $15, $4E, $45, $5E
    db $2D, $46, $02, $FF, $C0, $C0, $C4, $80, $C4, $80, $FB, $88, $7B, $0A, $7B, $0A
    db $7B, $42, $F7, $D4, $00, $E0, $00, $60, $00, $60, $A0, $40, $40, $60, $00, $40
    db $40, $C0, $00, $C0, $E0, $60, $E0, $20, $E0, $40, $C0, $60, $E0, $20, $C0, $00
    db $C0, $00, $C0, $40, $00, $FF, $26, $FF, $C6, $CF, $C6, $DF, $52, $77, $53, $77
    db $0B, $27, $00, $18, $F7, $A6, $EF, $8F, $FF, $CF, $FF, $DF, $6F, $67, $67, $6F
    db $37, $2F, $18, $18, $00, $C0, $00, $C0, $00, $C0, $80, $20, $40, $A0, $20, $E0
    db $80, $80, $00, $00, $C0, $40, $C0, $40, $C0, $40, $E0, $20, $E0, $20, $E0, $E0
    db $80, $80, $00, $00, $00, $10, $16, $26, $14, $3D, $02, $39, $69, $59, $36, $59
    db $39, $5F, $0F, $2F, $10, $10, $36, $26, $2B, $29, $2F, $29, $66, $00, $60, $40
    db $60, $40, $30, $00, $00, $80, $80, $40, $80, $C0, $00, $C0, $60, $A0, $C0, $A0
    db $40, $20, $00, $40, $80, $80, $C0, $40, $40, $40, $40, $40, $60, $00, $60, $20
    db $E0, $20, $C0, $00, $00, $30, $06, $30, $06, $60, $B2, $F9, $C4, $99, $59, $9D
    db $03, $DB, $24, $DF, $3F, $20, $3F, $20, $7F, $40, $C6, $00, $E6, $00, $E2, $80
    db $E4, $80, $E0, $C0, $00, $C0, $40, $C0, $00, $40, $E0, $A0, $80, $A0, $C0, $A0
    db $80, $E0, $80, $60, $C0, $40, $C0, $00, $C0, $00, $60, $00, $60, $00, $60, $00
    db $60, $20, $E0, $60, $2A, $FF, $7D, $BB, $47, $3D, $25, $6F, $14, $4E, $14, $6E
    db $31, $6F, $20, $5E, $C4, $80, $C4, $80, $7A, $08, $5A, $4A, $7B, $4A, $7B, $4A
    db $7A, $4A, $7B, $4A, $A0, $D0, $C0, $F0, $E0, $E0, $80, $C0, $80, $C0, $80, $C0
    db $00, $40, $00, $C0, $70, $10, $70, $10, $60, $00, $40, $40, $40, $40, $40, $40
    db $C0, $40, $C0, $40, $18, $C6, $29, $DE, $93, $E6, $D5, $FE, $3D, $3E, $0C, $0E
    db $02, $03, $00, $00, $CB, $F2, $D7, $B6, $FF, $E4, $EF, $EC, $3F, $3E, $0F, $0E
    db $03, $03, $00, $00, $00, $C0, $60, $E0, $70, $F0, $60, $E0, $80, $C0, $00, $40
    db $40, $C0, $00, $00, $C0, $C0, $E0, $E0, $F0, $F0, $E0, $E0, $40, $40, $C0, $40
    db $C0, $C0, $00, $00, $00, $10, $16, $26, $14, $3D, $02, $39, $69, $59, $36, $59
    db $39, $5F, $0F, $2F, $10, $10, $36, $26, $2B, $29, $2F, $29, $66, $00, $60, $40
    db $60, $40, $30, $00, $00, $80, $80, $40, $80, $C0, $00, $C0, $60, $A0, $C0, $A0
    db $40, $20, $00, $40, $80, $80, $C0, $40, $40, $40, $40, $40, $60, $00, $60, $20
    db $E0, $20, $C0, $00, $26, $30, $17, $20, $3B, $59, $16, $D9, $51, $99, $40, $9B
    db $34, $CF, $2D, $FA, $3F, $00, $3F, $00, $66, $40, $E4, $80, $E6, $80, $E4, $00
    db $E0, $00, $C4, $80, $40, $C0, $C0, $C0, $80, $40, $40, $20, $40, $20, $40, $20
    db $C0, $20, $80, $50, $C0, $00, $C0, $00, $C0, $00, $E0, $20, $E0, $20, $E0, $00
    db $E0, $00, $F0, $10, $11, $CA, $02, $DF, $57, $9B, $37, $CD, $04, $FE, $24, $EE
    db $14, $CE, $00, $DE, $E4, $C0, $E4, $80, $E4, $80, $FA, $88, $FB, $EA, $DB, $CA
    db $FB, $CA, $FB, $8A, $00, $60, $00, $60, $C0, $A0, $80, $C0, $80, $C0, $80, $C0
    db $80, $E0, $80, $E0, $E0, $20, $E0, $20, $60, $20, $40, $40, $40, $40, $40, $40
    db $60, $20, $60, $00, $40, $9E, $45, $BF, $21, $93, $64, $92, $04, $7E, $00, $7E
    db $3C, $3E, $04, $06, $FB, $9A, $FA, $9A, $BE, $D2, $DF, $B2, $7B, $6A, $7F, $7E
    db $3F, $3E, $07, $06, $C0, $E0, $E0, $60, $60, $E0, $60, $E0, $40, $C0, $C0, $C0
    db $40, $C0, $80, $C0, $60, $60, $E0, $60, $E0, $60, $E0, $60, $C0, $C0, $C0, $C0
    db $C0, $C0, $40, $40, $00, $10, $16, $26, $14, $3D, $02, $39, $69, $59, $36, $59
    db $39, $5F, $0F, $2F, $10, $10, $36, $26, $2B, $29, $2F, $29, $66, $00, $60, $40
    db $60, $40, $30, $00, $00, $80, $80, $40, $80, $C0, $00, $C0, $60, $A0, $C0, $A0
    db $40, $20, $00, $40, $80, $80, $C0, $40, $40, $40, $40, $40, $60, $00, $60, $20
    db $E0, $20, $C0, $00, $34, $24, $06, $31, $2E, $48, $8A, $D1, $84, $DB, $59, $99
    db $5B, $9B, $24, $DF, $3B, $00, $3F, $20, $77, $00, $E6, $00, $E4, $00, $E6, $00
    db $E4, $00, $E0, $80, $C0, $40, $80, $80, $80, $80, $C0, $40, $00, $60, $40, $20
    db $A0, $60, $80, $60, $C0, $00, $80, $00, $80, $00, $C0, $00, $E0, $20, $E0, $20
    db $E0, $00, $E0, $20, $00, $5F, $59, $09, $6F, $10, $6F, $50, $69, $10, $E9, $00
    db $E9, $2C, $CC, $06, $4E, $00, $66, $00, $7F, $40, $7F, $6F, $79, $21, $F9, $E1
    db $F9, $C1, $FC, $C4, $7E, $4E, $00, $80, $C0, $00, $40, $80, $C0, $40, $E0, $80
    db $E0, $60, $A0, $40, $A0, $A0, $F0, $00, $40, $00, $C0, $40, $C0, $00, $E0, $20
    db $E0, $20, $E0, $00, $E0, $20, $F0, $30, $80, $17, $5F, $17, $5F, $2F, $7F, $4F
    db $3F, $4F, $3F, $17, $1F, $3B, $4B, $80, $6F, $4F, $6F, $4F, $4F, $47, $4F, $07
    db $4F, $07, $6F, $0F, $7B, $4B, $C0, $D0, $F0, $20, $D0, $70, $90, $E0, $E0, $80
    db $80, $80, $80, $C0, $F0, $C0, $F0, $80, $F0, $10, $E0, $E0, $80, $80, $80, $80
    db $00, $08, $08, $10, $08, $1C, $00, $1C, $31, $2E, $1C, $6B, $1B, $6C, $27, $54
    db $08, $08, $18, $10, $14, $14, $14, $14, $37, $04, $77, $63, $70, $40, $78, $40
    db $00, $40, $40, $20, $40, $E0, $00, $E0, $30, $D0, $E0, $50, $60, $D0, $80, $A0
    db $40, $40, $60, $20, $A0, $A0, $A0, $A0, $B0, $80, $B0, $10, $30, $10, $60, $00
    db $3B, $57, $00, $7B, $3B, $58, $74, $4B, $58, $34, $3F, $0B, $6D, $1A, $2D, $79
    db $7C, $04, $7C, $50, $7C, $40, $7F, $0B, $4F, $00, $47, $00, $47, $00, $46, $00
    db $60, $A0, $00, $60, $40, $60, $80, $40, $00, $C0, $00, $40, $00, $C0, $40, $80
    db $E0, $80, $E0, $20, $E0, $20, $C0, $40, $C0, $40, $C0, $40, $40, $00, $40, $00
    db $00, $13, $BB, $2F, $B0, $53, $9F, $B0, $C7, $A1, $D3, $A1, $D3, $A1, $D3, $99
    db $DA, $00, $CC, $80, $DF, $90, $FF, $88, $F7, $46, $F3, $C2, $F2, $92, $F2, $92
    db $FB, $8A, $00, $40, $40, $00, $40, $80, $40, $80, $C0, $00, $C0, $00, $C0, $80
    db $C0, $00, $60, $00, $C0, $00, $C0, $40, $C0, $40, $C0, $40, $C0, $40, $40, $00
    db $40, $40, $E0, $60, $80, $1D, $5F, $1E, $5F, $6F, $BF, $EF, $7F, $5F, $9F, $0F
    db $EF, $06, $06, $80, $7F, $0F, $7F, $0E, $DF, $8F, $9F, $0F, $FF, $0F, $EF, $EF
    db $06, $06, $C0, $E0, $C0, $40, $A0, $00, $E0, $80, $80, $C0, $C0, $C0, $C0, $C0
    db $A0, $80, $E0, $00, $E0, $E0, $80, $80, $C0, $C0, $C0, $C0, $00, $10, $10, $20
    db $10, $39, $00, $3F, $24, $5B, $39, $56, $36, $59, $4F, $A9, $10, $10, $30, $20
    db $29, $29, $2F, $2F, $6F, $49, $6F, $46, $60, $40, $F0, $80, $00, $80, $80, $40
    db $80, $C0, $00, $C0, $60, $A0, $C0, $A0, $C0, $A0, $00, $40, $80, $80, $C0, $40
    db $40, $40, $40, $40, $60, $00, $60, $20, $60, $20, $C0, $00, $76, $AF, $00, $F6
    db $36, $F0, $49, $B6, $30, $A9, $0F, $E6, $1A, $F5, $5A, $F3, $F9, $89, $F9, $20
    db $F9, $80, $FF, $96, $DF, $80, $9F, $80, $8E, $00, $8C, $80, $C0, $40, $00, $C0
    db $C0, $C0, $00, $C0, $80, $40, $80, $C0, $40, $C0, $80, $C0, $C0, $00, $C0, $40
    db $C0, $40, $C0, $C0, $C0, $40, $40, $40, $40, $00, $40, $00, $00, $1A, $B3, $7F
    db $33, $33, $5F, $01, $7F, $41, $7B, $00, $72, $20, $52, $2D, $5F, $00, $CC, $80
    db $4C, $00, $7E, $08, $7E, $1E, $7A, $1A, $73, $42, $73, $42, $7E, $5E, $00, $C0
    db $80, $00, $40, $00, $40, $80, $00, $80, $00, $00, $40, $C0, $E0, $C0, $A0, $00
    db $40, $00, $C0, $40, $C0, $40, $80, $00, $80, $00, $C0, $40, $60, $20, $60, $00
    db $80, $2D, $5F, $0C, $9F, $4C, $9F, $1D, $FE, $1E, $1F, $1F, $1F, $0C, $0C, $80
    db $7E, $5E, $FE, $9E, $FE, $1E, $FF, $FE, $1F, $1F, $1F, $1F, $0C, $0C, $C0, $40
    db $E0, $80, $C0, $80, $C0, $00, $40, $40, $C0, $80, $80, $C0, $60, $20, $40, $40
    db $40, $40, $C0, $40, $C0, $C0, $80, $80, $00, $21, $21, $40, $21, $73, $00, $73
    db $C0, $BF, $73, $AD, $6D, $B3, $1E, $D2, $21, $21, $61, $40, $52, $52, $52, $52
    db $DE, $1E, $DE, $8C, $C0, $80, $E1, $80, $00, $00, $00, $80, $00, $80, $00, $80
    db $C0, $40, $80, $40, $80, $40, $00, $C0, $00, $00, $80, $80, $80, $80, $80, $80
    db $C0, $00, $C0, $40, $C0, $40, $C0, $40, $6D, $DE, $00, $ED, $2D, $E1, $52, $AD
    db $41, $D2, $3F, $ED, $12, $FF, $92, $73, $F3, $92, $F3, $40, $F3, $80, $FF, $AD
    db $BF, $80, $9E, $80, $8C, $00, $8C, $00, $80, $C0, $00, $C0, $00, $C0, $00, $C0
    db $80, $40, $80, $C0, $00, $C0, $40, $80, $C0, $40, $C0, $80, $C0, $C0, $C0, $40
    db $C0, $40, $40, $40, $40, $00, $40, $00, $00, $E1, $F3, $E0, $52, $C1, $B0, $20
    db $F1, $60, $F1, $10, $71, $11, $70, $20, $F0, $00, $32, $12, $B3, $12, $71, $30
    db $F1, $D1, $F1, $91, $71, $41, $71, $40, $F1, $90, $00, $41, $DF, $E8, $DF, $C8
    db $F8, $40, $7C, $10, $7C, $54, $7C, $08, $5E, $80, $4E, $00, $3E, $18, $3F, $17
    db $38, $10, $BC, $14, $FC, $24, $FC, $20, $DE, $52, $CE, $4E, $F0, $ED, $FC, $FA
    db $FE, $FB, $F6, $82, $8F, $F0, $FF, $1C, $FD, $FC, $F9, $F0, $8F, $89, $F0, $70
    db $F0, $7F, $FF, $7F, $FF, $E0, $E0, $F0, $F0, $F0, $FF, $FF, $FF, $FF, $E0, $E0
    db $FF, $FF, $80, $00, $06, $00, $03, $02, $05, $03, $0E, $04, $13, $08, $16, $00
    db $1C, $80, $07, $06, $03, $03, $06, $04, $09, $08, $1F, $13, $1E, $12, $1C, $1C
    db $F9, $0F, $0F, $1F, $1F, $F9, $0F, $0F, $1F, $1F, $F0, $0F, $0F, $FF, $FF, $FF
    db $FF, $1F, $1F, $F0, $0F, $0F, $FF, $FF, $FF, $FF, $1F, $1F, $00, $00, $03, $00
    db $02, $01, $03, $00, $02, $00, $02, $00, $07, $8A, $F5, $2D, $9E, $00, $03, $02
    db $03, $02, $02, $02, $03, $02, $03, $02, $07, $06, $F8, $70, $C3, $82, $01, $00
    db $C0, $00, $80, $40, $E0, $40, $A0, $00, $E0, $C0, $E0, $20, $D0, $01, $C0, $C0
    db $C0, $80, $A0, $A0, $A0, $A0, $A0, $A0, $20, $20, $70, $10, $F8, $34, $47, $03
    db $1D, $00, $03, $F8, $78, $00, $1E, $18, $03, $03, $00, $60, $D9, $35, $7F, $29
    db $CE, $11, $36, $0A, $19, $05, $0B, $02, $0F, $05, $05, $00, $39, $09, $C6, $40
    db $F0, $C0, $28, $20, $14, $10, $0C, $08, $0C, $08, $06, $00, $00, $05, $0B, $01
    db $0B, $02, $0A, $07, $0E, $06, $0D, $04, $0E, $0C, $1A, $08, $1C, $00, $0C, $08
    db $0C, $08, $0D, $08, $09, $08, $0B, $09, $0A, $0A, $16, $12, $14, $14, $00, $01
    db $72, $01, $72, $20, $F1, $60, $F0, $30, $78, $30, $38, $10, $18, $00, $1C, $00
    db $F3, $52, $F3, $72, $F1, $D1, $F0, $90, $78, $48, $38, $08, $18, $08, $1C, $14
    db $E0, $18, $34, $31, $79, $37, $EF, $4F, $5F, $9E, $FE, $E0, $2C, $24, $49, $49
    db $9F, $8F, $BF, $1F, $FE, $3E, $E0, $08, $3C, $D8, $FC, $FF, $FF, $FE, $FF, $00
    db $01, $E0, $3C, $24, $FC, $E4, $FF, $FF, $FF, $FF, $01, $01, $01, $00, $C0, $00
    db $80, $40, $E0, $40, $A0, $00, $E0, $C0, $E0, $20, $D0, $01, $C0, $C0, $C0, $80
    db $A0, $A0, $A0, $A0, $A0, $A0, $20, $20, $70, $10, $FF, $FF, $00, $60, $D8, $20
    db $76, $12, $D9, $23, $4E, $09, $2E, $1E, $2D, $04, $13, $08, $17, $00, $38, $08
    db $CE, $46, $E7, $80, $70, $40, $30, $20, $30, $20, $1C, $10, $1C, $10, $03, $40
    db $FF, $CD, $3E, $B8, $77, $7B, $D7, $E0, $8E, $90, $E6, $0B, $FF, $3F, $0E, $00
    db $2E, $04, $7F, $0E, $77, $06, $00, $00, $00, $8A, $CF, $4E, $0A, $80, $CB, $AD
    db $DD, $DD, $A0, $CB, $01, $03, $01, $07, $02, $09, $0F, $04, $86, $01, $02, $03
    db $04, $07, $0C, $0E, $08, $0C, $0F, $04, $11, $0A, $05, $0B, $04, $0A, $05, $0B
    db $04, $0A, $05, $08, $0D, $0F, $F8, $0D, $0F, $0D, $0F, $8E, $CF, $C9, $C3, $60
    db $C2, $80, $94, $90, $96, $09, $89, $09, $80, $FF, $20, $20, $FD, $01, $02, $0E
    db $14, $FC, $01, $03, $18, $1F, $93, $DC, $05, $55, $5C, $0E, $9E, $5C, $3F, $FF
    db $E5, $95, $E5, $39, $FF, $59, $53, $93, $90, $2F, $A6, $09, $96, $01, $09, $B6
    db $01, $70, $78, $70, $C2, $78, $D9, $07, $9B, $05, $99, $07, $9B, $05, $9A, $F9
    db $07, $F3, $D9, $E3, $96, $01, $86, $31, $86, $FE, $9E, $CC, $CF, $F6, $FC, $FE
    db $F5, $78, $30, $01, $C7, $FC, $03, $8F, $F8, $7E, $A9, $13, $3C, $1F, $0F, $3A
    db $1D, $0D, $11, $04, $03, $FD, $0F, $E3, $E7, $B0, $FB, $F3, $90, $AF, $A5, $C3
    db $EE, $FE, $5C, $35, $AE, $53, $9F, $F4, $F5, $95, $55, $3A, $4F, $3D, $80, $3B
    db $84, $3F, $80, $7F, $C7, $63, $71, $82, $65, $75, $F5, $02, $71, $86, $65, $82
    db $7D, $75, $C0, $1C, $3D, $80, $32, $8D, $79, $82, $7F, $A0, $2D, $A2, $20, $9A
    db $37, $2F, $9F, $DA, $BF, $C7, $C0, $F8, $F0, $FD, $F0, $7D, $79, $F5, $C5, $12
    db $A0, $63, $43, $E1, $E0, $C1, $FF, $3E, $1C, $1E, $3E, $3F, $95, $F6, $44, $44
    db $73, $9D, $54, $4F, $6F, $73, $7E, $55, $DD, $DD, $DA, $55, $55, $55, $AD, $E5
    db $C3, $F2, $FD, $E5, $08, $02, $01, $02, $03, $84, $87, $86, $09, $F3, $66, $1A
    db $FC, $FE, $78, $FC, $FD, $70, $F5, $FE, $01, $FE, $5F, $1C, $E7, $F8, $98, $E7
    db $E1, $73, $37, $01, $F3, $BF, $0F, $1F, $07, $0F, $43, $E3, $7F, $86, $09, $01
    db $09, $49, $41, $09, $70, $FD, $78, $70, $30, $38, $70, $5B, $E5, $A5, $23, $19
    db $07, $3A, $05, $1B, $D9, $07, $DB, $05, $99, $07, $E3, $91, $F7, $87, $39, $E1
    db $64, $44, $73, $55, $59, $EE, $AE, $E5, $C3, $FA, $95, $C3, $80, $7F, $80, $40
    db $38, $80, $08, $B0, $B8, $30, $20, $90, $30, $80, $29, $90, $7D, $C9, $80, $BF
    db $CF, $CF, $CF, $EF, $C7, $E4, $8F, $08, $01, $0C, $32, $0D, $7F, $EF, $14, $E1
    db $1C, $F3, $2E, $70, $F3, $C0, $E1, $80, $C0, $08, $1E, $7F, $38, $80, $3C, $3D
    db $3F, $3D, $C7, $AA, $65, $9E, $79, $61, $82, $E1, $02, $71, $82, $C0, $1C, $8F
    db $F3, $C0, $F3, $98, $39, $75, $58, $37, $75, $5F, $57, $3A, $8D, $39, $40, $D0
    db $EF, $E4, $02, $F1, $11, $E0, $0A, $31, $04, $9B, $EF, $4E, $CD, $2E, $C0, $BF
    db $7F, $9F, $5E, $DE, $1E, $78, $F7, $F9, $04, $08, $FA, $87, $22, $89, $06, $41
    db $B6, $FB, $02, $73, $8E, $FD, $E2, $0F, $F7, $07, $67, $03, $30, $8E, $4E, $D1
    db $37, $0F, $31, $FE, $2D, $D3, $1F, $13, $3F, $1F, $FD, $DF, $FB, $59, $F1, $E1
    db $E0, $E8, $F3, $E0, $F3, $49, $A2, $F5, $FA, $F9, $0F, $8F, $FC, $65, $90, $01
    db $0C, $87, $08, $8D, $77, $F0, $FB, $F3, $8F, $39, $39, $F3, $C0, $78, $57, $3A
    db $78, $39, $55, $37, $37, $75, $50, $00, $8E, $7F, $8F, $30, $12, $FD, $20, $9F
    db $C0, $30, $40, $A5, $3F, $C8, $0F, $D0, $D8, $BF, $9F, $F7, $FA, $E5, $E8, $E4
    db $E0, $02, $B5, $4B, $A3, $4C, $08, $C7, $04, $83, $2A, $C4, $5C, $6B, $87, $BF
    db $30, $E8, $FC, $7B, $78, $78, $12, $E4, $43, $BF, $EF, $30, $0F, $B0, $1F, $22
    db $9D, $80, $30, $48, $B0, $BF, $EF, $F5, $CF, $CF, $84, $7A, $39, $4F, $DC, $04
    db $1E, $3C, $47, $F8, $48, $7A, $FC, $79, $EF, $CF, $87, $B0, $83, $A7, $CF, $87
    db $CF, $3F, $40, $3F, $80, $7F, $90, $60, $80, $4F, $8F, $1F, $9F, $3F, $9F, $3F
    db $BF, $3F, $FF, $80, $FF, $BF, $FF, $FF, $F0, $E0, $E0, $C0, $C0, $C0, $C0, $C0
    db $C0, $C0, $02, $FC, $01, $FE, $03, $06, $01, $F2, $F9, $F8, $F9, $F8, $F9, $F8
    db $F9, $F8, $FF, $01, $FF, $FD, $FF, $FF, $0F, $07, $07, $03, $07, $03, $07, $03
    db $07, $03, $BF, $3F, $B0, $30, $80, $00, $A0, $00, $C0, $30, $9D, $09, $86, $4E
    db $C0, $3F, $C0, $C0, $CF, $C0, $FF, $C0, $FF, $E0, $FF, $FF, $F5, $FB, $F9, $BF
    db $FF, $FF, $F1, $F0, $01, $00, $01, $00, $05, $00, $13, $0C, $EB, $C0, $73, $30
    db $03, $FC, $0F, $03, $FF, $03, $FF, $03, $FF, $07, $FF, $FF, $AF, $DF, $CF, $FD
    db $FF, $FF, $8E, $10, $37, $7E, $34, $48, $39, $77, $33, $B7, $FF, $38, $39, $77
    db $80, $31, $0C, $2C, $F3, $25, $9F, $62, $8E, $6B, $0E, $E3, $8E, $01, $DE, $BB
    db $FB, $F3, $7F, $5F, $5E, $9E, $5F, $C0, $FE, $88, $CF, $FC, $01, $76, $D9, $22
    db $DA, $07, $8B, $52, $F5, $72, $F9, $01, $8F, $07, $17, $23, $57, $27, $00, $C6
    db $3B, $C2, $31, $11, $E0, $42, $31, $24, $9B, $E2, $4F, $C9, $2E, $20, $8F, $E0
    db $7F, $9F, $5E, $DE, $1E, $DF, $DE, $77, $8C, $74, $8A, $C3, $16, $71, $43, $24
    db $BA, $43, $FB, $06, $A9, $02, $FD, $F0, $9F, $07, $67, $03, $F7, $77, $8F, $1F
    db $73, $77, $E3, $1F, $E4, $37, $78, $E3, $33, $97, $EF, $3B, $78, $88, $90, $40
    db $99, $3F, $D0, $2C, $8C, $1F, $C0, $39, $C4, $44, $AF, $7D, $81, $80, $BF, $F3
    db $E0, $E2, $EC, $E2, $83, $A6, $10, $B6, $CF, $10, $FD, $9D, $6A, $B7, $28, $96
    db $13, $BF, $88, $EF, $CF, $FE, $78, $78, $79, $00, $8F, $30, $1F, $F0, $20, $9F
    db $C9, $30, $D0, $2D, $B6, $4B, $9F, $42, $13, $E8, $BA, $BF, $9F, $F2, $F9, $E2
    db $E0, $EF, $E6, $02, $19, $EE, $0F, $C4, $04, $83, $29, $C6, $34, $49, $9D, $6A
    db $5F, $DE, $68, $E8, $FE, $FB, $78, $78, $7B, $79, $97, $6F, $47, $39, $35, $55
    db $6F, $F4, $F7, $73, $35, $35, $4D, $D4, $45, $55, $55, $37, $F4, $53, $95, $93
    db $30, $A1, $7F, $02, $3D, $68, $8C, $33, $81, $36, $BF, $1D, $B4, $03, $A0, $EF
    db $80, $F7, $E6, $FE, $F7, $E0, $EA, $FE, $02, $03, $B4, $B8, $FC, $F7, $F0, $13
    db $73, $0C, $EF, $01, $FE, $0F, $F7, $07, $7F, $F4, $A0, $07, $03, $F0, $83, $38
    db $E0, $3F, $40, $3B, $44, $FD, $E0, $E7, $E3, $F0, $FB, $C0, $80, $BF, $41, $5F
    db $20, $13, $0B, $FC, $52, $2C, $4B, $34, $03, $78, $D4, $32, $F4, $FD, $7F, $7F
    db $7B, $39, $8A, $7F, $66, $55, $45, $56, $55, $5E, $65, $55, $23, $2E, $7F, $A0
    db $4A, $8D, $89, $AF, $9D, $9F, $B8, $BD, $81, $79, $98, $80, $9F, $B9, $62, $F9
    db $03, $0B, $3C, $FE, $84, $80, $F9, $C6, $00, $77, $FC, $9E, $A2, $BE, $C2, $F6
    db $E1, $D3, $D1, $9D, $1C, $C2, $1D, $55, $D9, $9A, $01, $5D, $DD, $03, $DF, $D0
    db $D8, $3E, $7F, $21, $DF, $23, $00, $BD, $7B, $E0, $C6, $B8, $41, $7C, $FB, $05
    db $8F, $49, $4C, $BA, $76, $03, $01, $98, $7F, $18, $BF, $C6, $80, $7F, $38, $CA
    db $B4, $A1, $9F, $E5, $FE, $C0, $5E, $25, $1E, $E3, $5E, $FE, $11, $20, $81, $68
    db $DE, $64, $D2, $C1, $98, $DF, $1B, $FC, $21, $01, $DF, $DE, $08, $37, $80, $FD
    db $E3, $3F, $94, $95, $E4, $49, $40, $44, $0D, $DD, $9E, $44, $44, $9E, $45, $55
    db $55, $0B, $66, $F9, $54, $F0, $29, $1F, $13, $3D, $23, $B9, $A7, $E3, $6E, $FE
    db $B8, $F9, $B6, $FF, $E0, $C0, $40, $01, $06, $7C, $10, $60, $20, $28, $68, $11
    db $38, $C9, $68, $99, $FB, $8F, $CF, $C7, $87, $86, $01, $06, $07, $37, $BD, $72
    db $DF, $30, $10, $D8, $8E, $FE, $EF, $0F, $03, $DC, $01, $10, $10, $F0, $03, $C8
    db $39, $10, $F1, $86, $70, $F7, $CB, $C7, $C6, $F9, $87, $9F, $1D, $07, $0E, $01
    db $04, $0C, $03, $0B, $04, $37, $08, $20, $1F, $19, $66, $14, $9E, $55, $53, $95
    db $39, $04, $41, $FF, $29, $85, $55, $55, $34, $40, $94, $44, $F5, $55, $29, $55
    db $2C, $16, $F5, $35, $55, $55, $FF, $29, $66, $F0, $FF, $03, $80, $F8, $7F, $FF
    db $80, $F8, $7F, $07, $BF, $E0, $3C, $FC, $1F, $07, $E1, $F8, $FE, $FF, $1F, $03
    db $E0, $F8, $FE, $3F, $FD, $07, $F9, $FE, $08, $40, $FE, $03, $FF, $BF, $03, $FE
    db $7F, $07, $D7, $01, $07, $01, $7F, $18, $0E, $F0, $03, $01, $F0, $F8, $FE, $10
    db $9C, $83, $58, $35, $54, $44, $44, $42, $55, $53, $95, $55, $04, $41, $F2, $A5
    db $2E, $52, $9F, $FF, $FF, $F5, $52, $95, $26, $52, $BF, $FF, $7F, $9F, $1F, $7F
    db $FE, $7F, $7F, $FC, $FD, $E0, $80, $1F, $C0, $81, $07, $70, $0F, $FF, $E0, $01
    db $E3, $F0, $87, $3C, $FF, $01, $E3, $E0, $79, $8B, $60, $3F, $28, $1F, $11, $DF
    db $C2, $0C, $3E, $13, $FF, $20, $08, $1F, $CE, $0C, $73, $F3, $FF, $1F, $C0, $1F
    db $1D, $F0, $D0, $60, $18, $14, $EA, $95, $FE, $56, $4F, $E5, $5D, $49, $44, $06
    db $E5, $FF, $FF, $FF, $FF, $56, $FF, $5F, $FF, $FF, $FF, $F0, $0B, $DA, $E4, $EC
    db $F3, $7C, $FB, $8B, $FC, $41, $86, $7F, $1B, $66, $C1, $01, $80, $60, $80, $80
    db $70, $38, $C0, $60, $98, $18, $E4, $67, $43, $1F, $20, $9F, $5E, $A0, $1E, $E0
    db $9C, $60, $C4, $38, $01, $E0, $7F, $1F, $C0, $40, $1F, $0F, $07, $0F, $05, $09
    db $F7, $C4, $FB, $67, $3F, $28, $1F, $11, $DF, $C2, $0C, $3E, $13, $FF, $31, $C8
    db $27, $08, $1F, $CE, $0C, $73, $B5, $18, $C0, $F7, $F9, $10, $CB, $F7, $06, $07
    db $1F, $1D, $FF, $1C, $E2, $18, $E3, $D7, $60, $19, $14, $96, $58, $08, $88, $88
    db $9F, $7F, $88, $88, $88, $88, $EE, $E8, $88, $89, $89, $8F, $F8, $88, $88, $88
    db $80, $80, $E4, $D8, $E7, $5F, $F8, $CB, $3C, $42, $FD, $D1, $EE, $92, $ED, $B3
    db $CC, $FF, $01, $18, $0C, $17, $09, $08, $34, $70, $CF, $38, $E7, $9E, $0C, $E3
    db $1F, $9C, $07, $DC, $EB, $06, $FF, $C0, $60, $20, $0C, $03, $E0, $3C, $1E, $07
    db $D1, $EE, $DA, $E5, $6C, $F3, $65, $BA, $B1, $FE, $69, $E1, $C1, $FF, $0A, $03
    db $81, $C0, $80, $04, $30, $F4, $03, $7D, $80, $DF, $E7, $E9, $06, $F4, $83, $EA
    db $D1, $F5, $C8, $FF, $1F, $87, $E0, $78, $3E, $9F, $DF, $CF, $90, $44, $44, $44
    db $4A, $44, $44, $E9, $44, $44, $C0, $84, $44, $44, $44, $40, $00, $BB, $F9, $E4
    db $7F, $FB, $24, $FE, $19, $F8, $17, $F1, $1F, $FE, $1D, $EB, $0F, $E9, $06, $80
    db $C0, $E8, $08, $E0, $E1, $01, $EC, $0C, $F0, $00, $63, $E0, $BF, $7C, $07, $FC
    db $2F, $DC, $5D, $B8, $9D, $70, $69, $E0, $D3, $C0, $FE, $1F, $03, $07, $0F, $1F
    db $3F, $E4, $04, $13, $F9, $01, $FE, $04, $EE, $18, $FE, $F4, $1A, $FE, $12, $FB
    db $F0, $FE, $F1, $E1, $17, $10, $B7, $D0, $37, $30, $E0, $20, $8F, $C0, $80, $98
    db $03, $30, $11, $60, $EF, $0F, $CF, $1F, $F0, $3F, $67, $CF, $8F, $99, $19, $44
    db $47, $1B, $44, $14, $19, $44, $41, $B4, $41, $41, $94, $47, $08, $31, $B4, $14
    db $00, $98, $44, $19, $44, $44, $F3, $E5, $E0, $FA, $02, $F9, $01, $F0, $0F, $FF
    db $FD, $FE, $F0, $CB, $FB, $E3, $23, $20, $C7, $C0, $0F, $87, $80, $FF, $DF, $3F
    db $7F, $FE, $F8, $FF, $07, $FC, $F8, $CC, $03, $E3, $60, $F8, $08, $CF, $C0, $71
    db $70, $7F, $0D, $0C, $80, $9F, $F7, $3F, $8F, $C0, $F3, $7F, $94, $5F, $38, $89
    db $38, $88, $FF, $DE, $44, $49, $4F, $FF, $88, $80, $B8, $FF, $EE, $44, $4A, $EE
    db $90, $9D, $3F, $E0, $DF, $FE, $01, $B7, $F8, $99, $FC, $BF, $D4, $DF, $EB, $FF
    db $E0, $FE, $FE, $F6, $FB, $72, $BF, $48, $BF, $DF, $A0, $EF, $50, $DF, $A0, $DE
    db $B8, $60, $E3, $37, $3F, $1F, $9F, $80, $4F, $40, $9F, $80, $1F, $0E, $EB, $35
    db $67, $B9, $F1, $9F, $72, $ED, $10, $3E, $FE, $77, $8E, $FD, $3D, $3F, $1F, $06
    db $7F, $C0, $7F, $B3, $BF, $DF, $A0, $DE, $DC, $D9, $A1, $D7, $A6, $3F, $7F, $B8
    db $3F, $9F, $80, $9E, $99, $92, $53, $A8, $A8, $81, $44, $D3, $C3, $55, $58, $88
    db $89, $88, $8E, $39, $8A, $88, $80, $01, $8F, $B8, $57, $CC, $5B, $C7, $5C, $C3
    db $5E, $C1, $5F, $C0, $A0, $E0, $9F, $FF, $7F, $3F, $1F, $F1, $C3, $F8, $E0, $1C
    db $F0, $9E, $70, $DE, $30, $4F, $38, $83, $C1, $7C, $E3, $3E, $E1, $57, $B8, $B3
    db $DC, $73, $FE, $FB, $C9, $FF, $01, $80, $C0, $E0, $C2, $83, $03, $08, $27, $1C
    db $B3, $8F, $58, $C7, $5E, $C1, $46, $B9, $78, $C6, $3E, $F1, $CF, $FE, $7F, $3F
    db $07, $C1, $96, $44, $44, $44, $44, $41, $74, $19, $44, $44, $45, $55, $88, $0A
    db $84, $79, $E4, $14, $94, $94, $19, $40, $00, $8C, $FC, $22, $DE, $C5, $3C, $8B
    db $78, $97, $70, $30, $E0, $C7, $07, $E8, $EF, $FF, $03, $01, $03, $07, $0F, $1F
    db $78, $10, $64, $73, $03, $F8, $9F, $10, $3F, $38, $F0, $BE, $E1, $7F, $E8, $FF
    db $FC, $EF, $C7, $0F, $1E, $17, $B0, $D1, $F3, $CF, $07, $1C, $32, $FD, $0D, $FB
    db $FA, $E6, $E5, $1C, $FB, $10, $40, $08, $E1, $E0, $03, $F8, $AD, $37, $F0, $77
    db $CF, $C0, $3F, $83, $80, $07, $FE, $0F, $3F, $7F, $94, $FF, $77, $70, $84, $44
    db $44, $48, $88, $41, $C0, $44, $41, $C0, $AD, $77, $4A, $44, $44, $40, $BC, $07
    db $FB, $07, $F8, $48, $79, $7B, $FB, $3B, $F9, $19, $FF, $03, $F8, $B7, $86, $84
    db $C4, $E6, $00, $F9, $67, $FE, $E1, $0F, $F1, $EF, $11, $67, $1C, $AF, $9E, $B4
    db $8F, $BF, $83, $E1, $60, $E0, $11, $E1, $01, $EC, $0C, $6E, $0E, $71, $01, $7C
    db $1F, $FD, $0D, $F5, $05, $FD, $01, $F2, $FA, $FE, $D5, $9F, $81, $DF, $D1, $D9
    db $DE, $49, $4D, $FF, $45, $7E, $2E, $26, $B6, $B2, $BA, $97, $79, $79, $77, $84
    db $49, $49, $44, $FF, $79, $1A, $08, $44, $91, $A7, $77, $97, $71, $94, $44, $94
    db $41, $CD, $3F, $31, $DF, $0E, $F7, $07, $27, $26, $6E, $FF, $11, $08, $F8, $D8
    db $D9, $91, $BF, $C0, $E7, $F8, $0F, $80, $FF, $E0, $0F, $7F, $4C, $0C, $FF, $18
    db $30, $20, $B3, $F3, $FC, $E7, $CF, $DF, $91, $55, $7F, $FF, $38, $98, $88, $88
    db $F8, $88, $F8, $88, $88, $88, $8D, $44, $E4, $BE, $81, $BF, $7E, $01, $1E, $1A
    db $C4, $3A, $D4, $AB, $FF, $7F, $1E, $05, $02, $01, $C8, $10, $BE, $61, $71, $CE
    db $C6, $B9, $9D, $7D, $92, $B9, $E6, $5B, $DC, $97, $60, $E0, $E0, $CE, $B8, $65
    db $64, $9D, $9C, $31, $30, $A3, $80, $7F, $60, $80, $D9, $7A, $A5, $3C, $F3, $5D
    db $BA, $AA, $DF, $67, $DD, $D1, $AE, $E0, $9F, $FF, $04, $A4, $F2, $FA, $FB, $FD
    db $BC, $FE, $04, $2F, $D2, $EF, $12, $D7, $2A, $6F, $92, $5F, $A6, $A4, $DF, $A8
    db $BF, $48, $1B, $2D, $20, $4D, $40, $65, $60, $0D, $19, $9B, $80, $97, $37, $95
    db $D1, $44, $44, $14, $44, $4F, $FF, $41, $77, $77, $73, $FF, $FF, $79, $ED, $79
    db $77, $FF, $3C, $30, $48, $E0, $1E, $1C, $A0, $1E, $61, $10, $CF, $20, $8F, $60
    db $0F, $C0, $FF, $E1, $E3, $E1, $EF, $DF, $9F, $3F, $5C, $8F, $80, $1F, $7E, $01
    db $FC, $E1, $C7, $9E, $60, $0E, $F0, $FF, $7F, $01, $03, $1F, $3F, $7F, $47, $0E
    db $01, $FE, $3E, $81, $3C, $83, $3D, $02, $FD, $F9, $E0, $FF, $01, $7F, $03, $03
    db $07, $1F, $09, $62, $95, $F0, $0B, $F8, $04, $0C, $83, $9E, $E0, $11, $01, $0E
    db $0F, $C0, $97, $7E, $D8, $90, $A4, $4D, $DD, $9D, $44, $44, $9D, $E9, $72, $58
    db $06, $88, $09, $44, $17, $DF, $ED, $D7, $73, $E0, $E3, $FD, $03, $F9, $07, $E3
    db $1F, $0E, $FE, $F8, $F9, $06, $0F, $FC, $E0, $01, $06, $F6, $06, $10, $60, $F9
    db $20, $28, $68, $69, $38, $C9, $68, $99, $8F, $FE, $CF, $C7, $87, $01, $07, $1D
    db $FE, $EF, $F0, $C0, $8E, $FE, $F9, $0F, $1C, $FE, $F0, $01, $06, $0F, $C8, $39
    db $42, $10, $F1, $F2, $70, $F7, $C2, $CD, $04, $39, $11, $6E, $0F, $07, $01, $EE
    db $0F, $03, $07, $3F, $0F, $3F, $7F, $9A, $77, $77, $88, $83, $98, $88, $E7, $71
    db $58, $88, $88, $80, $94, $57, $56, $08, $80, $94, $72, $3F, $F8, $60, $30, $A4
    db $70, $B8, $E1, $C7, $7E, $1F, $F8, $E3, $CF, $BE, $3E, $F9, $F9, $E7, $FF, $E1
    db $7E, $1F, $FE, $F8, $E0, $5F, $F1, $BF, $E7, $DF, $3F, $FE, $C0, $01, $C0, $FF
    db $B1, $E7, $DF, $FE, $C0, $3F, $69, $E7, $1F, $1D, $FE, $FE, $81, $06, $3C, $FC
    db $E0, $E3, $0F, $FD, $01, $0E, $03, $1F, $03, $0F, $F5, $FE, $10, $23, $DF, $1F
    db $03, $C3, $F8, $FA, $E0, $FC, $C0, $F8, $99, $FE, $55, $F3, $98, $3A, $80, $73
    db $55, $39, $83, $C1, $F7, $55, $64, $46, $09, $88, $3B, $FF, $25, $50, $B8, $88
    db $80, $9D, $43, $3F, $C7, $0F, $F8, $87, $FE, $F9, $9F, $EF, $67, $FE, $FE, $8F
    db $E3, $1F, $CF, $E0, $C3, $7F, $38, $DF, $E7, $1C, $FF, $E0, $38, $E0, $1E, $01
    db $2F, $FF, $1F, $F8, $07, $E0, $FE, $FC, $03, $FC, $F3, $08, $84, $7F, $02, $6F
    db $7E, $09, $F7, $F0, $F8, $FC, $FE, $94, $FF, $88, $88, $89, $83, $F5, $53, $88
    db $88, $08, $0F, $46, $44, $46, $3C, $32, $6F, $3C, $30, $09, $DB, $E5, $6C, $F3
    db $9C, $7B, $8B, $7C, $E1, $26, $1F, $13, $0F, $F0, $FF, $01, $80, $E0, $F0, $F8
    db $FC, $07, $C3, $FC, $F8, $7F, $7E, $BF, $3F, $DF, $9F, $67, $F3, $01, $FC, $FF
    db $7F, $3F, $1F, $07, $01, $BF, $CE, $1E, $E0, $F1, $C0, $20, $1F, $F8, $07, $F0
    db $7F, $38, $07, $8C, $03, $7E, $01, $E0, $11, $70, $01, $0E, $0F, $95, $9E, $E8
    db $88, $A8, $AF, $FF, $F8, $88, $88, $09, $87, $D4, $46, $89, $88, $83, $A8, $88
    db $0A, $88, $0B, $DB, $E7, $6B, $F4, $A9, $76, $AD, $72, $51, $3E, $53, $D3, $FC
    db $03, $80, $C0, $E0, $B0, $EF, $18, $F7, $BB, $46, $73, $8E, $6C, $63, $30, $7C
    db $DB, $E0, $76, $FC, $39, $0E, $03, $18, $CA, $3F, $1E, $EF, $BF, $07, $1F, $C3
    db $21, $1F, $FB, $07, $F0, $F8, $F8, $FC, $FE, $7F, $CC, $5F, $EE, $4E, $F7, $07
    db $CE, $F1, $F6, $E9, $EA, $F5, $FC, $3F, $86, $7F, $0C, $0E, $06, $F0, $C0, $F8
    db $90, $7E, $D8, $90, $A4, $4D, $94, $96, $76, $54, $88, $60, $FF, $D6, $FF, $90
    db $E0, $E3, $FD, $03, $F9, $07, $E3, $1F, $0E, $FE, $F8, $F9, $06, $0F, $FC, $E0
    db $01, $06, $F6, $06, $10, $60, $19, $1C, $20, $12, $28, $11, $60, $68, $3D, $C8
    db $6A, $99, $8F, $0C, $C3, $0C, $C5, $02, $86, $09, $82, $05, $07, $04, $03, $1D
    db $FE, $E5, $F0, $FC, $C0, $8E, $CE, $F1, $E1, $10, $1F, $05, $1C, $E6, $F0, $03
    db $01, $30, $04, $1A, $E5, $E0, $C8, $29, $02, $14, $D1, $18, $B1, $3C, $3A, $EF
    db $AB, $3B, $53, $F9, $D1, $93, $02, $15, $4E, $0A, $25, $4F, $08, $C7, $39, $46
    db $93, $11, $97, $75, $88, $88, $88, $89, $E7, $75, $88, $88, $88, $09, $45, $88
    db $08, $86, $66, $F2, $88, $88, $05, $66, $6F, $24, $F0, $EF, $C7, $7E, $1F, $7E
    db $F9, $78, $E7, $01, $A2, $7D, $B9, $67, $FF, $E0, $7E, $1F, $7E, $7C, $30, $20
    db $4F, $C9, $BF, $DF, $BF, $7F, $7F, $FE, $CC, $1E, $3B, $FE, $FF, $81, $C7, $97
    db $32, $40, $01, $43, $A7, $5F, $1D, $BF, $FE, $BE, $C0, $06, $DE, $2D, $EC, $E2
    db $0B, $FD, $01, $0E, $01, $21, $13, $06, $19, $FB, $C7, $BF, $7E, $01, $80, $4F
    db $23, $D7, $06, $01, $68, $F9, $BF, $80, $B0, $08, $E0, $19, $0C, $F2, $6D, $93
    db $77, $55, $38, $88, $98, $6F, $88, $08, $88, $85, $66, $FF, $9F, $F6, $86, $66
    db $6D, $D0, $6C, $83, $7D, $26, $38, $87, $F8, $BE, $DF, $9F, $AF, $47, $90, $FD
    db $FE, $F8, $BF, $DF, $8F, $CF, $28, $41, $8E, $F1, $3E, $FE, $41, $CC, $7B, $E7
    db $D8, $DF, $A2, $1D, $8E, $EF, $FD, $80, $40, $F8, $C0, $82, $8E, $EE, $EF, $00
    db $08, $C5, $DF, $D0, $D4, $94, $D6, $86, $C7, $92, $87, $9A, $2B, $AC, $DF, $D5
    db $DF, $32, $21, $80, $6B, $86, $82, $20, $50, $30, $02, $F4, $34, $01, $D3, $F3
    db $E0, $23, $BC, $D4, $FA, $D2, $F9, $93, $F3, $09, $CA, $2C, $0C, $20, $DC, $10
    db $EB, $ED, $EE, $90, $66, $66, $6F, $58, $E6, $6E, $DF, $FF, $FF, $9F, $FE, $DF
    db $FF, $FF, $F9, $00, $DA, $C4, $EC, $E1, $8C, $49, $88, $28, $EB, $08, $9E, $0B
    db $5E, $16, $7B, $51, $BD, $21, $80, $12, $F2, $F7, $FE, $FC, $10, $ED, $51, $00
    db $43, $7C, $B8, $3F, $7E, $BF, $1D, $DD, $1B, $A3, $23, $08, $01, $77, $64, $66
    db $B5, $7F, $3F, $7F, $3F, $1D, $03, $47, $D4, $01, $89, $99, $18, $75, $43, $D1
    db $87, $C0, $97, $C7, $92, $87, $9A, $2B, $AC, $DF, $D5, $FF, $41, $81, $80, $86
    db $82, $20, $50, $41, $9F, $29, $1C, $18, $51, $6C, $6A, $6F, $AB, $BB, $D3, $F9
    db $D1, $93, $7F, $08, $F6, $08, $10, $28, $29, $13, $11, $93, $E4, $94, $44, $44
    db $44, $44, $44, $44, $44, $44, $44, $44, $41, $55, $09, $44, $44, $04, $40, $FC
    db $18, $D9, $BF, $19, $FC, $1F, $DC, $3D, $EC, $0E, $F4, $05, $B0, $41, $FF, $E7
    db $E6, $E0, $C2, $F1, $FA, $BE, $00, $31, $7F, $6F, $EE, $DE, $C1, $0E, $7F, $7B
    db $FB, $46, $67, $5B, $9C, $3F, $20, $FF, $80, $10, $20, $80, $04, $98, $60, $C0
    db $01, $F4, $04, $FD, $07, $E3, $03, $FE, $0C, $EE, $07, $FA, $04, $F8, $01, $F7
    db $FF, $FB, $F8, $FC, $F3, $F8, $FB, $FE, $42, $B0, $CF, $9F, $D6, $C7, $69, $0E
    db $97, $58, $78, $67, $E3, $CD, $4E, $FF, $38, $F0, $A0, $80, $B0, $92, $DE, $14
    db $41, $44, $DF, $FF, $FF, $FF, $EE, $FF, $FF, $FF, $ED, $F9, $FF, $FF, $F9, $68
    db $E0, $1E, $1C, $A0, $61, $10, $CE, $20, $9D, $60, $05, $C0, $C8, $E1, $E3, $E0
    db $03, $EB, $04, $DE, $01, $8D, $12, $34, $0B, $54, $CB, $80, $2D, $EC, $01, $6D
    db $B7, $15, $14, $9D, $28, $9C, $29, $7F, $1B, $64, $CD, $6C, $24, $95, $94, $88
    db $08, $50, $0B, $01, $FB, $3C, $83, $3F, $1F, $02, $EF, $12, $EB, $04, $DF, $15
    db $CF, $F3, $FB, $78, $07, $3A, $45, $DE, $EA, $C8, $90, $41, $9C, $29, $1C, $18
    db $51, $6C, $6A, $6F, $AB, $BB, $D3, $F9, $D1, $93, $FF, $08, $10, $28, $29, $13
    db $11, $93, $5F, $F4, $09, $88, $88, $04, $4A, $44, $44, $54, $04, $49, $44, $84
    db $49, $44, $44, $40, $61, $3B, $F9, $04, $9B, $8E, $79, $38, $E7, $E1, $DF, $FE
    db $1D, $F8, $FF, $06, $08, $20, $C1, $1C, $00, $63, $E0, $BF, $7C, $07, $FC, $2F
    db $DC, $5D, $B8, $9D, $70, $69, $E0, $D3, $C0, $FE, $1F, $03, $07, $0F, $1F, $3F
    db $66, $FE, $81, $0E, $52, $B5, $D6, $30, $06, $F0, $04, $EA, $0E, $12, $7E, $F2
    db $01, $FC, $08, $09, $11, $E1, $71, $70, $17, $10, $11, $37, $D0, $77, $B0, $E0
    db $20, $C0, $80, $98, $03, $30, $11, $60, $EF, $FE, $0F, $1F, $3F, $67, $CF, $8F
    db $92, $5F, $83, $98, $98, $88, $08, $88, $80, $80, $57, $88, $98, $88, $38, $F8
    db $80, $C1, $42, $DF, $FE, $BF, $90, $EF, $F7, $0F, $DF, $7F, $5F, $FC, $80, $C7
    db $BC, $FF, $FE, $7F, $7C, $3F, $BC, $00, $8B, $7E, $F6, $CF, $F7, $EF, $EF, $DF
    db $DF, $3E, $9E, $7D, $BF, $7F, $9F, $7C, $FF, $C0, $E1, $C1, $02, $07, $21, $DC
    db $F3, $C3, $BF, $BF, $9F, $7C, $66, $F9, $BE, $C3, $C7, $3F, $F0, $FF, $F0, $BF
    db $3C, $78, $C3, $F0, $04, $F4, $EF, $E2, $DF, $F2, $0F, $E2, $1F, $42, $BF, $02
    db $95, $6F, $2A, $DF, $F0, $60, $C0, $96, $FF, $F5, $76, $3C, $08, $39, $75, $88
    db $88, $88, $83, $41, $2F, $25, $23, $C3, $57, $53, $A8, $88, $88, $F5, $07, $80
    db $F0, $81, $07, $FB, $3E, $A1, $7F, $7F, $F8, $FE, $78, $F7, $42, $BF, $3C, $FB
    db $1F, $FB, $F4, $CF, $F3, $BF, $4C, $FE, $0F, $F0, $FE, $F8, $FB, $F0, $C3, $0C
    db $FE, $C3, $1F, $E0, $FF, $FC, $FE, $FD, $29, $1F, $03, $87, $7F, $FC, $3F, $F8
    db $FC, $1C, $F3, $70, $EF, $FC, $FC, $F8, $FC, $F0, $E0, $94, $55, $55, $88, $3B
    db $88, $5F, $48, $98, $83, $BF, $F1, $88, $80, $B8, $5F, $38, $83, $98, $88, $B4
    db $9C, $3F, $E0, $DF, $02, $B6, $FB, $9A, $BE, $D7, $DE, $EB, $FC, $FE, $E0, $F7
    db $FB, $F1, $7E, $EF, $73, $3B, $F3, $3C, $7F, $C7, $1C, $E0, $9F, $E6, $01, $7F
    db $F0, $3F, $C7, $EB, $35, $65, $BA, $F1, $9E, $71, $EE, $EF, $10, $3E, $77, $8F
    db $3D, $3C, $1C, $C1, $07, $99, $E0, $E3, $3C, $FC, $C7, $D8, $E7, $C7, $F8, $38
    db $7F, $DF, $27, $70, $3F, $C7, $3F, $C0, $07, $8F, $8D, $66, $6F, $FF, $F8, $ED
    db $FF, $FF, $F9, $FF, $8E, $69, $9D, $00, $AC, $BF, $B0, $B3, $A5, $65, $83, $2B
    db $EE, $0A, $9B, $0D, $5F, $15, $7B, $51, $DF, $40, $4C, $20, $DA, $FC, $02, $01
    db $11, $51, $00, $77, $89, $7F, $43, $3E, $47, $3F, $03, $5F, $31, $EF, $72, $4B
    db $57, $A5, $32, $80, $09, $03, $83, $07, $87, $03, $F3, $01, $C9, $02, $82, $07
    db $A7, $02, $CA, $18, $75, $43, $D1, $87, $C0, $97, $C7, $92, $87, $9A, $2B, $AC
    db $DF, $D5, $FF, $41, $81, $80, $86, $82, $20, $50, $12, $A1, $2A, $14, $35, $15
    db $55, $69, $6A, $AA, $BC, $D5, $FD, $FB, $93, $63, $02, $D6, $EA, $20, $D6, $28
    db $D5, $10, $EA, $EC, $96, $FF, $FF, $FF, $FF, $80, $C2, $7F, $88, $88, $88, $88
    db $FF, $88, $80, $98, $88, $FF, $88, $88, $88, $88, $FF, $09, $CD, $65, $32, $D3
    db $21, $70, $7C, $E0, $04, $DE, $A1, $EF, $58, $D3, $0F, $EC, $03, $73, $80, $7F
    db $BC, $40, $01, $0B, $E3, $78, $3F, $1F, $0F, $E3, $03, $01, $04, $79, $8E, $3E
    db $C7, $9F, $61, $C3, $38, $1F, $2F, $DD, $E7, $9D, $97, $EA, $0E, $07, $01, $F8
    db $0D, $05, $22, $F9, $3C, $CE, $F1, $F3, $3C, $39, $CE, $1F, $DC, $2F, $EE, $97
    db $E7, $DF, $06, $F3, $F9, $3D, $08, $E0, $0C, $86, $C7, $94, $E4, $94, $44, $44
    db $44, $44, $44, $44, $47, $E4, $44, $49, $44, $41, $44, $44, $41, $44, $44, $40
    db $5C, $18, $D9, $BF, $19, $FC, $1E, $DD, $3C, $EC, $0E, $F4, $05, $BE, $47, $FF
    db $E7, $E6, $E1, $C3, $F1, $FA, $B8, $00, $35, $70, $6D, $E0, $DD, $CC, $69, $08
    db $F3, $70, $47, $60, $57, $84, $06, $34, $FF, $8F, $1F, $33, $F7, $8F, $9F, $7B
    db $CA, $31, $F6, $0E, $FD, $06, $0C, $FE, $EE, $07, $FA, $04, $F8, $01, $F7, $FF
    db $F1, $F9, $F3, $F8, $FB, $FE, $30, $84, $70, $0C, $C0, $16, $67, $8B, $40, $3B
    db $08, $F3, $30, $CF, $48, $FF, $8C, $3C, $FE, $BF, $F7, $CF, $B7, $93, $44, $44
    db $44, $44, $41, $41, $94, $44, $44, $0A, $88, $04, $79, $41, $49, $49, $41, $94
    db $00, $2C, $FC, $62, $FE, $45, $FC, $4B, $F8, $D7, $F0, $B0, $E0, $C7, $86, $6F
    db $68, $FF, $03, $01, $03, $07, $0F, $1F, $78, $90, $60, $73, $03, $F8, $9F, $10
    db $3F, $38, $7F, $F0, $BE, $61, $7F, $E8, $FF, $FC, $EF, $C7, $0F, $1E, $17, $00
    db $DD, $E3, $33, $CF, $87, $7F, $9F, $FE, $BE, $F9, $0D, $F3, $FA, $E6, $E5, $1C
    db $FB, $02, $08, $E1, $E0, $03, $F8, $8D, $B7, $70, $77, $F0, $CF, $C0, $3F, $83
    db $80, $07, $FE, $0F, $3F, $7F, $97, $D7, $FF, $F8, $88, $88, $83, $9F, $08, $88
    db $88, $88, $7F, $75, $88, $88, $88, $83, $E8, $80, $98, $88, $00, $37, $3F, $C1
    db $7F, $83, $A7, $1E, $FC, $F3, $E1, $07, $DC, $FF, $01, $03, $27, $1E, $F3, $1F
    db $80, $E0, $F9, $E7, $E9, $97, $BD, $43, $75, $8B, $89, $77, $35, $CB, $DB, $2F
    db $FF, $E0, $90, $40, $88, $F0, $C0, $08, $35, $BB, $46, $CF, $3C, $27, $39, $E4
    db $9B, $30, $E3, $7C, $CF, $FF, $FE, $FC, $27, $FE, $F8, $30, $7F, $20, $F7, $1F
    db $CF, $7F, $BF, $A7, $5F, $73, $9F, $FB, $7F, $39, $E7, $C7, $3F, $FF, $10, $41
    db $10, $F8, $E0, $92, $7F, $88, $3C, $1F, $78, $88, $88, $89, $8F, $1F, $5F, $13
    db $C3, $88, $88, $88, $89, $48, $38, $DF, $3F, $FB, $E1, $87, $70, $3F, $74, $83
    db $C1, $36, $2D, $C0, $FC, $1F, $3F, $3C, $E0, $FE, $F9, $F6, $0D, $0F, $9C, $73
    db $2D, $DA, $DD, $3A, $37, $FD, $C0, $E0, $F8, $FC, $F7, $F0, $F8, $FD, $9C, $03
    db $F7, $38, $DC, $03, $03, $EE, $10, $DF, $ED, $BF, $79, $03, $FD, $C6, $7D, $E2
    db $9C, $FB, $16, $0D, $CE, $39, $EE, $19, $FD, $F9, $FC, $C4, $E0, $F8, $FC, $F8
    db $95, $DF, $F8, $88, $88, $09, $8F, $88, $88, $83, $98, $F8, $88, $88, $88, $8F
    db $FF, $88, $88, $93, $88, $0E, $37, $F9, $87, $FB, $FB, $6D, $7D, $9E, $C2, $C5
    db $39, $D4, $AB, $FF, $F1, $F3, $79, $9C, $C0, $C8, $01, $FE, $81, $F1, $CE, $C7
    db $B9, $9E, $63, $FC, $1B, $BF, $C7, $C7, $F8, $F0, $FF, $80, $CE, $B9, $67, $1F
    db $0F, $80, $D9, $7A, $A5, $3C, $F3, $5D, $BA, $AA, $DF, $67, $DD, $D1, $AE, $E0
    db $9F, $FF, $04, $A4, $F2, $FA, $FB, $FD, $BC, $FE, $C1, $3F, $E0, $87, $70, $48
    db $A7, $67, $9F, $5C, $BF, $F3, $E8, $E5, $FF, $01, $1F, $7F, $3F, $EF, $1F, $94
    db $F5, $F0, $98, $88, $88, $98, $88, $88, $88, $88, $A8, $88, $90, $77, $F8, $88
    db $88, $88, $80, $86, $F8, $3D, $C6, $05, $FE, $B5, $4E, $D8, $A7, $60, $F2, $27
    db $DC, $FF, $80, $40, $A0, $FB, $04, $00, $CF, $35, $37, $CA, $89, $77, $E2, $FD
    db $FC, $33, $2E, $D3, $E7, $19, $3B, $CC, $FF, $3D, $0E, $07, $E1, $30, $32, $59
    db $CC, $00, $4F, $B4, $CF, $34, $EF, $14, $6D, $96, $3E, $D7, $17, $F9, $BB, $FD
    db $DD, $FE, $FE, $04, $06, $07, $01, $7C, $87, $33, $7E, $B3, $9F, $71, $49, $24
    db $7F, $91, $BF, $CB, $BF, $87, $FE, $B3, $71, $49, $24, $91, $CB, $40, $8E, $48
    db $66, $66, $FF, $FF, $88, $88, $80, $98, $DF, $FF, $56, $DE, $08, $DB, $E7, $C9
    db $D0, $A0, $72, $A5, $22, $E9, $91, $06, $53, $1E, $73, $56, $BC, $03, $80, $26
    db $CD, $D8, $F6, $F8, $10, $E0, $40, $A8, $2E, $B0, $EF, $18, $F7, $46, $73, $8E
    db $6C, $63, $30, $7C, $DB, $FF, $E0, $76, $39, $0E, $03, $18, $00, $7A, $4B, $DA
    db $8A, $C1, $95, $C7, $97, $C5, $91, $87, $9A, $2B, $AC, $DF, $D5, $27, $40, $B4
    db $80, $75, $7E, $84, $78, $80, $7E, $82, $20, $50, $02, $7F, $C0, $57, $66, $6E
    db $C7, $DE, $91, $9A, $0F, $AE, $FD, $FC, $FE, $97, $A2, $0C, $06, $9E, $36, $10
    db $60, $0A, $E0, $0C, $C0, $08, $10, $E8, $94, $E4, $49, $44, $44, $44, $48, $41
    db $94, $44, $44, $84, $44, $14, $FF, $48, $44, $44, $FF, $FF, $20, $F8, $1E, $F3
    db $1F, $AF, $6E, $1E, $FC, $1C, $D9, $3B, $B6, $77, $5F, $DF, $FF, $E1, $E0, $E1
    db $E3, $C4, $88, $20, $61, $95, $80, $25, $2C, $38, $60, $72, $E2, $86, $8E, $0C
    db $FC, $70, $FF, $7F, $9F, $1D, $71, $03, $8F, $C2, $0F, $F2, $3F, $8F, $74, $84
    db $1A, $0A, $74, $10, $85, $CB, $4B, $E6, $F0, $70, $7D, $02, $F8, $05, $77, $85
    db $8B, $34, $1E, $84, $8C, $0C, $FC, $79, $78, $01, $90, $03, $67, $69, $68, $D7
    db $73, $03, $07, $80, $BF, $0C, $63, $AB, $67, $69, $99, $60, $84, $14, $44, $44
    db $4E, $44, $19, $44, $44, $49, $1B, $E8, $49, $44, $44, $44, $44, $A4, $17, $41
    db $4B, $14, $10, $E0, $A0, $0F, $1B, $1F, $B6, $BE, $6D, $7C, $DB, $F8, $B6, $F0
    db $FF, $5F, $F0, $E0, $41, $83, $07, $0F, $7F, $88, $80, $9C, $3E, $7E, $9F, $1F
    db $FD, $78, $7C, $FE, $8C, $80, $30, $43, $8D, $0D, $37, $DD, $DF, $3E, $7E, $3C
    db $34, $B1, $80, $7F, $FF, $F2, $C8, $20, $81, $CB, $7F, $1F, $3E, $FF, $7E, $20
    db $CF, $FE, $E0, $DF, $91, $FF, $F5, $3B, $86, $43, $84, $14, $44, $9E, $AE, $E4
    db $EE, $4A, $44, $44, $40, $E8, $80, $21, $82, $05, $FB, $02, $14, $EE, $09, $FC
    db $23, $D8, $E0, $FE, $FD, $FC, $FB, $F8, $F7, $F0, $21, $DF, $DE, $3F, $63, $70
    db $FE, $E0, $1C, $BB, $03, $B1, $09, $9C, $0C, $DE, $7C, $E1, $E0, $1F, $FC, $F6
    db $F3, $33, $D8, $10, $F8, $89, $60, $B0, $EA, $38, $6E, $FE, $86, $06, $9E, $F7
    db $F0, $6B, $EF, $E0, $E7, $E1, $81, $80, $61, $85, $1F, $A7, $AE, $07, $BF, $1C
    db $FE, $06, $5E, $0E, $5F, $0F, $44, $07, $E0, $E3, $F0, $F9, $F1, $F0, $F8, $95
    db $FF, $FF, $FF, $3C, $34, $16, $2F, $F3, $C3, $2F, $FF, $FF, $3A, $88, $88, $8F
    db $F3, $A8, $88, $88, $E7, $17, $83, $E3, $31, $8E, $98, $07, $FE, $FC, $80, $CF
    db $D9, $06, $A6, $01, $DF, $C1, $FD, $04, $03, $07, $1F, $E4, $7F, $7F, $FE, $03
    db $F0, $C0, $01, $FD, $FE, $F8, $F8, $F0, $C0, $01, $F8, $F5, $0B, $1D, $E3, $52
    db $F9, $1F, $D8, $BD, $6C, $9E, $E4, $9F, $EF, $DF, $87, $C0, $03, $81, $91, $F3
    db $C3, $3C, $3F, $F2, $F7, $FF, $3C, $08, $88, $FF, $2F, $FF, $5D, $3C, $28, $80
    db $03, $F6, $08, $9D, $01, $21, $22, $01, $F0, $D8, $24, $CC, $23, $87, $60, $C0
    db $F8, $87, $8E, $81, $71, $F2, $14, $C4, $47, $AE, $03, $70, $3F, $05, $3C, $3A
    db $C7, $BF, $01, $01, $EF, $04, $82, $01, $0F, $F1, $FD, $F0, $FF, $C1, $FE, $8E
    db $80, $F1, $3F, $50, $F0, $EF, $EB, $94, $FF, $FF, $F3, $C3, $44, $1F, $3C, $3F
    db $F3, $88, $88, $88, $8F, $2F, $F5, $73, $C0, $88, $80, $8F, $03, $76, $08, $3D
    db $01, $E1, $02, $03, $01, $E0, $78, $C3, $F8, $87, $8E, $81, $71, $F0, $DE, $3E
    db $BC, $F9, $F0, $0F, $9C, $EB, $7F, $E0, $93, $7C, $F8, $0F, $6F, $7F, $86, $1B
    db $83, $67, $F8, $6F, $1F, $0F, $FE, $86, $E0, $70, $F0, $01, $E0, $FC, $83, $DF
    db $0F, $60, $FE, $1F, $01, $7F, $1F, $80, $01, $93, $2F, $38, $88, $80, $AF, $F5
    db $3C, $3E, $89, $0A, $88, $85, $5F, $FF, $88, $88, $88, $88, $06, $B8, $C7, $4C
    db $F3, $33, $FC, $8D, $7E, $C3, $3F, $C0, $FE, $03, $FE, $7F, $3F, $0C, $03, $67
    db $80, $39, $3E, $C0, $8C, $F0, $8F, $4C, $80, $81, $FE, $BF, $C0, $A0, $F6, $FB
    db $06, $FE, $03, $C2, $3F, $F2, $0F, $7E, $83, $1D, $F2, $7F, $7E, $F9, $F8, $80
    db $F0, $F8, $EC, $40, $1F, $10, $5B, $B4, $80, $A2, $D5, $2E, $DE, $23, $FF, $7F
    db $3F, $20, $30, $7F, $7D, $3E, $3F, $94, $58, $08, $88, $88, $9F, $7F, $88, $88
    db $88, $88, $E8, $88, $0B, $8F, $F8, $88, $88, $88, $80, $80, $E4, $D8, $E7, $5F
    db $78, $0B, $3C, $42, $7D, $D1, $EE, $92, $ED, $B3, $CC, $FF, $01, $18, $0C, $17
    db $09, $08, $34, $70, $CF, $38, $E7, $9E, $0C, $E3, $1F, $9C, $07, $DC, $EB, $06
    db $FF, $C0, $60, $20, $0C, $03, $E0, $3C, $1E, $02, $D1, $EE, $DA, $E5, $6C, $73
    db $25, $3A, $31, $3E, $69, $7E, $61, $C1, $FE, $FC, $0A, $03, $01, $04, $F4, $03
    db $7D, $80, $C3, $DF, $E7, $E9, $06, $F4, $83, $EA, $D1, $F5, $C8, $1F, $87, $FC
    db $E0, $78, $3E, $9F, $DF, $CF, $96, $E7, $75, $88, $88, $88, $09, $47, $58, $88
    db $88, $88, $95, $88, $80, $66, $6F, $58, $80, $88, $66, $6F, $4F, $13, $FD, $5B
    db $FD, $9E, $DE, $7F, $33, $78, $DC, $7F, $FF, $01, $03, $09, $4C, $02, $80, $24
    db $0F, $F7, $E3, $7E, $F8, $7E, $9F, $1E, $E7, $80, $45, $BE, $9D, $E6, $FF, $07
    db $7E, $F8, $7E, $3E, $0C, $04, $87, $80, $7D, $BD, $7E, $80, $81, $F2, $C4, $EB
    db $60, $80, $16, $B9, $3D, $3F, $01, $0D, $10, $07, $98, $30, $4F, $B6, $43, $E5
    db $FA, $B8, $FD, $7F, $7D, $03, $60, $7B, $B4, $37, $47, $D0, $FD, $80, $70, $80
    db $84, $C8, $60, $98, $DF, $91, $FF, $3C, $3F, $EF, $59, $39, $89, $7A, $FF, $29
    db $83, $B8, $87, $44, $74, $44, $06, $1D, $02, $39, $06, $A2, $5C, $65, $98, $F1
    db $0C, $05, $0E, $7C, $03, $FC, $82, $83, $80, $02, $03, $FE, $07, $FC, $7E, $05
    db $FE, $FE, $FE, $FD, $FC, $F8, $18, $E0, $81, $7F, $7E, $BF, $40, $BE, $FA, $A0
    db $FD, $7E, $41, $40, $A0, $69, $9E, $06, $5B, $EC, $27, $E8, $4B, $F4, $98, $C0
    db $02, $80, $46, $04, $F9, $F8, $4E, $DB, $D8, $E8, $CB, $C0, $BE, $80, $7E, $FE
    db $FC, $8B, $F5, $3C, $32, $F4, $3C, $3F, $3C, $3F, $F3, $C3, $82, $03, $F6, $08
    db $9D, $01, $63, $62, $9F, $FC, $42, $FE, $05, $09, $FE, $C3, $F8, $87, $8F, $80
    db $70, $F0, $10, $F6, $9E, $B8, $7F, $EF, $90, $03, $0C, $F0, $F2, $03, $0D, $0E
    db $0C, $F2, $FE, $03, $F8, $31, $CC, $1C, $02, $D0, $20, $70, $0F, $4B, $86, $81
    db $76, $C8, $07, $84, $33, $81, $02, $7D, $8B, $F5, $3C, $35, $3C, $3F, $5F, $3C
    db $3E, $3C, $30, $82, $03, $F6, $08, $9D, $01, $63, $62, $9F, $FC, $42, $FE, $05
    db $09, $FE, $C2, $F8, $87, $8E, $81, $71, $F0, $1E, $FE, $0F, $82, $7F, $38, $44
    db $3F, $E2, $9F, $03, $0C, $F0, $F3, $03, $0F, $0C, $6C, $F2, $FE, $01, $01, $02
    db $FC, $B0, $8F, $9E, $81, $07, $73, $F0, $1D, $FC, $9F, $7F, $4E, $3F, $A4, $9F
    db $A0, $87, $3C, $33, $C3, $3C, $33, $C3, $00, $7B, $88, $CC, $0C, $B3, $3F, $71
    db $4E, $C2, $BC, $A1, $99, $56, $C7, $D8, $4F, $C0, $D8, $17, $BC, $23, $27, $20
    db $FA, $F8, $8D, $F5, $46, $3B, $30, $AE, $93, $72, $C3, $EC, $2B, $D9, $16, $BA
    db $24, $5D, $41, $0C, $A7, $E2, $1B, $FA, $0E, $F5, $3F, $C8, $CD, $4E, $33, $30
    db $03, $CD, $FC, $9E, $62, $35, $C7, $36, $C5, $AC, $4B, $EC, $0B, $8A, $FF, $3C
    db $35, $3C, $3F, $F3, $C3, $F3, $C3, $82, $03, $F6, $08, $1D, $01, $03, $62, $07
    db $FC, $7A, $06, $FC, $F1, $06, $C2, $F8, $87, $8E, $81, $71, $F0, $1E, $FE, $0F
    db $82, $7F, $31, $44, $3F, $E2, $9F, $03, $0C, $0E, $F0, $61, $81, $6F, $2C, $13
    db $E0, $21, $CC, $81, $40, $BE, $B0, $8F, $9E, $81, $23, $73, $E0, $8D, $78, $E3
    db $DE, $01, $8E, $31, $38, $40, $92, $59, $53, $A8, $A8, $8F, $2F, $FF, $3C, $35
    db $58, $0B, $88, $95, $53, $88, $A8, $88, $19, $87, $F8, $53, $EC, $58, $E7, $40
    db $5F, $E0, $B0, $EF, $9F, $FE, $7F, $2F, $1F, $F8, $CC, $03, $3F, $36, $C1, $1B
    db $E0, $80, $C7, $47, $81, $C1, $7C, $63, $3E, $21, $17, $18, $13, $1C, $33, $3E
    db $7B, $7F, $C9, $FC, $01, $02, $03, $22, $DC, $E0, $9F, $C3, $50, $42, $46, $FD
    db $B9, $76, $C6, $3F, $F1, $CF, $9F, $F8, $7F, $37, $06, $C1, $91, $44, $4F, $FF
    db $4D, $46, $44, $A1, $9F, $44, $49, $44, $FD, $4E, $E4, $49, $44, $00, $0F, $3D
    db $8F, $8A, $E3, $E1, $FD, $FC, $F1, $F0, $F9, $F8, $C6, $C0, $E4, $03, $7F, $7E
    db $80, $7F, $1F, $C3, $F7, $F9, $C7, $F8, $07, $1D, $4E, $38, $1F, $D6, $37, $67
    db $BF, $E0, $79, $3E, $20, $C7, $FE, $FC, $F8, $EF, $3F, $F8, $04, $01, $6B, $93
    db $03, $FB, $07, $97, $66, $E6, $24, $A4, $14, $94, $2B, $2F, $03, $F2, $07, $6F
    db $7F, $6D, $12, $55, $2A, $AF, $48, $66, $2A, $A8, $D0, $B8, $C0, $C7, $BD, $C1
    db $34, $DC, $E0, $9C, $DE, $01, $F6, $8E, $8F, $0F, $8F, $40, $C7, $87, $A0, $DF

; v2.1 opening-only routing: Podunk IDs 430-435, 450-459; initial lab
; IDs 2901-2904, 2906, 2908-2909, 2911, 2915-2916 use global $18.
; Continuations inherit that window. Carltron/Professor routes are unchanged.
; ID 2924 "Now what?" still opens global $04 (bordered Boy); later uses unchanged.
