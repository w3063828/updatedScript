clearscreen.
LOCAL cAltitude 	IS 1000.
LOCAL cPitch 		IS 0.
LOCAL SPDLMT      IS 450.
until RCS {
  if RCS { RCS off. }
  wait 0.5.}

lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
set TARGET TO VESSEL("FG12"). 
set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
lock bdsm to vxcl(up:vector,gp:POSITION).
//set TRTM to VECDRAWARGS( V(0,0,0),target:position,green,"ship",1,true).
stage.
lock throttle to (2.5 * Ship:Mass * GRAV / ship:availablethrust).

wait 3.
AG3 ON.
lock throttle TO (-1 * ((SHIP:AIRSPEED-spdlmt)/spdlmt)).
until vb < 4 {
  
   SET cPitch TO MATH().
   LOCK STEERING TO HEADING(TARGET:HEADING,cPitch).
   PRINT "Altitude       : " 	+ ROUND(altitude,0) 		+ "m    " 	AT (5,5).
	PRINT "Target Distance: " 	+ ROUND(TARGET:DISTANCE,0) 	+ "m    " 	AT (5,8).
   print "VB:    " + round(VB(),2) + "      " at (5,3).
   print "pitch:    " + round(cPitch,4) + "      " at (5,4).
   WAIT 0.2.
if vb < 2562 {
  lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
  SET cAltitude TO (TARGET:Altitude).
  //lock throttle to (2.5 * Ship:Mass * GRAV / ship:availablethrust).
  }
  if vb < 20 {stage.}
  }

 function dtg {
  return altitude - gp:terrainHeight.
}
FUNCTION math {
  lock mathResult to ((cAltitude-ship:altitude)/100) + ((cAltitude-ship:altitude)/20).
  RETURN mathResult.
}
function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}