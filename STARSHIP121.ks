
SAS off.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
RCS on.
lights on.
lock KKK to time:seconds.
set gp to latlng(-0.097124,-74.557706).
//LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock target to gp.
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
lock TWR to MAX( 0.001, (MAXTHRUST * 0.91) / (MASS*GRAV)).
lock shipLatLng to SHIP:GEOPOSITION.
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
lock impactTime to betterALTRADAR / -VERTICALSPEED.
lock landingRadar to min(ALTITUDE, betterALTRADAR). 
set throttle to 0.
gear off.
set xfil to 1.
control_point().
set talt to 78.
rcs on.
//sas on.
//WAIT 15.
sas off.
local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).
lock throttle to min(target_twr / maxtwr, 1).
set gp to latlng(-0.097124,-74.557706).
local pid is pidloop(1.81818181818182, 0.237484789986517, 1.00432804652623, 0, maxtwr). //fg

gear off.
brakes off.
sas off.
rcs off.
local target_twr is 0.
//LOCK STEERING TO HEADING(gp:HEADING,90).
lock steering to up + R(0,0,180).
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
//lock GRAV TO SHIP:SENSORS:GRAV:mag.
lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
lock maxAcc to ship:availablethrust / mass.
lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
LOCAL desiredFore IS 0.
LOCAL desiredstar IS 0.
LOCAL desiredtop  IS 0.
LOCAL desiredpitch  IS 0.
LOCAL shipFacing IS ship:facing.
LOCAL axisSpeed IS axis_speed().
LOCAL RCSdeadZone IS 0.05.
local PIDpitch is pidloop(4, 0.2, 0.05, -45, 45).
local PIDtop is pidloop(4, 0.2, 0.1, -20, 20).
local PIDfore is pidloop(4, 0.2, 0.1, -20, 20).
local PIDstar is pidloop(4, 0.2, 0.1, -20, 20).
//local pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
local last_time is time:seconds.
local total_error is 0.
clearscreen.

local start_time is time:seconds.
local original_length is ship:parts:length.

