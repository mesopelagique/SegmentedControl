// The indicator glides to the chosen segment, animated by the cs.hero engine

Case of

		//______________________________________________________
	: (Form event code=On Load)

		Form.transition:=cs.hero.ElementTransition.new()
		Form.control:=cs.SegmentedControl.new(Form.transition)

		//______________________________________________________
	: (Form event code=On Timer)

		Form.transition.onTimer()

		//______________________________________________________
	: (Form event code=On Clicked)

		If (Position("segbtn_"; FORM Event.objectName)=1)

			Form.control.select(Num(Substring(FORM Event.objectName; 8)))

		End if

		//______________________________________________________
	: (Form event code=On Unload)

		SET TIMER(0)

		//______________________________________________________
End case
