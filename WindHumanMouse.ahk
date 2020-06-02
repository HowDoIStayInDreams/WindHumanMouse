#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
;CoordMode Mouse, Client   ; if you use this line in your scripts, uncomment that
SetBatchLines, -1
SetMouseDelay -1
Process, Priority,, H
;*********************************************************************************
;--------------------------------------------------------------------------------;
;  v1.5										 ;
;  Original script by: Flight in Pascal					         ;
;  Link: https://github.com/SRL/SRL/blob/master/shared/mouse.simba               ;
;  More Flight's mouse moves: https://paste.villavu.com/show/3279/       	 ;
;  Modified script with simpler method MoveMouse() by: dexon in C#           	 ;
;  Conversion from C# into AHK by: HowDoIStayInDreams, with the help of Arekusei ;
;--------------------------------------------------------------------------------;
;--------------------------------------------------------------------------------;
;  Changelog:									 ;
;  v1.3 added dynamic mouse speed					 	 ;
;  v1.4 added acceleration and brake, shout-out to kl and Lazy			 ;
;  v1.5 fixed jiggle at the destination (pointed out by Sound)                   ;
;	added smoother sleep function		   			 	 ;
; 	maxStep is now more dynamic, using GlitchedSoul's weighted Random	 ;
;--------------------------------------------------------------------------------;
;*********************************************************************************