if PERIAPSIS > 40000 { set runmode to 20.}
else { set runmode to 1.}
until runmode = 0 { //Run until we end the program
    if runmode = 20 { 
      rcs off.
        if PERIAPSIS > 40000 {
           set STEERING to RETROGRADE.
           RCS OFF.
           lock throttle to 0.5.   
           wait 1.5.   
           }
          
        if PERIAPSIS < 40000  { 
             set thottle to 0.
             set runmode to 1.}
         
    }
    if runmode = 1 { 
       until SHIP:ALTITUDE < 30000 and ship:AIRSPEED < 700 {
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
        if SHIP:ALTITUDE < 30000 and ship:AIRSPEED < 700 {set runmode to 2.}
    }
    
    if runmode = 2 { 
       clearscreen.
       AG1 ON.
       AG2 ON.
       // set TRTM to vxcl(up:vector,gp:POSITION).
       //set TRTM to VECDRAWARGS( V(0,0,0),gp:position,green,"ship",1,true).
       until dtg() < 450 {
      
       set TRTM to gp:POSITION.
       //set TRTMA to VECDRAWARGS( V(0,0,0),TRTM,green,"ship",1,true).
       set TRTM2 to r(0,180,0)*TRTM.
      // set TRTMb to VECDRAWARGS( V(0,0,0),TRTM2,red,"ship",1,true).
       set PIDpitch:SETPOINT TO math3().
       //if SHIP:GROUNDSPEED < 200 {set PIDpitch to pidloop(4, 0.1, 0.1, -85, 85).}
       
       SET desiredpitch TO -1 * PIDpitch:UPDATE(TIME:SECONDS,axis_speed[1]).
       set last_time to time:seconds. 
       LOCK STEERING TO HEADING(TARGET:HEADING,desiredpitch).
       set TVAL to 0.
       wait 0.
       
       
       //math
       print "RUNMODE:    " + runmode + "      " at (5,4).
       print "Impact Time:" + round(impacttime,1) + "      " at (5,5). 
       print "Desired lateral speed " + round(math3(),3) + "      " at (5,6). 
       print "desired pitch " + round(desiredpitch,3) + "      " at (5,7).
       print "pitch:    " + round(pitch_for(),4) + "      " at (5,8).
      //speed
       print "vertspeed:" + round(verticalspeed,1) + "      " at (5,10).
       print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,11).
       print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,12).
       print "fore speed " + round(axis_speed[1],3) + "      " at (5,13).
       //distance 
      print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,15). 
      print "dtg:    " +round(dtg(),2) + "      " at (5,16). 
      print "str line dist:    " + round(VB(),1) + "      " at (5,18).
      print "fore D " + round(axis_distance[1],3) + "      " at (5,19).
      print "star D " + round(axis_distance[2],3) + "      " at (5,20). 
      print "stopD    " + stoppingDistance() + "      " at (5,21).
       
       //if landingRadar < (stoppingDistance + 100) {set runmode to 3.}
       }
       IF dtg() <450 {set runmode to 3.}
    }
        
    if runmode = 3 { // Land on the ground
       toggle ag3.
       //lock steering to v(340,0,180).
       lock steering to v(340,0,180).
       until pitch_for > 80 {
         SET PID:SETPOINT TO 0.
         set target_twr to 2.
                  lock maxtwr to (ship:maxthrust * 1)/ (GRAV * ship:mass).
         global pid is pidloop(1.818181818182, 1.4523718852301, 0.164222839640732, 0, maxtwr).
         //set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
         //set RV:mag to min(8,RV:mag). //just for safety
         //lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).
         lock steering to v(340,0,180).
         lock throttle to min(target_twr / maxtwr, 1).
         print "RUNMODE:    " + runmode + "      " at (5,4).
         print "Impact Time:" + round(impacttime,1) + "      " at (5,5). 
         print "Desired lateral speed " + round(math3(),3) + "      " at (5,6). 
         print "desired pitch " + round(desiredpitch,3) + "      " at (5,7).
         print "pitch:    " + round(pitch_for(),4) + "      " at (5,8). 
       }
       ag4 on. 
       until vb() < 50{
        SET PID:SETPOINT TO 0.
         set target_twr to pid:update(kkk,ship:verticalSpeed).
                  lock maxtwr to (ship:maxthrust * 1)/ (GRAV * ship:mass).
         global pid is pidloop(1.818181818182, 1.4523718852301, 0.164222839640732, 0, maxtwr).
         set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
         set RV:mag to min(8,RV:mag). //just for safety
         lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).
         lock throttle to min(target_twr / maxtwr, 1).
       
       }
      
     

        set runmode to 4.}

   if runmode = 4 {  

       lock steering to descent_vector.
       //lock steering to heading(targetDirection, targetPitch).
       lock maxtwr to (ship:maxthrust * 1)/ (GRAV * ship:mass).
       global pid is pidloop(1.818181818182, 1.4523718852301, 0.164222839640732, 0, maxtwr).
       set tAlt to 75.
       clearscreen.
       
        until ship:status = "Landed" {
          rcs on.
         if ship:GROUNDSPEED < 1 {lock steering to up.}
         if dtg()< 106 and vb()< 7.5 {set tAlt to 20. ag10 on. gear on. } 
         set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
         set RV:mag to min(8,RV:mag). //just for safety
         lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).
         set PID:setpoint to math().
          set SHIP:CONTROL:fore TO desiredFore.
          set SHIP:CONTROL:top TO desiredtop. 
          set SHIP:CONTROL:starboard TO desiredstar. 
          set pid:setpoint to math().
          set TRTM to vxcl(up:vector,gp:POSITION).
          //set TRTM to VECDRAWARGS( V(0,0,0),gp:position,green,"ship",1,true).
          set target_twr to pid:update(time:seconds, ship:verticalspeed).
          set PIDfore:SETPOINT TO axis_distance[1]/10.
          set PIDstar:SETPOINT TO 1 * axis_distance[2]/10.
          set PIDtop:SETPOINT TO axis_distance[3]/10.
          //lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
          lock myVelocity to ship:facing:inverse * ship:velocity:surface.
          SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1]).
          SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2]). 
          SET desiredtop TO PIDtop:UPDATE(TIME:SECONDS,axis_speed[3]).
          set last_time to time:seconds. 
          set pid:maxoutput to maxtwr.
          set target_twr to pid:update(time:seconds, ship:verticalspeed).
        
            print "pid set point:    " + PID:SETPOINT + "      " at (5,1). 
            print "talt:    " + tAlt + "      " at (5,2). 
            print "D    " + delta[0] + "      " at (5,3). 
            //math
            print "RUNMODE:    " + runmode + "      " at (5,4).
            print "Impact Time:" + round(impacttime,1) + "      " at (5,5). 
            print "Desired lateral speed " + round(math3(),3) + "      " at (5,6). 
            print "desired pitch " + round(desiredpitch,3) + "      " at (5,7).
            print "pitch:    " + round(pitch_for(),4) + "      " at (5,8).
            //speed
            print "vertspeed:" + round(verticalspeed,1) + "      " at (5,10).
            print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,11).
            print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,12).
            print "fore speed " + round(axis_speed[1],3) + "      " at (5,13).
             print "star speed " + round(axis_speed[2],3) + "      " at (5,14).
            //distance 
            print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,15). 
            print "dtg:    " +round(dtg(),2) + "      " at (5,16). 
            print "str line dist:    " + round(VB(),1) + "      " at (5,18).
            print "fore D " + round(axis_distance[1],3) + "      " at (5,19).
            print "star D " + round(axis_distance[2],3) + "      " at (5,20). 
            print "stopD    " + stoppingDistance() + "      " at (5,21).
           
           
           }
           rcs off.
           set runmode to 0.
      }
}
        
    
function mathE {
lock mathResulte to (round(axis_speed[1],3)/4).
lock mathResultF to (mathResulte + mathf).
  RETURN mathResultf.}

