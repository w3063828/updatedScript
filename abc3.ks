//Ziegler-Nichols Tuning Method
local kU is 4.
print "Testing kU: " + kU.

// Wait for user to hit RCS (and turn on debug fuel)
wait until rcs.
rcs off.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").

// Get to > 500 meters up
local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).
lock throttle to min(target_twr / maxtwr, 1).
lock steering to lookdirup(up:vector, facing:topvector).
set ship:control:pilotmainthrottle to 0.
stage.
set target_twr to maxtwr.
wait until alt:radar > 60.

// PID until our first crossover
//local pid is pidloop(kU, 0, 0, 0, maxtwr).
//local pid is pidloop(1.81818181818182, 5.48325897757928, 0.0434983348738613, 0, maxtwr).
local pid is pidloop(1.81818181818182, 0.9725434, 0.2434983348738613, 0, maxtwr).
//global pid is pidloop(1.81818181818182, 0.456998571460453, 0.521911117675102, 0, maxtwr).
set pid:setpoint to 0.
until ship:verticalspeed < 0 {
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.01.
}

local start_time is time:seconds.
local early_error is 0.
local late_error is 0.
local flips is list().
local error_sign is -1.

// Measure early error (0 - 5s)
until time:seconds > start_time + 20 {
  set early_error to max(early_error, abs(ship:verticalspeed)).
  if ship:verticalspeed * error_sign < 0 {
    flips:add(time:seconds).
    set error_sign to -error_sign.
  }
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.01.
}

// Measure late error (5 - 20s)
until time:seconds > start_time + 60{
  set late_error to max(late_error, abs(ship:verticalspeed)).
  if ship:verticalspeed * error_sign < 0 {
    flips:add(time:seconds).
    set error_sign to -error_sign.
  }
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.01.
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
wait 5.
