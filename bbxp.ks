start().

set talt to 1.
set runmode to 2.
until runmode = 0 {
    if runmode =2 {  
      global ipuBackup IS CONFIG:IPU.
     if ipuBackup > 201 {set ipuBackup to 200.} 
     SET CONFIG:IPU TO 100.
     set overshoot to 1.
		 // if kuniverse:activevessel = ship {
     GLOBAL geo_diff is v(0,0,0).
     set offset to vxcl(gp:position-body:position,gp:position).
	   GLOBAL target_pos is gp:position.
		 set offset:mag to min(overshoot,vxcl(up:vector,gp:position):mag / ((90 - vang(up:vector, -velocity:surface)) * 0.3) ). 
		 set target_gp to body:geopositionof(target_pos).
		 addons:tr:settarget(target_gp).
		 set posError to target_gp:position - addons:tr:impactpos:position.
		 SET geo_diff to geo_diff * 0.8 + 0.2 * vxcl(target_gp:position - body:position, posError).
     set dlold to 20000.
     lock throttle to 0.55.
     wait 7.
     set sign to (dlold - DL()).
     until sign <= 0 {
                       LOCK STEERING TO HEADING(gp:HEADING,16).
                       set posError to target_gp:position - addons:tr:impactpos:position.
			                 SET geo_diff to geo_diff * 0.8 + 0.2 * vxcl(target_gp:position - body:position, posError).
                       print "vel rel to target " + round(ship:groundspeed ,2) + "      " at (5,5).
                       print "Remaining Delat-V " + round(dl(),3) + "      " at (5,6).
                       print "sign " + round(sign,3) + "      " at (5,7).
                       wait 0.
                       set dlold to dl().
                       set sign to (dlold - DL()).
                       if dl() < 20 { set throttle to 0.15. SET CONFIG:IPU TO 500. }}
     CLEARSCREEN.
     set throttle to 0.
     SET CONFIG:IPU TO 200.
     set runmode to  3.
    }
    if runmode = 3 { 
       until SHIP:ALTITUDE < 30000 and ship:AIRSPEED < 700 {
        LOCK STEERING TO HEADING(gp:HEADING,45).
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
        if SHIP:ALTITUDE < 30000 and ship:AIRSPEED < 700 {set runmode to 4.}
    }

if runmode = 4 { 
       clearscreen.
       AG1 ON.
       AG2 ON.
        set TRTM to vxcl(up:vector,gp:POSITION).
       
      until dtg() < 550 {
       if vb() > 15000 {set PIDpitch to pidloop(1, 0.2, 0.01, -10, 10).}
       else { set PIDpitch to pidloop(1, 0.25, 0.1, -55, 55).}
       set TRTM to gp:POSITION.
       set TRTM2 to r(0,180,0)*TRTM.
       set PIDpitch:SETPOINT TO math3().
       SET desiredpitch TO -1 * PIDpitch:UPDATE(TIME:SECONDS,axis_speed[1]).
       set last_time to time:seconds. 
       LOCK STEERING TO HEADING(gp:HEADING,desiredpitch).
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
       //set TRTMA to VECDRAWARGS( V(0,0,0),TRTM,green,"ship",1,true).
       //set TRTM to VECDRAWARGS( V(0,0,0),gp:position,green,"ship",1,true).
       //set TRTMb to VECDRAWARGS( V(0,0,0),TRTM2,red,"ship",1,true).
       }
       IF dtg() < 550 {set runmode to 5.}
    }
        
    if runmode = 5 { // flip
       set target_twr to pid:update(time:seconds, ship:verticalspeed).
       local pid is pidloop(1.818181818182, 1.4523718852301, 0.164222839640732, 0, maxtwr).
       lock throttle to min(target_twr / maxtwr, 1).
       SET PID:SETPOINT TO math().
       rcs on.
       lock r1 to max(-135,-90 +(0 - (2 * ship:groundspeed))).
       LOCK STEERING TO LOOKDIRUP(ANGLEAXIS(r1,VCRS(VELOCITY:SURFACE,BODY:POSITION))*VELOCITY:SURFACE,FACING:TOPVECTOR).
       
       ag3 on.
       lock maxtwr to (ship:maxthrust * 1)/ (GRAV * ship:mass).
      
       //
      lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
      
       until pitch_for >70 {
         
         print "pitch:    " + round(pitch_for(),4) + "      " at (5,8). 
         wait 0.2.
       }
       set runmode to 6.}

   if runmode = 6 {  

       lock steering to descent_vector.
       //lock steering to heading(targetDirection, targetPitch).
       lock maxtwr to (ship:maxthrust * 1)/ (GRAV * ship:mass).
       global pid is pidloop(1.818181818182, 1.4523718852301, 0.164222839640732, 0, maxtwr).
       set tAlt to 25.
       clearscreen.
       
        until ship:status = "Landed" {
          rcs on.
         if ship:GROUNDSPEED < 1 {lock steering to up.}
         if dtg()< 86 and vb()< 50 {set tAlt to (talt - 1). ag10 on. gear on. lock throttle to (GRAV / maxAcc + (talt - dtg()) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector). } 
         
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
        
            print "talt:    " + tAlt + "      " at (5,5). 
            print "D    " + delta[0] + "      " at (5,6). 
            print "vertspeed:" + round(verticalspeed,1) + "      " at (5,10).
            print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,11).
            print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,12).
            print "dtg:    " +round(dtg(),2) + "      " at (5,7). 
            wait 0.
           
           }
           rcs off.
           shutdown_stack().
           set runmode to 0.
      } 
}


























