CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").

IF HASTARGET {
	lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
  set ship:control:pilotmainthrottle to 0.
  stage.
gear off.
brakes off.
sas off.
rcs on.
local target_twr is 0.
lock steering to up.
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
//lock GRAV TO SHIP:SENSORS:GRAV:mag.
lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
lock maxAcc to ship:availablethrust / mass.
lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
LOCAL desiredFore IS 0.
LOCAL desiredstar IS 0.
LOCAL desiredtop  IS 0.
LOCAL shipFacing IS ship:facing.
LOCAL axisSpeed IS axis_speed().
LOCAL RCSdeadZone IS 0.05.
local PIDtop is pidloop(4, 0.1, 0.1, -10, 10).
local PIDfore is pidloop(4, 0.1, 0.1, -10, 10).
local PIDstar is pidloop(4, 0.1, 0.1, -10, 10).
local pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
local last_time is time:seconds.
local total_error is 0.
clearscreen.
set tAlt to 25.    
local start_time is time:seconds.
local original_length is ship:parts:length. 
  until ship:parts:length > original_length {
  
   set SHIP:CONTROL:fore TO desiredFore.
   set SHIP:CONTROL:top TO desiredtop. 
   set SHIP:CONTROL:starboard TO desiredstar. 
   set pid:setpoint to math().
   set TRTM to vxcl(up:vector,gp:POSITION).
   set TRTM to VECDRAWARGS( V(0,0,0),target:position,green,"ship",1,true).
   set target_twr to pid:update(time:seconds, ship:verticalspeed).
   set PIDfore:SETPOINT TO axis_distance[1]/10.
   set PIDstar:SETPOINT TO axis_distance[2]/10.
   set PIDtop:SETPOINT TO axis_distance[3]/10.
   lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   lock myVelocity to ship:facing:inverse * ship:velocity:surface.
   SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1]).
   SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2]). 
   SET desiredtop TO PIDtop:UPDATE(TIME:SECONDS,axis_speed[3]).
   set total_error to total_error + abs(PIDtop:error * PIDFore:error * PIDstar:error * (time:seconds - last_time)).
   set last_time to time:seconds. 
  
    print "talt:    " + talt + "      " at (5,4).
    print "VB:    " + round(VB(),4) + "      " at (5,5).
    print "fore D " + round(axis_distance[1],3) + "      " at (5,7).
    print "star D " + round(axis_distance[2],3) + "      " at (5,8).
    print "top  D " + round(axis_distance[3],3) + "      " at (5,9). 

    print "desiredFore:  " + round(desiredFore) + "      " at (5,11).
    print "desiredstar:  " + round(desiredstar) + "      " at (5,12).
    print "desiredtop:  " + round(desiredtop) + "      " at (5,13).
    //print "myVelocity:  " + axis_speed[0] + "      " at (5,11).
   
    //print "Fsetpoint:    " + PIDfore:SETPOINT + "      " at (5,15).
    //print "ssetpoint:    " + PIDstar:SETPOINT + "      " at (5,16).
    //print "tsetpoint:    " + PIDtop:SETPOINT + "      " at (5,17).
    
    //print "fore S " + axis_speed[1] + "      " at (5,19).
    //print "star S " + axis_speed[2] + "      " at (5,20).
   // print "top  S " + axis_speed[3] + "      " at (5,21).

    
    print "dtg:    " +round(dtg(),2) + "      " at (5,23).

   
   
    if vb < 0.1 {set talt to max(10,talt - 0.35).}
    if vb < 0.05 {lock talt to min(10,vb * 500).}
    IF ABS(desiredFore) > RCSdeadZone { SET desiredFore TO 0. }
    IF ABS(desiredstar) > RCSdeadZone { SET desiredFore TO 0. }
    }
}
else {
gear on.
shutdown_stack().
rcs off.}

 
 FUNCTION axis_speed {
	LOCAL localStation IS target:position.
	LOCAL localship IS SHIP.
	LOCAL relitaveSpeedVec IS SHIP:VELOCITY:SURFACE - target:VELOCITY:surface.	//relitaveSpeedVec is the speed as reported by the navball in target mode as a vector along the target prograde direction
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
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}
FUNCTION math {
  lock mathResult to ((talt-dtg())/4).
  RETURN mathResult.
}
function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
FUNCTION mathf {
  lock mathResult to -1 *(axis_distance[1]/6).
  RETURN mathResult.
}
FUNCTION maths {
  lock mathResult to -1 * (axis_distance[2]/6).
  RETURN mathResult.
}
FUNCTION matht {
  lock mathResult to -1 * (axis_distance[3]/6).
  RETURN mathResult.
}
FUNCTION shutdown_stack {
	RCS OFF.
	UNLOCK STEERING.
	UNLOCK THROTTLE.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	SET SHIP:CONTROL:FORE TO 0.
	SET SHIP:CONTROL:TOP TO 0.
	SET SHIP:CONTROL:STARBOARD TO 0.

}