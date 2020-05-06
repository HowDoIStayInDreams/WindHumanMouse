# WindHumanMouse

Make sure you do #include WindHumanMouse.ahk in your script and put it in same directory

Normal usage:

MoveMouse(100,200)

Relative destination usage:

MoveMouse(100,200,"RD")

xs: starting mouse position's X coordinate
ys: starting mouse position's Y coordinate
xe: ending mouse position's X coordinate
ye: ending mouse position's Y coordinate
gravity: the bigger gravity, the straighter mouse move
wind: how "windy" is the mouse move, bigger value, more windy
minWait: mouse speed, bigger value, slower speed (minimum value of sleep)
maxWait: mouse speed, bigger value, slower speed (maximum value of sleep)
maxStep: at the destination, it does a little twirl, bigger value, bigger twirls, just dont go overboard, because u wont be able to use your mouse, max would be ~20-30. If you go up and above, you risk losing control of your mouse
targetArea: when close to destination, it reduces speed, the bigger value, the bigger area

WindMouse(xs, ys, xe, ye, gravity, wind, minWait, maxWait, maxStep, targetArea)
