; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Equates section - Names for variables.

; ---------------------------------------------------------------------------
; size variables - you'll get an informational error if you need to change these...
; they are all in units of bytes
Size_of_Snd_driver_guess =	$7FC	; approximate post-compressed size of the Z80 sound driver
Debug_Lagometer =	0		; set to 1 to enable on-screen lagometer. Seems to have an odd habit of breaking Special Stages....

; ---------------------------------------------------------------------------
; Object Status Table offsets (for everything between Object_RAM and Primary_Collision)
; ---------------------------------------------------------------------------
; NAT: By the way, some of these are grossly out of order. I know, I know,
; Bad Natsumi, etc.
; But I did this to help make more sense for the changes I am about to do,
; to make it faster. Sonic 2 is slow as molasses.
; you may also note, objoff_xx will not match with the actual addresses

	phase 0
id			ds.l 1		; object ID (if you change this, change insn1op and insn2op in s2.macrosetup.asm, if you still use them)
			ds.b 1		; object's height / 2, often used for determining when object is offscreen (no need to draw sprites)
render_flags		ds.b 1		; bitfield ; bit 7 = onscreen flag, bit 0 = x mirror, bit 1 = y mirror, bit 2 = coordinate system, bit 6 = render subobjects
art_tile		ds.w 1		; start of sprite's art
mappings		ds.l 1		; address of object mappings data
x_pixel =		*		; x coordinate for objects using screen-space coordinate system
x_pos			ds.l 1		; object x-position
x_sub =			*-2		; object sub-pixel x-position
y_pixel =		*-2		; y coordinate for objects using screen-space coordinate system
boss_subtype =		*-2		;
objoff_A =		*-2

y_pos			ds.l 1		; object y-position
y_sub =			*-2		; object sub-pixel y-position
objoff_10 =		*
x_vel			ds.w 1		; horizontal velocity
y_vel			ds.w 1		; vertical velocity
objoff_14 =		*		; objects can use this space for anything
boss_invulnerable_time = *		; BYTE	; the amount of time boss is invulnerable for
inertia			ds.w 1		; Sonic&Tails - directionless representation of speed... not updated in the air

y_radius		ds.b 1		; object's height / 2, often used for floor/wall collision
x_radius		ds.b 1		; object's width / 2, often used for floor/wall collision
flip_turned =		*		; 0 for normal, 1 to invert flipping (it's a 180 degree rotation about the axis of Sonic's spine, so he stays in the same position but looks turned around)
objoff_40 =		*
objoff_41 =		*
			ds.w 1		; this space is not used (aside from a couple of objects, due to lack of object RAM)
boss_sine_count =	*		;
mapping_frame		ds.b 1		; the frame the object is currently intending to display
anim_frame		ds.b 1		; offset into animation script. Yes, it has nothing to do with frames as such.
anim			ds.b 1		; animation ID
next_anim		ds.b 1		; animation to be played next. If same as anim, animation will not reset
anim_frame_duration	ds.b 1		; how long until next frame of animation must be played
width_pixels		ds.b 1		; object's width / 2, often used for determining when object is offscreen (no need to draw sprites)

invulnerable_time =	*		; Sonic&Tails - time remaining until player stops blinking
collision_flags		ds.b 1		; various flags related to enemy collision
collision_property	ds.b 1		; various object collision properties, usually boss hit count
move_lock =		*		; Sonic&Tails - horizontal control lock, counts down to 0
respawn_index		ds.w 1		; address where the object's respawn data is stored. Unique for every object in level
status			ds.b 1		; note: exact meaning depends on the object... for sonic/tails: bit 0: leftfacing. bit 1: inair. bit 2: spinning. bit 3: onobject. bit 4: rolljumping. bit 5: pushing. bit 6: underwater.
objoff_28 =		*		; overlaps subtype, but a few objects use it for other things anyway
air_left =		*		; the amount of air left for the player.
subtype			ds.b 1		; object subtype property
boss_routine =		*		;
angle			ds.w 1		; angle about the z axis. There is 256 degrees, as opposed to 360
routine			ds.b 1		; objects routine counter
routine_secondary	ds.b 1		; secondary object routine counter
flip_angle =		*-1		; angle about the x axis (360 degrees = 256) (twist/tumble)
objoff_29 =		*-1

objoff_2A =		*
obj_control		ds.b 1		; 0 for normal, 1 for hanging or for resting on a flipper, $81 for going through CNZ/OOZ/MTZ tubes or stopped in CNZ cages or stoppers or flying if Tails
objoff_2B =		*
status_secondary	ds.b 1		;
objoff_2C =		*
boss_defeated =		*
flips_remaining		ds.b 1		; number of flip revolutions remaining
objoff_2D =		*
flip_speed		ds.b 1		; number of flip revolutions per frame / 256
objoff_2E =		*
objoff_2F =		*+1
invincibility_time	ds.w 1		; number of frames until invincibility ends
objoff_30 =		*
objoff_31 =		*+1
speedshoes_time		ds.w 1		; number of frames until speed shoes end
objoff_32 =		*
objoff_33 =		*+1
boss_hitcount2 =	*
interact		ds.w 1		; Full RAM address of the last object Sonic stood on
objoff_34 =		*
top_solid_bit		ds.b 1		; the bit to check for top solidity (either $C or $E)
objoff_35 =		*
lrb_solid_bit		ds.b 1		; the bit to check for left/right/bottom solidity (either $D or $F)
objoff_36 =		*
next_tilt		ds.b 1		; angle on ground in front of sprite
objoff_37 =		*
tilt			ds.b 1		; angle on ground

objoff_38 =		*
boss_hurt_sonic =	*		; flag set by collision response routine when sonic has just been hurt (by boss?)
stick_to_convex		ds.b 1		; 0 for normal, 1 to make Sonic stick to convex surfaces like the rotating discs in Sonic 1 and 3 (unused in Sonic 2 but fully functional)
objoff_39 =		*
pinball_mode =		*
spindash_flag		ds.b 1		; 0 for normal, 1 for charging a spindash or forced rolling
restart_countdown =	*
objoff_3A =		*
objoff_3B =		*+1
spindash_counter	ds.w 1
objoff_3C =		*
objoff_3D =		*+1
jumping			ds.w 1		; set when Sonic is jumping... This should REALLY be a byte...
objoff_3E =		*
objoff_3F =		*+1
parent			ds.w 1		; address of object that owns or spawned this one, if applicable

