core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
clearscreen.
LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
// Automatic Lander
lock STEERING to RETROGRADE. 
local SUICIDE_DISTANCE_MARGIN is 100.
local ACCEPTABLE_LANDING_SLOPE is 5.
local ACCEPTABLE_DRIFT is 0.5.
local CONTACT_SPEED is 2.
local CONTACT_CUTOFF is 15.
local DESCENT_SPEED is 5.
set runmode to 1.
until runmode = 0 { //Run until we end the program
 if runmode = 1 { 
   print "RUNMODE:    " + runmode + "      " at (5,4).
   print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
   print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
   print "periapsis   " + PERIAPSIS + "      " at (5,7).
  if PERIAPSIS > 30000  {
    set STEERING to RETROGRADE.
    
   lock throttle to (3* Ship:Mass * GRAV / ship:availablethrust).
    wait 0.2.}
  else {
    set STEERING to RETROGRADE.
    lock throttle to 0.
    }       
  if SHIP:ALTITUDE < 40000 and ship:AIRSPEED > 768 {
      set STEERING to RETROGRADE.
      lock throttle to 0.5.
      wait 0.5.
     }
   if SHIP:ALTITUDE < 40000 and ship:AIRSPEED < 768 {
     lock throttle to 0.
     set STEERING to RETROGRADE.
     wait 2.}
   
   if SHIP:ALTITUDE < 20000 and ship:groundspeed > 100 {
     set STEERING to RETROGRADE.
     ag7 on.
     rcs on.
     lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
     wait 0.2.}
   else {
     set STEERING to RETROGRADE.
     lock throttle to 0.}

   if SHIP:ALTITUDE < 15000 and ship:AIRSPEED < 750 {
    wait 0.
    set STEERING to RETROGRADE.
    lock throttle to 0.
    set runmode to 2.}
  }

 if runmode = 2 {
   RUNPATH("0:/F1.KS").
   set runmode to 0.
  }
   print "RUNMODE:    " + runmode + "      " at (5,4).
   print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
   print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
}
