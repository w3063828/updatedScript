LOCAL cPitch 		IS 0.
LOCAL bPitch 		IS 0.
LOCAL dPitch 		IS 0.
global cAltitude 	IS ship:Altitude.
LOCAL cPitch 		IS 0.
LOCAL SPDLMT      IS 500.
CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
set TARGET TO VESSEL("FG12"). 
lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
lock throttle TO (-1 * ((SHIP:AIRSPEED-spdlmt)/spdlmt)).
local pid is pidloop(0.4545454545454551,0.0378687256760025877432637, 0.393650418236142, 15, -15).
//stage.
LOCK STEERING TO HEADING(TARGET:HEADING,math()).
until altitude > 800 AND 1050 > altitude {
    print "Alt:    " +round(altitude,2) + "      " at (5,8).
    print "current erorr:    " + round(DT,2) + "      " at (5,9).
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
    print "setpoint" + pid:setpoint + "      " at (5,11).
    print "vert" + round(ship:verticalspeed,1) + "      " at (5,7).
    }
clearscreen. 
until vb < 0 {
  if vb < 60 {AG1 ON.ag2 on.stage.} 
  wait 0.
  if vb < 500 {lock steering to TARGET:POSITION.} 
  if vb < 2060{
   SET cAltitude TO (TARGET:Altitude).}  
  lock cPitch TO MATH().
  lock dpitch to ((2.5 * cPitch) + bPitch).
  set PID:setpoint to MATH1.
  lock bPitch TO PID:UPDATE(time:seconds, ship:verticalspeed).
  LOCK STEERING TO HEADING(TARGET:HEADING,dpitch).
    print "VB:    " + VB + "      " at (5,5).
    print "Alt:    " +round(altitude,2) + "      " at (5,8).
    print "current erorr:    " + round(DT(),2) + "      " at (5,9).
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
    print "setpoint" + pid:setpoint + "      " at (5,11).
    print "vert" + round(ship:verticalspeed,1) + "      " at (5,7).
    //WAIT 0.
}

 function dtg {
  return altitude - gp:terrainHeight.
}
 FUNCTION math {
  lock mathResult to ((cAltitude-altitude)/15).
  RETURN mathResult.}
  FUNCTION math1 {
  lock mathResult to ((cAltitude-altitude)/10).
  RETURN mathResult.}

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
FUNCTION DT {
  lock mathResult to (cAltitude - ship:altitude).}
  
function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return 90 - vang(ves:up:vector, pointing).}