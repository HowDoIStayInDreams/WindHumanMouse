#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#include WindHumanMouse.ahk

F12::
MoveMouse(-100, 100,, "RD")
;MoveMouse(-100, 100, 0.5, "RD")
Return

F11::
MoveMouse(600, 400)
;MoveMouse(600, 400, 0.5)
Return
