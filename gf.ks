
SET TARGET TO VESSEL("mr").
lock VB to vxcl(up:vector,TARGET:POSITION):mag.
CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
global pid is pidloop(0.23512961948290467, 0.097932885400950909, 0.23396590165793896, 0,1).
stage.
set tAlt to 120.
lock tAlt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + tAlt.
LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock maxAcc to ship:availablethrust / mass.
lock throttle to (grav / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
lock steering to heading(300,70).

wait 3.
lock des_nutz to (grav / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
set xx to 1.
set KKK to time:seconds.
set runmode to 1.
LOCK RV to vxcl(up:vector, target:position / 8 - velocity:surface) / 2.5. //relative velocity vector, we base our steering on this
set RV:mag to min(8,RV:mag). //just for safety
until runmode = 0{
if runmode =1 {
  set config:ipu to 500.
    
    //lookdirup() makes the steering ignore the roll (or more precisely, it will effectively cancel it out)
    if VB < 3 set tAlt to 30. //we're above target area so start descending
    if gp <> 0 { set runmode to 1.}
    if VB < .05 {
      wait 60.
      set runmode to 2.}
    }

if runmode = 2 { 
  clearscreen.
  SET TARGET TO VESSEL("usc").
    set config:ipu to 400.
    gear off.
    brakes off.
    rcs on.
    lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
    local target_twr is 0.
    lock g TO SHIP:SENSORS:GRAV:mag.
    lock maxtwr to ship:maxthrust / (g * (ship:mass + 188970)).
    lock throttle to min(target_twr / maxtwr, 1).
        set pid:setpoint to 5.
     if gear { gear off. set pid:setpoint to pid:setpoint - 1. }
     if brakes { brakes off. set pid:setpoint to pid:setpoint + 1. }
      set pid:maxoutput to maxtwr.
      set target_twr to pid:update(kkk, ship:verticalspeed).
      if vxcl(up:vector,gp:position):mag < 5 set tAlt to max(1,tAlt - 0.04). //we're above target area so start descending
      if ship:status:contains("landed") {set runmode to 0.}
    else {set runmode to 2.}
    wait 0.
}
if runmode = 3 {
SET TARGET TO VESSEL("usc").
set pid:setpoint to 10.
lock throttle to (des_nutz * xx).
    set xx to pid:update(kkk, verticalspeed).
    lock steering to lookdirup(up:vector * 10 + RV, facing:topvector). //lookdirup() makes the steering ignore the roll (or more precisely, it will effectively cancel it out)
    if vxcl(up:vector,gp:position):mag < 5 set tAlt to max(1,tAlt - 0.04). //we're above target area so start descending
    if ship:status:contains("landed") {set runmode to 0.}
    else {set runmode to 3.}
    wait 0.
}
print "RUNMODE:    " + runmode + "      " at (5,4).
print "VB:    " + VB + "      " at (5,5).
print "dn:    " + des_nutz + "      " at (5,6).
print "xx:    " + xx + "      " at (5,7).
}

wait 3.

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