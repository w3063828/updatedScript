
start().
until vb < 10 {
    set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
    set RV:mag to min(8,RV:mag). //just for safety
    lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
    print "VB:    " + VB + "      " at (5,5).
    print "talt:    " + tAlt + "      " at (5,6). 
    if vb < 1 and vb > 0 {
    clearscreen.
    start2().
  }
}
function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
FUNCTION math {
  lock mathResult to ((talt-dtg())/4).
  RETURN mathResult.
}
FUNCTION start {
CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal"). 
lock TARGET TO VESSEL("jORFRID'S dEBRIS").
   set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
 lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
  STAGE.
  lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
  lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
  global PIDfore is pidloop(4,1,1,-10,10).
  global PIDstar is pidloop(4,1,1,-10,10).
  global PIDtop is pidloop(4,1,1,-10,10).
 // global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
  local pid is pidloop(1.81818181818182, 4.0606958269566, 0.587368878071348, 0, maxtwr).
  GLOBAL pid_throttle is 0.
  global RCSdeadZone IS 0.05.//rcs will not fire below this value
  global desiredFore IS 0.
  global desiredStar IS 0.
  GLOBAL desiredtop  IS 0.
  global shipFacing IS ship:facing:inverse.
  global axis_distance IS axis_distance().
  global tOld is time:seconds - 0.02.
  GLOBAL axisSpeed IS axis_speed().

  sas on.
  wait 2.
  sas off.
  gear on.
  set tAlt to 70.
  lock tAlt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + tAlt.
  lock maxAcc to ship:availablethrust / mass.
  lock throttle to (GRAV / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
  
}
function start2 {
  set talt to 20.
  set TRTM to vxcl(up:vector,gp:POSITION).
  set TRTM to VECDRAWARGS( V(0,0,0),target:position,green,"ship",1,true).
  global target_twr is 0.
  local pid is pidloop(1.81818181818182, 4.05284576246403, 0.0588506568436101, 0, maxtwr).
      lock steering to UP.
      set ship:control:pilotmainthrottle to 0.
      set PIDfore:SETPOINT TO 0.
      set PIDstar:SETPOINT TO 0.
      set PIDtop:SETPOINT TO 0.
      set SHIP:CONTROL:fore TO (desiredFore *1).
      set SHIP:CONTROL:top TO (desiredtop * -1).
      set SHIP:CONTROL:starboard TO (desiredstar * -1).
      RCS ON.
  until vb < 0 {
  //lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
  
  set pid:maxoutput to maxtwr.
  lock throttle to min(target_twr / maxtwr, 1).
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  set pid:setpoint to math(). 
  print "setpoint" + pid:setpoint + "      " at (5,5).
  print "dtg:    " +round(dtg(),2) + "      " at (5,6).
  print "current erorr:    " + round(abs(dtg() - talt),2) + "      " at (5,7).
  print "VB:    " + VB + "      " at (5,8).
  print "talt:    " + tAlt + "      " at (5,15). 
    print "desiredFore:  " + round(desiredFore) + "      " at (5,9).
    print "desiredstar:  " + round(desiredstar) + "      " at (5,10).
    print "desiredtop:  " + round(desiredtop) + "      " at (5,11).
    //print "myVelocity:  " + axis_speed[0] + "      " at (5,11).
    
    print "fore  " + axis_distance[1] + "      " at (5,12).
    print "star  " + axis_distance[2] + "      " at (5,13).
    print "top  " + axis_distance[3] + "      " at (5,14).
  
  SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_distance[1]).
  SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_distance[2]). 
  SET desiredtop TO PIDtop:UPDATE(TIME:SECONDS,axis_distance[3]).
  IF ABS(desiredFore) > RCSdeadZone { SET desiredFore TO 0. }
  IF ABS(desiredStar) > RCSdeadZone { SET desiredStar TO 0. }
  IF ABS(desiredTOP) > RCSdeadZone { SET desiredStar TO 0. }     
  }
  
}
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

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
FUNCTION mathf {
  lock mathResult to (axis_distance[1]/10).
  RETURN mathResult.
}
FUNCTION maths {
  lock mathResult to (axis_distance[2]/10).
  RETURN mathResult.
}
FUNCTION matht {
  lock mathResult to (axis_distance[3]/10).
  RETURN mathResult.
}