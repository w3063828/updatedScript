
  local pid is pidloop(0.28166778734885156, 0.67973461165092885, 0.012451723217964172, 0,1).
  LOCK GRAV1 TO SHIP:SENSORS:GRAV:mag.
  lock steering to descent_vector().
  clearscreen.
  set runmode to 1.
  
  until runmode = 0 { //Run until we end the program
    if runmode = 1 {
      LOCK THROTTLE TO pid:update(kkk, ship:verticalspeed). 
      SET PID:SETPOINT TO distance_to_speed_math(45).
      wait 0. 
      if ship:status = "Landed" {
        PRINT "this will hopefully work maybe ?...".
      set runmode to 2.}
    }
    if runmode = 2{
      set throttle to 0.5.
      wait 5.
      iandi().}
    
    
    
     print "get fucked kid" at (5,10).
      print "ground distance:    " + round(dtg()) + "      "at (5,7).
      print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
      print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
      print "rmode:    " + runmode + "      " at (5,8).
      
    
 }

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

  return vcrs(c_vec - a_vec, b_vec - a_vec).
}

 local hover_pid is pidloop(2.7, 4.4, 0.12, 0, 1).
function hover {
  parameter setpoint.
  set hover_pid:setpoint to setpoint.
  set hover_pid:maxoutput to availtwr().
  return min(
    hover_pid:update(time:seconds, ship:verticalspeed) /
    max(cos(vang(up:vector, ship:facing:vector)), 0.0001) /
    max(availtwr(), 0.0001),
    1
  ).
}

function land {
  local t is 0.
  lock steering to descent_vector().
  lock throttle to t.
  until radar() < CONTACT_CUTOFF { set t to hover(-DESCENT_SPEED). wait 0. }
  until velocity:surface:mag < ACCEPTABLE_DRIFT { set t to hover(0). wait 0. }
  until ship:status = "Landed" { set t to hover(-CONTACT_SPEED). wait 0. }
  lock throttle to 0.
}

function iandi {
  local t is 0.
  lock steering to descent_vector().
  lock throttle to t.
  until radar() < CONTACT_CUTOFF { set t to hover(0). wait 0. }
  until velocity:surface:mag < ACCEPTABLE_DRIFT { set t to hover(0). wait 0. }
  until ship:status = "Landed" { set t to hover(0). wait 0. }
  lock throttle to 0.
}

// Helper functions

function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * grav1 - velocity:surface).
}

local display_data is lex(
  "step", "waiting"
).
function display {
  parameter update is lex().
  for key in update:keys set display_data[key] to update[key].
  local i is 0.
  for key in display_data:keys {
    print (key + ": " +display_data[key]):padright(terminal:width) at (0, i).
    set i to i + 1.
  }
}

function unrotate {
  parameter v. if v:typename <> "Vector" set v to v:vector.
  return lookdirup(v, ship:facing:topvector).
}

function radar {
    return altitude - body:geopositionof(ship:position):terrainheight.
  }


function availtwr {
  return  MAX( 0.001, MAXTHRUST / (MASS*grav1)).
}

FUNCTION distance_to_speed_math {
  PARAMETER dist.
  set mathResult to ((dist-dtg())/4).
  RETURN mathResult.
}

function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}



