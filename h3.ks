
rcs off.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
SET SHIP:CONTROL:NEUTRALIZE to TRUE.
local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock GRAV to body:mu / body:position:sqrmagnitude.
lock maxtwr to ship:maxthrust / (g * ship:mass).
 lock maxAcc to ship:availablethrust / mass.
lock throttle to min(target_twr / maxtwr, 1).
lock steering to lookdirup(up:vector, facing:topvector).
set ship:control:pilotmainthrottle to 0.
set leg_part to ship:partstagged("HH")[0].
set target_twr to 1.25.
wait until alt:radar > 50.
set tAlt to 45.
// PID until our first crossover
//local pid is pidloop(kU, 0, 0, 0, maxtwr).
//local pid is pidloop(1.81818181818182, 5.48325897757928, 0.0434983348738613, 0, maxtwr).
//local pid is pidloop(1.81818181818182, 0.9725434, 0.2434983348738613, 0, maxtwr).
//global pid is pidloop(1.81818181818182, 0.456998571460453, 0.521911117675102, 0, maxtwr).
local pid is pidloop(1.81818181818182, 0.823295836191430, 0.028970465180975, 0, maxtwr).
set pid:setpoint to 0.
until ship:verticalspeed < 0 {
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.01.
}
local start_time is time:seconds.
LOCK STEERING TO HEADING(0,90).


until time:seconds > start_time + 10 {
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.01.
}

set gp to LATLNG(-0.097136696143733,-74.5577421405819).
lOCAL desiredFore IS 0.
LOCAL desiredstar IS 0.

LOCAL desiredpitch  IS 0.
LOCAL shipFacing IS ship:facing.
LOCAL axisSpeed IS axis_speed().
LOCAL RCSdeadZone IS 0.05.

local PIDfore is pidloop(4, 0.2, 0.1, -10, 10).
local PIDstar is pidloop(4, 0.2, 0.1, -10, 10).
local last_time is time:seconds.
set SHIP:CONTROL:fore TO desiredFore.

set SHIP:CONTROL:starboard TO desiredstar. 
lock myVelocity to ship:facing:inverse * ship:velocity:surface.         
rcs on.
clearscreen.
until ship:status = "Landed" {
  lock throttle to (GRAV / maxAcc + (talt - DTG()) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
  set PIDfore:SETPOINT TO axis_distance[1]/10.
  set PIDstar:SETPOINT TO axis_distance[2]/10.

  SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1]).
  SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2]). 

  set SHIP:CONTROL:fore TO desiredFore.
 
  set SHIP:CONTROL:starboard TO desiredstar. 
          print "VB:    " + round(VB(),4) + "      " at (5,6).
          print "fore D " + round(axis_distance[1],3) + "      " at (5,7).
          print "star D " + round(axis_distance[2],3) + "      " at (5,8).
     
          print "setpoint" + pid:setpoint + "      " at (5,10).
          print "desiredFore:  " + round(desiredFore) + "      " at (5,11).
          print "desiredstar:  " + round(desiredstar) + "      " at (5,12).
     
          print "fore S " + round(axis_speed[1],3) + "      " at (5,14).
          print "star S " + round(axis_speed[2],3) + "      " at (5,15).
 
  wait 0.2.
   //if vb() < 1 {set pid:setpoint to -1.}
}
SET SHIP:CONTROL:NEUTRALIZE to TRUE.
function VB{
   return vxcl(up:vector,gp:POSITION):mag.}

 FUNCTION axis_speed {
	LOCAL localStation IS gp:position.
	LOCAL localship IS SHIP.
	LOCAL relitaveSpeedVec IS SHIP:VELOCITY:SURFACE - gp:VELOCITY:surface.	//relitaveSpeedVec is the speed as reported by the navball in target mode as a vector along the target prograde direction
	LOCAL speedFor IS VDOT(relitaveSpeedVec, ship:Facing:FOREVECTOR).	//positive is moving forwards, negative is moving backwards
	LOCAL speedStar IS VDOT(relitaveSpeedVec, ship:Facing:STARVECTOR).	//positive is moving right, negative is moving left
	LOCAL speedtop IS VDOT(relitaveSpeedVec, ship:Facing:topVECTOR).
  RETURN LIST(relitaveSpeedVec,speedFor,speedStar,speedtop).
}
FUNCTION axis_distance {
   
	LOCAL distVec IS vxcl(up:vector,gp:POSITION).//vector pointing at the station port from the ship: port
	LOCAL dist IS vb().
	LOCAL distFor IS VDOT(distVec,ship:Facing:FOREVECTOR ).	//if positive then stationPort is ahead of ship:Port, if negative than stationPort is behind of ship:Port
	LOCAL distStar IS VDOT(distVec,ship:Facing:STARVECTOR).	//if positive then stationPort is to the right of ship:Port, if negative than stationPort is to the left of ship:Port
	LOCAL disttop IS VDOT(distVec,ship:Facing:topVECTOR).
  RETURN LIST(dist,distFor,distStar,disttop).
}

function dtg {
 
 local bounds_box is leg_part:bounds.
 
   return bounds_box:bottomaltradar.
}