priority 		ds.w 1		; address for object's target priority layer. CAN NOT BE INVALID ADDRESS, IF SPRITE IS DISPLAYED!
object_size =		*		; the size of an object
next_object =		*
; ---------------------------------------------------------------------------
; Special Stage object properties:
ss_dplc_timer =		objoff_28
ss_x_pos =		objoff_2A
ss_x_sub =		objoff_2C
ss_y_pos =		objoff_2E
ss_y_sub =		objoff_30
ss_init_flip_timer =	objoff_32
ss_flip_timer =		objoff_33
ss_z_pos =		objoff_34
ss_hurt_timer =		objoff_36
ss_slide_timer =	objoff_37
ss_parent =		objoff_38
ss_rings_base =		objoff_3C	; word
ss_rings_hundreds =	objoff_3C
ss_rings_tens =		objoff_3D
ss_rings_units =	objoff_3E
ss_last_angle_index =	objoff_3F
; ---------------------------------------------------------------------------
; when childsprites are activated (i.e. bit #6 of render_flags set)
mainspr_mapframe	= x_pos+3
mainspr_width		= y_pos+2
mainspr_childsprites 	= y_pos+3	; amount of child sprites

	phase x_vel
sub2_x_pos		ds.w 1		; x_vel
sub2_y_pos		ds.w 1		; y_vel
mainspr_height		ds.b 1
sub2_mapframe		ds.b 1

sub3_x_pos		ds.w 1		; y_radius
sub3_y_pos		ds.w 1		; priority
			ds.b 1		; unused
sub3_mapframe		ds.b 1		; anim_frame

sub4_x_pos		ds.w 1		; anim
sub4_y_pos		ds.w 1		; anim_frame_duration
			ds.b 1		; DO NOT USE, BRIDGES WILL HURT YOU
sub4_mapframe		ds.b 1		; collision_property

sub5_x_pos		ds.w 1		; status
sub5_y_pos		ds.w 1		; routine
			ds.b 1		; unused
sub5_mapframe		ds.b 1

sub6_x_pos		ds.w 1		; subtype
sub6_y_pos		ds.w 1
			ds.b 1		; unused
sub6_mapframe		ds.b 1

sub7_x_pos		ds.w 1
sub7_y_pos		ds.w 1
			ds.b 1		; unused
sub7_mapframe		ds.b 1

sub8_x_pos		ds.w 1
sub8_y_pos		ds.w 1
			ds.b 1		; unused
sub8_mapframe		ds.b 1

sub9_x_pos		ds.w 1
sub9_y_pos		ds.w 1
			ds.b 1		; unused
sub9_mapframe		ds.b 1
next_subspr		= 6
; ---------------------------------------------------------------------------
; property of all objects:

; ---------------------------------------------------------------------------
; Bits 3-6 of an object's status after a SolidObject call is a
; bitfield with the following meaning:
p1_standing_bit   = 3
p2_standing_bit   = p1_standing_bit + 1

p1_standing       = 1<<p1_standing_bit
p2_standing       = 1<<p2_standing_bit

pushing_bit_delta = 2
p1_pushing_bit    = p1_standing_bit + pushing_bit_delta
p2_pushing_bit    = p1_pushing_bit + 1

p1_pushing        = 1<<p1_pushing_bit
p2_pushing        = 1<<p2_pushing_bit


standing_mask     = p1_standing|p2_standing
pushing_mask      = p1_pushing|p2_pushing

; ---------------------------------------------------------------------------
; The high word of d6 after a SolidObject call is a bitfield
; with the following meaning:
p1_touch_side_bit   = 0
p2_touch_side_bit   = p1_touch_side_bit + 1

p1_touch_side       = 1<<p1_touch_side_bit
p2_touch_side       = 1<<p2_touch_side_bit

touch_side_mask     = p1_touch_side|p2_touch_side

p1_touch_bottom_bit = p1_touch_side_bit + pushing_bit_delta
p2_touch_bottom_bit = p1_touch_bottom_bit + 1

p1_touch_bottom     = 1<<p1_touch_bottom_bit
p2_touch_bottom     = 1<<p2_touch_bottom_bit

touch_bottom_mask   = p1_touch_bottom|p2_touch_bottom

p1_touch_top_bit   = p1_touch_bottom_bit + pushing_bit_delta
p2_touch_top_bit   = p1_touch_top_bit + 1

p1_touch_top       = 1<<p1_touch_top_bit
p2_touch_top       = 1<<p2_touch_top_bit

touch_top_mask     = p1_touch_top|p2_touch_top

; ---------------------------------------------------------------------------
; Controller Buttons
;
; Buttons bit numbers
button_up:			EQU	0
button_down:			EQU	1
button_left:			EQU	2
button_right:			EQU	3
button_B:			EQU	4
button_C:			EQU	5
button_A:			EQU	6
button_start:			EQU	7
; Buttons masks (1 << x == pow(2, x))
button_up_mask:			EQU	1<<button_up	; $01
button_down_mask:		EQU	1<<button_down	; $02
button_left_mask:		EQU	1<<button_left	; $04
button_right_mask:		EQU	1<<button_right	; $08
button_B_mask:			EQU	1<<button_B	; $10
button_C_mask:			EQU	1<<button_C	; $20
button_A_mask:			EQU	1<<button_A	; $40
button_start_mask:		EQU	1<<button_start	; $80

; ---------------------------------------------------------------------------
; Casino night bumpers
bumper_id           = 0
bumper_x            = 2
bumper_y            = 4
next_bumper         = 6
prev_bumper_x       = bumper_x-next_bumper

; ---------------------------------------------------------------------------
; status_secondary bitfield variables
;
; status_secondary variable bit numbers
status_sec_hasShield:		EQU	0
status_sec_isInvincible:	EQU	1
status_sec_hasSpeedShoes:	EQU	2
status_sec_isSliding:		EQU	7
; status_secondary variable masks (1 << x == pow(2, x))
status_sec_hasShield_mask:	EQU	1<<status_sec_hasShield		; $01
status_sec_isInvincible_mask:	EQU	1<<status_sec_isInvincible	; $02
status_sec_hasSpeedShoes_mask:	EQU	1<<status_sec_hasSpeedShoes	; $04
status_sec_isSliding_mask:	EQU	1<<status_sec_isSliding		; $80

; ---------------------------------------------------------------------------
; Constants that can be used instead of hard-coded IDs for various things.
; The "id" function allows to remove elements from an array/table without having
; to change the IDs everywhere in the code.

cur_zone_id := 0 ; the zone ID currently being declared
cur_zone_str := "0" ; string representation of the above

; macro to declare a zone ID
; this macro also declares constants of the form zone_id_X, where X is the ID of the zone in stock Sonic 2
; in order to allow level offset tables to be made dynamic
zoneID macro zoneID,{INTLABEL}
__LABEL__ = zoneID
zone_id_{cur_zone_str} = zoneID
cur_zone_id := cur_zone_id+1
cur_zone_str := "\{cur_zone_id}"
    endm

; Zone IDs. These MUST be declared in the order in which their IDs are in stock Sonic 2, otherwise zone offset tables will screw up
emerald_hill_zone zoneID	$00
zone_1 zoneID			$01
wood_zone zoneID		$02
zone_3 zoneID			$03
metropolis_zone zoneID		$04
metropolis_zone_2 zoneID	$05
wing_fortress_zone zoneID	$06
hill_top_zone zoneID		$07
hidden_palace_zone zoneID	$08
zone_9 zoneID			$09
oil_ocean_zone zoneID		$0A
mystic_cave_zone zoneID		$0B
casino_night_zone zoneID	$0C
chemical_plant_zone zoneID	$0D
death_egg_zone zoneID		$0E
aquatic_ruin_zone zoneID	$0F
sky_chase_zone zoneID		$10

; NOTE: If you want to shift IDs around, set useFullWaterTables to 1 in the assembly options

; set the number of zones
no_of_zones = cur_zone_id

; Zone and act IDs
emerald_hill_zone_act_1 =	(emerald_hill_zone<<8)|$00
emerald_hill_zone_act_2 =	(emerald_hill_zone<<8)|$01
chemical_plant_zone_act_1 =	(chemical_plant_zone<<8)|$00
chemical_plant_zone_act_2 =	(chemical_plant_zone<<8)|$01
aquatic_ruin_zone_act_1 =	(aquatic_ruin_zone<<8)|$00
aquatic_ruin_zone_act_2 =	(aquatic_ruin_zone<<8)|$01
casino_night_zone_act_1 =	(casino_night_zone<<8)|$00
casino_night_zone_act_2 =	(casino_night_zone<<8)|$01
hill_top_zone_act_1 =		(hill_top_zone<<8)|$00
hill_top_zone_act_2 =		(hill_top_zone<<8)|$01
mystic_cave_zone_act_1 =	(mystic_cave_zone<<8)|$00
mystic_cave_zone_act_2 =	(mystic_cave_zone<<8)|$01
oil_ocean_zone_act_1 =		(oil_ocean_zone<<8)|$00
oil_ocean_zone_act_2 =		(oil_ocean_zone<<8)|$01
metropolis_zone_act_1 =		(metropolis_zone<<8)|$00
metropolis_zone_act_2 =		(metropolis_zone<<8)|$01
metropolis_zone_act_3 =		(metropolis_zone_2<<8)|$00
sky_chase_zone_act_1 =		(sky_chase_zone<<8)|$00
wing_fortress_zone_act_1 =	(wing_fortress_zone<<8)|$00
death_egg_zone_act_1 =		(death_egg_zone<<8)|$00
; Prototype zone and act IDs
wood_zone_act_1 =		(wood_zone<<8)|$00
wood_zone_act_2 =		(wood_zone<<8)|$01
hidden_palace_zone_act_1 =	(hidden_palace_zone<<8)|$00
hidden_palace_zone_act_2 =	(hidden_palace_zone<<8)|$01

; ---------------------------------------------------------------------------
; some variables and functions to help define those constants (redefined before a new set of IDs)
offset :=	0		; this is the start of the pointer table
ptrsize :=	1		; this is the size of a pointer (should be 1 if the ID is a multiple of the actual size)
idstart :=	0		; value to add to all IDs

; function using these variables
id function ptr,((ptr-offset)/ptrsize+idstart)

; V-Int routines
offset :=	Vint_SwitchTbl
ptrsize :=	1
idstart :=	0

VintID_Lag =		id(Vint_Lag_ptr) ; 0
VintID_SEGA =		id(Vint_SEGA_ptr) ; 2
VintID_Title =		id(Vint_Title_ptr) ; 4
VintID_Unused6 =	id(Vint_Unused6_ptr) ; 6
VintID_Level =		id(Vint_Level_ptr) ; 8
VintID_S2SS =		id(Vint_S2SS_ptr) ; A
VintID_TitleCard =	id(Vint_TitleCard_ptr) ; C
VintID_UnusedE =	id(Vint_UnusedE_ptr) ; E
VintID_Pause =		id(Vint_Pause_ptr) ; 10
VintID_Fade =		id(Vint_Fade_ptr) ; 12
VintID_PCM =		id(Vint_PCM_ptr) ; 14
VintID_Menu =		id(Vint_Menu_ptr) ; 16
VintID_Ending =		id(Vint_Ending_ptr) ; 18
VintID_CtrlDMA =	id(Vint_CtrlDMA_ptr) ; 1A

; Game modes
offset :=	GameModesArray
ptrsize :=	1
idstart :=	0

GameModeID_SegaScreen =		id(GameMode_SegaScreen) ; 0
GameModeID_TitleScreen =	id(GameMode_TitleScreen) ; 4
GameModeID_Demo =		id(GameMode_Demo) ; 8
GameModeID_Level =		id(GameMode_Level) ; C
GameModeID_SpecialStage =	id(GameMode_SpecialStage) ; 10
GameModeID_ContinueScreen =	id(GameMode_ContinueScreen) ; 14
GameModeID_2PResults =		id(GameMode_2PResults) ; 18
GameModeID_2PLevelSelect =	id(GameMode_2PLevelSelect) ; 1C
GameModeID_EndingSequence =	id(GameMode_EndingSequence) ; 20
GameModeID_OptionsMenu =	id(GameMode_OptionsMenu) ; 24
GameModeID_LevelSelect =	id(GameMode_LevelSelect) ; 28
GameModeFlag_TitleCard =	7 ; flag bit
GameModeID_TitleCard =		1<<GameModeFlag_TitleCard ; flag mask

; palette IDs
offset :=	PalPointers
ptrsize :=	8
idstart :=	0

PalID_SEGA =	id(PalPtr_SEGA) ; 0
PalID_Title =	id(PalPtr_Title) ; 1
PalID_MenuB =	id(PalPtr_MenuB) ; 2
PalID_BGND =	id(PalPtr_BGND) ; 3
PalID_EHZ =	id(PalPtr_EHZ) ; 4
PalID_EHZ2 =	id(PalPtr_EHZ2) ; 5
PalID_WZ =	id(PalPtr_WZ) ; 6
PalID_EHZ3 =	id(PalPtr_EHZ3) ; 7
PalID_MTZ =	id(PalPtr_MTZ) ; 8
PalID_MTZ2 =	id(PalPtr_MTZ2) ; 9
PalID_WFZ =	id(PalPtr_WFZ) ; A
PalID_HTZ =	id(PalPtr_HTZ) ; B
PalID_HPZ =	id(PalPtr_HPZ) ; C
PalID_EHZ4 =	id(PalPtr_EHZ4) ; D
PalID_OOZ =	id(PalPtr_OOZ) ; E
PalID_MCZ =	id(PalPtr_MCZ) ; F
PalID_CNZ =	id(PalPtr_CNZ) ; 10
PalID_CPZ =	id(PalPtr_CPZ) ; 11
PalID_DEZ =	id(PalPtr_DEZ) ; 12
PalID_ARZ =	id(PalPtr_ARZ) ; 13
PalID_SCZ =	id(PalPtr_SCZ) ; 14
PalID_HPZ_U =	id(PalPtr_HPZ_U) ; 15
PalID_CPZ_U =	id(PalPtr_CPZ_U) ; 16
PalID_ARZ_U =	id(PalPtr_ARZ_U) ; 17
PalID_SS =	id(PalPtr_SS) ; 18
PalID_MCZ_B =	id(PalPtr_MCZ_B) ; 19
PalID_CNZ_B =	id(PalPtr_CNZ_B) ; 1A
PalID_SS1 =	id(PalPtr_SS1) ; 1B
PalID_SS2 =	id(PalPtr_SS2) ; 1C
PalID_SS3 =	id(PalPtr_SS3) ; 1D
PalID_SS4 =	id(PalPtr_SS4) ; 1E
PalID_SS5 =	id(PalPtr_SS5) ; 1F
PalID_SS6 =	id(PalPtr_SS6) ; 20
PalID_SS7 =	id(PalPtr_SS7) ; 21
PalID_SS1_2p =	id(PalPtr_SS1_2p) ; 22
PalID_SS2_2p =	id(PalPtr_SS2_2p) ; 23
PalID_SS3_2p =	id(PalPtr_SS3_2p) ; 24
PalID_OOZ_B =	id(PalPtr_OOZ_B) ; 25
PalID_Menu =	id(PalPtr_Menu) ; 26
PalID_Result =	id(PalPtr_Result) ; 27

; PLC IDs
offset :=	ArtLoadCues
ptrsize :=	2
idstart :=	0

PLCID_Std1 =		id(PLCptr_Std1) ; 0
PLCID_Std2 =		id(PLCptr_Std2) ; 1
PLCID_StdWtr =		id(PLCptr_StdWtr) ; 2
PLCID_GameOver =	id(PLCptr_GameOver) ; 3
PLCID_Ehz1 =		id(PLCptr_Ehz1) ; 4
PLCID_Ehz2 =		id(PLCptr_Ehz2) ; 5
PLCID_Miles1up =	id(PLCptr_Miles1up) ; 6
PLCID_MilesLife =	id(PLCptr_MilesLife) ; 7
PLCID_Tails1up =	id(PLCptr_Tails1up) ; 8
PLCID_TailsLife =	id(PLCptr_TailsLife) ; 9
PLCID_Unused1 =		id(PLCptr_Unused1) ; A
PLCID_Unused2 =		id(PLCptr_Unused2) ; B
PLCID_Mtz1 =		id(PLCptr_Mtz1) ; C
PLCID_Mtz2 =		id(PLCptr_Mtz2) ; D
PLCID_Wfz1 =		id(PLCptr_Wfz1) ; 10
PLCID_Wfz2 =		id(PLCptr_Wfz2) ; 11
PLCID_Htz1 =		id(PLCptr_Htz1) ; 12
PLCID_Htz2 =		id(PLCptr_Htz2) ; 13
PLCID_Hpz1 =		id(PLCptr_Hpz1) ; 14
PLCID_Hpz2 =		id(PLCptr_Hpz2) ; 15
PLCID_Unused3 =		id(PLCptr_Unused3) ; 16
PLCID_Unused4 =		id(PLCptr_Unused4) ; 17
PLCID_Ooz1 =		id(PLCptr_Ooz1) ; 18
PLCID_Ooz2 =		id(PLCptr_Ooz2) ; 19
PLCID_Mcz1 =		id(PLCptr_Mcz1) ; 1A
PLCID_Mcz2 =		id(PLCptr_Mcz2) ; 1B
PLCID_Cnz1 =		id(PLCptr_Cnz1) ; 1C
PLCID_Cnz2 =		id(PLCptr_Cnz2) ; 1D
PLCID_Cpz1 =		id(PLCptr_Cpz1) ; 1E
PLCID_Cpz2 =		id(PLCptr_Cpz2) ; 1F
PLCID_Dez1 =		id(PLCptr_Dez1) ; 20
PLCID_Dez2 =		id(PLCptr_Dez2) ; 21
PLCID_Arz1 =		id(PLCptr_Arz1) ; 22
PLCID_Arz2 =		id(PLCptr_Arz2) ; 23
PLCID_Scz1 =		id(PLCptr_Scz1) ; 24
PLCID_Scz2 =		id(PLCptr_Scz2) ; 25
PLCID_Results =		id(PLCptr_Results) ; 26
PLCID_Signpost =	id(PLCptr_Signpost) ; 27
PLCID_CpzBoss =		id(PLCptr_CpzBoss) ; 28
PLCID_EhzBoss =		id(PLCptr_EhzBoss) ; 29
PLCID_HtzBoss =		id(PLCptr_HtzBoss) ; 2A
PLCID_ArzBoss =		id(PLCptr_ArzBoss) ; 2B
PLCID_MczBoss =		id(PLCptr_MczBoss) ; 2C
PLCID_CnzBoss =		id(PLCptr_CnzBoss) ; 2D
PLCID_MtzBoss =		id(PLCptr_MtzBoss) ; 2E
PLCID_OozBoss =		id(PLCptr_OozBoss) ; 2F
PLCID_FieryExplosion =	id(PLCptr_FieryExplosion) ; 30
PLCID_DezBoss =		id(PLCptr_DezBoss) ; 31
PLCID_EhzAnimals =	id(PLCptr_EhzAnimals) ; 32
PLCID_MczAnimals =	id(PLCptr_MczAnimals) ; 33
PLCID_HtzAnimals =	id(PLCptr_HtzAnimals) ; 34
PLCID_MtzAnimals =	id(PLCptr_MtzAnimals) ; 34
PLCID_WfzAnimals =	id(PLCptr_WfzAnimals) ; 34
PLCID_DezAnimals =	id(PLCptr_DezAnimals) ; 35
PLCID_HpzAnimals =	id(PLCptr_HpzAnimals) ; 36
PLCID_OozAnimals =	id(PLCptr_OozAnimals) ; 37
PLCID_SczAnimals =	id(PLCptr_SczAnimals) ; 38
PLCID_CnzAnimals =	id(PLCptr_CnzAnimals) ; 39
PLCID_CpzAnimals =	id(PLCptr_CpzAnimals) ; 3A
PLCID_ArzAnimals =	id(PLCptr_ArzAnimals) ; 3B
PLCID_SpecialStage =	id(PLCptr_SpecialStage) ; 3C
PLCID_SpecStageBombs =	id(PLCptr_SpecStageBombs) ; 3D
PLCID_WfzBoss =		id(PLCptr_WfzBoss) ; 3E
PLCID_Tornado =		id(PLCptr_Tornado) ; 3F
PLCID_Capsule =		id(PLCptr_Capsule) ; 40
PLCID_Explosion =	id(PLCptr_Explosion) ; 41
PLCID_ResultsTails =	id(PLCptr_ResultsTails) ; 42

; 2P VS results screens
offset := TwoPlayerResultsPointers
ptrsize := 8
idstart := 0

VsRSID_Act =	id(VsResultsScreen_Act)		; 0
VsRSID_Zone =	id(VsResultsScreen_Zone)	; 1
VsRSID_Game =	id(VsResultsScreen_Game)	; 2
VsRSID_SS =	id(VsResultsScreen_SS)		; 3
VsRSID_SSZone =	id(VsResultsScreen_SSZone)	; 4

; Animation IDs
offset :=	SonicAniData
ptrsize :=	2
idstart :=	0

AniIDSonAni_Walk			= id(SonAni_Walk_ptr)			;  0 ;   0
AniIDSonAni_Run				= id(SonAni_Run_ptr)			;  1 ;   1
AniIDSonAni_Roll			= id(SonAni_Roll_ptr)			;  2 ;   2
AniIDSonAni_Roll2			= id(SonAni_Roll2_ptr)			;  3 ;   3
AniIDSonAni_Push			= id(SonAni_Push_ptr)			;  4 ;   4
AniIDSonAni_Wait			= id(SonAni_Wait_ptr)			;  5 ;   5
AniIDSonAni_Balance			= id(SonAni_Balance_ptr)		;  6 ;   6
AniIDSonAni_LookUp			= id(SonAni_LookUp_ptr)			;  7 ;   7
AniIDSonAni_Duck			= id(SonAni_Duck_ptr)			;  8 ;   8
AniIDSonAni_Spindash		= id(SonAni_Spindash_ptr)		;  9 ;   9
AniIDSonAni_Blink			= id(SonAni_Blink_ptr)			; 10 ;  $A
AniIDSonAni_GetUp			= id(SonAni_GetUp_ptr)			; 11 ;  $B
AniIDSonAni_Balance2		= id(SonAni_Balance2_ptr)		; 12 ;  $C
AniIDSonAni_Stop			= id(SonAni_Stop_ptr)			; 13 ;  $D
AniIDSonAni_Float			= id(SonAni_Float_ptr)			; 14 ;  $E
AniIDSonAni_Float2			= id(SonAni_Float2_ptr)			; 15 ;  $F
AniIDSonAni_Spring			= id(SonAni_Spring_ptr)			; 16 ; $10
AniIDSonAni_Hang			= id(SonAni_Hang_ptr)			; 17 ; $11
AniIDSonAni_Dash2			= id(SonAni_Dash2_ptr)			; 18 ; $12
AniIDSonAni_Dash3			= id(SonAni_Dash3_ptr)			; 19 ; $13
AniIDSonAni_Hang2			= id(SonAni_Hang2_ptr)			; 20 ; $14
AniIDSonAni_Bubble			= id(SonAni_Bubble_ptr)			; 21 ; $15
AniIDSonAni_DeathBW			= id(SonAni_DeathBW_ptr)		; 22 ; $16
AniIDSonAni_Drown			= id(SonAni_Drown_ptr)			; 23 ; $17
AniIDSonAni_Death			= id(SonAni_Death_ptr)			; 24 ; $18
AniIDSonAni_Hurt			= id(SonAni_Hurt_ptr)			; 25 ; $19
AniIDSonAni_Hurt2			= id(SonAni_Hurt2_ptr)			; 26 ; $1A
AniIDSonAni_Slide			= id(SonAni_Slide_ptr)			; 27 ; $1B
AniIDSonAni_Blank			= id(SonAni_Blank_ptr)			; 28 ; $1C
AniIDSonAni_Balance3		= id(SonAni_Balance3_ptr)		; 29 ; $1D
AniIDSonAni_Balance4		= id(SonAni_Balance4_ptr)		; 30 ; $1E
AniIDSupSonAni_Transform	= id(SupSonAni_Transform_ptr)	; 31 ; $1F
AniIDSonAni_Lying			= id(SonAni_Lying_ptr)			; 32 ; $20
AniIDSonAni_LieDown			= id(SonAni_LieDown_ptr)		; 33 ; $21


offset :=	TailsAniData
ptrsize :=	2
idstart :=	0

AniIDTailsAni_Walk			= id(TailsAni_Walk_ptr)			;  0 ;   0
AniIDTailsAni_Run			= id(TailsAni_Run_ptr)			;  1 ;   1
AniIDTailsAni_Roll			= id(TailsAni_Roll_ptr)			;  2 ;   2
AniIDTailsAni_Roll2			= id(TailsAni_Roll2_ptr)		;  3 ;   3
AniIDTailsAni_Push			= id(TailsAni_Push_ptr)			;  4 ;   4
AniIDTailsAni_Wait			= id(TailsAni_Wait_ptr)			;  5 ;   5
AniIDTailsAni_Balance		= id(TailsAni_Balance_ptr)		;  6 ;   6
AniIDTailsAni_LookUp		= id(TailsAni_LookUp_ptr)		;  7 ;   7
AniIDTailsAni_Duck			= id(TailsAni_Duck_ptr)			;  8 ;   8
AniIDTailsAni_Spindash		= id(TailsAni_Spindash_ptr)		;  9 ;   9
AniIDTailsAni_Dummy1		= id(TailsAni_Dummy1_ptr)		; 10 ;  $A
AniIDTailsAni_Dummy2		= id(TailsAni_Dummy2_ptr)		; 11 ;  $B
AniIDTailsAni_Dummy3		= id(TailsAni_Dummy3_ptr)		; 12 ;  $C
AniIDTailsAni_Stop			= id(TailsAni_Stop_ptr)			; 13 ;  $D
AniIDTailsAni_Float			= id(TailsAni_Float_ptr)		; 14 ;  $E
AniIDTailsAni_Float2		= id(TailsAni_Float2_ptr)		; 15 ;  $F
AniIDTailsAni_Spring		= id(TailsAni_Spring_ptr)		; 16 ; $10
AniIDTailsAni_Hang			= id(TailsAni_Hang_ptr)			; 17 ; $11
AniIDTailsAni_Blink			= id(TailsAni_Blink_ptr)		; 18 ; $12
AniIDTailsAni_Blink2		= id(TailsAni_Blink2_ptr)		; 19 ; $13
AniIDTailsAni_Hang2			= id(TailsAni_Hang2_ptr)		; 20 ; $14
AniIDTailsAni_Bubble		= id(TailsAni_Bubble_ptr)		; 21 ; $15
AniIDTailsAni_DeathBW		= id(TailsAni_DeathBW_ptr)		; 22 ; $16
AniIDTailsAni_Drown			= id(TailsAni_Drown_ptr)		; 23 ; $17
AniIDTailsAni_Death			= id(TailsAni_Death_ptr)		; 24 ; $18
AniIDTailsAni_Hurt			= id(TailsAni_Hurt_ptr)			; 25 ; $19
AniIDTailsAni_Hurt2			= id(TailsAni_Hurt2_ptr)		; 26 ; $1A
AniIDTailsAni_Slide			= id(TailsAni_Slide_ptr)		; 27 ; $1B
AniIDTailsAni_Blank			= id(TailsAni_Blank_ptr)		; 28 ; $1C
AniIDTailsAni_Dummy4		= id(TailsAni_Dummy4_ptr)		; 29 ; $1D
AniIDTailsAni_Dummy5		= id(TailsAni_Dummy5_ptr)		; 30 ; $1E
AniIDTailsAni_HaulAss		= id(TailsAni_HaulAss_ptr)		; 31 ; $1F
AniIDTailsAni_Fly			= id(TailsAni_Fly_ptr)			; 32 ; $20


; Other sizes
palette_line_size =	$10*2	; 16 word entries

; ---------------------------------------------------------------------------
; function for converting priority to proper format
prlayer =		$80
prio	function x, Sprite_Table_Input+(x*prlayer)

; ---------------------------------------------------------------------------
; I run the main 68k RAM addresses through this function
; to let them work in both 16-bit and 32-bit addressing modes.
ramaddr function x,-(-x)&$FFFFFFFF

; ---------------------------------------------------------------------------
; RAM variables - General
	phase	ramaddr($FFFF0000)	; Pretend we're in the RAM
RAM_Start:

Chunk_Table:			ds.b $8000	; was "Metablock_Table"
Chunk_Table_End:

Level_Layout:			ds.b $1000
Level_Layout_End:

Block_Table:			ds.w $C00
Block_Table_End:

TempArray_LayerDef:		ds.b $200	; used by some layer deformation routines
Decomp_Buffer:			ds.b $200
Sprite_Table_Input:		ds.b prlayer*8	; in custom format before being converted and stored in Sprite_Table/Sprite_Table_2
Sprite_Table_Input_End:

Object_RAM:			; The various objects in the game are loaded in this area.
				; Each game mode uses different objects, so some slots are reused.
				; The section below declares labels for the objects used in main gameplay.
				; Objects for other game modes are declared further down.
Reserved_Object_RAM:
MainCharacter:			; first object (usually Sonic except in a Tails Alone game)
				ds.b object_size
Sidekick:			; second object (Tails in a Sonic and Tails game)
				ds.b object_size
TitleCard:
TitleCard_ZoneName:		; level title card: zone name
GameOver_GameText:		; "GAME" from GAME OVER
TimeOver_TimeText:		; "TIME" from TIME OVER
				ds.b object_size
TitleCard_Zone:			; level title card: "ZONE"
GameOver_OverText:		; "OVER" from GAME OVER
TimeOver_OverText:		; "OVER" from TIME OVER
				ds.b object_size
TitleCard_ActNumber:		; level title card: act number
				ds.b object_size
TitleCard_Background:		; level title card: background
				ds.b object_size
TitleCard_Bottom:		; level title card: yellow part at the bottom
				ds.b object_size
TitleCard_Left:			; level title card: red part on the left
				ds.b object_size

				; Reserved object RAM, free slots
				ds.b object_size
				ds.b object_size
				ds.b object_size
				ds.b object_size
				ds.b object_size

CPZPylon:			; Pylon in the foreground in CPZ
				ds.b object_size
WaterSurface1:			; First water surface
Oil:				; Oil at the bottom of OOZ
				ds.b object_size
WaterSurface2:			; Second water surface
				ds.b object_size
Reserved_Object_RAM_End:

Dynamic_Object_RAM:		; Dynamic object RAM
				ds.b $23*object_size
Dynamic_Object_RAM_2P_End:	; SingleObjLoad stops searching here in 2P mode
				ds.b $48*object_size
Dynamic_Object_RAM_End:

LevelOnly_Object_RAM:
Tails_Tails:			; address of the Tail's Tails object
				ds.b object_size
SuperSonicStars:
				ds.b object_size
Sonic_BreathingBubbles:		; Sonic's breathing bubbles
				ds.b object_size
Tails_BreathingBubbles:		; Tails' breathing bubbles
				ds.b object_size
Sonic_Dust:			; Sonic's spin dash dust
				ds.b object_size
Tails_Dust:			; Tails' spin dash dust
				ds.b object_size
Sonic_Shield:
				ds.b object_size
Tails_Shield:
				ds.b object_size
Sonic_InvincibilityStars:
				ds.b object_size
				ds.b object_size
				ds.b object_size
				ds.b object_size
Tails_InvincibilityStars:
				ds.b object_size
				ds.b object_size
				ds.b object_size
				ds.b object_size
LevelOnly_Object_RAM_End:

Object_RAM_End:

Primary_Collision:		ds.b $300
Secondary_Collision:		ds.b $300
Sprite_Table_2:			ds.b $280	; Sprite attribute table buffer for the bottom split screen in 2-player mode
				ds.b $80	; unused, but SAT buffer can spill over into this area when there are too many sprites on-screen

VDP_Command_Buffer:		ds.w 7*$12	; stores 18 ($12) VDP commands to issue the next time ProcessDMAQueue is called
VDP_Command_Buffer_Slot:	ds.l 1		; stores the address of the next open slot for a queued VDP command

Horiz_Scroll_Buf:		ds.b $400
Horiz_Scroll_Buf_End:
Sonic_Stat_Record_Buf:		ds.b $100
Sonic_Pos_Record_Buf:		ds.b $100
Tails_Pos_Record_Buf:		ds.b $100
CNZ_saucer_data:		ds.b $40	; the number of saucer bumpers in a group which have been destroyed. Used to decide when to give 500 points instead of 10
CNZ_saucer_data_End:
				ds.b $C0	; $FFFFE740-$FFFFE7FF ; unused as far as I can tell
Max_Rings =			511
Ring_Positions:			ds.w Max_Rings+1
Ring_Positions_End:

Camera_RAM:
Camera_X_pos:			ds.l 1
Camera_Y_pos:			ds.l 1
Camera_BG_X_pos:		ds.l 1		; only used sometimes as the layer deformation makes it sort of redundant
Camera_BG_Y_pos:		ds.l 1
Camera_BG2_X_pos:		ds.l 1		; used in CPZ
Camera_BG2_Y_pos:		ds.l 1		; used in CPZ
Camera_BG3_X_pos:		ds.l 1		; unused (only initialised at beginning of level)?
Camera_BG3_Y_pos:		ds.l 1		; unused (only initialised at beginning of level)?
Camera_X_pos_P2:		ds.l 1
Camera_Y_pos_P2:		ds.l 1
Camera_BG_X_pos_P2:		ds.l 1		; only used sometimes as the layer deformation makes it sort of redundant
Camera_BG_Y_pos_P2:		ds.l 1
Camera_BG2_X_pos_P2:		ds.w 1		; unused (only initialised at beginning of level)?
				ds.w 1		; $FFFFEE32-$FFFFEE33 ; seems unused
Camera_BG2_Y_pos_P2:		ds.l 1
Camera_BG3_X_pos_P2:		ds.w 1		; unused (only initialised at beginning of level)?
				ds.w 1		; $FFFFEE3A-$FFFFEE3B ; seems unused
Camera_BG3_Y_pos_P2:		ds.l 1
Horiz_block_crossed_flag:	ds.b 1		; toggles between 0 and $10 when you cross a block boundary horizontally
Verti_block_crossed_flag:	ds.b 1		; toggles between 0 and $10 when you cross a block boundary vertically
Horiz_block_crossed_flag_BG:	ds.b 1		; toggles between 0 and $10 when background camera crosses a block boundary horizontally
Verti_block_crossed_flag_BG:	ds.b 1		; toggles between 0 and $10 when background camera crosses a block boundary vertically
Horiz_block_crossed_flag_BG2:	ds.b 1		; used in CPZ
				ds.b 1		; $FFFFEE45 ; seems unused
Horiz_block_crossed_flag_BG3:	ds.b 1
				ds.b 1		; $FFFFEE47 ; seems unused
Horiz_block_crossed_flag_P2:	ds.b 1		; toggles between 0 and $10 when you cross a block boundary horizontally
Verti_block_crossed_flag_P2:	ds.b 1		; toggles between 0 and $10 when you cross a block boundary vertically
				ds.b 6		; $FFFFEE4A-$FFFFEE4F ; seems unused
Scroll_flags:			ds.w 1		; bitfield ; bit 0 = redraw top row, bit 1 = redraw bottom row, bit 2 = redraw left-most column, bit 3 = redraw right-most column
Scroll_flags_BG:		ds.w 1		; bitfield ; bits 0-3 as above, bit 4 = redraw top row (except leftmost block), bit 5 = redraw bottom row (except leftmost block), bits 6-7 = as bits 0-1
Scroll_flags_BG2:		ds.w 1		; bitfield ; essentially unused; bit 0 = redraw left-most column, bit 1 = redraw right-most column
Scroll_flags_BG3:		ds.w 1		; bitfield ; for CPZ; bits 0-3 as Scroll_flags_BG but using Y-dependent BG camera; bits 4-5 = bits 2-3; bits 6-7 = bits 2-3
Scroll_flags_P2:		ds.w 1		; bitfield ; bit 0 = redraw top row, bit 1 = redraw bottom row, bit 2 = redraw left-most column, bit 3 = redraw right-most column
Scroll_flags_BG_P2:		ds.w 1		; bitfield ; bits 0-3 as above, bit 4 = redraw top row (except leftmost block), bit 5 = redraw bottom row (except leftmost block), bits 6-7 = as bits 0-1
Scroll_flags_BG2_P2:		ds.w 1		; bitfield ; essentially unused; bit 0 = redraw left-most column, bit 1 = redraw right-most column
Scroll_flags_BG3_P2:		ds.w 1		; bitfield ; for CPZ; bits 0-3 as Scroll_flags_BG but using Y-dependent BG camera; bits 4-5 = bits 2-3; bits 6-7 = bits 2-3
Camera_RAM_copy:		ds.l 2		; copied over every V-int
Camera_BG_copy:			ds.l 2		; copied over every V-int
Camera_BG2_copy:		ds.l 2		; copied over every V-int
Camera_BG3_copy:		ds.l 2		; copied over every V-int
Camera_P2_copy:			ds.l 8		; copied over every V-int
Scroll_flags_copy:		ds.w 1		; copied over every V-int
Scroll_flags_BG_copy:		ds.w 1		; copied over every V-int
Scroll_flags_BG2_copy:		ds.w 1		; copied over every V-int
Scroll_flags_BG3_copy:		ds.w 1		; copied over every V-int
Scroll_flags_copy_P2:		ds.w 1		; copied over every V-int
Scroll_flags_BG_copy_P2:	ds.w 1		; copied over every V-int
Scroll_flags_BG2_copy_P2:	ds.w 1		; copied over every V-int
Scroll_flags_BG3_copy_P2:	ds.w 1		; copied over every V-int

Camera_X_pos_diff:		ds.w 1		; (new X pos - old X pos) * 256
Camera_Y_pos_diff:		ds.w 1		; (new Y pos - old Y pos) * 256
Camera_BG_X_pos_diff:		ds.w 1		; Effective camera change used in WFZ ending and HTZ screen shake
Camera_BG_Y_pos_diff:		ds.w 1		; Effective camera change used in WFZ ending and HTZ screen shake
Camera_X_pos_diff_P2:		ds.w 1		; (new X pos - old X pos) * 256
Camera_Y_pos_diff_P2:		ds.w 1		; (new Y pos - old Y pos) * 256
Screen_Shaking_Flag_HTZ:	ds.b 1		; activates screen shaking code in HTZ's layer deformation routine
Screen_Shaking_Flag:		ds.b 1		; activates screen shaking code (if existent) in layer deformation routine
Scroll_lock:			ds.b 1		; set to 1 to stop all scrolling for P1
Scroll_lock_P2:			ds.b 1		; set to 1 to stop all scrolling for P2
unk_EEC0:			ds.l 1		; unused, except on write in LevelSizeLoad...
unk_EEC4:			ds.w 1		; same as above. The write being a long also overwrites the address below
Camera_Max_Y_pos:		ds.w 1
Camera_Min_X_pos:		ds.w 1
Camera_Max_X_pos:		ds.w 1
Camera_Min_Y_pos:		ds.w 1
Camera_Max_Y_pos_now:		ds.w 1		; was "Camera_max_scroll_spd"...
Horiz_scroll_delay_val:		ds.w 1		; if its value is a, where a != 0, X scrolling will be based on the player's X position a-1 frames ago
Sonic_Pos_Record_Index:		ds.w 1		; into Sonic_Pos_Record_Buf and Sonic_Stat_Record_Buf
Horiz_scroll_delay_val_P2:	ds.w 1
Tails_Pos_Record_Index:		ds.w 1		; into Tails_Pos_Record_Buf
Camera_Y_pos_bias:		ds.w 1		; added to y position for lookup/lookdown, $60 is center
Camera_Y_pos_bias_P2:		ds.w 1		; for Tails
Deform_lock:			ds.b 1		; set to 1 to stop all deformation
				ds.b 1		; $FFFFEEDD ; seems unused
Camera_Max_Y_Pos_Changing:	ds.b 1
Dynamic_Resize_Routine:		ds.b 1
				ds.b 2		; $FFFFEEE0-$FFFFEEE1
Camera_BG_X_offset:		ds.w 1		; Used to control background scrolling in X in WFZ ending and HTZ screen shake
Camera_BG_Y_offset:		ds.w 1		; Used to control background scrolling in Y in WFZ ending and HTZ screen shake
HTZ_Terrain_Delay:		ds.w 1		; During HTZ screen shake, this is a delay between rising and sinking terrain during which there is no shaking
HTZ_Terrain_Direction:		ds.b 1		; During HTZ screen shake, 0 if terrain/lava is rising, 1 if lowering
				ds.b 3		; $FFFFEEE9-$FFFFEEEB ; seems unused
Vscroll_Factor_P2_HInt:		ds.l 1
Camera_X_pos_copy:		ds.l 1
Camera_Y_pos_copy:		ds.l 1
Tails_Min_X_pos:		ds.w 1
Tails_Max_X_pos:		ds.w 1
Tails_Min_Y_pos:		ds.w 1		; seems not actually implemented (only written to)
Tails_Max_Y_pos:		ds.w 1
Camera_RAM_End:

Block_cache:			ds.b $80
Ring_consumption_table:		ds.b $80	; contains RAM addresses of rings currently being consumed
Ring_consumption_table_End:

Underwater_target_palette:	ds.b palette_line_size	; This is used by the screen-fading subroutines.
Underwater_target_palette_line2:ds.b palette_line_size	; While Underwater_palette contains the blacked-out palette caused by the fading,
Underwater_target_palette_line3:ds.b palette_line_size	; Underwater_target_palette will contain the palette the screen will ultimately fade in to.
Underwater_target_palette_line4:ds.b palette_line_size

Underwater_palette:		ds.b palette_line_size	; main palette for underwater parts of the screen
Underwater_palette_line2:	ds.b palette_line_size
Underwater_palette_line3:	ds.b palette_line_size
Underwater_palette_line4:	ds.b palette_line_size
DrvMem:				ds.b $4C0	; memory used by AMPS

Game_Mode:			ds.w 1		; 1 byte ; see GameModesArray (master level trigger, Mstr_Lvl_Trigger)
Ctrl_1_Logical:					; 2 bytes
Ctrl_1_Held_Logical:		ds.b 1		; 1 byte
Ctrl_1_Press_Logical:		ds.b 1		; 1 byte
Ctrl_1:						; 2 bytes
Ctrl_1_Held:			ds.b 1		; 1 byte ; (pressed and held were switched around before)
Ctrl_1_Press:			ds.b 1		; 1 byte
Ctrl_2:						; 2 bytes
Ctrl_2_Held:			ds.b 1		; 1 byte
Ctrl_2_Press:			ds.b 1		; 1 byte
				ds.b 4		; $FFFFF608-$FFFFF60B ; seems unused
VDP_Reg1_val:			ds.w 1		; normal value of VDP register #1 when display is disabled
				ds.b 6		; $FFFFF60E-$FFFFF613 ; seems unused
Demo_Time_left:			ds.w 1		; 2 bytes

Vscroll_Factor:
Vscroll_Factor_FG:		ds.w 1
Vscroll_Factor_BG:		ds.w 1
unk_F61A:			ds.l 1		; Only ever cleared, never used
Vscroll_Factor_P2:
Vscroll_Factor_P2_FG:		ds.w 1
Vscroll_Factor_P2_BG:		ds.w 1
Teleport_timer:			ds.b 1		; timer for teleport effect
Teleport_flag:			ds.b 1		; set when a teleport is in progress
Hint_counter_reserve:		ds.w 1		; Must contain a VDP command word, preferably a write to register $0A. Executed every V-INT.
Palette_fade_range:				; Range affected by the palette fading routines
Palette_fade_start:		ds.b 1		; Offset from the start of the palette to tell what range of the palette will be affected in the palette fading routines
Palette_fade_length:		ds.b 1		; Number of entries to change in the palette fading routines

MiscLevelVariables:
VIntSubE_RunCount:		ds.b 1
				ds.b 1		; $FFFFF629 ; seems unused
Vint_routine:			ds.b 1		; was "Delay_Time" ; routine counter for V-int
				ds.b 1		; $FFFFF62B ; seems unused
Sprite_count:			ds.b 1		; the number of sprites drawn in the current frame
				ds.b 5		; $FFFFF62D-$FFFFF631 ; seems unused
PalCycle_Frame:			ds.w 1		; ColorID loaded in PalCycle
PalCycle_Timer:			ds.w 1		; number of frames until next PalCycle call
RNG_seed:			ds.l 1		; used for random number generation
Game_paused:			ds.w 1
				ds.b 4		; $FFFFF63C-$FFFFF63F ; seems unused
DMA_data_thunk:			ds.w 1		; Used as a RAM holder for the final DMA command word. Data will NOT be preserved across V-INTs, so consider this space reserved.
				ds.w 1		; $FFFFF642-$FFFFF643 ; seems unused
Hint_flag:			ds.w 1		; unless this is 1, H-int won't run

Water_Level_1:			ds.w 1
Water_Level_2:			ds.w 1
Water_Level_3:			ds.w 1
Water_on:			ds.b 1		; is set based on Water_flag
Water_routine:			ds.b 1
Water_fullscreen_flag:		ds.b 1		; was "Water_move"
Do_Updates_in_H_int:		ds.b 1

PalCycle_Frame_CNZ:		ds.w 1
PalCycle_Frame2:		ds.w 1
PalCycle_Frame3:		ds.w 1
PalCycle_Frame2_CNZ:		ds.w 1
				ds.b 4		; $FFFFF658-$FFFFF65B ; seems unused
Palette_frame:			ds.w 1
Palette_timer:			ds.b 1		; was "Palette_frame_count"
Super_Sonic_palette:		ds.b 1

Title_TextBanner:
DEZ_Eggman:					; Word
DEZ_Shake_Timer:				; Word
WFZ_LevEvent_Subrout:				; Word
SegaScr_PalDone_Flag:				; Byte (cleared once as a word)
Credits_Trigger:		ds.b 1		; cleared as a word a couple times
Ending_PalCycle_flag:		ds.b 1

Title_EnableTextBanner:
SegaScr_VInt_Subrout:
Ending_VInt_Subrout:
WFZ_BG_Y_Speed:			ds.w 1
				ds.w 1		; $FFFFF664-$FFFFF665 ; seems unused
PalCycle_Timer2:		ds.w 1
PalCycle_Timer3:		ds.w 1

Ctrl_2_Logical:					; 2 bytes
Ctrl_2_Held_Logical:		ds.b 1		; 1 byte
Ctrl_2_Press_Logical:		ds.b 1		; 1 byte
Sonic_Look_delay_counter:	ds.w 1		; 2 bytes
Tails_Look_delay_counter:	ds.w 1		; 2 bytes
Super_Sonic_frame_count:	ds.w 1
Camera_ARZ_BG_X_pos:		ds.l 1
				ds.b $A		; $FFFFF676-$FFFFF67F ; seems unused
MiscLevelVariables_End

Plc_Buffer:			ds.b $60	; Pattern load queue (each entry is 6 bytes)
Plc_Buffer_Only_End:
				; these seem to store nemesis decompression state so PLC processing can be spread out across frames
Plc_Buffer_Reg0:		ds.l 1
Plc_Buffer_Reg4:		ds.l 1
Plc_Buffer_Reg8:		ds.l 1
Plc_Buffer_RegC:		ds.l 1
Plc_Buffer_Reg10:		ds.l 1
Plc_Buffer_Reg14:		ds.l 1
Plc_Buffer_Reg18:		ds.w 1		; amount of current entry remaining to decompress
Plc_Buffer_Reg1A:		ds.w 1
				ds.b 4		; seems unused
Plc_Buffer_End:


Misc_Variables:
				ds.w 1		; unused

; extra variables for the second player (CPU) in 1-player mode
Tails_control_counter:		ds.w 1		; how long until the CPU takes control
Tails_respawn_counter:		ds.w 1
				ds.w 1		; unused
Tails_CPU_routine:		ds.w 1
Tails_CPU_target_x:		ds.w 1
Tails_CPU_target_y:		ds.w 1
Tails_interact_ID:		ds.b 1		; object ID of last object stood on
Tails_CPU_jumping:		ds.b 1

Rings_manager_routine:		ds.b 1
Level_started_flag:		ds.b 1
Ring_start_addr_RAM:		ds.w 1
Ring_start_addr_RAM_P2:		ds.w 1
Ring_start_addr_ROM		ds.l 1
Ring_end_addr_ROM		ds.l 1
Ring_start_addr_ROM_P2		ds.l 1
Ring_end_addr_ROM_P2		ds.l 1
CNZ_Bumper_routine:		ds.b 1
CNZ_Bumper_UnkFlag:		ds.b 1		; Set only, never used again
CNZ_Visible_bumpers_start:	ds.l 1
CNZ_Visible_bumpers_end:	ds.l 1
CNZ_Visible_bumpers_start_P2:	ds.l 1
CNZ_Visible_bumpers_end_P2:	ds.l 1

Screen_redraw_flag:		ds.b 1		; if whole screen needs to redraw, such as when you destroy that piston before the boss in WFZ
CPZ_UnkScroll_Timer:		ds.b 1		; Used only in unused CPZ scrolling function
WFZ_SCZ_Fire_Toggle:		ds.b 1
				ds.b 1		; $FFFFF72F ; seems unused
Water_flag:			ds.b 1		; if the level has water or oil
				ds.b 1		; $FFFFF731 ; seems unused
Demo_button_index_2P:		ds.w 1		; index into button press demo data, for player 2
Demo_press_counter_2P:		ds.w 1		; frames remaining until next button press, for player 2
Tornado_Velocity_X:		ds.w 1		; speed of tails' plane in scz ($FFFFF736)
Tornado_Velocity_Y:		ds.w 1
ScreenShift:			ds.b 1
				ds.b 4		; $FFFFF73B-$FFFFF73E
Boss_CollisionRoutine:		ds.b 1
Boss_AnimationArray:		ds.b $10	; up to $10 bytes; 2 bytes per entry
Ending_Routine:
Boss_X_pos:			ds.w 1
				ds.w 1		; Boss_MoveObject reads a long, but all other places in the game use only the high word
Boss_Y_pos:			ds.w 1
				ds.w 1		; same here
Boss_X_vel:			ds.w 1
Boss_Y_vel:			ds.w 1
Boss_Countdown:			ds.w 1
				ds.w 1		; $FFFFF75E-$FFFFF75F ; unused

Sonic_top_speed:		ds.w 1
Sonic_acceleration:		ds.w 1
Sonic_deceleration:		ds.w 1
Sonic_LastLoadedDPLC:		ds.b 1		; mapping frame number when Sonic last had his tiles requested to be transferred from ROM to VRAM. can be set to a dummy value like -1 to force a refresh DMA. was: Sonic_mapping_frame
				ds.b 1		; $FFFFF767 ; seems unused
Primary_Angle:			ds.b 1
				ds.b 1		; $FFFFF769 ; seems unused
Secondary_Angle:		ds.b 1
				ds.b 1		; $FFFFF76B ; seems unused
Obj_placement_routine:		ds.b 1
				ds.b 1		; $FFFFF76D ; seems unused
Camera_X_pos_last:		ds.w 1		; Camera_X_pos_coarse from the previous frame

Obj_load_addr_right:		ds.l 1		; contains the address of the next object to load when moving right
Obj_load_addr_left:		ds.l 1		; contains the address of the last object loaded when moving left
Obj_load_addr_2:		ds.l 1
Obj_load_addr_3:		ds.l 1
unk_F780:			ds.b 6		; seems to be an array of horizontal chunk positions, used for object position range checks
unk_F786:			ds.b 3
unk_F789:			ds.b 3
Camera_X_pos_last_P2:		ds.w 1
Obj_respawn_index_P2:		ds.w 2		; respawn table indices of the next objects when moving left or right for the second player

Demo_button_index:		ds.w 1		; index into button press demo data, for player 1
Demo_press_counter:		ds.b 1		; frames remaining until next button press, for player 1
				ds.b 1		; $FFFFF793 ; seems unused
PalChangeSpeed:			ds.w 1
Collision_addr:			ds.l 1
				ds.b $D		; $FFFFF79A-$FFFFF7A6 ; seems unused
Boss_defeated_flag:		ds.b 1
				ds.b 2		; $FFFFF7A8-$FFFFF7A9 ; seems unused
Current_Boss_ID:		ds.b 1
				ds.b 5		; $FFFFF7AB-$FFFFF7AF ; seems unused
MTZ_Platform_Cog_X:		ds.w 1		; X position of moving MTZ platform for cog animation.
MTZCylinder_Angle_Sonic:	ds.b 1
MTZCylinder_Angle_Tails:	ds.b 1
				ds.b $A		; $FFFFF7B4-$FFFFF7BD ; seems unused
BigRingGraphics:		ds.w 1		; S1 holdover
				ds.b 7		; $FFFFF7C0-$FFFFF7C6 ; seems unused
WindTunnel_flag:		ds.b 1
				ds.b 1		; $FFFFF7C8 ; seems unused
WindTunnel_holding_flag:	ds.b 1
				ds.b 2		; $FFFFF7CA-$FFFFF7CB ; seems unused
Control_Locked:			ds.b 1
SpecialStage_flag_2P:		ds.b 1
				ds.b 1		; $FFFFF7CE ; seems unused
Control_Locked_P2:		ds.b 1
Chain_Bonus_counter:		ds.w 1		; counts up when you destroy things that give points, resets when you touch the ground
Bonus_Countdown_1:		ds.w 1		; level results time bonus or special stage sonic ring bonus
Bonus_Countdown_2:		ds.w 1		; level results ring bonus or special stage tails ring bonus
Update_Bonus_score:		ds.b 1
				ds.b 3		; $FFFFF7D7-$FFFFF7D9 ; seems unused
Camera_X_pos_coarse:		ds.w 1		; (Camera_X_pos - 128) / 256
Camera_X_pos_coarse_P2:		ds.w 1
Tails_LastLoadedDPLC:		ds.b 1		; mapping frame number when Tails last had his tiles requested to be transferred from ROM to VRAM. can be set to a dummy value like -1 to force a refresh DMA.
TailsTails_LastLoadedDPLC:	ds.b 1		; mapping frame number when Tails' tails last had their tiles requested to be transferred from ROM to VRAM. can be set to a dummy value like -1 to force a refresh DMA.
ButtonVine_Trigger:		ds.b $10	; 16 bytes flag array, #subtype byte set when button/vine of respective subtype activated
Anim_Counters:			ds.b $10	; $FFFFF7F0-$FFFFF7FF
Misc_Variables_End:

Sprite_Table:			ds.b $280	; Sprite attribute table buffer
Sprite_Table_End:
				ds.b $80	; unused, but SAT buffer can spill over into this area when there are too many sprites on-screen

Normal_palette:			ds.b palette_line_size	; main palette for non-underwater parts of the screen
Normal_palette_line2:		ds.b palette_line_size
Normal_palette_line3:		ds.b palette_line_size
Normal_palette_line4:		ds.b palette_line_size
Normal_palette_End:

Target_palette:			ds.b palette_line_size	; This is used by the screen-fading subroutines.
Target_palette_line2:		ds.b palette_line_size	; While Normal_palette contains the blacked-out palette caused by the fading,
Target_palette_line3:		ds.b palette_line_size	; Target_palette will contain the palette the screen will ultimately fade in to.
Target_palette_line4:		ds.b palette_line_size
Target_palette_End:

Object_Respawn_Table:
Obj_respawn_index:		ds.w 2		; respawn table indices of the next objects when moving left or right for the first player
Obj_respawn_data:		ds.b $100	; Maximum possible number of respawn entries that S2 can handle; for stock S2, $80 is enough
Obj_respawn_data_End:
				ds.b $FC	; Stack; the first $7E bytes are cleared by ObjectsManager_Init, with possibly disastrous consequences. At least $A0 bytes are needed.
System_Stack:

SS_2p_Flag:			ds.w 1		; $FFFFFE00-$FFFFFE01 ; seems unused
Level_Inactive_flag:		ds.w 1		; (2 bytes)
Timer_frames:			ds.w 1		; (2 bytes)
Debug_object:			ds.b 1
				ds.b 1		; $FFFFFE07 ; seems unused
Debug_placement_mode:		ds.b 1
				ds.b 1		; the whole word is tested, but the debug mode code uses only the low byte
Debug_Accel_Timer:		ds.b 1
Debug_Speed:			ds.b 1
Vint_runcount:			ds.l 1

Current_ZoneAndAct:				; 2 bytes
Current_Zone:			ds.b 1		; 1 byte
Current_Act:			ds.b 1		; 1 byte
Life_count:			ds.b 1
				ds.b 3		; $FFFFFE13-$FFFFFE15 ; seems unused

Current_Special_StageAndAct:	; 2 bytes
Current_Special_Stage:		ds.b 1
Current_Special_Act:		ds.b 1
Continue_count:			ds.b 1
Super_Sonic_flag:		ds.b 1
Time_Over_flag:			ds.b 1
Extra_life_flags:		ds.b 1

; If set, the respective HUD element will be updated.
Update_HUD_lives:		ds.b 1
Update_HUD_rings:		ds.b 1
Update_HUD_timer:		ds.b 1
Update_HUD_score:		ds.b 1

Ring_count:			ds.w 1		; 2 bytes
Timer:						; 4 bytes
Timer_minute_word:				; 2 bytes
				ds.b 1		; filler
Timer_minute:			ds.b 1		; 1 byte
Timer_second:			ds.b 1		; 1 byte
Timer_centisecond:				; inaccurate name (the seconds increase when this reaches 60)
Timer_frame:			ds.b 1		; 1 byte

Score:				ds.l 1		; 4 bytes
				ds.b 6		; $FFFFFE2A-$FFFFFE2F ; seems unused
Last_star_pole_hit:		ds.b 1		; 1 byte -- max activated starpole ID in this act
Saved_Last_star_pole_hit:	ds.b 1
Saved_x_pos:			ds.w 1
Saved_y_pos:			ds.w 1
Saved_Ring_count:		ds.w 1
Saved_Timer:			ds.l 1
Saved_art_tile:			ds.w 1
Saved_Solid_bits:		ds.w 1
Saved_Camera_X_pos:		ds.w 1
Saved_Camera_Y_pos:		ds.w 1
Saved_Camera_BG_X_pos:		ds.w 1
Saved_Camera_BG_Y_pos:		ds.w 1
Saved_Camera_BG2_X_pos:		ds.w 1
Saved_Camera_BG2_Y_pos:		ds.w 1
Saved_Camera_BG3_X_pos:		ds.w 1
Saved_Camera_BG3_Y_pos:		ds.w 1
Saved_Water_Level:		ds.w 1
Saved_Water_routine:		ds.b 1
Saved_Water_move:		ds.b 1
Saved_Extra_life_flags:		ds.b 1
Saved_Extra_life_flags_2P:	ds.b 1		; stored, but never restored
Saved_Camera_Max_Y_pos:		ds.w 1
Saved_Dynamic_Resize_Routine:	ds.b 1

				ds.b 5		; $FFFFFE59-$FFFFFE5D ; seems unused
Oscillating_Numbers:
Oscillation_Control:		ds.w 1
Oscillating_variables:
Oscillating_Data:		ds.w $20
Oscillating_Numbers_End

Logspike_anim_counter:		ds.b 1
Logspike_anim_frame:		ds.b 1
Rings_anim_counter:		ds.b 1
Rings_anim_frame:		ds.b 1
Unknown_anim_counter:		ds.b 1		; I think this was $FFFFFEC4 in the alpha
Unknown_anim_frame:		ds.b 1
Ring_spill_anim_counter:	ds.b 1		; scattered rings
Ring_spill_anim_frame:		ds.b 1
Ring_spill_anim_accum:		ds.w 1
				ds.b 6		; $FFFFFEA9-$FFFFFEAF ; seems unused, but cleared once
Oscillating_variables_End
				ds.b $10	; $FFFFFEB0-$FFFFFEBF ; seems unused

; values for the second player (some of these only apply to 2-player games)
Tails_top_speed:		ds.w 1		; Tails_max_vel
Tails_acceleration:		ds.w 1
Tails_deceleration:		ds.w 1
Life_count_2P:			ds.b 1
Extra_life_flags_2P:		ds.b 1
Update_HUD_lives_2P:		ds.b 1
Update_HUD_rings_2P:		ds.b 1
Update_HUD_timer_2P:		ds.b 1
Update_HUD_score_2P:		ds.b 1		; mostly unused
Time_Over_flag_2P:		ds.b 1
				ds.b 3		; $FFFFFECD-$FFFFFECF ; seems unused
Ring_count_2P:			ds.w 1
Timer_2P:					; 4 bytes
Timer_minute_word_2P:				; 2 bytes
				ds.b 1		; filler
Timer_minute_2P:		ds.b 1		; 1 byte
Timer_second_2P:		ds.b 1		; 1 byte
Timer_centisecond_2P:				; inaccurate name (the seconds increase when this reaches 60)
Timer_frame_2P:			ds.b 1		; 1 byte
Score_2P:			ds.l 1
				ds.b 6		; $FFFFFEDA-$FFFFFEDF ; seems unused
Last_star_pole_hit_2P:		ds.b 1
Saved_Last_star_pole_hit_2P:	ds.b 1
Saved_x_pos_2P:			ds.w 1
Saved_y_pos_2P:			ds.w 1
Saved_Ring_count_2P:		ds.w 1
Saved_Timer_2P:			ds.l 1
Saved_art_tile_2P:		ds.w 1
Saved_Solid_bits_2P:		ds.w 1
Rings_Collected:		ds.w 1		; number of rings collected during an act in two player mode
Rings_Collected_2P:		ds.w 1
Monitors_Broken:		ds.w 1		; number of monitors broken during an act in two player mode
Monitors_Broken_2P:		ds.w 1
Loser_Time_Left:				; 2 bytes
				ds.b 1		; seconds
				ds.b 1		; frames

				ds.b $16	; $FFFFFEFA-$FFFFFF0F ; seems unused
Results_Screen_2P:		ds.w 1		; 0 = act, 1 = zone, 2 = game, 3 = SS, 4 = SS all
				ds.b $E		; $FFFFFF12-$FFFFFF1F ; seems unused

Results_Data_2P:				; $18 (24) bytes
EHZ_Results_2P:			ds.b 6		; 6 bytes
MCZ_Results_2P:			ds.b 6		; 6 bytes
CNZ_Results_2P:			ds.b 6		; 6 bytes
SS_Results_2P:			ds.b 6		; 6 bytes
Results_Data_2P_End:

SS_Total_Won:			ds.b 2		; 2 bytes (player 1 then player 2)
				ds.b 6		; $FFFFFF3A-$FFFFFF3F ; seems unused
Perfect_rings_left:		ds.w 1
Perfect_rings_flag:		ds.w 1
				ds.b 8		; $FFFFFF44-$FFFFFF4B ; seems unused

CreditsScreenIndex:
SlotMachineInUse:		ds.w 1
SlotMachineVariables:				; $12 values
SlotMachine_Routine:		ds.b 1
SlotMachine_Timer:		ds.b 1
				ds.b 1		; $FFFFFF50 ; seems unused except for 1 write
SlotMachine_Index:		ds.b 1
SlotMachine_Reward:		ds.w 1
SlotMachine_Slot1Pos:		ds.w 1
SlotMachine_Slot1Speed:		ds.b 1
SlotMachine_Slot1Rout:		ds.b 1
SlotMachine_Slot2Pos:		ds.w 1
SlotMachine_Slot2Speed:		ds.b 1
SlotMachine_Slot2Rout:		ds.b 1
SlotMachine_Slot3Pos:		ds.w 1
SlotMachine_Slot3Speed:		ds.b 1
SlotMachine_Slot3Rout:		ds.b 1

				ds.b $10	; $FFFFFF60-$FFFFFF6F ; seems unused

Player_mode:			ds.w 1		; 0 = Sonic and Tails, 1 = Sonic, 2 = Tails
Player_option:			ds.w 1		; 0 = Sonic and Tails, 1 = Sonic, 2 = Tails

Two_player_items:		ds.w 1
				ds.b $A		; $FFFFFF76-$FFFFFF7F ; seems unused

LevSel_HoldTimer:		ds.w 1
Level_select_zone:		ds.w 1
Sound_test_sound:		ds.w 1
Title_screen_option:		ds.b 1
				ds.b 1		; $FFFFFF87 ; unused
Current_Zone_2P:		ds.b 1
Current_Act_2P:			ds.b 1
Two_player_mode_copy:		ds.w 1
Options_menu_box:		ds.b 1
				ds.b 1		; $FFFFFF8D ; unused
Total_Bonus_Countdown:		ds.w 1

Level_Music:			ds.w 1
Bonus_Countdown_3:		ds.w 1
				ds.b 4		; $FFFFFF94-$FFFFFF97 ; seems unused
Game_Over_2P:			ds.w 1

				ds.b 6		; $FFFFFF9A-$FFFFFF9F ; seems unused

SS2p_RingBuffer:		ds.w 6
				ds.b 4		; $FFFFFFAC-$FFFFFFAF ; seems unused
Got_Emerald:			ds.b 1
Emerald_count:			ds.b 1
Got_Emeralds_array:		ds.b 7		; 7 bytes
				ds.b 7		; $FFFFFFB9-$FFFFFFBF ; filler
Next_Extra_life_score:		ds.l 1
Next_Extra_life_score_2P:	ds.l 1
Level_Has_Signpost:		ds.w 1		; 1 = signpost, 0 = boss or nothing
Signpost_prev_frame:		ds.b 1
				ds.b 1		; $FFFFFFCB ; seems unused
Camera_Min_Y_pos_Debug_Copy:	ds.w 1
Camera_Max_Y_pos_Debug_Copy:	ds.w 1

Level_select_flag:		ds.b 1
Slow_motion_flag:		ds.b 1		; This NEEDs to be after Level_select_flag because of the call to CheckCheats
Debug_options_flag:		ds.b 1		; if set, allows you to enable debug mode and "night mode"
S1_hidden_credits_flag:		ds.b 1		; Leftover from Sonic 1. This NEEDs to be after Debug_options_flag because of the call to CheckCheats
Correct_cheat_entries:		ds.w 1
Correct_cheat_entries_2:	ds.w 1		; for 14 continues or 7 emeralds codes

Two_player_mode:		ds.w 1		; flag (0 for main game)
unk_FFDA:			ds.w 1		; Written to once at title screen, never read from
unk_FFDC:			ds.b 1		; Written to near loc_175EA, never read from
unk_FFDD:			ds.b 1		; Written to near loc_175EA, never read from
unk_FFDE:			ds.b 1		; Written to near loc_175EA, never read from
unk_FFDF:			ds.b 1		; Written to near loc_175EA, never read from

Demo_mode_flag:			ds.w 1		; 1 if a demo is playing (2 bytes)
Demo_number:			ds.w 1		; which demo will play next (2 bytes)
Ending_demo_number:		ds.w 1		; zone for the ending demos (2 bytes, unused)
LagFrames:			ds.w 1
ConsoleRegion:
Graphics_Flags:			ds.w 1		; misc. bitfield
Debug_mode_flag:		ds.w 1		; (2 bytes)
Checksum_fourcc:		ds.l 1		; (4 bytes)

RAM_End

    if * > 0	; Don't declare more space than the RAM can contain!
	fatal "The RAM variable declarations are too large by $\{*} bytes."
    endif


; RAM variables - SEGA screen
	phase	Object_RAM	; Move back to the object RAM
SegaScr_Object_RAM:
				; Unused slot
				ds.b object_size
SegaScreenObject:		; Sega screen
				ds.b object_size
SegaHideTM:				; Object that hides TM symbol on JP region
				ds.b object_size
SegaScr_Object_RAM_End:


; RAM variables - Title screen
	phase	Object_RAM	; Move back to the object RAM
TtlScr_Object_RAM:
IntroTextBanner:
				ds.b object_size
IntroSonic:			; stars on the title screen
				ds.b object_size
IntroTails:
				ds.b object_size
IntroLargeStar:
TitleScreenPaletteChanger:
				ds.b object_size
TitleScreenPaletteChanger3:
				ds.b object_size
IntroEmblemTop:
				ds.b object_size
IntroSmallStar1:
				ds.b object_size
IntroSonicHand:
				ds.b object_size
IntroTailsHand:
				ds.b object_size
TitleScreenPaletteChanger2:
				ds.b object_size

				ds.b 6*object_size

TitleScreenMenu:
				ds.b object_size
IntroSmallStar2:
				ds.b object_size
TtlScr_Object_RAM_End:


; RAM variables - Special stage
	phase	RAM_Start	; Move back to start of RAM
SSRAM_ArtNem_SpecialSonicAndTails:
				ds.b $353*$20	; $353 art blocks
SSRAM_MiscKoz_SpecialPerspective:
				ds.b $1AFC
SSRAM_MiscNem_SpecialLevelLayout:
				ds.b $180
				ds.b $9C	; padding
SSRAM_MiscKoz_SpecialObjectLocations:
				ds.b $1AE0

	phase	Sprite_Table_Input
SS_Sprite_Table_Input:		ds.b prlayer*8	; in custom format before being converted and stored in Sprite_Table
SS_Sprite_Table_Input_End:

	phase	Object_RAM	; Move back to the object RAM
SS_Object_RAM:
				ds.b object_size
				ds.b object_size
SpecialStageHUD:		; HUD in the special stage
				ds.b object_size
SpecialStageStartBanner:
				ds.b object_size
SpecialStageNumberOfRings:
				ds.b object_size
SpecialStageShadow_Sonic:
				ds.b object_size
SpecialStageShadow_Tails:
				ds.b object_size
SpecialStageTails_Tails:
				ds.b object_size
SS_Dynamic_Object_RAM:
				ds.b $18*object_size
SpecialStageResults:
				ds.b object_size
				ds.b $C*object_size
SpecialStageResults2:
				ds.b object_size
				ds.b $4C*object_size
SS_Dynamic_Object_RAM_End:
				ds.b object_size
SS_Object_RAM_End:

				; The special stage mode also uses the rest of the RAM for
				; different purposes.
SS_Misc_Variables:
PNT_Buffer:			ds.b $700
PNT_Buffer_End:
SS_Horiz_Scroll_Buf_2:		ds.b $400

SSTrack_mappings_bitflags:				ds.l 1
SSTrack_mappings_uncompressed:			ds.l 1
SSTrack_anim:							ds.b 1
SSTrack_last_anim_frame:				ds.b 1
SpecialStage_CurrentSegment:			ds.b 1
SSTrack_anim_frame:						ds.b 1
SS_Alternate_PNT:						ds.b 1
SSTrack_drawing_index:					ds.b 1
SSTrack_Orientation:					ds.b 1
SS_Alternate_HorizScroll_Buf:			ds.b 1
SSTrack_mapping_frame:					ds.b 1
SS_Last_Alternate_HorizScroll_Buf:		ds.b 1
SS_New_Speed_Factor:					ds.l 1
SS_Cur_Speed_Factor:					ds.l 1
		ds.b 5
SSTrack_duration_timer:					ds.b 1
		ds.b 1
SS_player_anim_frame_timer:				ds.b 1
SpecialStage_LastSegment:				ds.b 1
SpecialStage_Started:					ds.b 1
		ds.b 4
SSTrack_last_mappings_copy:				ds.l 1
SSTrack_last_mappings:					ds.l 1
		ds.b 4
SSTrack_LastVScroll:					ds.w 1
		ds.b 3
SSTrack_last_mapping_frame:				ds.b 1
SSTrack_mappings_RLE:					ds.l 1
SSDrawRegBuffer:						ds.w 6
SSDrawRegBuffer_End
		ds.b 2
SpecialStage_LastSegment2:	ds.b 1
SS_unk_DB4D:	ds.b 1
		ds.b $14
SS_Ctrl_Record_Buf:
				ds.w $F
SS_Last_Ctrl_Record:
				ds.w 1
SS_Ctrl_Record_Buf_End
SS_CurrentPerspective:	ds.l 1
SS_Check_Rings_flag:		ds.b 1
SS_Pause_Only_flag:		ds.b 1
SS_CurrentLevelObjectLocations:	ds.l 1
SS_Ring_Requirement:	ds.w 1
SS_CurrentLevelLayout:	ds.l 1
		ds.b 1
SS_2P_BCD_Score:	ds.b 1
		ds.b 1
SS_NoCheckpoint_flag:	ds.b 1
		ds.b 2
SS_Checkpoint_Rainbow_flag:	ds.b 1
SS_Rainbow_palette:	ds.b 1
SS_Perfect_rings_left:	ds.w 1
		ds.b 2
SS_Star_color_1:	ds.b 1
SS_Star_color_2:	ds.b 1
SS_NoCheckpointMsg_flag:	ds.b 1
		ds.b 1
SS_NoRingsTogoLifetime:	ds.w 1
SS_RingsToGoBCD:		ds.w 1
SS_HideRingsToGo:	ds.b 1
SS_TriggerRingsToGo:	ds.b 1
SS_Misc_Variables_End:

	phase	ramaddr(Horiz_Scroll_Buf)	; Still in SS RAM
SS_Horiz_Scroll_Buf_1:		ds.b $400
SS_Horiz_Scroll_Buf_1_End:

	phase	ramaddr(Boss_AnimationArray)	; Still in SS RAM
SS_Offset_X:			ds.w 1
SS_Offset_Y:			ds.w 1
SS_Swap_Positions_Flag:	ds.b 1

	phase	ramaddr(Sprite_Table)	; Still in SS RAM
SS_Sprite_Table:			ds.b $280	; Sprite attribute table buffer
SS_Sprite_Table_End:
				ds.b $80	; unused, but SAT buffer can spill over into this area when there are too many sprites on-screen


; RAM variables - Continue screen
	phase	Object_RAM	; Move back to the object RAM
ContScr_Object_RAM:
				ds.b object_size
				ds.b object_size
ContinueText:			; "CONTINUE" on the Continue screen
				ds.b object_size
ContinueIcons:			; The icons in the Continue screen
				ds.b $D*object_size
ContScr_Object_RAM_End:


; RAM variables - 2P VS results screen
	phase	Object_RAM	; Move back to the object RAM
VSRslts_Object_RAM:
VSResults_HUD:			; Blinking text at the bottom of the screen
				ds.b object_size
VSRslts_Object_RAM_End:


; RAM variables - Menu screens
	phase	Object_RAM	; Move back to the object RAM
Menus_Object_RAM:		; No objects are loaded in the menu screens
Menus_Object_RAM_End:


; RAM variables - Ending sequence
	phase	Object_RAM
EndSeq_Object_RAM:
				ds.b object_size
				ds.b object_size
Tails_Tails_Cutscene:		; Tails' tails on the cut scene
				ds.b object_size
EndSeqPaletteChanger:
				ds.b object_size
CutScene:
				ds.b object_size
EndSeq_Object_RAM_End:

	dephase		; Stop pretending

	!org	0	; Reset the program counter


; ---------------------------------------------------------------------------
; VDP addressses
VDP_data_port =			$C00000 ; (8=r/w, 16=r/w)
VDP_control_port =		$C00004 ; (8=r/w, 16=r/w)
PSG_input =			$C00011

; ---------------------------------------------------------------------------
; Z80 addresses
Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_End =			$A02000 ; end of non-reserved Z80 RAM
Z80_Bus_Request =		$A11100
Z80_Reset =			$A11200

Security_Addr =			$A14000

; ---------------------------------------------------------------------------
; I/O Area
HW_Version =				$A10001
HW_Port_1_Data =			$A10003
HW_Port_2_Data =			$A10005
HW_Expansion_Data =			$A10007
HW_Port_1_Control =			$A10009
HW_Port_2_Control =			$A1000B
HW_Expansion_Control =		$A1000D
HW_Port_1_TxData =			$A1000F
HW_Port_1_RxData =			$A10011
HW_Port_1_SCtrl =			$A10013
HW_Port_2_TxData =			$A10015
HW_Port_2_RxData =			$A10017
HW_Port_2_SCtrl =			$A10019
HW_Expansion_TxData =		$A1001B
HW_Expansion_RxData =		$A1001D
HW_Expansion_SCtrl =		$A1001F

; ---------------------------------------------------------------------------
; Art tile stuff
flip_x              =      (1<<11)
flip_y              =      (1<<12)
palette_bit_0       =      5
palette_bit_1       =      6
palette_line_0      =      (0<<13)
palette_line_1      =      (1<<13)
palette_line_2      =      (2<<13)
palette_line_3      =      (3<<13)
high_priority_bit   =      7
high_priority       =      (1<<15)
palette_mask        =      $6000
tile_mask           =      $07FF
nontile_mask        =      $F800
drawing_mask        =      $7FFF

; ---------------------------------------------------------------------------
; VRAM and tile art base addresses.
; VRAM Reserved regions.
VRAM_Plane_A_Name_Table                  = $C000	; Extends until $CFFF
VRAM_Plane_B_Name_Table                  = $E000	; Extends until $EFFF
VRAM_Plane_A_Name_Table_2P               = $A000	; Extends until $AFFF
VRAM_Plane_B_Name_Table_2P               = $8000	; Extends until $8FFF
VRAM_Plane_Table_Size                    = $1000	; 64 cells x 32 cells x 2 bytes per cell
VRAM_Sprite_Attribute_Table              = $F800	; Extends until $FA7F
VRAM_Sprite_Attribute_Table_Size         = $0280	; 640 bytes
VRAM_Horiz_Scroll_Table                  = $FC00	; Extends until $FF7F
VRAM_Horiz_Scroll_Table_Size             = $0380	; 224 lines * 2 bytes per entry * 2 PNTs

; VRAM Reserved regions, Sega screen.
VRAM_SegaScr_Plane_A_Name_Table          = $C000	; Extends until $DFFF
VRAM_SegaScr_Plane_B_Name_Table          = $A000	; Extends until $BFFF
VRAM_SegaScr_Plane_Table_Size            = $2000	; 128 cells x 32 cells x 2 bytes per cell

; VRAM Reserved regions, Special Stage.
VRAM_SS_Plane_A_Name_Table1              = $C000	; Extends until $DFFF
VRAM_SS_Plane_A_Name_Table2              = $8000	; Extends until $9FFF
VRAM_SS_Plane_B_Name_Table               = $A000	; Extends until $BFFF
VRAM_SS_Plane_Table_Size                 = $2000	; 128 cells x 32 cells x 2 bytes per cell
VRAM_SS_Sprite_Attribute_Table           = $F800	; Extends until $FA7F
VRAM_SS_Sprite_Attribute_Table_Size      = $0280	; 640 bytes
VRAM_SS_Horiz_Scroll_Table               = $FC00	; Extends until $FF7F
VRAM_SS_Horiz_Scroll_Table_Size          = $0380	; 224 lines * 2 bytes per entry * 2 PNTs

; VRAM Reserved regions, Title screen.
VRAM_TtlScr_Plane_A_Name_Table           = $C000	; Extends until $CFFF
VRAM_TtlScr_Plane_B_Name_Table           = $E000	; Extends until $EFFF
VRAM_TtlScr_Plane_Table_Size             = $1000	; 64 cells x 32 cells x 2 bytes per cell

; VRAM Reserved regions, Ending sequence and credits.
VRAM_EndSeq_Plane_A_Name_Table           = $C000	; Extends until $DFFF
VRAM_EndSeq_Plane_B_Name_Table1          = $E000	; Extends until $EFFF (plane size is 64x32)
VRAM_EndSeq_Plane_B_Name_Table2          = $4000	; Extends until $5FFF
VRAM_EndSeq_Plane_Table_Size             = $2000	; 64 cells x 64 cells x 2 bytes per cell

; VRAM Reserved regions, menu screen.
VRAM_Menu_Plane_A_Name_Table             = $C000	; Extends until $CFFF
VRAM_Menu_Plane_B_Name_Table             = $E000	; Extends until $EFFF
VRAM_Menu_Plane_Table_Size               = $1000	; 64 cells x 32 cells x 2 bytes per cell

; From here on, art tiles are used; VRAM address is art tile * $20.
ArtTile_VRAM_Start                    = $0000

; Common to 1p and 2p menus.
ArtTile_ArtNem_FontStuff              = $0010

; Sega screen
ArtTile_ArtNem_Sega_Logo              = $0001
ArtTile_ArtNem_Trails                 = $0080
ArtTile_ArtUnc_Giant_Sonic            = $0088

; Title screen
ArtTile_ArtNem_Title                  = $0000
ArtTile_ArtNem_TitleSprites           = $0150
ArtTile_ArtNem_MenuJunk               = $03F2
ArtTile_ArtNem_Player1VS2             = $0402
ArtTile_ArtNem_CreditText             = $0500
ArtTile_ArtNem_FontStuff_TtlScr       = $0680

; Credits screen
ArtTile_ArtNem_CreditText_CredScr     = $0001

; Menu background.
ArtTile_ArtNem_MenuBox                = $0070

; Level select icons.
ArtTile_ArtNem_LevelSelectPics        = $0090

; 2p results screen.
ArtTile_ArtNem_1P2PWins               = $0070
ArtTile_ArtNem_SpecialPlayerVSPlayer  = $03DF
ArtTile_ArtNem_2p_Signpost            = $05E8
ArtTile_TwoPlayerResults              = $0600

; Special stage stuff.
ArtTile_ArtNem_SpecialEmerald         = $0174
ArtTile_ArtNem_SpecialMessages        = $01A2
ArtTile_ArtNem_SpecialHUD             = $01FA
ArtTile_ArtNem_SpecialFlatShadow      = $023C
ArtTile_ArtNem_SpecialDiagShadow      = $0262
ArtTile_ArtNem_SpecialSideShadow      = $029C
ArtTile_ArtNem_SpecialExplosion       = $02B5
ArtTile_ArtNem_SpecialSonic           = $02E5
ArtTile_ArtNem_SpecialTails           = $0300
ArtTile_ArtNem_SpecialTails_Tails     = $0316
ArtTile_ArtNem_SpecialRings           = $0322
ArtTile_ArtNem_SpecialStart           = $038A
ArtTile_ArtNem_SpecialBomb            = $038A
ArtTile_ArtNem_SpecialStageResults    = $0590
ArtTile_ArtNem_SpecialBack            = $0700
ArtTile_ArtNem_SpecialStars           = $077F
ArtTile_ArtNem_SpecialTailsText       = $07A4

; Ending.
ArtTile_EndingCharacter               = $0019
ArtTile_ArtNem_EndingFinalTornado     = $0156
ArtTile_ArtNem_EndingPics             = $0328
ArtTile_ArtNem_EndingMiniTornado      = $0493

; S1 Ending
ArtTile_ArtNem_S1EndFlicky            = $05A5
ArtTile_ArtNem_S1EndRabbit            = $0553
ArtTile_ArtNem_S1EndPenguin           = $0573
ArtTile_ArtNem_S1EndSeal              = $0585
ArtTile_ArtNem_S1EndPig               = $0593
ArtTile_ArtNem_S1EndChicken           = $0565
ArtTile_ArtNem_S1EndSquirrel          = $05B3

; Continue screen.
ArtTile_ArtNem_ContinueTails          = $0500
ArtTile_ArtNem_ContinueText           = $0500
ArtTile_ArtNem_ContinueText_2         = ArtTile_ArtNem_ContinueText + $24
ArtTile_ArtNem_MiniContinue           = $0524
ArtTile_ContinueScreen_Additional     = $0590
ArtTile_ContinueCountdown             = $06FC

; ---------------------------------------------------------------------------
; Level art stuff.
ArtTile_ArtKos_LevelArt               = $0000
ArtTile_ArtKos_NumTiles_EHZ           = $0393
ArtTile_ArtKos_NumTiles_CPZ           = $0364
ArtTile_ArtKos_NumTiles_ARZ           = $03F6
ArtTile_ArtKos_NumTiles_CNZ           = $0331
ArtTile_ArtKos_NumTiles_HTZ_Main      = $01FC ; Until this tile, equal to EHZ tiles.
ArtTile_ArtKos_NumTiles_HTZ_Sup       = $0183 ; Overwrites several EHZ tiles.
ArtTile_ArtKos_NumTiles_HTZ           = ArtTile_ArtKos_NumTiles_HTZ_Main + ArtTile_ArtKos_NumTiles_HTZ_Sup - 1
ArtTile_ArtKos_NumTiles_MCZ           = $03A9
ArtTile_ArtKos_NumTiles_OOZ           = $02AA
ArtTile_ArtKos_NumTiles_MTZ           = $0319
ArtTile_ArtKos_NumTiles_SCZ           = $036E
ArtTile_ArtKos_NumTiles_WFZ_Main      = $0307 ; Until this tile, equal to SCZ tiles.
ArtTile_ArtKos_NumTiles_WFZ_Sup       = $0073 ; Overwrites several SCZ tiles.
ArtTile_ArtKos_NumTiles_WFZ           = ArtTile_ArtKos_NumTiles_WFZ_Main + ArtTile_ArtKos_NumTiles_WFZ_Sup - 1
ArtTile_ArtKos_NumTiles_DEZ           = $0326 ; Skips several CPZ tiles.

; ---------------------------------------------------------------------------
; Shared badniks and objects.

; Objects that use the same art tiles on all levels in which
; they are loaded, even if not all levels load them.
ArtTile_ArtNem_WaterSurface           = $0400
ArtTile_ArtNem_Button                 = $0424
ArtTile_ArtNem_HorizSpike             = $042C
ArtTile_ArtNem_Spikes                 = $0434
ArtTile_ArtNem_DignlSprng             = $043C
ArtTile_ArtNem_LeverSpring            = $0440
ArtTile_ArtNem_VrtclSprng             = $045C
ArtTile_ArtNem_HrzntlSprng            = $0470

; EHZ, HTZ
ArtTile_ArtKos_Checkers               = ArtTile_ArtKos_LevelArt+$0158
ArtTile_ArtUnc_Flowers1               = $0394
ArtTile_ArtUnc_Flowers2               = $0396
ArtTile_ArtUnc_Flowers3               = $0398
ArtTile_ArtUnc_Flowers4               = $039A
ArtTile_ArtNem_Buzzer                 = $03D2

; WFZ, SCZ
ArtTile_ArtNem_WfzHrzntlPrpllr        = $03CD
ArtTile_ArtNem_Clouds                 = $054F
ArtTile_ArtNem_WfzVrtclPrpllr         = $0561
ArtTile_ArtNem_Balkrie                = $0565

; ---------------------------------------------------------------------------
; Level-specific objects and badniks.

; EHZ
ArtTile_ArtUnc_EHZPulseBall           = $039C
ArtTile_ArtNem_Waterfall              = $039E
ArtTile_ArtNem_EHZ_Bridge             = $03B6
ArtTile_ArtNem_Buzzer_Fireball        = $03BE	; Actually unused
ArtTile_ArtNem_Coconuts               = $03EE
ArtTile_ArtNem_Masher                 = $0414
ArtTile_ArtUnc_EHZMountains           = $0500

; MTZ
ArtTile_ArtNem_Shellcracker           = $031C
ArtTile_ArtUnc_Lava                   = $0340
ArtTile_ArtUnc_MTZCylinder            = $034C
ArtTile_ArtUnc_MTZAnimBack_1          = $035C
ArtTile_ArtUnc_MTZAnimBack_2          = $0362
ArtTile_ArtNem_MtzSupernova           = $0368
ArtTile_ArtNem_MtzWheel               = $0378
ArtTile_ArtNem_MtzWheelIndent         = $03F0
ArtTile_ArtNem_LavaCup                = $03F9
ArtTile_ArtNem_BoltEnd_Rope           = $03FD
ArtTile_ArtNem_MtzSteam               = $0405
ArtTile_ArtNem_MtzSpikeBlock          = $0414
ArtTile_ArtNem_MtzSpike               = $041C
ArtTile_ArtNem_MtzMantis              = $043C
ArtTile_ArtNem_MtzAsstBlocks          = $0500
ArtTile_ArtNem_MtzLavaBubble          = $0536
ArtTile_ArtNem_MtzCog                 = $055F
ArtTile_ArtNem_MtzSpinTubeFlash       = $056B

; WFZ
ArtTile_ArtNem_WfzScratch             = $0379
ArtTile_ArtNem_WfzTiltPlatforms       = $0393
ArtTile_ArtNem_WfzVrtclLazer          = $039F
ArtTile_ArtNem_WfzWallTurret          = $03AB
ArtTile_ArtNem_WfzHrzntlLazer         = $03C3
ArtTile_ArtNem_WfzConveyorBeltWheel   = $03EA
ArtTile_ArtNem_WfzHook                = $03FA
ArtTile_ArtNem_WfzHook_Fudge          = ArtTile_ArtNem_WfzHook + 4 ; Bad mappings...
ArtTile_ArtNem_WfzBeltPlatform        = $040E
ArtTile_ArtNem_WfzGunPlatform         = $041A
ArtTile_ArtNem_WfzUnusedBadnik        = $0450
ArtTile_ArtNem_WfzLaunchCatapult      = $045C
ArtTile_ArtNem_WfzSwitch              = $0461
ArtTile_ArtNem_WfzThrust              = $0465
ArtTile_ArtNem_WfzFloatingPlatform    = $046D
ArtTile_ArtNem_BreakPanels            = $048C

; SCZ
ArtTile_ArtNem_Turtloid               = $038A
ArtTile_ArtNem_Nebula                 = $036E

; HTZ
ArtTile_ArtNem_Rexon                  = $037E
ArtTile_ArtNem_HtzFireball1           = $039E
ArtTile_ArtNem_HtzRock                = $03B2
ArtTile_ArtNem_HtzSeeSaw              = $03C6
ArtTile_ArtNem_Sol                    = $03DE
ArtTile_ArtNem_HtzZipline             = $03E6
ArtTile_ArtNem_HtzFireball2           = $0416
ArtTile_ArtNem_HtzValveBarrier        = $0426
ArtTile_ArtUnc_HTZMountains           = $0500
ArtTile_ArtUnc_HTZClouds              = ArtTile_ArtUnc_HTZMountains + $18
ArtTile_ArtNem_Spiker                 = $0520

; OOZ
ArtTile_ArtUnc_OOZPulseBall           = $02B6
ArtTile_ArtUnc_OOZSquareBall1         = $02BA
ArtTile_ArtUnc_OOZSquareBall2         = $02BE
ArtTile_ArtUnc_Oil1                   = $02C2
ArtTile_ArtUnc_Oil2                   = $02D2
ArtTile_ArtNem_OOZBurn                = $02E2
ArtTile_ArtNem_OOZElevator            = $02F4
ArtTile_ArtNem_SpikyThing             = $030C
ArtTile_ArtNem_BurnerLid              = $032C
ArtTile_ArtNem_StripedBlocksVert      = $0332
ArtTile_ArtNem_Oilfall                = $0336
ArtTile_ArtNem_Oilfall2               = $0346
ArtTile_ArtNem_BallThing              = $0354
ArtTile_ArtNem_LaunchBall             = $0368
ArtTile_ArtNem_OOZPlatform            = $039D
ArtTile_ArtNem_PushSpring             = $03C5
ArtTile_ArtNem_OOZSwingPlat           = $03E3
ArtTile_ArtNem_StripedBlocksHoriz     = $03FF
ArtTile_ArtNem_OOZFanHoriz            = $0403
ArtTile_ArtNem_Aquis                  = $0500
ArtTile_ArtNem_Octus                  = $0538

; MCZ
ArtTile_ArtNem_Flasher                = $03A8
ArtTile_ArtNem_Crawlton               = $03C0
ArtTile_ArtNem_Crate                  = $03D4
ArtTile_ArtNem_MCZCollapsePlat        = $03F4
ArtTile_ArtNem_VineSwitch             = $040E
ArtTile_ArtNem_VinePulley             = $041E
ArtTile_ArtNem_MCZGateLog             = $043C

; CNZ
ArtTile_ArtNem_Crawl                  = $0340
ArtTile_ArtNem_BigMovingBlock         = $036C
ArtTile_ArtNem_CNZSnake               = $037C
ArtTile_ArtNem_CNZBonusSpike          = $0380
ArtTile_ArtNem_CNZElevator            = $0384
ArtTile_ArtNem_CNZCage                = $0388
ArtTile_ArtNem_CNZHexBumper           = $0394
ArtTile_ArtNem_CNZRoundBumper         = $039A
ArtTile_ArtNem_CNZFlipper             = $03B2
ArtTile_ArtNem_CNZMiniBumper          = $03E6
ArtTile_ArtNem_CNZDiagPlunger         = $0402
ArtTile_ArtNem_CNZVertPlunger         = $0422

; Specific to 1p CNZ
ArtTile_ArtUnc_CNZFlipTiles_1         = $0330
ArtTile_ArtUnc_CNZFlipTiles_2         = $0540
ArtTile_ArtUnc_CNZSlotPics_1          = $0550
ArtTile_ArtUnc_CNZSlotPics_2          = $0560
ArtTile_ArtUnc_CNZSlotPics_3          = $0570

; Specific to 2p CNZ
ArtTile_ArtUnc_CNZFlipTiles_1_2p      = $0330
ArtTile_ArtUnc_CNZFlipTiles_2_2p      = $0740
ArtTile_ArtUnc_CNZSlotPics_1_2p       = $0750
ArtTile_ArtUnc_CNZSlotPics_2_2p       = $0760
ArtTile_ArtUnc_CNZSlotPics_3_2p       = $0770

; CPZ
ArtTile_ArtUnc_CPZAnimBack            = $0370
ArtTile_ArtNem_CPZMetalThings         = $0373
ArtTile_ArtNem_ConstructionStripes_2  = $0394
ArtTile_ArtNem_CPZBooster             = $039C
ArtTile_ArtNem_CPZElevator            = $03A0
ArtTile_ArtNem_CPZAnimatedBits        = $03B0
ArtTile_ArtNem_CPZTubeSpring          = $03E0
ArtTile_ArtNem_CPZStairBlock          = $0418
ArtTile_ArtNem_CPZMetalBlock          = $0430
ArtTile_ArtNem_CPZDroplet             = $043C
ArtTile_ArtNem_Grabber                = $0500
ArtTile_ArtNem_Spiny                  = $052D

; DEZ
ArtTile_ArtUnc_DEZAnimBack            = $0326
ArtTile_ArtNem_ConstructionStripes_1  = $0328

; ARZ
ArtTile_ArtNem_ARZBarrierThing        = $03F8
ArtTile_ArtNem_Leaves                 = $0410
ArtTile_ArtNem_ArrowAndShooter        = $0417
ArtTile_ArtUnc_Waterfall3             = $0428
ArtTile_ArtUnc_Waterfall2             = $042C
ArtTile_ArtUnc_Waterfall1_1           = $0430
ArtTile_ArtNem_Whisp                  = $0500
ArtTile_ArtNem_Grounder               = $0509
ArtTile_ArtNem_ChopChop               = $053B
ArtTile_ArtUnc_Waterfall1_2           = $0557
ArtTile_ArtNem_BigBubbles             = $055B

; ---------------------------------------------------------------------------
; Bosses
; Common tiles for some bosses (any for which no eggpod tiles are defined,
; except for WFZ and DEZ bosses).
ArtTile_ArtNem_Eggpod_4               = $0500
; Common tiles for all bosses.
ArtTile_ArtNem_FieryExplosion         = $0580

; CPZ boss
ArtTile_ArtNem_EggpodJets_1           = $0418
ArtTile_ArtNem_Eggpod_3               = $0420
ArtTile_ArtNem_CPZBoss                = $0500
ArtTile_ArtNem_BossSmoke_1            = $0570

; EHZ boss
ArtTile_ArtNem_Eggpod_1               = $03A0
ArtTile_ArtNem_EHZBoss                = $0400
ArtTile_ArtNem_EggChoppers            = $056C

; HTZ boss
ArtTile_ArtNem_Eggpod_2               = $03C1
ArtTile_ArtNem_HTZBoss                = $0421
ArtTile_ArtNem_BossSmoke_2            = $05E4

; ARZ boss
ArtTile_ArtNem_ARZBoss                = $03E0

; MCZ boss
ArtTile_ArtNem_MCZBoss                = $03C0
ArtTile_ArtUnc_FallingRocks           = $0560

; CNZ boss
ArtTile_ArtNem_CNZBoss                = $0407
ArtTile_ArtNem_CNZBoss_Fudge          = ArtTile_ArtNem_CNZBoss - $60 ; Badly reused mappings...

; MTZ boss
ArtTile_ArtNem_MTZBoss                = $037C
ArtTile_ArtNem_EggpodJets_2           = $0560

; OOZ boss
ArtTile_ArtNem_OOZBoss                = $038C

; WFZ and DEZ
ArtTile_ArtNem_RobotnikUpper          = $0500
ArtTile_ArtNem_RobotnikRunning        = $0518
ArtTile_ArtNem_RobotnikLower          = $0564

; WFZ boss
ArtTile_ArtNem_WFZBoss                = $0379

; DEZ
ArtTile_ArtNem_DEZBoss                = $0330
ArtTile_ArtNem_DEZWindow              = $0378
ArtTile_ArtNem_SilverSonic            = $0380

; ---------------------------------------------------------------------------
; Universal locations.

; Animals.
ArtTile_ArtNem_Animal_1               = $0580
ArtTile_ArtNem_Animal_2               = $0594

; Game over.
ArtTile_ArtNem_Game_Over              = $04DE

; Titlecard.
ArtTile_ArtNem_TitleCard              = $0580
ArtTile_LevelName                     = $05DE

; End of level.
ArtTile_ArtNem_Signpost               = $0434
ArtTile_HUD_Bonus_Score               = $0520
ArtTile_ArtNem_Perfect                = $0540
ArtTile_ArtNem_ResultsText            = $05B0
ArtTile_ArtUnc_Signpost               = $05E8
ArtTile_ArtNem_MiniCharacter          = $05F4
ArtTile_ArtNem_Capsule                = $0680

; Tornado.
ArtTile_ArtNem_Tornado                = $0500
ArtTile_ArtNem_TornadoThruster        = $0561

; Some common objects; these are loaded on all aquatic levels.
ArtTile_ArtNem_Explosion              = $05A4
ArtTile_ArtNem_Bubbles                = $05E8
ArtTile_ArtNem_SuperSonic_stars       = $05F2

; Universal (used on all standard levels).
ArtTile_ArtNem_Checkpoint             = $047C
ArtTile_ArtNem_TailsDust              = $048C
ArtTile_ArtNem_SonicDust              = $049C
ArtTile_ArtNem_Numbers                = $04AC
ArtTile_ArtNem_Shield                 = $04BE
ArtTile_ArtNem_Invincible_stars       = $04DE
ArtTile_ArtNem_Powerups               = $0680
ArtTile_ArtNem_Ring                   = $06BC
ArtTile_ArtNem_HUD                    = ArtTile_ArtNem_Powerups + $4A
ArtTile_ArtUnc_Sonic                  = $0780
ArtTile_ArtUnc_Tails                  = $07A0
ArtTile_ArtUnc_Tails_Tails            = $07B0

; ---------------------------------------------------------------------------
; HUD. The HUD components are linked in a chain, and linked to
; power-ups, because the mappings of monitors and lives counter(s)
; depend on one another. If you want to alter these (for example,
; because you need the VRAM for something else), you will probably
; have to edit the mappings (or move the power-ups and HUD as a
; single block unit).
ArtTile_HUD_Score_E                   = ArtTile_ArtNem_HUD + $18
ArtTile_HUD_Score                     = ArtTile_HUD_Score_E + 2
ArtTile_HUD_Rings                     = ArtTile_ArtNem_HUD + $30
ArtTile_HUD_Minutes                   = ArtTile_ArtNem_HUD + $28
ArtTile_HUD_Seconds                   = ArtTile_HUD_Minutes + 4
ArtTile_ArtUnc_2p_life_counter        = ArtTile_ArtNem_HUD + $2A
ArtTile_ArtUnc_2p_life_counter_lives  = ArtTile_ArtUnc_2p_life_counter + 9
ArtTile_ArtNem_life_counter           = ArtTile_ArtNem_HUD + $10A
ArtTile_ArtNem_life_counter_lives     = ArtTile_ArtNem_life_counter + 9

; ---------------------------------------------------------------------------
; 2p-mode HUD.
ArtTile_Art_HUD_Text_2P               = ArtTile_ArtNem_HUD
ArtTile_Art_HUD_Numbers_2P            = ArtTile_HUD_Score_E

; ---------------------------------------------------------------------------
; Unused objects, objects with mappings never loaded, objects with
; missing mappings and/or tiles, objects whose mappings and/or tiles
; are never loaded.
ArtTile_ArtNem_MZ_Platform            = $02B8
ArtTile_ArtUnc_HPZPulseOrb_1          = $02E8
ArtTile_ArtUnc_HPZPulseOrb_2          = $02F0
ArtTile_ArtUnc_HPZPulseOrb_3          = $02F8
ArtTile_ArtNem_HPZ_Bridge             = $0300
ArtTile_ArtNem_HPZ_Waterfall          = $0315
ArtTile_ArtNem_HPZPlatform            = $034A
ArtTile_ArtNem_HPZOrb                 = $035A
ArtTile_ArtNem_HPZ_Emerald            = $0392
ArtTile_ArtNem_GHZ_Spiked_Log         = $0398
ArtTile_ArtNem_Unknown                = $03FA
ArtTile_ArtNem_BigRing                = $0400
ArtTile_ArtNem_FloatPlatform          = $0418
ArtTile_ArtNem_BigRing_Flash          = $0462
ArtTile_ArtNem_EndPoints              = $04B6
ArtTile_ArtNem_BreakWall              = $0590
ArtTile_ArtNem_GHZ_Purple_Rock        = $06C0

