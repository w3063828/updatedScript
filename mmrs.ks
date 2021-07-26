clearscreen.
SAS OFF.
rcs on.
set talt to 70.
start().
until ship:verticalSpeed < -1 {WAIT 1.}
until ship:ALTITUDE < 50000 {WAIT 1.}

until ship:status = "Landed" {
        if TTI < 17 { lock throttle to min(target_twr / maxtwr, 1).
                 SET PID:SETPOINT TO math().}
        if dtg() < 1000 and ship:verticalspeed > -5 {set steering to up.  }
        if dtg < 150 {set talt to max(1,(talt - 2)).}
       print "Impact Time:" + round(TTI,1) + "      " at (5,5). 
       print "vertspeed:" + round(verticalspeed,1) + "      " at (5,10).
       print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,12).
       print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,15). 
       print "dtg:    " +round(dtg(),2) + "      " at (5,16). 
       set last_time to time:seconds. 
       set pid:maxoutput to maxtwr.
       set target_twr to pid:update(time:seconds, ship:verticalspeed).
    }


shutdown_stack().
        
 
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
   lock GRAV to body:mu / body:position:sqrmagnitude.

  lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
  lock maxAcc to ship:availablethrust / mass.
  lock STEERING to velocity:surface * -1.
  brakes on.
  global pid is pidloop(1.81818181818182, 1.2556497533381310, 0.189951564576641, 0, maxtwr).
  set leg_part to ship:partstagged("Hf")[0].
  lock surfaceElevation to body:geopositionOf(ship:position):terrainHeight.
  lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).
}
function dtg {
 
 local bounds_box is leg_part:bounds.
 
   return max(bounds_box:bottomaltradar,betterALTRADAR).
}
FUNCTION math {  
  lock mathResult to ((talt-dtg())/27.8).
  RETURN mathResult.
}
FUNCTION TTI {
  

  LOCAL d IS ALT:RADAR.
  LOCAL v IS -SHIP:VERTICALSPEED.
  LOCAL g IS grav.

  RETURN (SQRT(v^2 + 2 * g * d) - v) / g.
}