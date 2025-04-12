def SPRITE_NONE                    equ $00
def SPRITE_RED                     equ $01
def SPRITE_BLUE                    equ $02
def SPRITE_OAK                     equ $03
def SPRITE_YOUNGSTER               equ $04
def SPRITE_MONSTER                 equ $05
def SPRITE_COOLTRAINER_F           equ $06
def SPRITE_COOLTRAINER_M           equ $07
def SPRITE_LITTLE_GIRL             equ $08
def SPRITE_BIRD                    equ $09
def SPRITE_MIDDLE_AGED_MAN         equ $0a
def SPRITE_GAMBLER                 equ $0b
def SPRITE_SUPER_NERD              equ $0c
def SPRITE_GIRL                    equ $0d
def SPRITE_HIKER                   equ $0e
def SPRITE_BEAUTY                  equ $0f
def SPRITE_GENTLEMAN               equ $10
def SPRITE_DAISY                   equ $11
def SPRITE_BIKER                   equ $12
def SPRITE_SAILOR                  equ $13
def SPRITE_COOK                    equ $14
def SPRITE_BIKE_SHOP_CLERK         equ $15
def SPRITE_MR_FUJI                 equ $16
def SPRITE_GIOVANNI                equ $17
def SPRITE_ROCKET                  equ $18
def SPRITE_CHANNELER               equ $19
def SPRITE_WAITER                  equ $1a
def SPRITE_SILPH_WORKER_F          equ $1b
def SPRITE_MIDDLE_AGED_WOMAN       equ $1c
def SPRITE_BRUNETTE_GIRL           equ $1d
def SPRITE_LANCE                   equ $1e
def SPRITE_UNUSED_SCIENTIST        equ $1f
def SPRITE_SCIENTIST               equ $20
def SPRITE_ROCKER                  equ $21
def SPRITE_SWIMMER                 equ $22
def SPRITE_SAFARI_ZONE_WORKER      equ $23
def SPRITE_GYM_GUIDE               equ $24
def SPRITE_GRAMPS                  equ $25
def SPRITE_CLERK                   equ $26
def SPRITE_FISHING_GURU            equ $27
def SPRITE_GRANNY                  equ $28
def SPRITE_NURSE                   equ $29
def SPRITE_LINK_RECEPTIONIST       equ $2a
def SPRITE_SILPH_PRESIDENT         equ $2b
def SPRITE_SILPH_WORKER_M          equ $2c
def SPRITE_WARDEN                  equ $2d
def SPRITE_CAPTAIN                 equ $2e
def SPRITE_FISHER                  equ $2f
def SPRITE_KOGA                    equ $30
def SPRITE_GUARD                   equ $31
def SPRITE_UNUSED_GUARD            equ $32
def SPRITE_MOM                     equ $33
def SPRITE_BALDING_GUY             equ $34
def SPRITE_LITTLE_BOY              equ $35
def SPRITE_UNUSED_GAMEBOY_KID      equ $36
def SPRITE_GAMEBOY_KID             equ $37
def SPRITE_FAIRY                   equ $38
def SPRITE_AGATHA                  equ $39
def SPRITE_BRUNO                   equ $3a
def SPRITE_LORELEI                 equ $3b
def SPRITE_SEEL                    equ $3c
def SPRITE_POKE_BALL               equ $3d
def SPRITE_FOSSIL                  equ $3e
def SPRITE_BOULDER                 equ $3f
def SPRITE_PAPER                   equ $40
def SPRITE_POKEDEX                 equ $41
def SPRITE_CLIPBOARD               equ $42
def SPRITE_SNORLAX                 equ $43
def SPRITE_UNUSED_OLD_AMBER        equ $44
def SPRITE_OLD_AMBER               equ $45
def SPRITE_UNUSED_GAMBLER_ASLEEP_1 equ $46
def SPRITE_UNUSED_GAMBLER_ASLEEP_2 equ $47
def SPRITE_GAMBLER_ASLEEP          equ $48

