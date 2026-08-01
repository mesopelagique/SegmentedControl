//%attributes = {"shared":true}
// Open the demo. Click a segment; the pill glides to it.
#DECLARE

var $window : Integer
$window:=Open form window("Demo"; Plain form window; Horizontally centered; Vertically centered)
DIALOG("Demo")
CLOSE WINDOW($window)
