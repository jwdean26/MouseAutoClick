;MyAutoClick Parameters

;Check if the INI file exists
if FileExist("MyAutoClick.ini")
	{
	;Read values from the INI file
	IniRead, WaitTime, MyAutoClick.ini, Settings, WaitTime
	IniRead, PollingTime, MyAutoClick.ini, Settings, PollingTime
	IniRead, Hkey, MyAutoClick.ini, Settings, Hotkey
	}

;Create the MyAutoClickParameters dialog
Gui +Resize
Gui, Font, s14 w700, Arial
Gui, Add, Text,, Please enter the wait time (in milliseconds) the mouse cursor must pause before an autoclick occurs:
Gui, Add, Text,, Example: 1000 = 1 second
Gui, Add, Text,, Please enter the time (in milliseconds) MyAutoClick checks to see if the mouse cursor is moving or stationary:
Gui, Add, Text,, 10 milliseconds should be a good time for most systems.
Gui, Add, Text,, Please enter the hotkey sequence used to toggle MyAutoClick on and off:
Gui, Add, Text,, Examples: F10, Shift+Ctrl+Alt+S, etc.

Gui, Add, Edit, vWaitTime ym, %WaitTime%
Gui, Add, Text,,
Gui, Add, Edit, vPollingTime, %PollingTime%
Gui, Add, Text,,
Gui, Add, Hotkey, vHkey, %Hkey%
Gui, Add, Text,,
Gui, Add, Button, default, OK
Gui, Show, AutoSize Center, MyAutoClick Parameters

return

ButtonOK:
{
ErrorLevel := 0
Gui, Submit, NoHide
IniWrite, %WaitTime%, MyAutoClick.ini, Settings, WaitTime
If ErrorLevel
	MsgBox, There was an error writing WaitTime to MyAutoClick.ini file.
IniWrite, %PollingTime%, MyAutoClick.ini, Settings, PollingTime
If ErrorLevel
	MsgBox, There was an error writing PollingTime to MyAutoClick.ini file.
IniWrite, %Hkey%, MyAutoClick.ini, Settings, Hotkey
If ErrorLevel
	MsgBox, There was an error writing Hkey to MyAutoClick.ini file.
}

GuiEscape:
GuiClose:
ExitApp