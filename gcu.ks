  
// PID Test v1.0.0
// Kevin Gisi
// http://youtube.com/gisikw
set tAlt2 to 70.
SET kP TO 0.01.
SET kI TO 0.005.
SET kD TO 0.005.

SET lastP TO 0.
SET lastTime TO 0.
SET totalP TO 0.
LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock maxAcc to ship:availablethrust / mass.

FUNCTION PID_LOOP {
  PARAMETER target.
  PARAMETER current.

  SET output TO 0.
  SET now TO TIME:SECONDS.

  SET P TO target - current.
  SET I TO 0.3734305021353066.
  SET D TO 0.52321681985631585.

  IF lastTime > 0 {
    SET I TO totalP + ((P + lastP)/2 * (now - lastTime)).
    SET D TO (P - lastP) / (now - lastTime).
  }

  SET output TO P * kP + I * kI + D * kD.

  CLEARSCREEN.
  PRINT "P: " + P.
  PRINT "I: " + I.
  PRINT "D: " + D.
  PRINT "Output: " + output.
  print "dtg:    " +round(dtg(),2) + "      " at (5,8).

  SET lastP TO P.
  SET lastTime TO now.
  SET totalP TO I.
  
  RETURN output.
}

// Get us 500 meters up

set runmode to 1.
until runmode = 0 {
    if runmode =1 {
        LOCK STEERING TO HEADING(90, 90).
        set throttle to 0.25.
        if atg() > tAlt2 {SET RUNMODE TO 2.}
        }

    if runmode =2 {
        set throttle to 0.
        // Test our proportional function
        SET autoThrottle TO 0.
        LOCK THROTTLE TO autoThrottle.
        SET startTime TO TIME:SECONDS.
        SET autoThrottle TO PID_LOOP(tAlt2, dtg()).
        SET autoThrottle TO MAX(0, MIN(autoThrottle, 1)).
        WAIT 0.001.
        LOG (TIME:SECONDS - startTime) + "," + dtg() + "," + autoThrottle TO "testflight.csv".
        if time:seconds > startTime + 60 {set runmode to 3.}
        }
    if runmode =3 {
        LOCK THROTTLE TO 0.
        reboot.
        }
}


// Recover the vessel

function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}
function atg {
  return apoapsis - body:geopositionOf(ship:position):terrainHeight.
}
