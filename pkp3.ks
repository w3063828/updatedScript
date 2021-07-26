//RUNPATH("0:/F1.KS").

//stage.
SET SHIP:CONTROL:NEUTRALIZE to TRUE.
local speedlimit is 10.
stage.
START().
set vbold to VB() + 100.
local original_length is ship:parts:length. ///ship:parts:length > original_length 
until dtg() > height  and vb() < 75 {
  set STEERING TO HEADING(gp:HEADING,math()).
  print "pitch:    " + round(pitch_for(),4) + "      " at (5,2).
  print "math:    " +round(math(),2) + "      " at (5,3).


  wait 0.}
SET TALT TO (HEIGHT + 20).
CLEARSCREEN.
SET CONFIG:IPU TO 600.
set sign to (vbold - vb()).
until ship:parts:length > original_length {
   set vbold to vb().
  if vb() < 30 {lock steering to up. LOCK TALT TO MATHgg().  }
  if vb() > 30 {set STEERING TO HEADING(gp:HEADING,math()).}
   set PIDfore:SETPOINT TO MIN(7,(axis_distance[1]/5)).
   set PIDstar:SETPOINT TO MIN(7,(axis_distance[2]/5)).
   set PIDtop:SETPOINT TO MIN(7,(axis_distance[3]/5)).
   lock myVelocity to ship:facing:inverse * ship:velocity:surface.
   SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1])/1 .
   SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2])/1. 
   SET desiredtop TO PIDtop:UPDATE(TIME:SECONDS,axis_speed[3])/1.
   set SHIP:CONTROL:top TO desiredtop. 
   set SHIP:CONTROL:starboard TO desiredstar. 
   set last_time to time:seconds. 
   print "sign " + round(sign,3) + "      " at (5,1).
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,2).
    print "math:    " +round(math(),2) + "      " at (5,3).
    print "talt:    " + talt + "      " at (5,4).
    print "VB:    " + round(VB(),4) + "      " at (5,5).
    print "fore D " + round(axis_distance[1],3) + "      " at (5,7).
    print "star D " + round(axis_distance[2],3) + "      " at (5,8).
    print "top  D " + round(axis_distance[3],3) + "      " at (5,9). 
    print "bb " + height + "      " at (5,10). 
    print "desiredFore:  " + round(desiredFore,2) + "      " at (5,11).
    print "desiredstar:  " + round(desiredstar,2) + "      " at (5,12).
    print "desiredtop:  " + round(desiredtop,2) + "      " at (5,13).
    print "dtg:    " +round(dtg(),2) + "      " at (5,14).
    IF ABS(desiredFore) < 1 { SET desiredFore TO 0. }
    IF ABS(desiredstar) < RCSdeadZone { SET desiredstar TO 0. }
    IF ABS(desiredtop) < RCSdeadZone { SET desiredtop TO 0. }
     //set SHIP:CONTROL:fore TO desiredFore.
     
     set sign to (vbold - vb()).
    }
 SET CONFIG:IPU TO 200.

function VB{
   return ROUND(vxcl(up:vector,gp:POSITION):mag,4).

}

FUNCTION start {
  CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal"). 
  //lock TARGET TO VESSEL("BN 1").
  lock TARGET TO VESSEL("sbn 1.35 probe").
  set PortList to target:modulesnamed("ModuleDockingNode").
  for Ports in PortList {
  set port to Ports:PART.
	print port:name.
	if port:tag = "TgtDockPort" {
	set height to port:bounds:bottomaltradar.
  print height.
	print "Docking port targetted".
  wait 2.
	}}
  clearscreen.
 
 set height to port:bounds:bottomaltradar.
//  set gp to LATLNG(-0.0967646955755359,-74.6187122587352).
//  set height to body:geopositionOf(gp:position):terrainHeight.
  lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
  lock grav to body:mu / body:position:sqrmagnitude.
  gear off.
  set leg_part to ship:partstagged("hdd")[0].
  global target_twr is 0.
  LOCAL desiredFore IS 0.
  LOCAL desiredstar IS 0.
  LOCAL desiredtop  IS 0.
  LOCAL shipFacing IS ship:facing.
  global axisSpeed IS axis_speed().
  global RCSdeadZone IS 0.4.
  global PIDtop is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDfore is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDstar is pidloop(4, 0.1, 0.1, -10, 10).
  global last_time is time:seconds.
  set rv to 0.
  set talt to (height + 20).
  sas off.
  RCS ON.
  lock maxAcc to ship:availablethrust / mass.
  LOCK STEERING TO HEADING(gp:HEADING,90).
  lock throttle to (GRAV / maxAcc + (talt - DTG()) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
  clearscreen.
  global ipuBackup IS CONFIG:IPU.
  if ipuBackup > 201 {set ipuBackup to 200.} 
  GLOBAL desiredFore IS 0.
  global desiredstar IS 0.
  global desiredtop  IS 0.
  set STEERING TO HEADING(gp:HEADING,math()).
}

FUNCTION START2 {
 local lasParts is ship:partstagged("landing laser").
  local hasLas is false.
  global lasMod is 0.
  if lasParts:length > 0 {
    set lasMod to lasParts[0]:getmodule("LaserDistModule").
    set hasLas to true.
    lasMod:setfield("Enabled", true).
    lasMod:setfield("Visible", true).}
   
   local lasParts1 is ship:partstagged("landing laser1").
   local hasLas1 is false.
   global lasMod1 is 0.
  if lasParts:length > 0 {
    set lasMod1 to lasParts1[0]:getmodule("LaserDistModule").
    set hasLas1 to true.
    lasMod1:setfield("Enabled", true).
    lasMod1:setfield("Visible", true).}

 local lasParts2 is ship:partstagged("landing laser2").
  local hasLas2 is false.
  global lasMod2 is 0.
  if lasParts:length > 0 {
    set lasMod2 to lasParts2[0]:getmodule("LaserDistModule").
    set hasLas2 to true.
    lasMod2:setfield("Enabled", true).
    lasMod2:setfield("Visible", true).}

}



function AC {return min((height + 10),height + (VB*10)).}


function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}


