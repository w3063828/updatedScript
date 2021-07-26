
CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
//SET TARGET TO VESSEL("mr").
set gp to LATLNG(-0.0967646955755359,-74.6187122587352). //VAB //SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION). //VAB
lock throttle to 1.
sas on.
rcs on.
wait 1.
global speedlimit is 45.
sas off.
gear on.
set tAlt to 110.
lock tAlt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + tAlt.
lock grav to body:mu / body:position:sqrmagnitude.
lock maxAcc to ship:availablethrust / mass.
lock throttle to (grav / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
.

//wait 10.
//steering to GEO
until ship:status = "Landed" {
    set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) /8. //relative velocity vector, we base our steering on this
    set RV:mag to min(8,RV:mag). //just for safety
     if Ship:groundspeed > speedlimit {set steering to up.}
     if Ship:groundspeed < (speedlimit - 5 ) { lock steering to lookdirup(up:vector * 45 + RV, facing:topvector).} //lookdirup() makes the steering ignore the roll (or more precisely, it will effectively cancel it out)
    if VB < 10 set tAlt to max(1,tAlt - 2). //we're above target area so start descending
    if VB < 10 set tAlt to 70.
    print "VB    " + ROUND(VB,3) + "      " at (5,4).
}


    lock throttle to 0. 


wait until false.
function VB{
   return vxcl(up:vector,gp:POSITION):mag.}