;Init script
SetWinDelay, 0
TOOLTIPNUM := 15
CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen

; Create Win-RightClick window draging
#LButton:: MoveWindow("LButton")

; Create Win-RightClick to resize window
#RButton:: ResizeWindow("RButton")

;Call to move window under the mouse until 'move_key' is released
MoveWindow(moveKey)
{
	;Get window under mouse
	MouseGetPos,,, winID
	
	;Restore window if Maximized
	WinRestore, ahk_id %windowID%

	;Get inital mouse position
	MouseGetPos, mX, mY
	
	;Loop until mouse button is released
    Loop
    {
        GetKeystate, pressed, %moveKey%, P
		if pressed = U
        {
			ToolTip,,,, TOOLTIPNUM
		    break
        }

		WinGetPos, winX, winY,,, ahk_id %winID%
        MouseGetPos, newX, newY
        
		WinMove, ahk_id %winID%,,winX - (mX - newX), winY -(mY - newY)
		
		;Save new mouse location
		mX := newX
		mY := newY

		ShowWindowPosition(winID)

		sleep 5
    }
	
	return
}

;Call to resize the window
ResizeWindow(moveKey)
{
	;Get window under mouse
	MouseGetPos,,, winID
	
	;Restore window if Maximized
	WinRestore, ahk_id %windowID%

	;Get inital mouse position
	MouseGetPos, mX, mY
	
	;Loop until Mouse button is released
    Loop
    {
        GetKeystate, pressed, %moveKey%, P
		if pressed = U
        {
			ToolTip,,,, TOOLTIPNUM
		    break
        }

		WinGetPos, winX, winY, winH, winL, ahk_id %winID%
        MouseGetPos, newX, newY
        
		WinMove, ahk_id %winID%,,,,winH - (mX - newX), winL - (mY - newY)
		
		;Save new mouse location
		mX := newX
		mY := newY

		ShowWindowSize(winID)

		sleep 5
    }
	
	return
}

;Show where the window is currently
ShowWindowPosition(winID)
{
	;Get Window Location
	WinGetPos, x, y, w, h, ahk_id %winID%
	
	;Place ToolTip in center of window
	ToolTip, `(%x%`,%y%`), x + w/2, y + h/2, TOOLTIPNUM
	
}

;Show the window's size
ShowWindowSize(winID)
{	
;Get Window Size
	WinGetPos, x, y, w, h, ahk_id %winID%
	
	;Place ToolTip in center of window
	ToolTip, `(%w%x%h%`), x + w/2, y + h/2, TOOLTIPNUM

}