; AUDIO_1
def MUSIC_PALLET_TOWN equs "((Music_PalletTown - SFX_Headers_1) / 3)"
def MUSIC_POKECENTER equs "((Music_Pokecenter - SFX_Headers_1) / 3)"
def MUSIC_GYM equs "((Music_Gym - SFX_Headers_1) / 3)"
def MUSIC_CITIES1 equs "((Music_Cities1 - SFX_Headers_1) / 3)"
def MUSIC_CITIES2 equs "((Music_Cities2 - SFX_Headers_1) / 3)"
def MUSIC_CELADON equs "((Music_Celadon - SFX_Headers_1) / 3)"
def MUSIC_CINNABAR equs "((Music_Cinnabar - SFX_Headers_1) / 3)"
def MUSIC_VERMILION equs "((Music_Vermilion - SFX_Headers_1) / 3)"
def MUSIC_LAVENDER equs "((Music_Lavender - SFX_Headers_1) / 3)"
def MUSIC_SS_ANNE equs "((Music_SSAnne - SFX_Headers_1) / 3)"
def MUSIC_MEET_PROF_OAK equs "((Music_MeetProfOak - SFX_Headers_1) / 3)"
def MUSIC_MEET_RIVAL equs "((Music_MeetRival - SFX_Headers_1) / 3)"
def MUSIC_MUSEUM_GUY equs "((Music_MuseumGuy - SFX_Headers_1) / 3)"
def MUSIC_SAFARI_ZONE equs "((Music_SafariZone - SFX_Headers_1) / 3)"
def MUSIC_PKMN_HEALED equs "((Music_PkmnHealed - SFX_Headers_1) / 3)"
def MUSIC_ROUTES1 equs "((Music_Routes1 - SFX_Headers_1) / 3)"
def MUSIC_ROUTES2 equs "((Music_Routes2 - SFX_Headers_1) / 3)"
def MUSIC_ROUTES3 equs "((Music_Routes3 - SFX_Headers_1) / 3)"
def MUSIC_ROUTES4 equs "((Music_Routes4 - SFX_Headers_1) / 3)"
def MUSIC_INDIGO_PLATEAU equs "((Music_IndigoPlateau - SFX_Headers_1) / 3)"

; AUDIO_2
def MUSIC_GYM_LEADER_BATTLE equs "((Music_GymLeaderBattle - SFX_Headers_1) / 3)"
def MUSIC_TRAINER_BATTLE equs "((Music_TrainerBattle - SFX_Headers_1) / 3)"
def MUSIC_WILD_BATTLE equs "((Music_WildBattle - SFX_Headers_1) / 3)"
def MUSIC_FINAL_BATTLE equs "((Music_FinalBattle - SFX_Headers_1) / 3)"
def MUSIC_DEFEATED_TRAINER equs "((Music_DefeatedTrainer - SFX_Headers_1) / 3)"
def MUSIC_DEFEATED_WILD_MON equs "((Music_DefeatedWildMon - SFX_Headers_1) / 3)"
def MUSIC_DEFEATED_GYM_LEADER equs "((Music_DefeatedGymLeader - SFX_Headers_1) / 3)"

