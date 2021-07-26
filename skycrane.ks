local pid is pidloop(0.28166778734885156, 0.67973461165092885, 0.012451723217964172, 0,1).
set KKK to time:seconds.
LOCK THROTTLE TO pid:update(kkk, ship:verticalspeed).
LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock maxtwr to ship:maxthrust / (GRAV *ship:mass).
set runmode to 1. 
until runmode = 0 {
if runmode = 1 { 
 lock steering to retrograde. 
 SET PID:SETPOINT TO distance_to_speed_math(130).
 if verticalspeed < 0.05 and distanceToGround < 150 {
     print "you need to be droping at this point".
     wait 120.
     print "5 second warning".
     wait 5.
     runpath("0:/e.ks").
     set runmode to 0.}
}}





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