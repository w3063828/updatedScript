//runpath("0:/gdu123.ks").

wait 3.

CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
set TARGET TO VESSEL("FG12"). 
lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
lock throttle to 1.



rcs on.
LOCK STEERING TO LOOKDIRUP(up:vector,-NORTH:VECTOR).
stage.
until apoapsis > 1000 {
    print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
    print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
    print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
    print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
    wait 0.
}
lock throttle to 0.
until altitude > 800 {
  if ALTITUDE > 500 {ag3 on.}
    print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
    print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
    print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
    print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
    wait 0.
}

LOCK STEERING TO HEADING(TARGET:HEADING,0).
clearscreen.
until pitch_for < 10 {
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,4).
}
IF Pitch_for < 10 { 
ag4 on.
LOCK STEERING TO HEADING(TARGET:HEADING,0).
SAS oN.
wait 0.2.
sas off.
}
stage.
lock throttle to 1.
wait 2.
runpath("0:/gdu123.ks").
function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return 90 - vang(ves:up:vector, pointing).}