MoveMouse(x, y, speed:= 0.6, RD:= ""){

    ;Random, rxRan,-10,10  ; here you can randomize your destination coordinates
    ;Random, ryRan,-10,10  ; so you don't need to randomize them in your main script
    ;x:= x + rxRan         ; uncomment the beginning of these four lines
    ;y:= y + ryRan         ; if you want random destinations

    if(RD == "RD")
	{
        goRelative(x,y,speed)
    }
    else
	{        
        goStandard(x,y,speed)		
    }
}
;---------------------- no need to change anything below ------------------------;
WindMouse(xs, ys, xe, ye, gravity, wind, minWait, maxWait, maxStep, targetArea, sleepsArray){
windX:= 0, windY:= 0
veloX:= 0, veloY:= 0
newX:= Round(xs)
newY:= Round(ys)
waitDiff:= maxWait - minWait
sqrt2:= Sqrt(2)
sqrt3:= Sqrt(3)
sqrt5:= Sqrt(5)
dist:= Hypot(xe - xs, ye - ys)
i:= 1
stepVar:= maxStep
Loop{
	wind:= Min(wind, dist)
	if(dist >= targetArea){
		windX:= windX / sqrt3 + (random(round(wind) * 2 + 1) - wind) / sqrt5
		windY:= windY / sqrt3 + (random(round(wind) * 2 + 1) - wind) / sqrt5
		maxStep:= RandomWeight(stepVar/2, (stepVar+(stepVar/2))/2, stepVar)
		}else{
			windX:= windX / sqrt2
			windY:= windY / sqrt2
			if(maxStep < 3){
				maxStep:= 1
			}else{
				maxStep:= maxStep / 3
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
		if(dist <= 1){
			Break
		}
		newX:= Round(xs)
		newY:= Round(ys)
		if(oldX != newX) or (oldY != newY){
			MouseMove, newX, newY
		}
		step:= Hypot(xs - oldX, ys - oldY)
		c:= sleepsArray.Count()
		if(i > c){
			lastSleeps:= Round(sleepsArray[c])
			Random, w, lastSleeps, lastSleeps+1
			wait:= Max(Round(abs(w)),1)
			Sleep(wait)
		}else{
			waitSleep:= Round(sleepsArray[i])
			Random, w, waitSleep, waitSleep+1
			wait:= Max(Round(abs(w)),1)
			Sleep(wait)
			i++
		}
	}
endX:= Round(xe)
endY:= Round(ye)
	if(endX != newX) or (endY != newY){
		MouseMove, endX, endY
    }
i:= 1
}
WindMouse2(xs, ys, xe, ye, gravity, wind, minWait, maxWait, maxStep, targetArea){
windX:= 0, windY:= 0
veloX:= 0, veloY:= 0
newX:= Round(xs)
newY:= Round(ys)
waitDiff:= maxWait - minWait
sqrt2:= Sqrt(2)
sqrt3:= Sqrt(3)
sqrt5:= Sqrt(5)
dist:= Hypot(xe - xs, ye - ys)
newArr:=[]
stepVar:= maxStep
Loop{
    wind:= Min(wind, dist)
		if(dist >= targetArea){
			windX:= windX / sqrt3 + (random(round(wind) * 2 + 1) - wind) / sqrt5
			windY:= windY / sqrt3 + (random(round(wind) * 2 + 1) - wind) / sqrt5
			maxStep:= RandomWeight(stepVar/2, (stepVar+(stepVar/2))/2, stepVar)
        }else{
            windX:= windX / sqrt2
            windY:= windY / sqrt2
            if(maxStep < 3){
                maxStep:= 1
            }else{
                maxStep:= maxStep / 3
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
		if(dist <= 1){
			Break
		}
        newX:= Round(xs)
        newY:= Round(ys)
        if(oldX != newX) or (oldY != newY){
            p:=0
        }
        step:= Hypot(xs - oldX, ys - oldY)
		mean:= Round(waitDiff * (step / maxStep) + minWait)/7
		wait:= Muller((mean)/2,(mean)/2.718281)
		newArr.Push(wait)
    }
endX:= Round(xe)
endY:= Round(ye)
    if(endX != newX) or (endY != newY){
        p:=0
    }
Return newArr
}
createArray(arr){
Loop, % arr.MaxIndex()
    list2 .= arr[A_Index] . "`n"
Return list2
}
Hypot(dx, dy){
    return Sqrt(dx * dx + dy * dy)
}
random(n){
	random, out, 0, n
	return % out
}
Sleep(s)
{
    SetBatchLines, -1
    DllCall("QueryPerformanceFrequency", "Int64*", freq)
    DllCall("QueryPerformanceCounter", "Int64*", CounterBefore)
    While (((counterAfter - CounterBefore) / freq * 1000) < s)
        DllCall("QueryPerformanceCounter", "Int64*", CounterAfter)
    return ((counterAfter - CounterBefore) / freq * 1000)
}
Muller(m,s){
   Static i, Y
   If (i := !i){
      Random U, 0, 1.0
      Random V, 0, 6.2831853071795862
      U := sqrt(-2*ln(U))*s
      Y := m + U*sin(V)
      Return m + U*cos(V)
   }
   Return Y
}
SortArray(Array, Order="A"){
    MaxIndex := ObjMaxIndex(Array)
    If (Order = "R"){
        count := 0
        Loop, % MaxIndex
            ObjInsert(Array, ObjRemove(Array, MaxIndex - count++))
        Return
    }
    Partitions := "|" ObjMinIndex(Array) "," MaxIndex
    Loop{
        comma := InStr(this_partition := SubStr(Partitions, InStr(Partitions, "|", False, 0)+1), ",")
        spos := pivot := SubStr(this_partition, 1, comma-1) , epos := SubStr(this_partition, comma+1)
        if (Order = "A"){
            Loop, % epos - spos{
                if (Array[pivot] > Array[A_Index+spos])
                    ObjInsert(Array, pivot++, ObjRemove(Array, A_Index+spos))
            }
        }else{
            Loop, % epos - spos{
                if (Array[pivot] < Array[A_Index+spos])
                    ObjInsert(Array, pivot++, ObjRemove(Array, A_Index+spos))
            }
        }
        Partitions := SubStr(Partitions, 1, InStr(Partitions, "|", False, 0)-1)
        if (pivot - spos) > 1
            Partitions .= "|" spos "," pivot-1
        if (epos - pivot) > 1
            Partitions .= "|" pivot+1 "," epos
    }Until !Partitions
}
RandomWeight(min,target,max){
Random,Rmin,min,target
Random,Rmax,target,max
Random,weighted,Rmin,Rmax
Return, weighted
}
goStandard(x, y, speed){
MouseGetPos, xpos, ypos
distance:= (Sqrt(Hypot(x-xpos,y-ypos)))*speed
dynamicSpeed:= (1/distance)*60
Random, finalSpeed, dynamicSpeed, dynamicSpeed + 0.8
stepArea:= Max(( finalSpeed / 2 + distance ) / 10, 0.1)
newArr:=[]
newArr:= WindMouse2(xpos, ypos, x, y, 10, 3, finalSpeed * 10, finalSpeed * 12, stepArea * 11, stepArea * 7)
SortArray(newArr, "D")
c:= newArr.Count()
g:= c/2
	Loop, %g%{
	newArr.RemoveAt(c)
	c--
	}
newClone:=[]
newClone:= newArr.Clone()
SortArray(newClone, "A")
newArr.Push(newClone*)
WindMouse(xpos, ypos, x, y, 10, 3, finalSpeed * 10, finalSpeed * 12, stepArea * 11, stepArea * 7, newArr)
newArr:=[]
}
goRelative(x, y, speed){
MouseGetPos, xpos, ypos
distance:= (Sqrt(Hypot((xpos+abs(x))-xpos,(ypos+abs(y))-ypos)))*speed
dynamicSpeed:= (1/distance)*60
Random, finalSpeed, dynamicSpeed, dynamicSpeed + 0.8
stepArea:= Max(( finalSpeed / 2 + distance ) / 10, 0.1)
newArr:=[]
newArr:= WindMouse2(xpos, ypos, xpos+x, ypos+y, 10, 3, finalSpeed * 10, finalSpeed * 12, stepArea * 11, stepArea * 7)
SortArray(newArr, "D")
c:= newArr.Count()
g:= c/2
	Loop, %g%{
	newArr.RemoveAt(c)
	c--
	}
newClone:=[]
newClone:= newArr.Clone()
SortArray(newClone, "A")
WindMouse(xpos, ypos, xpos+x, ypos+y, 10, 3, finalSpeed * 10, finalSpeed * 12, stepArea * 11, stepArea * 7, newArr)
newArr:=[]
}
