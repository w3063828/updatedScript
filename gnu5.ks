CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
set talt to 40.

start().
lock RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
set RV:mag to min(8,RV:mag). //just for safety
set runmode to 1.
until runmode = 0 {
if runmode =1 { 
 lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
 print "VB:    " + VB + "      " at (5,5).
 print "talt:    " + FD + "      " at (5,6). 
 print "dtg:    " +round(dtg(),2) + "      " at (5,7).
 print "RUNMODE:    " + runmode + "      " at (5,8).

 //print "dtt:    " +round(dtt(),2) + "      " at (5,10).
if vb < 10 set runmode to 2.}

if runmode = 2 {
  until dtg() < 24{
    lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
    print "VB:    " + VB + "      " at (5,5).
    print "talt:    " + FD + "      " at (5,6). 
    print "dtg:    " +round(dtg(),2) + "      " at (5,7).
    print "RUNMODE:    " + runmode + "      " at (5,8).
    
    print "Fore: " + axis_distance[1] + "      " at (5,11).
    print "star:    " + axis_distance[2] + "      " at (5,12).
    print "top:    " + axis_distance[3] + "      " at (5,13).
    set talt to max(21,talt - 0.35). 
    wait 0.}
  
  set runmode to 3.
}
//runpath("0:/f2.ks").
 if runmode = 3 {     
global start_time is time:seconds.
global original_length is ship:parts:length. 
  until ship:parts:length > original_length {
   lock steering to up.
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
   
    print "Fsetpoint:    " + PIDfore:SETPOINT + "      " at (5,15).
    print "ssetpoint:    " + PIDstar:SETPOINT + "      " at (5,16).
    print "tsetpoint:    " + PIDtop:SETPOINT + "      " at (5,17).
    
    print "fore S " + axis_speed[1] + "      " at (5,19).
    print "star S " + axis_speed[2] + "      " at (5,20).
    print "top  S " + axis_speed[3] + "      " at (5,21).

    
    print "dtg:    " +round(dtg(),2) + "      " at (5,23).

   
   
    if vb < 0.1 {set talt to max(10,talt - 0.35).}
    if vb < 0.05 {lock talt to min(10,vb * 500).}
    IF ABS(desiredFore) > RCSdeadZone { SET desiredFore TO 0. }
    IF ABS(desiredstar) > RCSdeadZone { SET desiredFore TO 0. }
    }
  }
}


 
 FUNCTION axis_speed {
	global globalStation IS target:position.
	global globalship IS SHIP.
	global relitaveSpeedVec IS SHIP:VELOCITY:SURFACE - target:VELOCITY:surface.	//relitaveSpeedVec is the speed as reported by the navball in target mode as a vector along the target prograde direction
	global speedFor IS VDOT(relitaveSpeedVec, ship:Facing:FOREVECTOR).	//positive is moving forwards, negative is moving backwards
	global speedStar IS VDOT(relitaveSpeedVec, ship:Facing:STARVECTOR).	//positive is moving right, negative is moving left
	global speedtop IS VDOT(relitaveSpeedVec, ship:Facing:topVECTOR).
  RETURN LIST(relitaveSpeedVec,speedFor,speedStar,speedtop).
}
FUNCTION axis_distance {
   
	global distVec IS vxcl(up:vector,gp:POSITION).//vector pointing at the station port from the ship: port
	global dist IS vb().
	global distFor IS VDOT(distVec,ship:Facing:FOREVECTOR ).	//if positive then stationPort is ahead of ship:Port, if negative than stationPort is behind of ship:Port
	global distStar IS VDOT(distVec,ship:Facing:STARVECTOR).	//if positive then stationPort is to the right of ship:Port, if negative than stationPort is to the left of ship:Port
	global disttop IS VDOT(distVec,ship:Facing:topVECTOR).
  RETURN LIST(dist,distFor,distStar,disttop).
}
function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}
FUNCTION math {
  lock mathResult to ((talt-dtg())/8).
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
FUNCTION start {
    stage.
    rcs on.
    gear off.
    brakes off.
    sas off.
    LOCK FD TO talt.
    lock FC to AC().
    lock TARGET TO VESSEL("SCR").
    lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
    global tOld is time:seconds - 0.02.
    global target_twr is 0.
    lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
    lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
    lock maxAcc to ship:availablethrust / mass.
    lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
    global desiredFore IS 0.
    global desiredstar IS 0.
    global desiredtop  IS 0.
    global shipFacing IS ship:facing.
    global axisSpeed IS axis_speed().
    global RCSdeadZone IS 0.05.
    global PIDtop is pidloop(4, 0.1, 0.1, -10, 10).
    global PIDfore is pidloop(4, 0.1, 0.1, -10, 10).
    global PIDstar is pidloop(4, 0.1, 0.1, -10, 10).
    global pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
    lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
    global last_time is time:seconds.
    global total_error is 0.}