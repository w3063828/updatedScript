
SAS off.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
RCS on.
gear off.
lights on.

set desiredpitch to 1.
local target_twr is 0.
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).
lock maxAcc to ship:availablethrust / mass.
lock throttle to min(target_twr / maxtwr, 1).
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
lock impactTime to betterALTRADAR / -VERTICALSPEED.
lock landingRadar to min(ALTITUDE, betterALTRADAR). 
set throttle to 0.
set talt to 78.

clearscreen.
until SHIP:ALTITUDE < 30000 and ship:AIRSPEED < 700 {
        set steering to prograde * r(-75, 0, 0):vector.
        print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,5).
        print "vertspeed:" + round(verticalspeed,1) + "      " at (5,6).
        print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,7).
    }
clearscreen.   

set PIDpitch to pidloop(4, 0.1, 0.01, -75, 75).   
lock r1 to desiredpitch.
lock steering to heading(90, desiredpitch).
until dtg() < 550 {
       set PIDpitch:SETPOINT TO math().
       SET desiredpitch TO -1 * PIDpitch:UPDATE(TIME:SECONDS,GROUNDSPEED).
       set last_time to time:seconds. 

       print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
       print "desired pitch " + round(desiredpitch,3) + "      " at (5,4).
       print "vertspeed:" + round(verticalspeed,1) + "      " at (5,6).
       print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,5).
       print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,7).
       print "dtg:    " +round(dtg(),2) + "      " at (5,8). 
       
    }
set throttle to (2.5 * Ship:Mass * GRAV / ship:availablethrust).      

clearscreen.
ag3 on.
until pitch_for >85 {
         
         print "pitch:    " + round(pitch_for(),4) + "      " at (5,9). 
         wait 0.
       }

lock throttle to (GRAV / maxAcc + (talt - DTG()) / 8 - verticalspeed / 1) / vdot(up:vector,facing:vector).  
lock steering to descent_vector.   
ag4 on.  
until ship:status = "Landed" {    
     
        if ship:GROUNDSPEED < 1 {lock steering to up.}
        if dtg()< 86 and ship:GROUNDSPEED < 2 set tAlt to 0.1. 
         print "desired pitch " + round(desiredpitch,3) + "      " at (5,4).
       print "vertspeed:" + round(verticalspeed,1) + "      " at (5,6).
       print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,5).
       print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,7).
       print "dtg:    " +round(dtg(),2) + "      " at (5,8). 
       print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
        }
    









function math {
    lock mathResult1 to (ship:GROUNDSPEED / 20).
  RETURN mathResult1.}

function dtg {return altitude - body:geopositionOf(ship:position):terrainHeight.}

FUNCTION shutdown_stack {
	RCS OFF.
	UNLOCK STEERING.
	UNLOCK THROTTLE.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	SET SHIP:CONTROL:FORE TO 0.
	SET SHIP:CONTROL:TOP TO 0.
	SET SHIP:CONTROL:STARBOARD TO 0.

}

Function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return  90 - vang(ves:up:vector, pointing). 
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
function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * grav - velocity:surface).}
function unrotate {
  parameter v. if v:typename <> "Vector" set v to v:vector.
  return lookdirup(v, ship:facing:topvector).}


