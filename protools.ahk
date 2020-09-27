#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Make sure script is running as Admin so Protools can't screw up its keyboard access
if !A_IsAdmin || !(DllCall("GetCommandLine","Str")~=" /restart(?!\S)")
    Try RunWait % "*RunAs """ (A_IsCompiled?A_ScriptFullPath """ /restart":A_AhkPath """ /restart """ A_ScriptFullPath """")
if !A_IsAdmin {
    MsgBox, Script requires admin priveleges. Exiting script.
    ExitApp
}

; Bind Ctrl-Shift-F to Time Operations > Insert Time
^+f::
	#IfWinActive Pro Tools
		WinMenuSelectItem, Pro Tools, , Event, Time Operations, Insert Time...
		Send {Enter}
		WinClose, Time Operations
		return
	
; Bind Ctrl-Shift-F to Time Operations > Cut Time
^+d::
	#IfWinActive Pro Tools
		WinMenuSelectItem, Pro Tools, , Event, Time Operations, Cut Time...
		Send {Enter}
		WinClose, Time Operations
		return

; Bind Mouse 4 to Backspace
#IfWinActive Pro Tools
	XButton1::Send {Backspace}
	
; Bind Shift Mouse 4 to Cut Time
#IfWinActive Pro Tools
	+XButton1::
		WinMenuSelectItem, Pro Tools, , Event, Time Operations, Cut Time...
		Send {Enter}
		WinClose, Time Operations
		return

; Bind Ctrl Mouse 4 to Insert Time
#IfWinActive Pro Tools
	^XButton1::
		WinMenuSelectItem, Pro Tools, , Event, Time Operations, Insert Time...
		Send {Enter}
		WinClose, Time Operations
		return


; Bind Mouse 5 to Add Marker
#IfWinActive Pro Tools
	XButton2::Send {NumpadEnter}


; Bind Shift-Mouse 5 to Add Marker "C"
#IfWinActive Pro Tools
	+XButton2::
		Send {NumpadEnter}
		Send C
		Send {Enter}