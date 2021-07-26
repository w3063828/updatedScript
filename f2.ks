core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
clearscreen.
set KKK to time:seconds.
LOCK GRAV1 TO constant():g * (body:mass / body:radius^2).
// Automatic Lander
ag3 on.
local SUICIDE_DISTANCE_MARGIN is 150.
local ACCEPTABLE_LANDING_SLOPE is 5.
local ACCEPTABLE_DRIFT is 0.5.
local CONTACT_SPEED is 2.
local CONTACT_CUTOFF is 15.
local DESCENT_SPEED is 5.
main().
// Helper functions
function main {
  
  set ship:control:pilotmainthrottle to 0.
  sas on.
 
  
  set ship:control:pilotmainthrottle to 0.
  sas off.
  //display(lex("step", "Suicide burn")).
  perform_suicide_burn().
  //display(lex("step", "Slope seek")).
  //seek_landing_area().
  gear off.
  //(lex("step", "Landing")).
  
  HH().}

function perform_suicide_burn {
  local t is 0.
  lock steering to descent_vector().
  lock throttle to t.
  until radar() < 45  {
  LOCAL shipThrust IS SHIP:AVAILABLETHRUST * 0.95.
  LOCAL localGrav IS SHIP:BODY:MU/(SHIP:BODY:RADIUS + SHIP:ALTITUDE)^2.	//calculates gravity of the body
  LOCAL shipAcceleration IS shipThrust / SHIP:MASS.						//ship acceleration in m/s
  local v is -verticalspeed.
  local delta is radar() + 45.
	LOCAL stopTime IS  ABS(VERTICALSPEED) / (shipAcceleration - localGrav).//time needed to nutrlise vertical speed
	LOCAL stopDist IS 1/2 * shipAcceleration * stopTime * stopTime.			//how much distance is needed to come to a stop
	LOCAL twr IS shipAcceleration / localGrav.					//the TWR of the craft based on local gravity
	RETURN LEX("stopTime",stopTime,"stopDist",stopDist,"twr",twr,"dtg",radar()).
  if stopDist = delta set t to 1.
    else set t to 0.
    wait 0.
  }}


function seek_landing_area {
  local target_vector is unrotate(up).
  local t is 1.
  lock throttle to t.
  lock steering to target_vector.
  local slope is vang(ground_slope(), up:vector).
  until slope < ACCEPTABLE_LANDING_SLOPE and
        velocity:surface:mag < ACCEPTABLE_DRIFT {
    set slope to vang(ground_slope(), up:vector).
    local desired_velocity is vxcl(up:vector, ground_slope()).
    set desired_velocity:mag to 2.
    if slope < ACCEPTABLE_LANDING_SLOPE set desired_velocity to v(0, 0, 0).
    local delta_velocity is desired_velocity - velocity:surface.
    set target_vector to unrotate(up:vector * grav1 + delta_velocity).
    set t to hover(0).
    display(lex("Slope", vang(ground_slope(), up:vector))).
    wait 0.
  }}

