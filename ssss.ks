SAS off.
RCS on.
AG7 ON.
//toggle ag9.
//ag9 on. 
//stage.
lights on.
clearscreen.
lock KKK to time:seconds.
//LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
lock TWR to MAX( 0.001, (MAXTHRUST * 1) / (MASS*GRAV)).
lock shipLatLng to SHIP:GEOPOSITION.
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
lock impactTime to betterALTRADAR / -VERTICALSPEED.
lock landingRadar to min(ALTITUDE, betterALTRADAR). 
set throttle to 0.
//gear off.

       lock maxtwr to (ship:maxthrust * 1)/ (GRAV * ship:mass).
       //global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
      // local pid is pidloop(1.81818181818182, 0.257861553891434, 0.924963925825365, 0, maxtwr).
       local pid is pidloop(1.81818181818182, 4.0606958269566, 0.587368878071348, 0, maxtwr).
       set tAlt3 to 25.
   until abs(ship:GROUNDSPEED) <= abs(ship:verticalSpeed) {
      lock STEERING to descent_vector().
      IF ship:verticalspeed < 1 AND ship:GROUNDSPEED < 1 {LOCK STEERING TO UP.}
      set target_twr to pid:update(kkk, ship:verticalspeed). 
      lock throttle to min(target_twr / maxtwr, 1).
      SET PID:SETPOINT TO math1().
      print "ground distance:    " + round(landingRadar) + "      " at (5,4).
      print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
      print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
      print "pid set point:    " + PID:SETPOINT + "      " at (5,7). 
      print "talt:    " + tAlt3 + "      " at (5,9). 
      print "stopD    " + stoppingDistance() + "      " at (5,10).
       }
    //if abs(ship:GROUNDSPEED) <= abs(ship:verticalSpeed){

      
      until ship:status = "Landed" {
      if landingRadar() < 28 {set talt3 to min(5,talt3 - 0.15).}
      IF ship:verticalspeed < 1 AND ship:GROUNDSPEED < 1 {LOCK STEERING TO UP.}
      print "ground distance:    " + round(landingRadar) + "      " at (5,4).
      print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
      print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
      print "pid set point:    " + PID:SETPOINT + "      " at (5,7). 
      print "talt:    " + tAlt3 + "      " at (5,9). 
      lock throttle to min(target_twr / maxtwr, 1).
      set target_twr to pid:update(kkk,ship:verticalSpeed).
      SET PID:SETPOINT TO ((talt3 - landingRadar)/20) .
     // }
    }
        
    


function math1 {
  if dtg > 100 {lock mathResult to ((tAlt3-landingRadar)/50).}
  if dtg < 100 {lock mathResult to ((tAlt3-landingRadar)/4).}
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