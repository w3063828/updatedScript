//Set the ship to a known configuration
set STEERING to RETROGRADE.
SAS off.
RCS on.
lights on.
set throttle to 0.
gear off.
panels on.
LOCK GRAV TO constant():g * (body:mass / body:radius^2).
wait 17.
clearscreen.

// Lets get some math out of the way, shall we?
lock shipLatLng to SHIP:GEOPOSITION. //This is the ship's current location above the surface
//This variable store the altitude above sea level that the ground below the ship is at.
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.

lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).
     //Depending on what other mods you have installed ALT:RADAR may not work properly,
     // so instead I calculate it using the sea level altitude minus the ground elevation
lock impactTime to betterALTRADAR / -VERTICALSPEED. // Time until we hit the ground
                
// Calculate the theoretical throttle level to hover in place ( 1/TWR)
set GRAVITY to (constant():G * body:mass) / body:radius^2.
lock TWR to MAX( 0.001, MAXTHRUST / (MASS*GRAVITY)).
set runmode to 1.



until runmode = 0 { //Run until we end the program
   
    if runmode = 1 { 
        if PERIAPSIS > 100 { set runmode to 20.}
        else { set runmode to 21.}}

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
             set runmode to 21.}
         
    }

    if runmode = 21 { 
        ag8 on.
        lock steering to R(0,75,0) * velocity:surface.
        lock throttle to 0.
        if SHIP:ALTITUDE < 70000 and ship:AIRSPEED > 1660 {
                wait 1.
                   }

         if SHIP:ALTITUDE < 70000 and ship:AIRSPEED < 1600 {
                
                set runmode to 22.}}
        

    if runmode = 22 { //bellyflop
     lock steering to R(0,75,0) * velocity:surface.
        
        if SHIP:ALTITUDE < 30000 and ship:AIRSPEED > 600 {
                wait 1.
                   }

         if SHIP:ALTITUDE < 30000 and ship:AIRSPEED < 600 {
                lock throttle to 0.
                set runmode to 23.}}
        

    
        
    if runmode = 23 { // Coast until the ETA of slamming into the ground < 10 seconds
        
        panels off.
        brakes on.
        lock steering to R(0,65,0) * velocity:surface.
        set TVAL to 0.
        if ship:AIRSPEED > 200 {
                wait 0.1.
                   }

        else if ship:AIRSPEED < 200 {
                lock throttle to 0.
                }
        if impactTime < 100 and verticalspeed < -1 and betterALTRADAR < 1000{
            set runmode to 24.
            }
        }
        
    if runmode = 24 { // Land on the ground
    toggle ag8.
       lock steering to R(0,60,0) * velocity:surface.
      
       lock steering to R(0,90,0) * velocity:surface.
  

        lock STEERING to velocity:surface * -1.//Point retrograde relative to surface velocity
        set landingRadar to min(ALTITUDE, betterALTRADAR). 
        // Use whichever says our altitude is lower
                //This is useful in case we overshoot the KSC and need to land in the ocean.
        set TVAL to (1 / TWR) - (verticalspeed + max(5, min (250, landingRadar^1.08 / 8)) ) / 3 / TWR.
        lock throttle to tval.
        gear on.

        // Here we set the throttle to hover using a Thrust to weight ratio of one to counter act gravity
        // Then we modify the throttle by the error between the speed we want to be at (based on altitude)
        // and the speed we are currently at, then divide it by three to smooth it out and then divide it again 
        // by the TWR to automatically customize it for each ship.
        //
        if betterALTRADAR < 15 and ABS(VERTICALSPEED) < 1 {
            lock throttle to 0.
            lock steering to up.
            print "LANDED!".
                        set runmode to 0.
            }

        }
        
    

    


    //Print data to screen.
    print "RUNMODE:    " + runmode + "      " at (5,4).
    print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
    print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
    print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
    print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
    print "ETA to Pe:  " + round(ETA:PERIAPSIS) + "      " at (5,9).
    print "Impact Time:" + round(impacttime,1) + "      " at (5,10).
    
}