function east_for {
  parameter ves is ship.

  return vcrs(ves:up:vector, ves:north:vector).
}

function compass_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  local east is east_for(ves).

  local trig_x is vdot(ves:north:vector, pointing).
  local trig_y is vdot(east, pointing).

  local result is arctan2(trig_y, trig_x).

  if result < 0 {
    return 360 + result.
  } else {
    return result.
  }
}

function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return 90 - vang(ves:up:vector, pointing).
}

function roll_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing.
  if not thing:istype("string") {
    if thing:istype("vessel") or pointing:istype("part") {
      set pointing to thing:facing.
    } else if thing:istype("direction") {
      set pointing to thing.
    } else {
      print "type: " + thing:typename + " is not reconized by roll_for".
	}
  }

  local trig_x is vdot(pointing:topvector,ves:up:vector).
  if abs(trig_x) < 0.0035 {//this is the dead zone for roll when within 0.2 degrees of vertical
    return 0.
  } else {
    local vec_y is vcrs(ves:up:vector,ves:facing:forevector).
    local trig_y is vdot(pointing:topvector,vec_y).
    return arctan2(trig_y,trig_x).
  }
}

function compass_and_pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  local east is east_for(ves).

  local trig_x is vdot(ves:north:vector, pointing).
  local trig_y is vdot(east, pointing).
  local trig_z is vdot(ves:up:vector, pointing).

  local compass is arctan2(trig_y, trig_x).
  if compass < 0 {
    set compass to 360 + compass.
  }
  local pitch is arctan2(trig_z, sqrt(trig_x^2 + trig_y^2)).

  return list(compass,pitch).
}

function bearing_between {
  parameter ves,thing_1,thing_2.

  local vec_1 is type_to_vector(ves,thing_1).
  local vec_2 is type_to_vector(ves,thing_2).

  local fake_north is vxcl(ves:up:vector, vec_1).
  local fake_east is vcrs(ves:up:vector, fake_north).

  local trig_x is vdot(fake_north, vec_2).
  local trig_y is vdot(fake_east, vec_2).

  return arctan2(trig_y, trig_x).
}

function type_to_vector {
  parameter ves,thing.
  if thing:istype("vector") {
    return thing:normalized.
  } else if thing:istype("direction") {
    return thing:forevector.
  } else if thing:istype("vessel") or thing:istype("part") {
    return thing:facing:forevector.
  } else if thing:istype("geoposition") or thing:istype("waypoint") {
    return (thing:position - ves:position):normalized.
  } else {
    print "type: " + thing:typename + " is not recognized by lib_navball".
  }
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

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
FUNCTION mathf {
  lock mathResult to -1 *(axis_distance[1]/2).
  RETURN mathResult.
}
FUNCTION maths {
  lock mathResult to -1 * (axis_distance[2]/2).
  RETURN mathResult.
}
FUNCTION matht {
  lock mathResult to -1 * (axis_distance[3]/2).
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

 FUNCTION mathGG {
  lock mathResult to min((height +5),((height  + (VB * 4)) - 4)) .
  RETURN mathResult.
} 
function dtg {
 
 local bounds_box is leg_part:bounds.
 
   return bounds_box:bottomaltradar.
}

function dtgL {
 local dist is lasMod:getfield("distance"). 
  local dist1 is lasMod1:getfield("distance"). 
 local dist2 is lasMod2:getfield("distance"). 
 LOCAL MT1 IS MIN(DIST,DIST1).
 LOCAL MT2 IS MIN(MT1,DIST2).
 RETURN MT2.}

function L {
  RETURN MIN(DTG,DTGL).}


FUNCTION math {
  lock mathResult to ((15 - ship:groundspeed)/2.5).
  lock mathResultZ to (((vb()/20) - ship:groundspeed)/2).
  RETURN   90 - min(mathResult,mathResultZ).
}

function dl {
    lock mathResult1 to (geo_diff:mag /(tti + 1)).
    RETURN mathResult1.}
    