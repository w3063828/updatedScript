
start().
control_point().
set talt to 45.
rcs on.
//sas on.
//WAIT 15.
sas off.
local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).
lock throttle to min(target_twr / maxtwr, 1).

set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
   //set gp to latlng(-0.097124,-74.557706).
global pid is pidloop(1.818181818182, 1.4523718852301, 0.164222839640732, 0, maxtwr).//fg
toggle gear.
brakes off.
sas off.
rcs on.
local target_twr is 0.
//LOCK STEERING TO HEADING(gp:HEADING,90).
LOCK STEERING TO up.
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
//local pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
local last_time is time:seconds.
local total_error is 0.
clearscreen.
//set tAlt to 55.    
local start_time is time:seconds.
local original_length is ship:parts:length. 
  until ship:parts:length > original_length {
    set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
         set RV:mag to min(8,RV:mag). //just for safety
         lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).
  set PID:setpoint to math().
  if VB < 0.4 {LOCK TALT TO MATHgg().}
   set SHIP:CONTROL:fore TO desiredFore.
   set SHIP:CONTROL:top TO desiredtop. 
   set SHIP:CONTROL:starboard TO desiredstar. 
   set pid:setpoint to math().
   set TRTM to vxcl(up:vector,gp:POSITION).
   set TRTM to VECDRAWARGS( V(0,0,0),gp:position,green,"ship",1,true).
   set target_twr to pid:update(time:seconds, ship:verticalspeed).
   set PIDfore:SETPOINT TO axis_distance[1]/10.
   set PIDstar:SETPOINT TO 1 * axis_distance[2]/10.
   set PIDtop:SETPOINT TO axis_distance[3]/10.
   //lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   lock myVelocity to ship:facing:inverse * ship:velocity:surface.
   SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1]).
   SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2]). 
   SET desiredtop TO PIDtop:UPDATE(TIME:SECONDS,axis_speed[3]).
   set last_time to time:seconds. 
   set pid:maxoutput to maxtwr.
   set target_twr to pid:update(time:seconds, ship:verticalspeed).
    print "talt:    " + talt + "      " at (5,4).
    print "VB:    " + round(VB(),4) + "      " at (5,5).
    print "fore D " + round(axis_distance[1],3) + "      " at (5,7).
    print "star D " + round(axis_distance[2],3) + "      " at (5,8).
    print "top  D " + round(axis_distance[3],3) + "      " at (5,9). 
    print "bb " + height + "      " at (5,10). 
    print "desiredFore:  " + round(desiredFore) + "      " at (5,11).
    print "desiredstar:  " + round(desiredstar) + "      " at (5,12).
    print "desiredtop:  " + round(desiredtop) + "      " at (5,13).
    
   
    //print "Fsetpoint:    " + PIDfore:SETPOINT + "      " at (5,15).
    //print "ssetpoint:    " + PIDstar:SETPOINT + "      " at (5,16).
    //print "tsetpoint:    " + PIDtop:SETPOINT + "      " at (5,17).
      
    print "dtg:    " +round(dtg(),2) + "      " at (5,23).
    if abort { abort off. set talt to (talt-2).}
    if brakes { brakes off. set talt to (talt+2).}
    IF ABS(desiredFore) > RCSdeadZone { SET desiredFore TO 0. }
    IF ABS(desiredstar) > RCSdeadZone { SET desiredFore TO 0. }
    }



 
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
 SET GG TO 0.
 LOCK GG TO ship:bounds:bottomaltradar.
   return GG.
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

FUNCTION control_point {
	PARAMETER pTag IS "controlPoint".
	LOCAL controlList IS SHIP:PARTSTAGGED(pTag).
	IF controlList:LENGTH > 0 {
		controlList[0]:CONTROLFROM().
	} ELSE {
		IF SHIP:ROOTPART:HASSUFFIX("CONTROLFROM") {
			SHIP:ROOTPART:CONTROLFROM().
		}
	}
}
FUNCTION start {
  CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal"). 
  lock TARGET TO VESSEL("ef debris").
   set PortList to target:modulesnamed("ModuleDockingNode").
  for Ports in PortList {
	set port to Ports:PART.
	print port:name.
	if port:tag = "TgtDockPort" {
		set target to port.
	print "Docking port targetted".
	}}
   local port is target.
   global height is port:bounds:bottomaltradar.
   

  }

  FUNCTION mathGG {
  lock mathResult to min(50,(height + (VB*20))).
  RETURN mathResult.
}