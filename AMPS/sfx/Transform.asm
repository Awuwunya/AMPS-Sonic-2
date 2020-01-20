	sHeaderInitSFX						; Z80 offset is $FBC2
	sHeaderPrio	$78
	sHeaderCh	$03
	sHeaderSFX	$80, ctFM5, .FM5, $00, $00
	sHeaderSFX	$A1, ctPSG3, Transform_PSG3, $00+$0C, $00
	sHeaderSFX	$A1, ctPSG2, Transform_PSG2, $00+$0C, $00

.FM5
	sVoice		pDash
	ssMod68k	$00, $01, $C5, $1A
	dc.b nE6, $07
	saVol		$0A
	dc.b nRst, $06
	sVoice		pTransform2
	ssMod68k	$00, $01, $11, $FF
	dc.b nA2, $28

.Loop1
	dc.b sHold, $03
	saVol		$03
	sLoop		$00, $05, .Loop1
	sStop

Transform_PSG3	label *			; Yes, AS is this bad. I have to do it because of course
	dc.b nRst, $07
	ssMod68k	$00, $02, $05, $FF
	sNoisePSG	$E7
	dc.b nBb4, $1D

.Loop2
	dc.b sHold, $07
	saVol		$08
	sLoop		$00, $10, .Loop2
	sStop

Transform_PSG2	label *			; Yes, AS is this bad. I have to do it because of course
	dc.b nRst, $16
	sVolEnv		v03

.Loop3
	dc.b nD5, $04, nE5, nFs5
	saVol		$08
	saTranspose	$FF
	sLoop		$00, $05, .Loop3

.Loop4
	dc.b nD5, $04, nE5, nFs5
	saVol		$08
	saTranspose	$01
	sLoop		$00, $07, .Loop4
	sStop
