/*
SegmentedControl — an animated segmented picker for 4D forms, driven by Hero (cs.hero).

This is matchedGeometryEffect done straight. One "pill" rectangle marks the
selected segment; choosing another tweens the pill to that segment's own box. The
segments can be different widths — the pill reads each target's geometry from the
form and matches it, so nothing has to be hard-coded here.

Each segment is three form objects sharing a box: a hidden marker seg_<i> (the
geometry the pill flies to), a label lbl_<i>, and a transparent segbtn_<i> for the
click. Store the instance in Form.control.
*/

property transition : cs.hero.ElementTransition
property count : Integer
property selected : Integer
property pad : Integer:=4          // pill inset inside a segment box

// Selected vs unselected label ink
property selInk : Integer:=0x001E2A38
property dimInk : Integer:=0x006B7480

Class constructor($transition : cs.hero.ElementTransition)

	This.transition:=$transition
	This.count:=This._segmentCount()
	This.selected:=1

	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Move the selection to segment $i (1-based)
Function select($i : Integer)

	If (($i<1) || ($i>This.count) || ($i=This.selected))

		return

	End if

	// The pill flies to the chosen segment's own box, inset by pad
	var $seg:=cs.hero.ElementState.new("seg_"+String($i))

	This.transition.animate("pill")\
		.to({left: $seg.left+This.pad; top: $seg.top; width: $seg.width-(2*This.pad); height: $seg.height})\
		.duration(280)\
		.easing("easeInOutCubic")\
		.start()

	// Recolour the labels: the chosen one darkens, the previous one dims
	This._setInk("lbl_"+String($i); This.selInk)
	This._setInk("lbl_"+String(This.selected); This.dimInk)

	OBJECT SET TITLE(*; "content"; OBJECT Get title(*; "lbl_"+String($i)))

	This.selected:=$i

	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Change only the text colour, leaving the label's own background exactly as it is
Function _setInk($name : Text; $ink : Integer)

	var $foreground; $background : Integer
	OBJECT GET RGB COLORS(*; $name; $foreground; $background)
	OBJECT SET RGB COLORS(*; $name; $ink; $background)

	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _segmentCount() : Integer

	var $n : Integer:=0

	While (OBJECT Get type(*; "seg_"+String($n+1))#Object type unknown)

		$n:=$n+1

	End while

	return $n