; AUDIO_3 $1f
def MUSIC_TITLE_SCREEN equs "((Music_TitleScreen - SFX_Headers_1) / 3)"
def MUSIC_CREDITS equs "((Music_Credits - SFX_Headers_1) / 3)"
def MUSIC_HALL_OF_FAME equs "((Music_HallOfFame - SFX_Headers_1) / 3)"
def MUSIC_OAKS_LAB equs "((Music_OaksLab - SFX_Headers_1) / 3)"
def MUSIC_JIGGLYPUFF_SONG equs "((Music_JigglypuffSong - SFX_Headers_1) / 3)"
def MUSIC_BIKE_RIDING equs "((Music_BikeRiding - SFX_Headers_1) / 3)"
def MUSIC_SURFING equs "((Music_Surfing - SFX_Headers_1) / 3)"
def MUSIC_GAME_CORNER equs "((Music_GameCorner - SFX_Headers_1) / 3)"
def MUSIC_INTRO_BATTLE equs "((Music_IntroBattle - SFX_Headers_1) / 3)"
def MUSIC_DUNGEON1 equs "((Music_Dungeon1 - SFX_Headers_1) / 3)"
def MUSIC_DUNGEON2 equs "((Music_Dungeon2 - SFX_Headers_1) / 3)"
def MUSIC_DUNGEON3 equs "((Music_Dungeon3 - SFX_Headers_1) / 3)"
def MUSIC_CINNABAR_MANSION equs "((Music_CinnabarMansion - SFX_Headers_1) / 3)"
def MUSIC_POKEMON_TOWER equs "((Music_PokemonTower - SFX_Headers_1) / 3)"
def MUSIC_SILPH_CO equs "((Music_SilphCo - SFX_Headers_1) / 3)"
def MUSIC_MEET_EVIL_TRAINER equs "((Music_MeetEvilTrainer - SFX_Headers_1) / 3)"
def MUSIC_MEET_FEMALE_TRAINER equs "((Music_MeetFemaleTrainer - SFX_Headers_1) / 3)"
def MUSIC_MEET_MALE_TRAINER equs "((Music_MeetMaleTrainer - SFX_Headers_1) / 3)"

