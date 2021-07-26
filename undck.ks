CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
//LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
lock maxAcc to ship:availablethrust / mass.
lock KKK to time:seconds.
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
lock TWR to MAX( 0.001, (MAXTHRUST * 1) / (MASS*GRAV)).
lock shipLatLng to SHIP:GEOPOSITION.
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
lock impactTime to betterALTRADAR / -VERTICALSPEED.
lock landingRadar to min(ALTITUDE, betterALTRADAR).
set timer to 10.
TOGGLE ABORT.
AG4 ON.
ag4 off.
ag4 on.
set tAlt to 15.
GLOBAL original_length is ship:parts:length.
local start_time is time:seconds.
SET start_time2 TO time:seconds.
set runmode to 1.
  until runmode = 0 { 
    if runmode = 1 {lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
                    
                    rcs on.
                    sas off.
                     
                    until time:seconds > MAX(start_time,start_time2) + timer {doAscent().
                    print "RUNMODE:    " + runmode + "      " at (5,3).}
                    set runmode to 2.
                    //set throttle to 0.
                   //runpath("0:/land_at_v6.ks","Sector P-XS").
                    //wait 5 .
                    //runpath("0:/nbv3.ks"). 
                    //runpath("0:/ssss.ks"). 
                    
                    
                    
                    
                    }
    if runmode = 2 { 
                     lock maxtwr to (ship:maxthrust * 1)/ (GRAV * ship:mass).
                     global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
                     
                        until ship:status = "Landed" {
                             lock steering to descent_vector().
                             set target_twr to pid:update(kkk, ship:verticalspeed). 
                             lock throttle to min(target_twr / maxtwr, 1).
                             SET PID:SETPOINT TO math(tAlt).
                             //if dtg()< 24 LOCK steering TO UP.
                             if dtg()< 18 AND ABORT {
                               SET start_time2 TO time:seconds. TOGGLE AG4. SET RUNMODE TO 1. WAIT 1. ABORT OFF.}
                             if dtg() < (tAlt + 1) {set talt to MAX(1,talt - 0.15). GEAR ON.}
                             print "ground distance:    " + round(landingRadar) + "      " at (5,4).
                             print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
                             print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
                             print "pid set point:    " + PID:SETPOINT + "      " at (5,7). 
                             print "talt:    " + tAlt + "      " at (5,9). 
                             print "RUNMODE:    " + runmode + "      " at (5,3).
                             }
                    SET RUNMODE TO 0.}
  }






function doAscent {
  lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
  set targetDirection to 0.//w retrograde 
  lock steering to heading(targetDirection, targetPitch).}


function math {
  PARAMETER dist.
  set mathResult to ((dist-landingRadar)/4).
  RETURN mathResult.}
function stoppingDistance {
  local maxDeceleration is (ship:availableThrust / ship:mass) - GRAV.
  return ship:verticalSpeed^2 / (2 * maxDeceleration).}
  
function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * grav - velocity:surface).}

function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.}

function unrotate {
  parameter v. if v:typename <> "Vector" set v to v:vector.
  return lookdirup(v, ship:facing:topvector).}