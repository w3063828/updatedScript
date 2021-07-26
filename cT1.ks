//RUNPATH("0:/F1.KS").
//SET CONFIG:IPU TO 600.
clearscreen.
start().
set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
set RV:mag to min(8,RV:mag). //just for safety
set runmode to 1.

until runmode = 0 {
if runmode =1 { 
 
 lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
 print "VB:    " + VB + "      " at (5,5).
 print "talt:    " + FD + "      " at (5,6). 
 print "dtg:    " +round(dtg(),2) + "      " at (5,7).
 print "RUNMODE:    " + runmode + "      " at (5,8).
 if vb < 30 set runmode to 2.}

if runmode = 2 {
   lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
   print "VB:    " + VB + "      " at (5,5).
   print "talt:    " + FD + "      " at (5,6). 
   print "dtg:    " +round(dtg(),2) + "      " at (5,7).
   print "RUNMODE:    " + runmode + "      " at (5,8).
     set talt to max(21,tAlt - 0.1). 
     //runpath("0:/f2.ks").
 if vb < 1 {
    lock steering to lookdirup(up:vector * 4 + RV, facing:topvector).
     set TRTM to vxcl(up:vector,gp:POSITION).
     set TRTM to VECDRAWARGS( V(0,0,0),target:position,green,"ship",1,true).}
 if vb < 0.36  { set runmode to 3.}
 set runmode to 2.
 }
 
if runmode = 3 {
 print "RUNMODE:    " + runmode + "      " at (5,8). 
 print "VB:    " + VB + "      " at (5,5).
 print "talt:    " + FD + "      " at (5,6). 
 print "dtg:    " +round(dtg(),2) + "      " at (5,7).
 if vb < 0.3 {set talt to (vb * 69).}   
 if vb > 0.36 {set runmode to 2.}  
 lock steering to lookdirup(up:vector * 4 + RV, facing:topvector).
 if vb < 0.04 {set tAlt to max(1,tAlt - 2).}}
}


function VB{
   return ROUND(vxcl(up:vector,gp:POSITION):mag,4).

}
FUNCTION math {
  lock mathResult to ((talt-dtg())/4).
  RETURN mathResult.
}
FUNCTION start {
  CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal"). 
  LOCK TARGET TO VESSEL("UTV").
  set PortList to target:modulesnamed("ModuleDockingNode").
    for Ports in PortList {
	set port to Ports:PART.
	print port:name.
	if port:tag = "TgtDockPort" {
		set target to port.
		print "Docking port targetted".
	}
 } 
  lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
  lock GRAV to body:mu / body:position:sqrmagnitude.
  STAGE.
  lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
  lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
  global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
  global tOld is time:seconds - 0.02.
  gear off.
  global target_twr is 0.
  set tAlt to 150.
  LOCK FD TO tAlt.
  lock tAlt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + tAlt.
  lock maxAcc to ship:availablethrust / mass.
  lock throttle to (GRAV / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   wait 1.5.

}


FUNCTION axis_speed {
	LOCAL localStation IS target:position.
	LOCAL localship IS SHIP.
	LOCAL relitaveSpeedVec IS SHIP:VELOCITY:SURFACE - target:VELOCITY:surface.	//relitaveSpeedVec is the speed as reported by the navball in target mode as a vector along the target prograde direction
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

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}

