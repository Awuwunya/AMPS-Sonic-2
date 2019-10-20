	sHeaderInit						; Z80 offset is $F59A
	sHeaderPrio	$70
	sHeaderCh	$02
	sHeaderSFX	$80, ctFM5, .FM5, $00, $00
	sHeaderSFX	$A1, ctPSG3, .PSG3, $00+$0C, $02

.FM5
	ssMod68k	$02, $01, $72, $0B
	sVoice		pBreak
	dc.b nA4, $16
	sStop

.PSG3
	sVolEnv		v01
	sNoisePSG	$E7
	dc.b nB3, $1B
	sStop