; AUDIO_1 AUDIO_2 AUDIO_3
def SFX_SNARE_1 equs "((SFX_Snare1_1 - SFX_Headers_1) / 3)"
def SFX_SNARE_2 equs "((SFX_Snare2_1 - SFX_Headers_1) / 3)"
def SFX_SNARE_3 equs "((SFX_Snare3_1 - SFX_Headers_1) / 3)"
def SFX_SNARE_4 equs "((SFX_Snare4_1 - SFX_Headers_1) / 3)"
def SFX_SNARE_5 equs "((SFX_Snare5_1 - SFX_Headers_1) / 3)"
def SFX_TRIANGLE_1 equs "((SFX_Triangle1_1 - SFX_Headers_1) / 3)"
def SFX_TRIANGLE_2 equs "((SFX_Triangle2_1 - SFX_Headers_1) / 3)"
def SFX_SNARE_6 equs "((SFX_Snare6_1 - SFX_Headers_1) / 3)"
def SFX_SNARE_7 equs "((SFX_Snare7_1 - SFX_Headers_1) / 3)"
def SFX_SNARE_8 equs "((SFX_Snare8_1 - SFX_Headers_1) / 3)"
def SFX_SNARE_9 equs "((SFX_Snare9_1 - SFX_Headers_1) / 3)"
def SFX_CYMBAL_1 equs "((SFX_Cymbal1_1 - SFX_Headers_1) / 3)"
def SFX_CYMBAL_2 equs "((SFX_Cymbal2_1 - SFX_Headers_1) / 3)"
def SFX_CYMBAL_3 equs "((SFX_Cymbal3_1 - SFX_Headers_1) / 3)"
def SFX_MUTED_SNARE_1 equs "((SFX_Muted_Snare1_1 - SFX_Headers_1) / 3)"
def SFX_TRIANGLE_3 equs "((SFX_Triangle3_1 - SFX_Headers_1) / 3)"
def SFX_MUTED_SNARE_2 equs "((SFX_Muted_Snare2_1 - SFX_Headers_1) / 3)"
def SFX_MUTED_SNARE_3 equs "((SFX_Muted_Snare3_1 - SFX_Headers_1) / 3)"
def SFX_MUTED_SNARE_4 equs "((SFX_Muted_Snare4_1 - SFX_Headers_1) / 3)"
def SFX_CRY_00 equs "((SFX_Cry00_1 - SFX_Headers_1) / 3)"
def SFX_CRY_01 equs "((SFX_Cry01_1 - SFX_Headers_1) / 3)"
def SFX_CRY_02 equs "((SFX_Cry02_1 - SFX_Headers_1) / 3)"
def SFX_CRY_03 equs "((SFX_Cry03_1 - SFX_Headers_1) / 3)"
def SFX_CRY_04 equs "((SFX_Cry04_1 - SFX_Headers_1) / 3)"
def SFX_CRY_05 equs "((SFX_Cry05_1 - SFX_Headers_1) / 3)"
def SFX_CRY_06 equs "((SFX_Cry06_1 - SFX_Headers_1) / 3)"
def SFX_CRY_07 equs "((SFX_Cry07_1 - SFX_Headers_1) / 3)"
def SFX_CRY_08 equs "((SFX_Cry08_1 - SFX_Headers_1) / 3)"
def SFX_CRY_09 equs "((SFX_Cry09_1 - SFX_Headers_1) / 3)"
def SFX_CRY_0A equs "((SFX_Cry0A_1 - SFX_Headers_1) / 3)"
def SFX_CRY_0B equs "((SFX_Cry0B_1 - SFX_Headers_1) / 3)"
def SFX_CRY_0C equs "((SFX_Cry0C_1 - SFX_Headers_1) / 3)"
def SFX_CRY_0D equs "((SFX_Cry0D_1 - SFX_Headers_1) / 3)"
def SFX_CRY_0E equs "((SFX_Cry0E_1 - SFX_Headers_1) / 3)"
def SFX_CRY_0F equs "((SFX_Cry0F_1 - SFX_Headers_1) / 3)"
def SFX_CRY_10 equs "((SFX_Cry10_1 - SFX_Headers_1) / 3)"
def SFX_CRY_11 equs "((SFX_Cry11_1 - SFX_Headers_1) / 3)"
def SFX_CRY_12 equs "((SFX_Cry12_1 - SFX_Headers_1) / 3)"
def SFX_CRY_13 equs "((SFX_Cry13_1 - SFX_Headers_1) / 3)"
def SFX_CRY_14 equs "((SFX_Cry14_1 - SFX_Headers_1) / 3)"
def SFX_CRY_15 equs "((SFX_Cry15_1 - SFX_Headers_1) / 3)"
def SFX_CRY_16 equs "((SFX_Cry16_1 - SFX_Headers_1) / 3)"
def SFX_CRY_17 equs "((SFX_Cry17_1 - SFX_Headers_1) / 3)"
def SFX_CRY_18 equs "((SFX_Cry18_1 - SFX_Headers_1) / 3)"
def SFX_CRY_19 equs "((SFX_Cry19_1 - SFX_Headers_1) / 3)"
def SFX_CRY_1A equs "((SFX_Cry1A_1 - SFX_Headers_1) / 3)"
def SFX_CRY_1B equs "((SFX_Cry1B_1 - SFX_Headers_1) / 3)"
def SFX_CRY_1C equs "((SFX_Cry1C_1 - SFX_Headers_1) / 3)"
def SFX_CRY_1D equs "((SFX_Cry1D_1 - SFX_Headers_1) / 3)"
def SFX_CRY_1E equs "((SFX_Cry1E_1 - SFX_Headers_1) / 3)"
def SFX_CRY_1F equs "((SFX_Cry1F_1 - SFX_Headers_1) / 3)"
def SFX_CRY_20 equs "((SFX_Cry20_1 - SFX_Headers_1) / 3)"
def SFX_CRY_21 equs "((SFX_Cry21_1 - SFX_Headers_1) / 3)"
def SFX_CRY_22 equs "((SFX_Cry22_1 - SFX_Headers_1) / 3)"
def SFX_CRY_23 equs "((SFX_Cry23_1 - SFX_Headers_1) / 3)"
def SFX_CRY_24 equs "((SFX_Cry24_1 - SFX_Headers_1) / 3)"
def SFX_CRY_25 equs "((SFX_Cry25_1 - SFX_Headers_1) / 3)"