function HH {
  lock maxtwr to ship:maxthrust / (GRAV1 * ship:mass).
  global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
  set tAlt to 20.
  lock steering to descent_vector().
  clearscreen.
  set runmode to 1.
  until runmode = 0 { //Run until we end the program
    if runmode = 1 {
      set target_twr to pid:update(kkk, ship:verticalspeed). 
      lock throttle to min(target_twr / maxtwr, 1).
      SET PID:SETPOINT TO distance_to_speed_math(tAlt).
      print "ground distance:    " + round(dtg()) + "      " at (5,4).
      print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
      print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
      print "pid set point:    " + PID:SETPOINT + "      " at (5,7). 
      print "radar:    " + round(radar()) + "      " at (5,8).
      print "talt:    " + tAlt + "      " at (5,9). 
      print "RUNMODE:    " + runmode + "      " at (5,3).
      if dtg <= tAlt AND SHIP:verticalSpeed < 0.2 {
        SET runmode TO 2.
         }}

    if runmode = 2 {
      print "miss Tohru is the god queen of the never-verse". 
      set tAlt to 5.
      set steering to up.
      until ship:status = "Landed" {
        set pid:setpoint to math().
        set target_twr to pid:update(time:seconds, ship:verticalspeed).
        lock throttle to min(target_twr / maxtwr, 1).
      print "ground distance:    " + round(dtg()) + "      " at (5,4).
      print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
      print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
      print "pid set point:    " + PID:SETPOINT + "      " at (5,7). 
      print "radar:    " + round(radar()) + "      " at (5,8).
      print "talt:    " + tAlt + "      " at (5,9). 
      print "RUNMODE:    " + runmode + "      " at (5,3).
      
      
      //TOGGLE ag4.
        //set runmode to 4. }
        }
        set runmode to 0.
        }
    
  if runmode = 3 {
    doLaunch().
    doAscent().
    until apoapsis > 80000 {
    print "RUNMODE:    " + runmode + "      " at (5,4).
      print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
      print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
      print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
      print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
      print "ETA to Pe:  " + round(ETA:PERIAPSIS) + "      " at (5,9).
    }
    doShutdown().
    doCircularization().
    unlock throttle.
    print "miss elma is the OBJECT of affection to the never-verse".
    SET RUNMODE TO 0.}
  
  
if runmode = 4 {
GEAR ON.
RUNPATH("0:/CT1.KS").}
  }
}
function ground_slope {
  local east is vcrs(north:vector, up:vector).
  local a is body:geopositionof(ship:position + 5 * north:vector).
  local b is body:geopositionof(ship:position - 5 * north:vector + 5 * east).
  local c is body:geopositionof(ship:position - 5 * north:vector - 5 * east).

  local a_vec is a:altitudeposition(a:terrainheight).
  local b_vec is b:altitudeposition(b:terrainheight).
  local c_vec is c:altitudeposition(c:terrainheight).

  return vcrs(c_vec - a_vec, b_vec - a_vec).}

 local hover_pid is pidloop(0.51543463882990181, 0.3734305021353066, 0.52321681985631585, 0,1).
function hover {
  parameter setpoint.
  set hover_pid:setpoint to setpoint.
  set hover_pid:maxoutput to availtwr().
  return min(
    hover_pid:update(time:seconds, ship:verticalspeed) /
    max(cos(vang(up:vector, ship:facing:vector)), 0.0001) /
    max(availtwr(), 0.0001),
    1
  ).}

function land {
  local t is 0.
  lock steering to descent_vector().
  lock throttle to t.
  until radar() < CONTACT_CUTOFF { set t to hover(-DESCENT_SPEED). wait 0. }
  until velocity:surface:mag < ACCEPTABLE_DRIFT { set t to hover(0). wait 0. }
  until ship:status = "Landed" { set t to hover(-CONTACT_SPEED). wait 0. }
  lock throttle to 0.}

function iandi {
  local t is 0.
  lock steering to descent_vector().
  lock throttle to t.
  until radar() < CONTACT_CUTOFF { set t to hover(0). wait 0. }
  until velocity:surface:mag < ACCEPTABLE_DRIFT { set t to hover(0). wait 0. }
  until ship:status = "Landed" { set t to hover(0). wait 0. }
  lock throttle to 0.}


function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * grav1 - velocity:surface).}

local display_data is lex(
  "step", "waiting").
function display {
  parameter update is lex().
  for key in update:keys set display_data[key] to update[key].
  local i is 0.
  for key in display_data:keys {
    print (key + ": " +display_data[key]):padright(terminal:width) at (0, i).
    set i to i + 1.}}

function unrotate {
  parameter v. if v:typename <> "Vector" set v to v:vector.
  return lookdirup(v, ship:facing:topvector).}

function radar {
    return altitude - body:geopositionof(ship:position):terrainheight.
  }


function availtwr {
  return  MAX( 0.001, MAXTHRUST / (MASS*grav1)).}

FUNCTION distance_to_speed_math {
  PARAMETER dist.
  set mathResult to ((dist-dtg())/4).
  RETURN mathResult.}

