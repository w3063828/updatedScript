clearscreen.
CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
//SET TARGET TO VESSEL("mr").
set gp to LATLNG(-0.0967646955755359,-74.6187122587352). //VAB //SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION). //VAB
lock target to gp.
//sas on.
rcs on.
LOCK THROTTLE TO 1. 
WAIT 1.5.
global speedlimit is 45.
sas off.
gear on.
set tAlt to 70.
  lock GRAV to body:mu / body:position:sqrmagnitude.
 lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
lock tAlt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + tAlt.
lock grav to body:mu / body:position:sqrmagnitude.
lock maxAcc to ship:availablethrust / mass.
//lock throttle to (grav / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
global PIDpitch is pidloop(4, 0.1, 0.1, -90, 90).
global pid is pidloop(1.81818181818182, 1.63652641119137, 0.0434983348738613, 0, maxtwr).
//wait 10.
//steering to GEO
until ship:status = "Landed" {
    SET desiredpitch TO (90 + PIDpitch:UPDATE(TIME:SECONDS,axis_speed[1])).
    set target_twr to pid:update(time:seconds, ship:verticalspeed).
    set last_time to time:seconds. 
    LOCK STEERING TO HEADING(TARGET:HEADING,desiredpitch).
     set PIDpitch:SETPOINT TO math3().
     set pid:setpoint to math().
     set pid:maxoutput to maxtwr.  
     lock throttle to min(target_twr / maxtwr, 1).  
     lock myVelocity to ship:facing:inverse * ship:velocity:surface.
       print "VERT " + round(math(),3) + "      " at (5,5).
       print "Desired lateral speed " + round(math3(),3) + "      " at (5,6). 
       print "desired pitch " + round(desiredpitch,3) + "      " at (5,7).
       print "pitch:    " + round(pitch_for(),4) + "      " at (5,8).
      //speed
       print "vertspeed:" + round(verticalspeed,1) + "      " at (5,10).
       print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,11).
       print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,12).
       print "fore speed " + round(axis_speed[1],3) + "      " at (5,13).
       //distance 
        print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,15). 
        print "dtg:    " +round(dtg(),2) + "      " at (5,16). 
        print "str line dist:    " + round(VB(),1) + "      " at (5,18).
        print "fore D " + round(axis_distance[1],3) + "      " at (5,19).
        print "star D " + round(axis_distance[2],3) + "      " at (5,20). 
        print "stopD    " + stoppingDistance() + "      " at (5,21).
}

wait 3.

//landing throttle shutdown
when ship:status:contains("landed") then {
    lock throttle to 0. 
    set gp to 0.
}

wait until false.

function mathE {
lock mathResulte to (round(axis_speed[1],3)/4).
lock mathResultF to (mathResulte + mathf).
  RETURN mathResultf.}

function math3 {
    lock mathResult1 to min(speedlimit,(axis_distance[1]/10)).
  RETURN mathResult1.}


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
function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}
FUNCTION math {
  lock mathResult to ((talt-dtg())/8).
  RETURN mathResult.
}

FUNCTION mathf {
  lock mathResult to -1 *(axis_distance[1]/4).
  RETURN mathResult.
}
FUNCTION maths {
  lock mathResult to -1 * (axis_distance[2]/4).
  RETURN mathResult.
}
FUNCTION matht {
  lock mathResult to -1 * (axis_distance[3]/4).
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
function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  //return  90 - vang(ves:up:vector, pointing).}
  return vang(ves:up:vector, pointing).}