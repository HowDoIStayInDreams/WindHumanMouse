# WindHumanMouse

`#include WindHumanMouse.ahk` always include this in your script and put it in the same directory

* Normal usage

```autohotkey
MoveMouse(100, 200)
MoveMouse(100, 200, 0.55)        0.55 here is optional speed parameter. Default value:= 0.6
                                 from 0.45 (slow) to 0.7 (fast)
```

* Relative destination usage

```autohotkey
MoveMouse(100, 200,, "RD")
MoveMouse(100, 200, 0.55, "RD")  0.55 here is optional speed parameter. Default value:= 0.6
                                 from 0.45 (slow) to 0.7 (fast)
```
* Known issues:

If mouse moves abnormally fast or slow, try commenting
SetMouseDelay -1 in WindHumanMouse.ahk

Update AHK to the latest version
