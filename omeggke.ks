SET TARGET TO VESSEL("Untitled Space Craft").
CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
stage.
set tAlt to 100.
lock tAlt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + tAlt.
LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock maxAcc to ship:availablethrust / mass.
lock throttle to (grav / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
lock steering to heading(300,70).
print "gp:    " + gp + "      " at (5,4).
wait 10.
set runmode to 1.

until runmode = 0{
if runmode =1 {
    when gp <> 0 then {
    set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 2.5. //relative velocity vector, we base our steering on this
    set RV:mag to min(8,RV:mag). //just for safety
    lock steering to lookdirup(up:vector * 10 + RV, facing:topvector). //lookdirup() makes the steering ignore the roll (or more precisely, it will effectively cancel it out)
    if vxcl(up:vector,gp:position):mag < 3 set tAlt to 30. //we're above target area so start descending
    if gp:istype("GeoCoordinates") return true.
    if abort { abort off. set runmode to 2.}}

if runmode = 2 { 
    set gp to 0.
    gear off.
    brakes off.
    rcs on.
    local target_twr is 0.
    lock g TO SHIP:SENSORS:GRAV:mag.
    lock maxtwr to ship:maxthrust / (g * (ship:mass + 188970)).
    lock throttle to min(target_twr / maxtwr, 1).
    lock steering to lookdirup(ship:facing:upvector,ship:facing:upvector).
    LOCAL PIDfore IS PIDLOOP(0.91890245722606778,0.07970734778791666,0.027380389394238591,-10, 1).
    LOCAL PIDstar IS PIDLOOP(0.91890245722606778,0.07970734778791666,0.027380389394238591,-10, 1).
    local pid is pidloop(0.28166778734885156, 0.67973461165092885, 0.012451723217964172, 0, 1).
    set pid:setpoint to 1.
    until runmode =0 {
     if gear { gear off. set pid:setpoint to pid:setpoint - 1. }
      if brakes { brakes off. set pid:setpoint to pid:setpoint + 1. }
      set pid:maxoutput to maxtwr.
      set target_twr to pid:update(time:seconds, ship:verticalspeed).
      SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1]).
      SET desiredStar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2]).
      SET PIDfore:SETPOINT TO 0.
      SET PIDstar:SETPOINT TO 0. //(sqrt(DF)*-(signS())).
      if ag9 { ag9. set runmode to 0.}   
      LOCAL RCSdeadZone IS 0.05.//rcs will not fire below this value
      LOCAL desiredFore IS 0.
      LOCAL desiredStar IS 0.
      LOCAL shipFacing IS SHIP:FACING.
      LOCAL axisSpeed IS axis_speed().
      SET SHIP:CONTROL:FORE TO desiredFore.
      SET SHIP:CONTROL:STARBOARD TO desiredStar.
      IF ABS(desiredFore) > RCSdeadZone { SET desiredFore TO 0. }
      IF ABS(desiredStar) > RCSdeadZone { SET desiredStar TO 0. }
      wait 0.001.}   
      }
    print "RUNMODE:    " + runmode + "      " at (5,5).
    print "gp:    " + gp + "      " at (5,4).
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