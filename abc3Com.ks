//Ziegler-Nichols Tuning Method
local kU is 1.
print "Testing kU: " + kU.

// Wait for user to hit RCS (and turn on debug fuel)
wait until rcs.
//rcs off.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
set TARGET TO VESSEL("FG12"). 
set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
lock bdsm to vxcl(up:vector,gp:POSITION).
  LOCAL cPitch 		IS 0.
  LOCAL bPitch 		IS 0.
  LOCAL dPitch 		IS 0.
  LOCAL cAltitude 	IS 1000.
  LOCAL cPitch 		IS 0.
  LOCAL SPDLMT      IS 500.
lock throttle TO (-1 * ((SHIP:AIRSPEED-spdlmt)/spdlmt)).


stage.
LOCK STEERING TO HEADING(TARGET:HEADING,math).
 until altitude > 950{
    print "Alt:    " +round(altitude,2) + "      " at (5,8).
    print "current erorr:    " + round(DT,2) + "      " at (5,9).
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
    print "math" + math + "      " at (5,11).
    print "vert" + round(ship:verticalspeed,1) + "      " at (5,7).
 }

// PID until our first crossover
//local pid is pidloop(kU, 0, 0, 15,-15).
local pid is pidloop(1.81818181818182, 0.4545454545455, 0.34289329266175628, -15,15 ). 
 
                
                
until ship:verticalspeed < 0 {
  lock cPitch TO MATH().
  lock dpitch to ((2.5 * cPitch) + bPitch).
  set PID:setpoint to MATH1.
  lock bPitch TO PID:UPDATE(time:seconds, ship:verticalspeed).
  LOCK STEERING TO HEADING(TARGET:HEADING,dpitch).
  wait 0.01.
    print "math" + math + "      " at (5,7).
    print "Alt:    " +round(altitude,2) + "      " at (5,8).
    print "current erorr:    " + round(DT,2) + "      " at (5,9).
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
    print "setpoint" + pid:setpoint + "      " at (5,11).
    print "vert" + round(ship:verticalspeed,1) + "      " at (5,12).
}

local start_time is time:seconds.
local early_error is 0.
local late_error is 0.
local flips is list().
local error_sign is -1.

// Measure early error (0 - 5s)
until time:seconds > start_time + 5 {
  set early_error to max(early_error, abs(ship:verticalspeed)).
  if ship:verticalspeed * error_sign < 0 {
    flips:add(time:seconds).
    set error_sign to -error_sign.
  }
    lock cPitch TO MATH().
  lock dpitch to ((2.5 * cPitch) + bPitch).
  set PID:setpoint to MATH1.
  lock bPitch TO PID:UPDATE(time:seconds, ship:verticalspeed).
  LOCK STEERING TO HEADING(TARGET:HEADING,dpitch).
  wait 0.01.
   print "math" + math + "      " at (5,7).
   print "Alt:    " +round(altitude,2) + "      " at (5,8).
    print "current erorr:    " + round(DT,2) + "      " at (5,9).
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
    print "setpoint" + pid:setpoint + "      " at (5,11).
    print "vert" + round(ship:verticalspeed,1) + "      " at (5,12).
}

// Measure late error (10 - 30s)
until time:seconds > start_time + 20 {
  set late_error to max(late_error, abs(ship:verticalspeed)).
  if ship:verticalspeed * error_sign < 0 {
    flips:add(time:seconds).
    set error_sign to -error_sign.
  }
   lock cPitch TO MATH().
  lock dpitch to ((2 * cPitch) + bPitch).
  set PID:setpoint to MATH1.
  lock bPitch TO PID:UPDATE(time:seconds, ship:verticalspeed).
  LOCK STEERING TO HEADING(TARGET:HEADING,dpitch).
  wait 0.01.
   print "math" + math + "      " at (5,7).
   print "Alt:    " +round(altitude,2) + "      " at (5,8).
    print "current erorr:    " + round(DT,2) + "      " at (5,9).
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
    print "setpoint" + pid:setpoint + "      " at (5,11).
    print "vert" + round(ship:verticalspeed,1) + "      " at (5,12).
}

print "Early error " + early_error.
print "Late error: " + late_error.
print "Error difference: " + abs(late_error - early_error).
local total is 0.
if flips:length > 0 for i in range(flips:length - 1, 1) {
  set total to total + (flips[i] - flips[i-1]).
}
local pU is total / (flips:length - 1) * 2.
local kP is kU / 2.2.
local tI is 2.2 * pU.
local tD is pU / 6.3.

print "Period: " + pU.
print "kP: " + kP.
print "kI: " + (kP / tI).
print "kD: " + (kP * tD).

 function dtg {
  return altitude - gp:terrainHeight.
}
 FUNCTION math {
  lock mathResult to ((cAltitude-altitude)/15).
  RETURN mathResult.}
  FUNCTION math1 {
  lock mathResult to ((cAltitude-altitude)/10).
  RETURN mathResult.}

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
FUNCTION DT {
  lock mathResult to (cAltitude-ship:altitude).}
  
function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return 90 - vang(ves:up:vector, pointing).
}