FUNCTION start {
 control_point().
    set gp to LATLNG(-0.0967646955755359,-74.6187122587352).
    LOCK STEERING TO HEADING(gp:HEADING,16).
    rcs on.
    set leg_part to ship:partstagged("HH")[0].
    set rv to 0.
    SET HEIGHT TO GP:terrainheight.
    lock GRAV to body:mu / body:position:sqrmagnitude.
    lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
    lock forespeed to round(axis_speed[1],0).
    lock cygnus to round(dl(),0).
    lock maxAcc to ship:availablethrust / mass.
    lock shipLatLng to SHIP:GEOPOSITION.
    lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
    lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
    lock impactTime to betterALTRADAR / -VERTICALSPEED.
    lock RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. 
    LOCAL desiredFore IS 0.
    LOCAL desiredstar IS 0.
    LOCAL desiredtop  IS 0.
    LOCAL desiredpitch  IS 0.
    LOCAL shipFacing IS ship:facing.
    LOCAL axisSpeed IS axis_speed().
    LOCAL RCSdeadZone IS 0.05.
    local PIDtop is pidloop(4, 0.2, 0.1, -20, 20).
    local PIDfore is pidloop(4, 0.2, 0.1, -20, 20).
    local PIDstar is pidloop(4, 0.2, 0.1, -20, 20).
    local last_time is time:seconds.
    local total_error is 0.
    clearscreen. 
    wait 8.
    toggle AG1.
  //lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   }


function delta {
  local maxDeceleration is (ship:availableThrust / ship:mass) - GRAV.
  local beta is (SQRT(ship:verticalSpeed^2 + SHIP:GROUNDSPEED^2)).
  local charlie is beta^2 / (2 * maxDeceleration).
  return list (beta,charlie).}

function stoppingDistance {
  local maxDeceleration is (ship:availableThrust / ship:mass) - GRAV.
  return ship:verticalSpeed^2 / (2 * maxDeceleration).}
  
function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * grav - velocity:surface).}



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
  RETURN LIST(relitaveSpeedVec,speedFor,speedStar,speedtop).}
FUNCTION axis_distance {
   
	LOCAL distVec IS vxcl(up:vector,gp:POSITION).//vector pointing at the station port from the ship: port
	LOCAL dist IS vb().
	LOCAL distFor IS VDOT(distVec,ship:Facing:FOREVECTOR ).	//if positive then stationPort is ahead of ship:Port, if negative than stationPort is behind of ship:Port
	LOCAL distStar IS VDOT(distVec,ship:Facing:STARVECTOR).	//if positive then stationPort is to the right of ship:Port, if negative than stationPort is to the left of ship:Port
	LOCAL disttop IS VDOT(distVec,ship:Facing:topVECTOR).
  RETURN LIST(dist,distFor,distStar,disttop).}


function Dl {
    lock mathResult1 to (geo_diff:mag /(tti + 1)).
    RETURN mathResult1.}
    


FUNCTION TTI {
  LOCAL d IS ALT:RADAR.
  LOCAL v IS -SHIP:VERTICALSPEED.
  LOCAL g IS grav.
  RETURN (SQRT(v^2 + 2 * g * d) - v) / g.}




