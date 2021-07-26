
start().
     until ship:verticalSpeed < -1 {wait 2.}.
     lock STEERING to velocity:surface * -1.
     //LOCK STEERING TO GP:POSITION * -1.
     until TTI < 35 {WAIT 1.}
     set target_twr to 0.
     lock throttle to min(target_twr / maxtwr, 1).
     set pid:maxoutput to maxtwr.  
    until dtg() < 500 and ship:verticalspeed > -40  and ship:groundspeed < 2 { 
                                                      set target_twr to pid:update(time:seconds, ship:verticalspeed).
                                                      lock STEERING to velocity:surface * -1.
                                                      SET PID:SETPOINT TO math().
                                                    
                                                      print "vertspeed:" + round(verticalspeed,1) + "      " at (5,5).
                                                      print "dtg:    " +round(dtg(),2) + "      " at (5,6). 
                                                       set last_time to time:seconds. } 
     set pid to pidloop(1.81818181818182, 0.9725434, 0.2434983348738613, 0, maxtwr).
    lock steering to up.
     ag6 on.
     SET PID:SETPOINT TO -10.
      local last_time is time:seconds.
     

     until ship:status = "Landed" {                   print "vertspeed:" + round(verticalspeed,1) + "      " at (5,5).
                                                      print "dtg:    " +round(dtg(),2) + "      " at (5,6). 
                                                      print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,7).
                                                      
                                                      set target_twr to pid:update(time:seconds, ship:verticalspeed).
                                                      lock myVelocity to ship:facing:inverse * ship:velocity:surface.
                                                      
                                                      if dtg < 100 { SET PID:SETPOINT TO -3.}
                                                      set last_time to time:seconds. }


  

set throttle to 0.
SET SHIP:CONTROL:NEUTRALIZE to TRUE.
toggle brakes.
abort on.

function stoppingDistance {
  local maxDeceleration is (ship:availableThrust / ship:mass) - GRAV.
  return ship:verticalSpeed^2 / (2 * maxDeceleration).}
  
function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * grav - velocity:surface).}

function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.}

function unrotate {
  parameter v. if v:typename <> "Vector" set v to v:vector.
  return lookdirup(v, ship:facing:topvector).}

  function delta {
  local maxDeceleration is (ship:availableThrust / ship:mass) - GRAV.
  local beta is (SQRT(ship:verticalSpeed^2 + SHIP:GROUNDSPEED^2)).
  local charlie is beta^2 / (2 * maxDeceleration).
  return list (beta,charlie).
  }

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


function dl {
    lock mathResult1 to (geo_diff:mag /(tti + 1)).
    RETURN mathResult1.}
    


FUNCTION TTI {
  

  LOCAL d IS ALT:RADAR.
  LOCAL v IS -SHIP:VERTICALSPEED.
  LOCAL g IS grav.

  RETURN (SQRT(v^2 + 2 * g * d) - v) / g.
}

function VB{
   return ROUND(vxcl(up:vector,gp:POSITION):mag,4).

}

FUNCTION start {
RUNONCEPATH("0:/lib_rocket_utilities").
//set gp to LATLNG(-0.0967646955755359,-74.6187122587352).
set gp to addons:tr:impactpos.
LOCK STEERING TO Retrograde.
rcs on.

toggle AG1. 
set rv to 0.
SET HEIGHT TO GP:terrainheight.
lock GRAV to body:mu / body:position:sqrmagnitude.
lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
lock forespeed to round(axis_speed[1],0).
lock cygnus to round(dl(),0).
lock maxAcc to ship:availablethrust / mass.
lock shipLatLng to SHIP:GEOPOSITION.
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
lock impactTime to betterALTRADAR / -VERTICALSPEED.
lock RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. 
set talt to 55.
global ipuBackup IS CONFIG:IPU.
if ipuBackup > 201 {set ipuBackup to 200.} 
SET CONFIG:IPU TO 200.
set overshoot to 1.
GLOBAL geo_diff is v(0,0,0).
set offset to vxcl(gp:position-body:position,gp:position).
GLOBAL target_pos is gp:position.

global pid is pidloop(1.81818181818182, 1.2556497533381310, 0.189951564576641, 0, maxtwr).
control_point().

LOCK accel TO SHIP:SENSORS:acc:mag.


}

function AC {return min((height + 10),height + (VB*20)).}

function dtt {
 return SHIP:ALTITUDE - target:ALTITUDE.}
function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}

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
	LOCAL localStation IS gp.//.
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
 
   return GG.
}
FUNCTION math {  
  lock mathResult to ((talt-dtg())/12).
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
  lock mathResult to min((height +10) ,(height + (VB*20))).
  RETURN mathResult.
} 
function math3 {
    lock mathResult1 to (axis_distance[1]/(impacttime + ALTITUDE/2000)).
  RETURN mathResult1.}

  
FUNCTION control_point {
	PARAMETER pTag IS "TgtDockPort".
	LOCAL controlList IS SHIP:PARTSTAGGED(pTag).
	IF controlList:LENGTH > 0 {
		controlList[0]:CONTROLFROM().
	} ELSE {
		IF SHIP:ROOTPART:HASSUFFIX("CONTROLFROM") {
			SHIP:ROOTPART:CONTROLFROM().
		}
	}
}