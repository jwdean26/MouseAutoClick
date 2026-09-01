;MyAutoClick - An AutoHotKey script to automate a left mouse click when the mouse cursor stops moving for a specified time.
#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetBatchLines -1
CoordMode Mouse

IniRead WaitTime, MyAutoClick.ini, Settings, WaitTime
IniRead PollingTime, MyAutoClick.ini, Settings, PollingTime
IniRead Hkey, MyAutoClick.ini, Settings, Hotkey
IniRead MouseClick, MyAutoClick.ini, Settings, MouseClick

Hotkey %Hkey%, runMyAutoClick
Toggle := False ;Initialize MyAutoClick off
Menu, Tray, Icon, Red.ico ;Initialize MyAutoClick icon to a red mouse cursor icon.

return

runMyAutoClick:
ClickedAlready := True
Toggle := !Toggle

if Toggle ;MyAutoClick is enabled
	Menu, Tray, Icon, Green.ico ;Set MyAutoClick icon to a green mouse cursor icon.
else 
{
	Menu, Tray, Icon, Red.ico ;Set MyAutoClick icon to a red mouse cursor icon.
	return
}

;Main loop to click the mouse cursor if MyAutoClick is toggled on and the mouse cursor has stopped moving.
Loop
{
	If not Toggle
		break
	
	if (!MouseMoved(PollingTime))
	{
		if (!ClickedAlready and !MouseMoved(WaitTime - PollingTime))
		{
			ClickedAlready := True
			IniRead MouseClick, MyAutoClick.ini, Settings, MouseClick

			if (MouseClick = "Right")
			{
				Click, Right
			}
			else if (MouseClick = "Double")
			{
				Click, 2
			}
			else
			{
				Click
			}
		}
	} else 
	{
		ClickedAlready := False
	}
}
return

;Compare current mouse cursor position with previous mouse cursor position to determine if the mouse cursor has moved or not.
MouseMoved(delay)	
{
	MouseGetPos, X1, Y1
	Sleep % delay
	MouseGetPos, X2, Y2
	return (X1 != X2) or (Y1 != Y2)
}