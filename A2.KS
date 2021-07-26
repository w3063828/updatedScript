core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
clearscreen.
  LOCK GRAV TO constant():g * (body:mass / body:radius^2).
  doLaunch().
  gear off.
  doAscent().
  until apoapsis > 120000 {
    wait 0.1.
    print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
    print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
    print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
    print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
    print "ETA to Pe:  " + round(ETA:PERIAPSIS) + "      " at (5,9).
    //print "LF  " + round(LF:amount) + "      " at (5,10).
   }
     
  doShutdown().
  until round(ETA:APOAPSIS) < 200 { 
     print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
    wait 1.
  }
runpath("0:/land_at_v6.ks","ACl").
runpath("0:/NBV3.ks").
runpath("0:/ssss.ks").


function doLaunch {
  lock throttle to (8* Ship:Mass * GRAV / ship:availablethrust).

}

function doAscent {
  lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
  set targetDirection to 90.//e
  lock steering to heading(targetDirection, targetPitch).
    

}



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
  }
}

function doShutdown {
  lock throttle to 0.
  lock steering to prograde.
}

function doSafeStage {
  wait until stage:ready.
  stage.
}


function distanceToGround {
  return altitude - body:geopositionOf(ship:position):terrainHeight - 4.7.
}


// Helper functions

