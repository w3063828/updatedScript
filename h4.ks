  //lock TARGET TO VESSEL("sn 1").
  // set PortList to target:modulesnamed("ModuleDockingNode").
  //for Ports in PortList {
//	set port to Ports:PART.
	//print port:name.
	//if port:tag = "TgtDockPort" {
	//	set target to port.
//	print "Docking port targetted".
//	}}
  //control_point().
  clearscreen.
  set config:ipu to max(config:ipu,2000).
 lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
rcs on.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
//SET SHIP:CONTROL:NEUTRALIZE to TRUE.
local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock GRAV to body:mu / body:position:sqrmagnitude.
lock maxtwr to ship:maxthrust / (g * ship:mass).
 lock maxAcc to ship:availablethrust / mass.
lock throttle to min(target_twr / maxtwr, 1).
lock steering to lookdirup(up:vector, facing:topvector).
set ship:control:pilotmainthrottle to 0.
set leg_part to ship:partstagged("Hf")[0].
set target_twr to 1.25.
wait until alt:radar > 50.
set tAlt to 340.
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


until time:seconds > start_time + 1 {
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.01.
}

 set gp to LATLNG(-0.0967646955755359,-74.6187122587352).
  LOCAL desiredFore IS 6.
  LOCAL desiredstar IS -4.
  LOCAL desiredtop  IS -2.
  LOCAL shipFacing IS ship:facing.
  LOCAL axisSpeed IS axis_speed().
  LOCAL RCSdeadZone IS 0.02.

  global PIDtop is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDfore is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDstar is pidloop(4, 0.1, 0.1, -10, 10).
local last_time is time:seconds.
 
lock myVelocity to ship:facing:inverse * ship:velocity:surface.         
rcs on.
clearscreen.
until ship:status = "Landed" {
  lock throttle to (GRAV / maxAcc + (talt - DTG()) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
      
        set PIDfore:SETPOINT TO MIN(7,(axis_distance[1]/4)).
        set PIDstar:SETPOINT TO MIN(7,(axis_distance[2]/4)).
        set PIDtop:SETPOINT TO MIN(7,(axis_distance[3]/4)). 
        SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1]).
        SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2]). 
        SET desiredtop TO PIDtop:UPDATE(TIME:SECONDS,axis_speed[3]).
        set er1 to (PIDtop:SETPOINT - axis_speed[3]).
        set er2 to (PIDstar:SETPOINT - axis_speed[2]).
          print "talt:    " + talt + "      " at (5,4).
          print "VB:    " + round(VB(),4) + "      " at (5,5).
          print "fore D " + round(axis_distance[1],3) + "      " at (5,7).
          print "star D " + round(axis_distance[2],3) + "      " at (5,8).
          print "top  D " + round(axis_distance[3],3) + "      " at (5,9). 
    
          print "desiredFore:  " + round(desiredFore,3) + "      " at (5,11).
          print "desiredstar:  " + round(desiredstar,3) + "      " at (5,12).
          print "desiredtop:  " + round(desiredtop,3) + "      " at (5,13).
         // print "fore S " + axis_speed[1] + "      " at (5,19).
         // print "star S " + axis_speed[2] + "      " at (5,20).
         // print "top  S " + axis_speed[3] + "      " at (5,21).
          print "dtg:    " +round(dtg(),2) + "      " at (5,23).
        if abort { abort off. set talt to 0.}
        set SHIP:CONTROL:fore TO desiredFore.
        set SHIP:CONTROL:top TO desiredtop. 
        set SHIP:CONTROL:starboard TO desiredstar.
    IF ABS(desiredtop) > RCSdeadZone { SET desiredtop TO 0. }
    IF ABS(desiredstar) > RCSdeadZone { SET desiredstar TO 0. }
    IF ABS(desiredfore) > RCSdeadZone { SET desiredfore TO 0. }
       
 
  wait 0.
   
}
//SET SHIP:CONTROL:NEUTRALIZE to TRUE.
 set config:ipu to 200.
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
function l {
    return (axis_distance[3] + axis_distance[2]).
}
function dtg {
 
 local bounds_box is leg_part:bounds.
 
   return bounds_box:bottomaltradar.
}

  
FUNCTION control_point {
	PARAMETER pTag IS "Cp".
	LOCAL controlList IS SHIP:PARTSTAGGED(pTag).
	IF controlList:LENGTH > 0 {
		controlList[0]:CONTROLFROM().
	} ELSE {
		IF SHIP:ROOTPART:HASSUFFIX("CONTROLFROM") {
			SHIP:ROOTPART:CONTROLFROM().
		}
	}
}
