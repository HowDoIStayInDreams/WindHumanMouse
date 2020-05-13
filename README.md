# WindHumanMouse

`#include WindHumanMouse.ahk` always include this in your script and put it in the same directory

* Normal usage

```autohotkey
MoveMouse(100, 200)
MoveMouse(100, 200, 0.6)        0.6 here is optional speed parameter. Default value:= 0.57
                                 from 0.45 (slow) to 0.7 (fast)
```

* Relative destination usage

```autohotkey
MoveMouse(100, 200,, "RD")
MoveMouse(100, 200, 0.6, "RD")  0.6 here is optional speed parameter. Default value:= 0.57
                                 from 0.45 (slow) to 0.7 (fast)
```
