#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;CoordMode Mouse, Client     ; if you use this line in your scripts, uncomment that
SetBatchLines, -1
SetMouseDelay -1
;*************************************************************************************
;------------------------------------------------------------------------------------;
;  Original script by: Flight in Pascal, link: https://paste.villavu.com/show/3279/  ;
;  Modified script with simpler method MoveMouse() by: dexon in C#                   ;
;  Convertion from C# into AHK by: HowDoIStayInDreams, with the help of Arekusei     ;
;  Dynamic mouse speed implemented by: HowDoIStayInDreams                            ;
;  v1.2                                                                              ;
;------------------------------------------------------------------------------------;
MoveMouse(x, y, RD:= ""){
   ;---------------------------------------------------------------------------------;
   ; type here two numbers between 0 and 4294967295, or, better,                     ;
   ; go to https://www.random.org/ and generate two numbers between 0 and 1000000000 ;
   ;---------------------------------------------------------------------------------;
    Random, seed, 20737032, 786288360
    Random, , seed
                           ;---------------------------------------------------------;
    ;Random, rxRan,-10,10  ; here you can randomize your destination coordinates     ;
    ;Random, ryRan,-10,10  ; so you don't need to randomize them in your main script ;
    ;x:= x + rxRan         ; uncomment these                                         ;
    ;y:= y + ryRan         ; four lines if you want random destinations              ;
    ;                      ;---------------------------------------------------------;
    if(RD == "RD"){
        MouseGetPos, xpos, ypos
        distance:= (Sqrt(Hypot((xpos+abs(x))-xpos,(ypos+abs(y))-ypos)))*0.7
        dynamicSpeed:= (1/distance)*100
        Random, finalSpeed, dynamicSpeed, dynamicSpeed + 1
        stepArea:= Max(( finalSpeed / 2 + distance ) / 10, 0.1)
        WindMouse(xpos,ypos,xpos+x,ypos+y,9,3,finalSpeed,finalSpeed*1.3,10*stepArea,10*stepArea)
    }
    else{
        MouseGetPos, xpos, ypos
        distance:= (Sqrt(Hypot(x-xpos,y-ypos)))*0.7
        dynamicSpeed:= (1/distance)*100
        Random, finalSpeed, dynamicSpeed, dynamicSpeed + 1
        stepArea:= Max(( finalSpeed / 2 + distance ) / 10, 0.1)
        WindMouse(xpos,ypos,x,y,9,3,finalSpeed,finalSpeed*1.3,10*stepArea,10*stepArea)
    }
}
;----------------------- no need to change anything below --------------------------;
WindMouse(xs, ys, xe, ye, gravity, wind, minWait, maxWait, maxStep, targetArea){
    windX:= 0, windY:= 0
    veloX:= 0, veloY:= 0
    newX:= Round(xs)
    newY:= Round(ys)
    waitDiff:= maxWait - minWait
    sqrt2:= Sqrt(2)
    sqrt3:= Sqrt(3)
    sqrt5:= Sqrt(5)
    dist:= Hypot(xe - xs, ye - ys)
    while(dist > 1){
        wind:= Min(wind, dist)
        if(dist >= targetArea){
			windX:= windX / sqrt3 + (random(round(wind) * 2 + 1) - wind) / sqrt5
			windY:= windY / sqrt3 + (random(round(wind) * 2 + 1) - wind) / sqrt5
        }
        else{
            windX:= windX / sqrt2
            windY:= windY / sqrt2
            if(maxStep < 3){
                maxStep:= random(3) + 3
            }
            else{
                maxStep:= maxStep / sqrt5
            }
        }
        veloX += windX
        veloY += windY
        veloX:= veloX + gravity * ( xe - xs ) / dist
        veloY:= veloY + gravity * ( ye - ys ) / dist
        if(Hypot(veloX, veloY) > maxStep){
            randomDist:= maxStep / 2 + (Round(random(maxStep)) / 2)
            veloMag:= Hypot(veloX, veloY)
            veloX:= ( veloX / veloMag ) * randomDist
            veloY:= ( veloY / veloMag ) * randomDist
        }
        oldX:= Round(xs)
        oldY:= Round(ys)
        xs:= xs + veloX
        ys:= ys + veloY
        dist:= Hypot(xe - xs, ye - ys)
        newX:= Round(xs)
        newY:= Round(ys)
        if(oldX != newX) or (oldY != newY){
            MouseMove, newX, newY
        }
        step:= Hypot(xs - oldX, ys - oldY)
        wait:= Round(waitDiff * (step / maxStep) + minWait)
		Sleep(wait)
    }
    endX:= Round(xe)
    endY:= Round(ye)
    if(endX != newX) or (endY != newY){
        MouseMove, endX, endY
    }
}
Hypot(dx, dy){
    return Sqrt(dx * dx + dy * dy)
}
random(n){
	random, out, 0, n
	return % out
}
SystemTime() {
	static freq
	if (!freq)
		DllCall("QueryPerformanceFrequency", "Int64*", freq)
	DllCall("QueryPerformanceCounter", "Int64*", tick)
	Return tick / freq * 1000
}
Sleep(value) {
	t_start := SystemTime()
	t_elapsed := 0
	t_accuracy := value > 4 ? 0.742 : 0.2
	Loop {
		if (value - t_elapsed < t_accuracy)
			Return t_elapsed - value
		DllCall("Sleep", "UInt", 1)
		t_elapsed := SystemTime() - t_start
	}
}
