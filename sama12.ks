CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
SET TARGET TO VESSEL("omfg").
set gp to fuck_you_MR_you_rude_bitch().
lock tAlt2 to max(gp:terrainheight,68) + tAlt.
LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock maxtwr to ship:maxthrust / (GRAV *ship:mass).
set tAlt to 95.
lock steering to heading(300,70).
set KKK to time:seconds.
set xx to 1.
thot2().
rcs on.
stage.
wait 13.
set config:ipu to 500.
set runmode to 1.
until runmode = 0 {
if runmode =1 {
    set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 2.5. //relative velocity vector, we base our steering on this
    set RV:mag to min(8,RV:mag). //just for safety
    lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
		if VB() < 100 set tAlt to 25. //we're above target area so start descending
    if VB() < .5 set tAlt to 20. //we're above target area so start descending
    if gp <> 0 { set runmode to 1.}
    if VB() < 0.03{
			clearscreen.
      wait 60.
      set runmode to 2.}
    }

if runmode = 2 { 
  
	local pid is pidloop(0.28166778734885156, 0.67973461165092885, 0.012451723217964172, 0,1).
	LOCK THROTTLE TO pid:update(kkk, ship:verticalspeed).
	lock maxtwr to ship:maxthrust / (GRAV * (ship:mass + O)).
	until VB1() < 0.05 {
  	SET PID:SETPOINT TO distance_to_speed_math(130).
  	set RV to vxcl(up:vector, target:position / 8 - velocity:surface) / 2.5. //relative velocity vector, we base our steering on this
  	set RV:mag to min(8,RV:mag). //just for safety
		lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
		print "rv:    " + RV:mag + "      " at (5,9).
		print "Tmass:    " + round(target:mass) + "      " at (5,8).
		print "mass:    " + round(ship:mass) + "      " at (5,7).
		print "RUNMODE:    " + runmode + "      " at (5,4).
		print "VB:    " + VB + "      " at (5,5).
		print "MA:    " + ma() + "      " at (5,10).
		print "AT:    " + ship:availablethrust + "      " at (5,11).
		print "qq:    " + qq() + "      " at (5,12). 
		print "thot:    " + thot() + "      " at (5,13). 
		print "talt2:    " + tAlt2 + "      " at (5,14). 
		print "D-ground:    " + altitude + "      " at (5,15). 
		print "pid:setpoint:    " + pid:setpoint + "      " at (5,16).
		print "Vert:    " + ship:verticalspeed + "      " at (5,17).    
		print "math:    " + distance_to_speed_math(130) + "      " at (5,18).    
		print "maxrwr:    " + maxtwr + "      " at (5,19).}
		clearscreen.
		print "miss Tohru is the god queen of the never-verse".
		wait 29.
		
		set runode to 0.
		
}
print "rv:    " + RV:mag + "      " at (5,9).
print "Tmass:    " + round(target:mass) + "      " at (5,8).
print "mass:    " + round(ship:mass) + "      " at (5,7).
print "RUNMODE:    " + runmode + "      " at (5,4).
print "VB:    " + VB + "      " at (5,5).
print "MA:    " + ma() + "      " at (5,10).
print "AT:    " + ship:availablethrust + "      " at (5,11).
print "qq:    " + qq() + "      " at (5,12). 
print "thot:    " + thot() + "      " at (5,13). 
print "talt2:    " + tAlt2 + "      " at (5,14). 
print "alt:    " + altitude + "      " at (5,15). 
print "Vert:    " + ship:verticalspeed + "      " at (5,17).
}

FUNCTION axis_speed {
	LOCAL localStation IS target:position.
	LOCAL localship IS SHIP.
  
	LOCAL relitaveSpeedVec IS SHIP:VELOCITY:SURFACE - target:VELOCITY:surface.	//relitaveSpeedVec is the speed as reported by the navball in target mode as a vector along the target prograde direction
	LOCAL speedFor IS VDOT(relitaveSpeedVec, ship:Facing:FOREVECTOR).	//positive is moving forwards, negative is moving backwards
	LOCAL speedTop IS VDOT(relitaveSpeedVec, ship:Facing:TOPVECTOR).	//positive is moving up, negative is moving down
	LOCAL speedStar IS VDOT(relitaveSpeedVec, ship:Facing:STARVECTOR).	//positive is moving right, negative is moving left
	RETURN LIST(relitaveSpeedVec,speedFor,speedTop,speedStar).
}
FUNCTION axis_distance {
LOCAL localStation IS target:position.
	LOCAL localship IS SHIP.
	LOCAL distVec IS station:POSITION - ship:POSITION.//vector pointing at the station port from the ship: port
	LOCAL dist IS distVec:MAG.
	LOCAL distFor IS VDOT(distVec, ship:Facing:FOREVECTOR).	//if positive then stationPort is ahead of ship:Port, if negative than stationPort is behind of ship:Port
	LOCAL distStar IS VDOT(distVec, ship:Facing:STARVECTOR).	//if positive then stationPort is to the right of ship:Port, if negative than stationPort is to the left of ship:Port
	RETURN LIST(dist,distFor,distTop,distStar).
}
function distanceToGround {
  return altitude - body:geopositionOf(ship:position):terrainHeight - 4.7.
}


FUNCTION axis_speed {
	LOCAL localStation IS target:position.
	LOCAL localship IS SHIP.
  
	LOCAL relitaveSpeedVec IS SHIP:VELOCITY:SURFACE - target:VELOCITY:surface.	//relitaveSpeedVec is the speed as reported by the navball in target mode as a vector along the target prograde direction
	LOCAL speedFor IS VDOT(relitaveSpeedVec, ship:Facing:FOREVECTOR).	//positive is moving forwards, negative is moving backwards
	LOCAL speedTop IS VDOT(relitaveSpeedVec, ship:Facing:TOPVECTOR).	//positive is moving up, negative is moving down
	LOCAL speedStar IS VDOT(relitaveSpeedVec, ship:Facing:STARVECTOR).	//positive is moving right, negative is moving left
	RETURN LIST(relitaveSpeedVec,speedFor,speedTop,speedStar).
}
FUNCTION axis_distance {
LOCAL localStation IS target:position.
	LOCAL localship IS SHIP.
	LOCAL distVec IS station:POSITION - ship:POSITION.//vector pointing at the station port from the ship: port
	LOCAL dist IS distVec:MAG.
	LOCAL distFor IS VDOT(distVec, ship:Facing:FOREVECTOR).	//if positive then stationPort is ahead of ship:Port, if negative than stationPort is behind of ship:Port
	LOCAL distStar IS VDOT(distVec, ship:Facing:STARVECTOR).	//if positive then stationPort is to the right of ship:Port, if negative than stationPort is to the left of ship:Port
	RETURN LIST(dist,distFor,distTop,distStar).
}
function distanceToGround {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}


function MA{
return (ship:availablethrust / mass).
}

function MA1{
RETURN (ship:availablethrust / (ship:mass + 181)).
}
function thot{
return (grav / MA() + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
}

function thot1{
lock throttle to (grav / MA1() + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).}

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}

function VB1{
   return vxcl(up:vector,TARGET:POSITION):mag.
}
function qq{
return vdot(up:vector,facing:vector).}

function thot2{
lock throttle to (grav / MA() + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
}

function fuck_you_MR_you_rude_bitch{
 set ls to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
 return LS.
}

FUNCTION distance_to_speed_math {
  PARAMETER dist.
  set mathResult to ((dist-altitude)/4).
  RETURN mathResult.
}
