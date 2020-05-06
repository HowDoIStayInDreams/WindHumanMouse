#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#include WindHumanMouse.ahk

F12::
MoveMouse(-100, 100, "RD")
Return

F11::
MoveMouse(600, 400)
Return