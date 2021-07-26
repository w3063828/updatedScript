//RUNPATH("0:/F1.KS").
SET CONFIG:IPU TO 200.
SET SHIP:CONTROL:NEUTRALIZE to TRUE.
local speedlimit is 45.
set rv to 0.
wait 1.
set talt to 140.
sas off.
start().
set TRTM to vxcl(up:vector,gp:POSITION).
lock RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
//set RV:mag to min(8,RV:mag). //just for safety

rcs on.
lock steering to lookdirup(up:vector * 88 + RV, facing:topvector).
  until vb < 175 {
   set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) /8. //relative velocity vector, we base our steering on this
   set RV:mag to min(8,RV:mag). //just for safety
 print "VB:    " + VB + "      " at (5,5).
 print "talt:    " + FD + "      " at (5,6). 
 print "dtg:    " +round(dtg(),2) + "      " at (5,7).
 
 print "pitch_for:    " + pitch_for() + "      " at (5,9).
 //print "dtt:    " +round(dtt(),2) + "      " at (5,10).
 print "bb " + height + "      " at (5,10). 
 wait 0.
  }

lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).

  until dtg < (height + 20){
    set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) /8. //relative velocity vector, we base our steering on this
    set RV:mag to min(8,RV:mag). //just for safety
    print "VB:    " + VB + "      " at (5,5).
    print "talt:    " + FD + "      " at (5,6). 
    print "dtg:    " +round(dtg(),2) + "      " at (5,7).
    
    print "pitch_for:    " + pitch_for() + "      " at (5,9).
    //print "dtt:    " +round(dtt(),2) + "      " at (5,10).
    print "bb " + height + "      " at (5,10). 
    set talt to max(45,talt - 0.35). 
    wait 0.}

  
 set config:ipu to max(config:ipu,600).
clearscreen.
  LOCAL desiredFore IS 0.
  LOCAL desiredstar IS 0.
  LOCAL desiredtop  IS 0.
  rcs on.
  LOCK TALT TO MATHgg().
  local original_length is ship:parts:length. 
  lock myVelocity to ship:facing:inverse * ship:velocity:surface. 
    set pid:maxoutput to maxtwr.
  until ship:parts:length > original_length {
          set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) /8. //relative velocity vector, we base our steering on this
          set RV:mag to min(8,RV:mag). //just for safety
        SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1]).
        SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2]). 
        SET desiredtop TO PIDtop:UPDATE(TIME:SECONDS,axis_speed[3]).
        set PIDfore:SETPOINT TO (axis_distance[1]/20).
        set PIDstar:SETPOINT TO (axis_distance[2]/20).
        set PIDtop:SETPOINT TO  (axis_distance[3]/20).
        set target_twr to pid:update(time:seconds, ship:verticalspeed).
        //lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
        print "talt:    " + talt + "      " at (5,4).
        print "VB:    " + round(VB(),4) + "      " at (5,5).
        //print "fore D " + round(axis_distance[1],3) + "      " at (5,7).
        //print "star D " + round(axis_distance[2],3) + "      " at (5,8).
        //print "top  D " + round(axis_distance[3],3) + "      " at (5,9). 
        print "bb " + height + "      " at (5,10). 
        print "desiredFore:  " + round(desiredFore,2) + "      " at (5,11).
        print "desiredstar:  " + round(desiredstar,2) + "      " at (5,12).
        print "desiredtop:  " + round(desiredtop,2) + "      " at (5,13).
        print "dtg:    " +round(dtg(),2) + "      " at (5,23).
        IF ABS(desiredFore) > RCSdeadZone { SET desiredFore TO 0. }
        IF ABS(desiredstar) > RCSdeadZone { SET desiredstar TO 0. }
        IF ABS(desiredtop) > RCSdeadZone { SET desiredtop TO 0. }
        if vb() < 55 {lock steering to up.
        set SHIP:CONTROL:fore TO desiredFore.
        set SHIP:CONTROL:top TO desiredtop. 
        set SHIP:CONTROL:starboard TO desiredstar.
        }
        else {lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).
        SET SHIP:CONTROL:NEUTRALIZE to TRUE.}
        set pid:setpoint to math().
        set last_time to time:seconds. 
        

    }
  set config:ipu to 200.

function VB{
   return ROUND(vxcl(up:vector,gp:POSITION):mag,4).

}

FUNCTION start {
  CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal"). 
 // lock TARGET TO VESSEL("sn 1").
  // set PortList to target:modulesnamed("ModuleDockingNode").
  //for Ports in PortList {
	//set port to Ports:PART.
	//print port:name.
	//if port:tag = "TgtDockPort" {
//		set target to port.
//	print "Docking port targetted".
//	}}
set gp to LATLNG(-0.0967646955755359,-74.6187122587352).
set height to body:geopositionOf(gp:position):terrainHeight.
  control_point().
  clearscreen.
   //local port is target.
   //global height is port:bounds:bottomaltradar.
   set leg_part to ship:partstagged("Hf")[0].
  //lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
  lock GRAV to body:mu / body:position:sqrmagnitude.
  lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
  lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
  global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
  global tOld is time:seconds - 0.02.
  gear off.
  global target_twr is 0.
  LOCAL desiredFore IS 0.
  LOCAL desiredstar IS 0.
  LOCAL desiredtop  IS 0.
  LOCAL shipFacing IS ship:facing.
  global axisSpeed IS axis_speed().
  global RCSdeadZone IS 0.04.
  global PIDtop is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDfore is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDstar is pidloop(4, 0.1, 0.1, -10, 10).
  //local pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
  global last_time is time:seconds.
  global total_error is 0.
  LOCK FD TO talt.
  lock FC to AC().
  lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
  lock maxAcc to ship:availablethrust / mass.
  lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   wait 1.5.
}

function AC {return min((height + 10),height + (VB*20)).}

function dtt {
 return SHIP:ALTITUDE - target:ALTITUDE.}


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
function dtg {
 
 local bounds_box is leg_part:bounds.
 
   return bounds_box:bottomaltradar.
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

 FUNCTION mathGG {
  lock mathResult to (min((height + 15) ,(height + (VB*5))) + 0).
  RETURN mathResult.
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