function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.}
function doCircularization {
  local circ is list(0).
  set circ to improveConverge(circ, eccentricityScore@).
  wait until altitude >60001.
  executeManeuver(list(time:seconds + eta:apoapsis, 0, 0, circ[0])).}

function protectFromPast {
  parameter originalFunction.
  local replacementFunction is {
    parameter data.
    if data[0] < time:seconds + 15 {
      return 2^64.
    } else {
      return originalFunction(data).
    }
  }.
  return replacementFunction@.}

function doTransfer {
  local startSearchTime is ternarySearch(
    angleToMun@,
    time:seconds + 30, 
    time:seconds + 30 + orbit:period,
    1
  ).
  local transfer is list(startSearchTime, 0, 0, 0).
  set transfer to improveConverge(transfer, protectFromPast(munTransferScore@)).
  executeManeuver(transfer).
  wait 1.
  warpto(time:seconds + obt:nextPatchEta - 5).
  wait until body = Mun.
  wait 1.}

function angleToMun {
  parameter t.
  return vectorAngle(
    Kerbin:position - positionAt(ship, t),
    Kerbin:position - positionAt(Mun, t)
  ).}

function munTransferScore {
  parameter data.
  local mnv is node(data[0], data[1], data[2], data[3]).
  addManeuverToFlightPlan(mnv).
  local result is 0.
  if mnv:orbit:hasNextPatch {
    set result to mnv:orbit:nextPatch:periapsis.
  } else {
    set result to distanceToMunAtApoapsis(mnv).
  }
  removeManeuverFromFlightPlan(mnv).
  return result.}

function distanceToMunAtApoapsis {
  parameter mnv.
  local apoapsisTime is ternarySearch(
    altitudeAt@, 
    time:seconds + mnv:eta, 
    time:seconds + mnv:eta + (mnv:orbit:period / 2),
    1
  ).
  return (positionAt(ship, apoapsisTime) - positionAt(Mun, apoapsisTime)):mag.}

function altitudeAt {
  parameter t.
  return Kerbin:altitudeOf(positionAt(ship, t)).}

function ternarySearch {
  parameter f, left, right, absolutePrecision.
  until false {
    if abs(right - left) < absolutePrecision {
      return (left + right) / 2.
    }
    local leftThird is left + (right - left) / 3.
    local rightThird is right - (right - left) / 3.
    if f(leftThird) < f(rightThird) {
      set left to leftThird.
    } else {
      set right to rightThird.
    }
  }}

function eccentricityScore {
  parameter data.
  local mnv is node(time:seconds + eta:apoapsis, 0, 0, data[0]).
  addManeuverToFlightPlan(mnv).
  local result is mnv:orbit:eccentricity.
  removeManeuverFromFlightPlan(mnv).
  return result.}

function improveConverge {
  parameter data, scoreFunction.
  for stepSize in list(100, 10, 1) {
    until false {
      local oldScore is scoreFunction(data).
      set data to improve(data, stepSize, scoreFunction).
      if oldScore <= scoreFunction(data) {
        break.
      }
    }
  }
  return data.}

function improve {
  parameter data, stepSize, scoreFunction.
  local scoreToBeat is scoreFunction(data).
  local bestCandidate is data.
  local candidates is list().
  local index is 0.
  until index >= data:length {
    local incCandidate is data:copy().
    local decCandidate is data:copy().
    set incCandidate[index] to incCandidate[index] + stepSize.
    set decCandidate[index] to decCandidate[index] - stepSize.
    candidates:add(incCandidate).
    candidates:add(decCandidate).
    set index to index + 1.
  }
  for candidate in candidates {
    local candidateScore is scoreFunction(candidate).
    if candidateScore < scoreToBeat {
      set scoreToBeat to candidateScore.
      set bestCandidate to candidate.
    }
  }
  return bestCandidate.}

