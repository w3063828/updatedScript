
SAS off.
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
start().


   
   until DTG < 1400 and ship:AIRSPEED < 200 {
    set steering to prograde * r(-55, 0, 0):vector.
    lock throttle to 0.
    
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
  start2(). 
   until pitch_for >70 {     
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,8). 
    wait 0.}
   
until dtg() < 500 and ship:verticalspeed > -40  and ship:groundspeed < 5 { 
                                                      set target_twr to pid:update(time:seconds, ship:verticalspeed).
                                                      lock STEERING to velocity:surface * -1.
                                                      SET PID:SETPOINT TO math().
                                                    
                                                      print "vertspeed:" + round(verticalspeed,1) + "      " at (5,5).
                                                      print "dtg:    " +round(dtg(),2) + "      " at (5,6). 
                                                       set last_time to time:seconds. } 
     set pid to pidloop(1.81818181818182, 0.9725434, 0.2434983348738613, 0, maxtwr).
    lock steering to up.
     ag6 on.
     SET PID:SETPOINT TO -10.

     
     
      LOCAL desiredFore IS 0.
      LOCAL desiredstar IS 0.
      LOCAL desiredtop  IS 0.
      LOCAL desiredpitch  IS 0.
      LOCAL shipFacing IS ship:facing.
      LOCAL axisSpeed IS axis_speed().
      LOCAL RCSdeadZone IS 0.05.
      local PIDtop is pidloop(4, 0.2, 0.1, -10, 10).
      local PIDfore is pidloop(4, 0.2, 0.1, -10, 10).
      local PIDstar is pidloop(4, 0.2, 0.1, -10, 10).
      local last_time is time:seconds.
     
      SET GP TO  body:geopositionOf(ship:position).
     until ship:status = "Landed" {                   print "vertspeed:" + round(verticalspeed,1) + "      " at (5,5).
                                                      print "dtg:    " +round(dtg(),2) + "      " at (5,6). 
                                                      print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,7).
                                                      print "fore speed " + round(axis_speed[1],3) + "      " at (5,8).
                                                      print "star speed " + round(axis_speed[2],3) + "      " at (5,9).
                                                      print "str line dist:    " + round(VB(),1) + "      " at (5,10).
                                                      print "desiredFore:  " + round(desiredFore) + "      " at (5,11).
                                                      print "desiredstar:  " + round(desiredstar) + "      " at (5,12).
                                                      print "desiredtop:  " + round(desiredtop) + "      " at (5,13).
                                              
                                                      set SHIP:CONTROL:fore TO desiredFore.
                                                      set SHIP:CONTROL:top TO desiredtop. 
                                                      set SHIP:CONTROL:starboard TO desiredstar. 
                                                      set pid:maxoutput to maxtwr.
                                                      set PIDfore:SETPOINT TO axis_distance[1]/5.
                                                      set PIDstar:SETPOINT TO 1 * axis_distance[2]/5.
                                                      set PIDtop:SETPOINT TO axis_distance[3]/5.
                                                      set target_twr to pid:update(time:seconds, ship:verticalspeed).
                                                      lock myVelocity to ship:facing:inverse * ship:velocity:surface.
                                                      SET desiredFore TO PIDfore:UPDATE(TIME:SECONDS,axis_speed[1]).
                                                      SET desiredstar TO PIDstar:UPDATE(TIME:SECONDS,axis_speed[2]). 
                                                      SET desiredtop TO PIDtop:UPDATE(TIME:SECONDS,axis_speed[3]).
                                                      if dtg < 100 { SET PID:SETPOINT TO -1.5.}
                                                      set last_time to time:seconds. }





  rcs off.
  
 

        
function start {
  control_point(). 
 
  RCS on.
 

  
  lights on.
  gear off.
  ag1 on.
  ag2 on.
  lock g to body:mu / ((ship:altitude + body:radius)^2).
  lock maxtwr to ship:maxthrust / (g * ship:mass).
  GLOBAL pid is pidloop(1.81818181818182, 0.237484789986517, 1.00432804652623, 0, maxtwr). //fg
  GLOBAL target_twr is 0.
  global desiredFore IS 0.
  global desiredstar IS 0.
  global desiredtop  IS 0.
  global desiredpitch  IS 0.
  global shipFacing IS ship:facing.

  global RCSdeadZone IS 0.05.
  GLOBAL PIDtop is pidloop(4, 0.2, 0.1, -20, 20).
  GLOBAL PIDfore is pidloop(4, 0.2, 0.1, -20, 20).
  GLOBAL PIDstar is pidloop(4, 0.2, 0.1, -20, 20).
  GLOBAL last_time is time:seconds.
  GLOBAL total_error is 0.
  GLOBAL start_time is time:seconds.
  GLOBAL original_length is ship:parts:length.
  set throttle to 0.
  
  
  set xfil to 1.
  set talt to 75.
 
  
  
  lock maxAcc to ship:availablethrust / mass.
  lock TWR to MAX( 0.001, (MAXTHRUST * 0.91) / (MASS*g)).
  lock shipLatLng to SHIP:GEOPOSITION.
  lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
  lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
  lock impactTime to betterALTRADAR / -VERTICALSPEED.
  lock landingRadar to min(ALTITUDE, betterALTRADAR). 
  lock r1 to max(-135,-90 +(0 - (2 * ship:groundspeed))).
  lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
  lock throttle to min(target_twr / maxtwr, 1).
  lock steering to up + R(0,0,180).
  set gp to addons:tr:impactpos.
  lock target to gp. 
  clearscreen.  
}   

function start2 {
   rcs on.
   lock throttle to min(target_twr / maxtwr, 1). 
   local pid is pidloop(1.818181818182, 1.4523718852301, 0.164222839640732, 0, maxtwr).
   set target_twr to pid:update(time:seconds, ship:verticalspeed).
   SET PID:SETPOINT TO math().
   LOCK STEERING TO LOOKDIRUP(ANGLEAXIS(r1,VCRS(VELOCITY:SURFACE,BODY:POSITION))*VELOCITY:SURFACE,FACING:TOPVECTOR).
   lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
   ag3 on.
}
   


function mathE {
lock mathResulte to (round(axis_speed[1],3)/4).
lock mathResultF to (mathResulte + mathf).
  RETURN mathResultf.}

function math3 {
    lock mathResult1 to (axis_distance[1]/(impacttime + ALTITUDE/2000)).
  RETURN mathResult1.}


function stoppingDistance {
  local maxDeceleration is (ship:availableThrust / ship:mass) - g.
  return ship:verticalSpeed^2 / (2 * maxDeceleration).}
  
function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * g - velocity:surface).}

function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.}

function unrotate {
  parameter v. if v:typename <> "Vector" set v to v:vector.
  return lookdirup(v, ship:facing:topvector).}

  function delta {
  local maxDeceleration is (ship:availableThrust / ship:mass) - g.
  local beta is (SQRT(ship:verticalSpeed^2 + SHIP:GROUNDSPEED^2)).
  local charlie is beta^2 / (2 * maxDeceleration).
  return list (beta,charlie).
  }

function VB{
   return vxcl(up:vector,gp:POSITION):mag.}

 FUNCTION axis_speed {
  
	
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
  lock mathResult to ((talt-dtg())/12.5).
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