def SFX_LEVEL_UP equs "((SFX_Level_Up - SFX_Headers_1) / 3)"
def SFX_BALL_TOSS equs "((SFX_Ball_Toss - SFX_Headers_1) / 3)"
def SFX_BALL_POOF equs "((SFX_Ball_Poof - SFX_Headers_1) / 3)"
def SFX_FAINT_THUD equs "((SFX_Faint_Thud - SFX_Headers_1) / 3)"
def SFX_RUN equs "((SFX_Run - SFX_Headers_1) / 3)"
def SFX_DEX_PAGE_ADDED equs "((SFX_Dex_Page_Added - SFX_Headers_1) / 3)"
def SFX_CAUGHT_MON equs "((SFX_Caught_Mon - SFX_Headers_1) / 3)"
def SFX_PECK equs "((SFX_Peck - SFX_Headers_1) / 3)"
def SFX_FAINT_FALL equs "((SFX_Faint_Fall - SFX_Headers_1) / 3)"
def SFX_BATTLE_09 equs "((SFX_Battle_09 - SFX_Headers_1) / 3)"
def SFX_POUND equs "((SFX_Pound - SFX_Headers_1) / 3)"
def SFX_BATTLE_0B equs "((SFX_Battle_0B - SFX_Headers_1) / 3)"
def SFX_BATTLE_0C equs "((SFX_Battle_0C - SFX_Headers_1) / 3)"
def SFX_BATTLE_0D equs "((SFX_Battle_0D - SFX_Headers_1) / 3)"
def SFX_BATTLE_0E equs "((SFX_Battle_0E - SFX_Headers_1) / 3)"
def SFX_BATTLE_0F equs "((SFX_Battle_0F - SFX_Headers_1) / 3)"
def SFX_DAMAGE equs "((SFX_Damage - SFX_Headers_1) / 3)"
def SFX_NOT_VERY_EFFECTIVE equs "((SFX_Not_Very_Effective - SFX_Headers_1) / 3)"
def SFX_BATTLE_12 equs "((SFX_Battle_12 - SFX_Headers_1) / 3)"
def SFX_BATTLE_13 equs "((SFX_Battle_13 - SFX_Headers_1) / 3)"
def SFX_BATTLE_14 equs "((SFX_Battle_14 - SFX_Headers_1) / 3)"
def SFX_VINE_WHIP equs "((SFX_Vine_Whip - SFX_Headers_1) / 3)"
def SFX_BATTLE_16 equs "((SFX_Battle_16 ; unused? - SFX_Headers_1) / 3)"
def SFX_BATTLE_17 equs "((SFX_Battle_17 - SFX_Headers_1) / 3)"
def SFX_BATTLE_18 equs "((SFX_Battle_18 - SFX_Headers_1) / 3)"
def SFX_BATTLE_19 equs "((SFX_Battle_19 - SFX_Headers_1) / 3)"
def SFX_SUPER_EFFECTIVE equs "((SFX_Super_Effective - SFX_Headers_1) / 3)"
def SFX_BATTLE_1B equs "((SFX_Battle_1B - SFX_Headers_1) / 3)"
def SFX_BATTLE_1C equs "((SFX_Battle_1C - SFX_Headers_1) / 3)"
def SFX_DOUBLESLAP equs "((SFX_Doubleslap - SFX_Headers_1) / 3)"
def SFX_BATTLE_1E equs "((SFX_Battle_1E - SFX_Headers_1) / 3)"
def SFX_HORN_DRILL equs "((SFX_Horn_Drill - SFX_Headers_1) / 3)"
def SFX_BATTLE_20 equs "((SFX_Battle_20 - SFX_Headers_1) / 3)"
def SFX_BATTLE_21 equs "((SFX_Battle_21 - SFX_Headers_1) / 3)"
def SFX_BATTLE_22 equs "((SFX_Battle_22 - SFX_Headers_1) / 3)"
def SFX_BATTLE_23 equs "((SFX_Battle_23 - SFX_Headers_1) / 3)"
def SFX_BATTLE_24 equs "((SFX_Battle_24 - SFX_Headers_1) / 3)"
def SFX_BATTLE_25 equs "((SFX_Battle_25 - SFX_Headers_1) / 3)"
def SFX_BATTLE_26 equs "((SFX_Battle_26 - SFX_Headers_1) / 3)"
def SFX_BATTLE_27 equs "((SFX_Battle_27 - SFX_Headers_1) / 3)"
def SFX_BATTLE_28 equs "((SFX_Battle_28 - SFX_Headers_1) / 3)"
def SFX_BATTLE_29 equs "((SFX_Battle_29 - SFX_Headers_1) / 3)"
def SFX_BATTLE_2A equs "((SFX_Battle_2A - SFX_Headers_1) / 3)"
def SFX_BATTLE_2B equs "((SFX_Battle_2B - SFX_Headers_1) / 3)"
def SFX_BATTLE_2C equs "((SFX_Battle_2C - SFX_Headers_1) / 3)"
def SFX_PSYBEAM equs "((SFX_Psybeam - SFX_Headers_1) / 3)"
def SFX_BATTLE_2E equs "((SFX_Battle_2E - SFX_Headers_1) / 3)"
def SFX_BATTLE_2F equs "((SFX_Battle_2F - SFX_Headers_1) / 3)"
def SFX_PSYCHIC_M equs "((SFX_Psychic_M - SFX_Headers_1) / 3)"
def SFX_BATTLE_31 equs "((SFX_Battle_31 - SFX_Headers_1) / 3)"
def SFX_BATTLE_32 equs "((SFX_Battle_32 - SFX_Headers_1) / 3)"
def SFX_BATTLE_33 equs "((SFX_Battle_33 - SFX_Headers_1) / 3)"
def SFX_BATTLE_34 equs "((SFX_Battle_34 - SFX_Headers_1) / 3)"
def SFX_BATTLE_35 equs "((SFX_Battle_35 - SFX_Headers_1) / 3)"
def SFX_BATTLE_36 equs "((SFX_Battle_36 - SFX_Headers_1) / 3)"
def SFX_SILPH_SCOPE equs "((SFX_Silph_Scope - SFX_Headers_1) / 3)"