function executeManeuver {
  parameter mList.
  local mnv is node(mList[0], mList[1], mList[2], mList[3]).
  addManeuverToFlightPlan(mnv).
  local startTime is calculateStartTime(mnv).
  warpto(startTime - 15).
  wait until time:seconds > startTime - 10.
  lockSteeringAtManeuverTarget(mnv).
  wait until time:seconds > startTime.
  lock throttle to 1.
  until isManeuverComplete(mnv) {
    doAutoStage().
  }
  lock throttle to 0.
  unlock steering.
  removeManeuverFromFlightPlan(mnv).}

function addManeuverToFlightPlan {
  parameter mnv.
  add mnv.}

function calculateStartTime {
  parameter mnv.
  return time:seconds + mnv:eta - maneuverBurnTime(mnv) / 2.}

function maneuverBurnTime {
  parameter mnv.
  local dV is mnv:deltaV:mag.
  local g0 is 9.80665.
  local isp is 0.

  list engines in myEngines.
  for en in myEngines {
    if en:ignition and not en:flameout {
      set isp to isp + (en:isp * (en:availableThrust / ship:availableThrust)).
    }
  }

  local mf is ship:mass / constant():e^(dV / (isp * g0)).
  local fuelFlow is ship:availableThrust / (isp * g0).
  local t is (ship:mass - mf) / fuelFlow.

  return t.}

function lockSteeringAtManeuverTarget {
  parameter mnv.
  lock steering to mnv:burnvector.}

function isManeuverComplete {
  parameter mnv.
  if not(defined originalVector) or originalVector = -1 {
    declare global originalVector to mnv:burnvector.
  }
  if vang(originalVector, mnv:burnvector) > 90 {
    declare global originalVector to -1.
    return true.
  }
  return false.}

function removeManeuverFromFlightPlan {
  parameter mnv.
  remove mnv.}

function doLaunch {
  lock throttle to (5* Ship:Mass * grav1 / ship:availablethrust).
  }

function doAscent {
  lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
  set targetDirection to 0.//w retrograde 
  lock steering to heading(targetDirection, targetPitch).}



function doAutoStage {
  if not(defined oldThrust) {
    global oldThrust is ship:availablethrust.
  }
  if ship:availablethrust < (oldThrust - 10) {
    until false {
      doSafeStage(). wait 1.
      if ship:availableThrust > 0 { 
        break.
      }
    }
    global oldThrust is ship:availablethrust.
  }}

function doShutdown {
  lock throttle to 0.
  lock steering to prograde.}

function doSafeStage {
  wait until stage:ready.
  stage.}

function doHoverslam {
  lock steering to srfRetrograde.
  lock pct to stoppingDistance() / distanceToGround().
  set warp to 4.
  wait until pct > 0.1.
  set warp to 3.
  wait until pct > 0.4.
  set warp to 0.
  wait until pct > 1.
  lock throttle to pct.
  when distanceToGround() < 500 then { gear off. }
  wait until ship:verticalSpeed > 0.
  lock throttle to 0.
  lock steering to groundSlope().
  wait 30.
  unlock steering.}

function distanceToGround {
  return altitude - body:geopositionOf(ship:position):terrainHeight - 4.7.}

function stoppingDistance {
  local grav is constant():g * (body:mass / body:radius^2).
  local maxDeceleration is (ship:availableThrust / ship:mass) - grav.
  return ship:verticalSpeed^2 / (2 * maxDeceleration).}

function groundSlope {
  local east is vectorCrossProduct(north:vector, up:vector).

  local center is ship:position.

  local a is body:geopositionOf(center + 5 * north:vector).
  local b is body:geopositionOf(center - 3 * north:vector + 4 * east).
  local c is body:geopositionOf(center - 3 * north:vector - 4 * east).

  local a_vec is a:altitudePosition(a:terrainHeight).
  local b_vec is b:altitudePosition(b:terrainHeight).
  local c_vec is c:altitudePosition(c:terrainHeight).

  return vectorCrossProduct(c_vec - a_vec, b_vec - a_vec):normalized.}

FUNCTION math {
  lock mathResult to ((talt-dtg())/4).
  RETURN mathResult.
}