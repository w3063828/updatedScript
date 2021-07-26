SAS off.
RCS on.
lights on.
lock KKK to time:seconds.
//LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
lock TWR to MAX( 0.001, (MAXTHRUST * 0.91) / (MASS*GRAV)).
lock shipLatLng to SHIP:GEOPOSITION.
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
lock impactTime to betterALTRADAR / -VERTICALSPEED.
lock landingRadar to min(ALTITUDE, betterALTRADAR). 
set throttle to 0.
gear off.
if PERIAPSIS > 40000 { set runmode to 20.}
else { set runmode to 1.}
until runmode = 0 { //Run until we end the program
    if runmode = 20 { 
      rcs off.
        if PERIAPSIS > 40000 {
           set STEERING to RETROGRADE.
           RCS on.
           lock throttle to 0.5.   
           wait 1.5.   
           }
          
        if PERIAPSIS < 40000  { 
             set thottle to 0.
             set runmode to 1.}
         
    }
    if runmode = 1 { 
       until SHIP:ALTITUDE < 10000 and ship:AIRSPEED < 1000 {
        set steering to prograde * r(-85, 0, 0):vector.
        lock throttle to 0.
        wait 0.
         print "RUNMODE:    " + runmode + "      " at (5,4).
         print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
        print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
        print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
        print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
        print "ETA to Pe:  " + round(ETA:PERIAPSIS) + "      " at (5,9).
        print "Impact Time:" + round(impacttime,1) + "      " at (5,10). 
        print "stopD    " + stoppingDistance() + "      " at (5,11).
        print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,12).
       print "vertspeed:" + round(verticalspeed,1) + "      " at (5,13).
       print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,14).
       }
        if SHIP:ALTITUDE < 10000 and ship:AIRSPEED < 1000 {set runmode to 2.}
    }
    
    if runmode = 2 { 
       clearscreen.
       until  dtg() < 5000 {
       set steering to prograde * r(-90, 0, 0):vector.
       set TVAL to 0.
       wait 0.
       print "RUNMODE:    " + runmode + "      " at (5,4).
       print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
       print "Impact Time:" + round(impacttime,1) + "      " at (5,10). 
       print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,6).
       print "vertspeed:" + round(verticalspeed,1) + "      " at (5,7).
       print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,8).
       print "TVAL:" + round(TVAL,1) + "      " at (5,9).
       print "stopD    " + stoppingDistance() + "      " at (5,10).
       if landingRadar < (stoppingDistance + 1500) {set runmode to 3.}
       }
       IF dtg() < 5000 {set runmode to 3.}
    }
        
    if runmode = 3 { // Land on the ground
    toggle ag9.
      
       lock steering to descent_vector().
       wait 1.
       lock maxtwr to (ship:maxthrust * 1)/ (GRAV * ship:mass).
       global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
       set tAlt to 20.
   until ship:status = "Landed" {
      until abs(ship:GROUNDSPEED) < abs(ship:verticalSpeed) {set target_twr to pid:update(kkk,(-1 *ship:GROUNDSPEED)).
      SET PID:SETPOINT TO (math2(ship:GROUNDSPEED)).
      lock throttle to min(target_twr / maxtwr, 1).
       print "ground distance:    " + round(landingRadar) + "      " at (5,4).
      print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
      print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
      print "pid set point:    " + PID:SETPOINT + "      " at (5,7). 
      print "talt:    " + tAlt + "      " at (5,9). 
      print "RUNMODE:    " + runmode + "      " at (5,3).
      print "stopD    " + stoppingDistance() + "      " at (5,10).
      print "D    " + delta[0] + "      " at (5,11).
      
      }
      if abs(ship:GROUNDSPEED) < abs(ship:verticalSpeed) { //{RUNPATH("0:/cr.KS").
      set target_twr to pid:update(kkk,ship:verticalSpeed).
      SET PID:SETPOINT TO math(tAlt).
      lock throttle to min(target_twr / maxtwr, 1).
      }
      
      
       if dtg()< 21 {set talt to min(5,talt - 0.35).}
      print "ground distance:    " + round(landingRadar) + "      " at (5,4).
      print "ground speed:    " + round(ship:GROUNDSPEED) + "      " at (5,5).
      print "vertical speed:    " + round(ship:verticalSpeed) + "      " at (5,6).
      print "pid set point:    " + PID:SETPOINT + "      " at (5,7). 
      print "talt:    " + tAlt + "      " at (5,9). 
      print "RUNMODE:    " + runmode + "      " at (5,3).
      print "stopD    " + stoppingDistance() + "      " at (5,10).
      print "D    " + delta[0] + "      " at (5,11).
      }
                        set runmode to 0.
            }}
    
        
    


function math {
  PARAMETER dist.
  set mathResult to ((dist-landingRadar)/15).
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

  function delta {
  local maxDeceleration is (ship:availableThrust / ship:mass) - GRAV.
  local beta is (SQRT(ship:verticalSpeed^2 + SHIP:GROUNDSPEED^2)).
  local charlie is beta^2 / (2 * maxDeceleration).
  return list (beta,charlie).
  }
  
  
  function math2 {
  PARAMETER distx.
  set mathResult to -1 * (distx/20).
  RETURN mathResult.}
  