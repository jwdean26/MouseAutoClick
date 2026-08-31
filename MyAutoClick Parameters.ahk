;MyAutoClick Parameters
if FileExist("MyAutoClick.ini")
{
    IniRead, WaitTime, MyAutoClick.ini, Settings, WaitTime
    IniRead, PollingTime, MyAutoClick.ini, Settings, PollingTime
    IniRead, Hkey, MyAutoClick.ini, Settings, Hotkey
}

Gui +Resize
Gui, Font, s14 w700, Arial
Gui, Add, Text, vLbl1, Please enter the wait time (in milliseconds) the mouse cursor must pause before an autoclick occurs:
Gui, Add, Text, vLbl2, Example: 1000 = 1 second
Gui, Add, Text, vLbl3, Please enter the time (in milliseconds) MyAutoClick checks to see if the mouse cursor is moving or stationary:
Gui, Add, Text, vLbl4, 10 milliseconds should be a good time for most systems.
Gui, Add, Text, vLbl5, Please enter the hotkey sequence used to toggle MyAutoClick on and off:
Gui, Add, Text, vLbl6, Examples: F10, Shift+Ctrl+Alt+S, etc.
Gui, Add, Edit, vWaitTime ym w200, %WaitTime%
Gui, Add, Text,,
Gui, Add, Edit, vPollingTime w200, %PollingTime%
Gui, Add, Text,,
Gui, Add, Hotkey, vHkey w200, %Hkey%
Gui, Add, Text,,
Gui, Add, Button, vBtnOK default, OK
Gui, Show, AutoSize Center, MyAutoClick Parameters

; --- Capture the natural (autosized) layout as our baseline ---
GuiControlGet, OrigLbl1, Pos, Lbl1
GuiControlGet, OrigLbl2, Pos, Lbl2
GuiControlGet, OrigLbl3, Pos, Lbl3
GuiControlGet, OrigLbl4, Pos, Lbl4
GuiControlGet, OrigLbl5, Pos, Lbl5
GuiControlGet, OrigLbl6, Pos, Lbl6
GuiControlGet, OrigWaitTime, Pos, WaitTime
GuiControlGet, OrigPollingTime, Pos, PollingTime
GuiControlGet, OrigHkey, Pos, Hkey
GuiControlGet, OrigBtnOK, Pos, BtnOK
WinGetPos, , , OrigWinW, OrigWinH, A
return

GuiSize:
if (A_EventInfo = 1) ; ignore minimize
    return

newW := A_GuiWidth
newH := A_GuiHeight

; Enforce a minimum size ourselves — snap back up if shrunk too far
needSnap := false
if (newW < OrigWinW)
{
    newW := OrigWinW
    needSnap := true
}
if (newH < OrigWinH)
{
    newH := OrigWinH
    needSnap := true
}
if (needSnap)
    WinMove, A, , , , %newW%, %newH%

deltaW := newW - OrigWinW
deltaH := newH - OrigWinH

GuiControl, Move, Lbl1,        % "w" (OrigLbl1W + deltaW)
GuiControl, Move, Lbl2,        % "w" (OrigLbl2W + deltaW)
GuiControl, Move, Lbl3,        % "w" (OrigLbl3W + deltaW)
GuiControl, Move, Lbl4,        % "w" (OrigLbl4W + deltaW)
GuiControl, Move, Lbl5,        % "w" (OrigLbl5W + deltaW)
GuiControl, Move, Lbl6,        % "w" (OrigLbl6W + deltaW)
GuiControl, Move, WaitTime,    % "w" (OrigWaitTimeW + deltaW)
GuiControl, Move, PollingTime, % "w" (OrigPollingTimeW + deltaW)
GuiControl, Move, Hkey,        % "w" (OrigHkeyW + deltaW)

GuiControl, Move, BtnOK, % "y" (OrigBtnOKY + deltaH)

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