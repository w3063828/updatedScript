clearscreen.
START().

core:part:getmodule("kOSProcessor"):doevent("Open Terminal").

local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).

lock steering to RETROGRADE.
set ship:control:pilotmainthrottle to 0.
stage.
set target_twr to maxtwr.
SET TALT TO 100.
SET tAlt2 TO 100.
lock grav to body:mu / body:position:sqrmagnitude.
lock maxAcc to ship:availablethrust / mass.
UNTIL DTG() < 35000 {WAIT 1.


}

local pid is pidloop(1.81818181818182, 5.48325897757928, 0.0434983348738613, 0, maxtwr).
//global pid is pidloop(1.81818181818182, 0.456998571460453, 0.521911117675102, 0, maxtwr).
//set pid:setpoint to 0.

UNTIL ABS(SHIP:VERTICALSPEED) < 5 {
   if dtg()< 310 and ship:GROUNDSPEED < 1 {SET tAlt to max(0,tAlt - 0.5).}
 set pid:setpoint to MATH().
  set pid:maxoutput to maxtwr.
  IF SHIP:groundspeed < 1 { LOCK STEERING TO UP.}
  set target_twr to pid:update(time:seconds,ship:VERTICALSPEED ).
  lock throttle to min(target_twr / maxtwr, 1).
  print "pid set point:    " + round(PID:SETPOINT,1) + "      " at (5,4).
       print "vertspeed:" + round(verticalspeed,1) + "      " at (5,5).
       print "airspeed:" + round(ship:AIRSPEED,1) + "      " at (5,6).
       print "GROUND SPEED:" + round(SHIP:GROUNDSPEED,1) + "      " at (5,7).
       print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,8). 
       print "dtg:    " +round(dtg(),2) + "      " at (5,9). 
      wait 0.2.

}
SET GP TO body:geopositionOf(ship:position).
lock steering to descent_vector.
LOCAL axisSpeed IS axis_speed().       
       clearscreen.
       lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
        until ship:status = "Landed" {
          rcs on.
         //if dtg()< 40 and ship:GROUNDSPEED < 1 {SET tAlt to max(0,tAlt - 0.5).} 
         if ship:GROUNDSPEED < 1 {lock steering to up.}
         if dtg()< 110 and vb()< 15 {set tAlt to 35. ag10 on. gear on. } 
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
     
           
           
           }

function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.}
FUNCTION math {
  lock mathResult to ((talt-dtg())/15).
  RETURN mathResult.}

FUNCTION START{
lock KKK to time:seconds.

lock TWR to MAX( 0.001, (MAXTHRUST * 0.91) / (MASS*GRAV)).
lock shipLatLng to SHIP:GEOPOSITION.
lock surfaceElevation to shipLatLng:TERRAINHEIGHT.
lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).    
lock impactTime to betterALTRADAR / -VERTICALSPEED.
lock landingRadar to min(ALTITUDE, betterALTRADAR). 
set xfil to 1.
set talt to 78.
rcs on.
sas off.
GLOBAL target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).
//
//set gp to latlng(-0.097124,-74.557706).
GLOBAL pid is pidloop(1.81818181818182, 0.237484789986517, 1.00432804652623, 0, maxtwr). //fg

gear off.
brakes off.
sas off.
rcs off.
GLOBAL target_twr is 0.
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).

lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
lock maxAcc to ship:availablethrust / mass.
lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
GLOBAL desiredFore IS 0.
GLOBAL desiredstar IS 0.
GLOBAL desiredtop  IS 0.
GLOBAL desiredpitch  IS 0.
GLOBAL shipFacing IS ship:facing.

GLOBAL RCSdeadZone IS 0.05.

GLOBAL PIDtop is pidloop(4, 0.2, 0.1, -20, 20).
GLOBAL PIDfore is pidloop(4, 0.2, 0.1, -20, 20).
GLOBAL PIDstar is pidloop(4, 0.2, 0.1, -20, 20).
//GLOBAL pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
GLOBAL last_time is time:seconds.
GLOBAL total_error is 0.}
function VB{
   return ROUND(vxcl(up:vector,gp:POSITION):mag,4).

}
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