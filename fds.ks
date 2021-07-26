lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).stage.gear off.lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
set targetDirection to 90.lock steering to heading(targetDirection, targetPitch).until apoapsis > 100000 {
wait 0.5.print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5). print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).}

set steering to up.LOCK THROTTLE TO pid:update(a, ship:verticalspeed). SET PID:SETPOINT TO 1.
LOCK THROTTLE TO pid:update(a, ship:verticalspeed). SET PID:SETPOINT TO 1.