function math3 {
    lock mathResult1 to (axis_distance[1]/(impacttime + ALTITUDE/2000)).
  RETURN mathResult1.}


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

function VB{
   return vxcl(up:vector,gp:POSITION):mag.}
  



 FUNCTION axis_speed {
	LOCAL localStation IS gp:position.
	LOCAL localship IS SHIP.
	LOCAL relitaveSpeedVec IS SHIP:VELOCITY:SURFACE - gp:VELOCITY:surface.	//relitaveSpeedVec is the speed as reported by the navball in target mode as a vector along the target prograde direction
	LOCAL speedFor IS VDOT(relitaveSpeedVec, ship:Facing:FOREVECTOR).	//positive is moving forwards, negative is moving backwards
	LOCAL speedStar IS VDOT(relitaveSpeedVec, ship:Facing:STARVECTOR).	//positive is moving right, negative is moving left
	LOCAL speedtop IS VDOT(relitaveSpeedVec, ship:Facing:topVECTOR).
  RETURN LIST(relitaveSpeedVec,speedFor,speedStar,speedtop).
}
FUNCTION axis_distance {
   
	LOCAL distVec IS vxcl(up:vector,gp:POSITION).//vector pointing at the station port from the ship: port
	LOCAL dist IS vb().
	LOCAL distFor IS VDOT(distVec,ship:Facing:FOREVECTOR ).	//if positive then stationPort is ahead of ship:Port, if negative than stationPort is behind of ship:Port
	LOCAL distStar IS VDOT(distVec,ship:Facing:STARVECTOR).	//if positive then stationPort is to the right of ship:Port, if negative than stationPort is to the left of ship:Port
	LOCAL disttop IS VDOT(distVec,ship:Facing:topVECTOR).
  RETURN LIST(dist,distFor,distStar,disttop).
}
function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}
FUNCTION math {
  lock mathResult to ((talt-dtg())/8).
  RETURN mathResult.
}

FUNCTION mathf {
  lock mathResult to -1 *(axis_distance[1]/4).
  RETURN mathResult.
}
FUNCTION maths {
  lock mathResult to -1 * (axis_distance[2]/4).
  RETURN mathResult.
}
FUNCTION matht {
  lock mathResult to -1 * (axis_distance[3]/4).
  RETURN mathResult.
}
FUNCTION shutdown_stack {
	RCS OFF.
	UNLOCK STEERING.
	UNLOCK THROTTLE.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	SET SHIP:CONTROL:FORE TO 0.
	SET SHIP:CONTROL:TOP TO 0.
	SET SHIP:CONTROL:STARBOARD TO 0.

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
function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return  90 - vang(ves:up:vector, pointing).}