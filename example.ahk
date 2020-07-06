#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#include WindHumanMouse.ahk

F12::
;relative destination usage
MoveMouse(-100, 100,, "RD")
;MoveMouse(-100, 100, 0.5, "RD")
Return

F11::
;normal usage
MoveMouse(600, 400)
;MoveMouse(600, 400, 0.5)
Return
