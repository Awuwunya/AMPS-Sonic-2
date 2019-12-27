	sHeaderInit
	sHeaderPrio	$70
	sHeaderCh	$01
	sHeaderSFX	$80, ctFM5, .FM5, $00, $05

.FM5	sPan	spRight
	sVoice	pRings

SFX_Ring1 label *
	dc.b nE5, $04, nG5, $05, nC6, $1B
	sStop