def SFX_GET_ITEM_2 equs "((SFX_Get_Item2_1 - SFX_Headers_1) / 3)"
def SFX_TINK equs "((SFX_Tink_1 - SFX_Headers_1) / 3)"
def SFX_HEAL_HP equs "((SFX_Heal_HP_1 - SFX_Headers_1) / 3)"
def SFX_HEAL_AILMENT equs "((SFX_Heal_Ailment_1 - SFX_Headers_1) / 3)"
def SFX_START_MENU equs "((SFX_Start_Menu_1 - SFX_Headers_1) / 3)"
def SFX_PRESS_AB equs "((SFX_Press_AB_1 - SFX_Headers_1) / 3)"

; AUDIO_1 AUDIO_3
def SFX_GET_ITEM_1 equs "((SFX_Get_Item1_1 - SFX_Headers_1) / 3)"

def SFX_POKEDEX_RATING equs "((SFX_Pokedex_Rating_1 - SFX_Headers_1) / 3)"
def SFX_GET_KEY_ITEM equs "((SFX_Get_Key_Item_1 - SFX_Headers_1) / 3)"
def SFX_POISONED equs "((SFX_Poisoned_1 - SFX_Headers_1) / 3)"
def SFX_TRADE_MACHINE equs "((SFX_Trade_Machine_1 - SFX_Headers_1) / 3)"
def SFX_TURN_ON_PC equs "((SFX_Turn_On_PC_1 - SFX_Headers_1) / 3)"
def SFX_TURN_OFF_PC equs "((SFX_Turn_Off_PC_1 - SFX_Headers_1) / 3)"
def SFX_ENTER_PC equs "((SFX_Enter_PC_1 - SFX_Headers_1) / 3)"
def SFX_SHRINK equs "((SFX_Shrink_1 - SFX_Headers_1) / 3)"
def SFX_SWITCH equs "((SFX_Switch_1 - SFX_Headers_1) / 3)"
def SFX_HEALING_MACHINE equs "((SFX_Healing_Machine_1 - SFX_Headers_1) / 3)"
def SFX_TELEPORT_EXIT_1 equs "((SFX_Teleport_Exit1_1 - SFX_Headers_1) / 3)"
def SFX_TELEPORT_ENTER_1 equs "((SFX_Teleport_Enter1_1 - SFX_Headers_1) / 3)"
def SFX_TELEPORT_EXIT_2 equs "((SFX_Teleport_Exit2_1 - SFX_Headers_1) / 3)"
def SFX_LEDGE equs "((SFX_Ledge_1 - SFX_Headers_1) / 3)"
def SFX_TELEPORT_ENTER_2 equs "((SFX_Teleport_Enter2_1 - SFX_Headers_1) / 3)"
def SFX_FLY equs "((SFX_Fly_1 - SFX_Headers_1) / 3)"
def SFX_DENIED equs "((SFX_Denied_1 - SFX_Headers_1) / 3)"
def SFX_ARROW_TILES equs "((SFX_Arrow_Tiles_1 - SFX_Headers_1) / 3)"
def SFX_PUSH_BOULDER equs "((SFX_Push_Boulder_1 - SFX_Headers_1) / 3)"
def SFX_SS_ANNE_HORN equs "((SFX_SS_Anne_Horn_1 - SFX_Headers_1) / 3)"
def SFX_WITHDRAW_DEPOSIT equs "((SFX_Withdraw_Deposit_1 - SFX_Headers_1) / 3)"
def SFX_CUT equs "((SFX_Cut_1 - SFX_Headers_1) / 3)"
def SFX_GO_INSIDE equs "((SFX_Go_Inside_1 - SFX_Headers_1) / 3)"
def SFX_SWAP equs "((SFX_Swap_1 - SFX_Headers_1) / 3)"
def SFX_PURCHASE equs "((SFX_Purchase_1 - SFX_Headers_1) / 3)"
def SFX_COLLISION equs "((SFX_Collision_1 - SFX_Headers_1) / 3)"
def SFX_GO_OUTSIDE equs "((SFX_Go_Outside_1 - SFX_Headers_1) / 3)"
def SFX_SAVE equs "((SFX_Save_1 - SFX_Headers_1) / 3)"