function AC {
    return min((height + 10),height + (VB*20)).}



function east_for {
  parameter ves is ship.
  return vcrs(ves:up:vector, ves:north:vector).}

function compass_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  local east is east_for(ves).

  local trig_x is vdot(ves:north:vector, pointing).
  local trig_y is vdot(east, pointing).

  local result is arctan2(trig_y, trig_x).

  if result < 0 {
    return 360 + result.
  } else {
    return result.
  }}

function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return 90 - vang(ves:up:vector, pointing).}

function roll_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing.
  if not thing:istype("string") {
    if thing:istype("vessel") or pointing:istype("part") {
      set pointing to thing:facing.
    } else if thing:istype("direction") {
      set pointing to thing.
    } else {
      print "type: " + thing:typename + " is not reconized by roll_for".
	}
  }

  local trig_x is vdot(pointing:topvector,ves:up:vector).
  if abs(trig_x) < 0.0035 {//this is the dead zone for roll when within 0.2 degrees of vertical
    return 0.
  } else {
    local vec_y is vcrs(ves:up:vector,ves:facing:forevector).
    local trig_y is vdot(pointing:topvector,vec_y).
    return arctan2(trig_y,trig_x).
  }}

function compass_and_pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  local east is east_for(ves).

  local trig_x is vdot(ves:north:vector, pointing).
  local trig_y is vdot(east, pointing).
  local trig_z is vdot(ves:up:vector, pointing).

  local compass is arctan2(trig_y, trig_x).
  if compass < 0 {
    set compass to 360 + compass.
  }
  local pitch is arctan2(trig_z, sqrt(trig_x^2 + trig_y^2)).

  return list(compass,pitch).}

function bearing_between {
  parameter ves,thing_1,thing_2.

  local vec_1 is type_to_vector(ves,thing_1).
  local vec_2 is type_to_vector(ves,thing_2).

  local fake_north is vxcl(ves:up:vector, vec_1).
  local fake_east is vcrs(ves:up:vector, fake_north).

  local trig_x is vdot(fake_north, vec_2).
  local trig_y is vdot(fake_east, vec_2).

  return arctan2(trig_y, trig_x).}

function type_to_vector {
  parameter ves,thing.
  if thing:istype("vector") {
    return thing:normalized.
  } else if thing:istype("direction") {
    return thing:forevector.
  } else if thing:istype("vessel") or thing:istype("part") {
    return thing:facing:forevector.
  } else if thing:istype("geoposition") or thing:istype("waypoint") {
    return (thing:position - ves:position):normalized.
  } else {
    print "type: " + thing:typename + " is not recognized by lib_navball".
  }}

function dtg {
 local bounds_box is leg_part:bounds.
 return bounds_box:bottomaltradar.}
FUNCTION math {  
  lock mathResult to ((talt-dtg())/7.7).
  RETURN mathResult.}

FUNCTION mathf {
  lock mathResult to -1 *(axis_distance[1]/6).
  RETURN mathResult.}
FUNCTION maths {
  lock mathResult to -1 * (axis_distance[2]/6).
  RETURN mathResult.}
FUNCTION matht {
  lock mathResult to -1 * (axis_distance[3]/6).
  RETURN mathResult.}


FUNCTION mathGG {
  lock mathResult to min((height +10) ,(height + (VB*20))).
  RETURN mathResult.} 

function mathE {
 lock mathResulte to (round(axis_speed[1],3)/4).
 lock mathResultF to (mathResulte + mathf).
  RETURN mathResultf.}

function math3 {
    lock mathResult1 to (axis_distance[1]/(impacttime + ALTITUDE/2000)).
  RETURN mathResult1.}






FUNCTION control_point {
	PARAMETER pTag IS "TgtDockPort".
	LOCAL controlList IS SHIP:PARTSTAGGED(pTag).
	IF controlList:LENGTH > 0 {
		controlList[0]:CONTROLFROM().
	} ELSE {
		IF SHIP:ROOTPART:HASSUFFIX("CONTROLFROM") {
			SHIP:ROOTPART:CONTROLFROM().
		}
	}}

FUNCTION shutdown_stack {
	RCS OFF.
	UNLOCK STEERING.
	UNLOCK THROTTLE.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	SET SHIP:CONTROL:FORE TO 0.
	SET SHIP:CONTROL:TOP TO 0.
	SET SHIP:CONTROL:STARBOARD TO 0.}