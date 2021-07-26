//runpath("0:/sss.ks").
SAS off.
RCS on.
lights on.
set throttle to 0.
gear off.
panels on.
LOCK GRAV TO constant():g * (body:mass / body:radius^2).
//control_point().
//wait 10.
toggle ag9.
//wait 10.
set STEERING to RETROGRADE.
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

// wait 25.
toggle ag9.
set runmode to 1.
until runmode = 0 { //Run until we end the program
   
    if runmode = 1 { 
        if PERIAPSIS > 60000 { set runmode to 20.}
        if PERIAPSIS < 60000  { set runmode to 21.}}

    if runmode = 20 { 
      rcs off.
      //AG9 ON.
        until PERIAPSIS < 10000  {
           set STEERING to RETROGRADE.
           RCS on.
           lock throttle to 0.5.   
           wait 1.5.   
           }
          
        if PERIAPSIS < 10000  { 
             set thottle to 0.
             set runmode to 21.}
         
    }

    if runmode = 21 { 
        
        set throttle to 0.0.
        AG8 ON.
        RCS ON.
       
      until SHIP:ALTITUDE < 60000 {
         lock STEERING to RETROGRADE.
         print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
         print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,6).
         print "vertpeed:" + round(verticalspeed,1) + "      " at (5,7).
         print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,8).
         print "RUNMODE:    " + runmode + "      " at (5,4).
         }
      SET RUNMODE TO 22.}

    if runmode = 22 {
        until SHIP:GROUNDSPEED < 1100 AND SHIP:ALTITUDE < 20000 {
            lock STEERING to RETROGRADE. 
            if SHIP:GROUNDSPEED > 1000 { lock throttle to (4 * Ship:Mass * GRAV/ ship:availablethrust).}
            if SHIP:GROUNDSPEED < 1000 { lock throttle to 0.}
             print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
             print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,6).
             print "vertpeed:" + round(verticalspeed,1) + "      " at (5,7).
             print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,8).
             print "RUNMODE:    " + runmode + "      " at (5,4).}
            if  SHIP:ALTITUDE < 20000 {set runmode to 23.}}
        

    
        
    if runmode = 23 { // Coast until the ETA of slamming into the ground < 10 seconds
        
        panels off.
        brakes on.
        lock STEERING to velocity:surface * -1. //Point retrograde relative to surface velocity
        set TVAL to 0.
        if impactTime < 100 and verticalspeed < -1 and betterALTRADAR < 5000{
            set runmode to 24.
            }
        }
        
    if runmode = 24 { // Land on the ground
       
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
            wait 10.
            set runmode to 0.
            }

        }
        
    

    


    //Print data to screen.
   
}
FUNCTION control_point {
	PARAMETER pTag IS "controlPoint".
	LOCAL controlList IS SHIP:PARTSTAGGED(pTag).
	IF controlList:LENGTH > 0 {
		controlList[0]:CONTROLFROM().
	} ELSE {
		IF SHIP:ROOTPART:HASSUFFIX("CONTROLFROM") {
			SHIP:ROOTPART:CONTROLFROM().
		}
	}
}