; AUDIO_1
def SFX_POKEFLUE equs "((SFX_Pokeflute - SFX_Headers_1) / 3)"
def SFX_SAFARI_ZONE_PA equs "((SFX_Safari_Zone_PA - SFX_Headers_1) / 3)"

; AUDIO_3
def SFX_INTRO_LUNGE equs "((SFX_Intro_Lunge - SFX_Headers_1) / 3)"
def SFX_INTRO_HIP equs "((SFX_Intro_Hip - SFX_Headers_1) / 3)"
def SFX_INTRO_HOP equs "((SFX_Intro_Hop - SFX_Headers_1) / 3)"
def SFX_INTRO_RAISE equs "((SFX_Intro_Raise - SFX_Headers_1) / 3)"
def SFX_INTRO_CRASH equs "((SFX_Intro_Crash - SFX_Headers_1) / 3)"
def SFX_INTRO_WHOOSH equs "((SFX_Intro_Whoosh - SFX_Headers_1) / 3)"
def SFX_SLOTS_STOP_WHEEL equs "((SFX_Slots_Stop_Wheel - SFX_Headers_1) / 3)"
def SFX_SLOTS_REWARD equs "((SFX_Slots_Reward - SFX_Headers_1) / 3)"
def SFX_SLOTS_NEW_SPIN equs "((SFX_Slots_New_Spin - SFX_Headers_1) / 3)"
def SFX_SHOOTING_STAR equs "((SFX_Shooting_Star - SFX_Headers_1) / 3)"