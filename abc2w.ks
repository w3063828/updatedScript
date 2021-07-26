
set talt to 450.
// Tuned Hover Test

rcs on.
//sas on.
//WAIT 15.
sas off.
local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).
lock throttle to min(target_twr / maxtwr, 1).
set gp to LATLNG(-0.0967646955755359,-74.6187122587352).
//lock steering to UP.
set ship:control:pilotmainthrottle to 0.
//stage.
set vbold to vb().

clearscreen.

//local pid is pidloop(1.81818181818182, 0.237484789986517, 1.00432804652623, 0, maxtwr). //fg
local pid is pidloop(1.81818181818182, 5.48325897757928, 0.0434983348738613, 0, maxtwr). //skycrane
//local pid is pidloop(1.81818181818182, 4.07785993530615, 0.058489658441312, 0, maxtwr).//rover
//local pid is pidloop(1.81818181818182, 0.257861553891434, 0.924963925825365, 0, maxtwr).
//local pid is pidloop(1.81818181818182, 4.0606958269566, 0.587368878071348, 0, maxtwr).//16 i think
set sign to (vbold - vb()).
lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).
until 0 {
set vbold to vb().
if vb() < 0.1 {set steering to up.}
if vb() > 0.1 and  sign <= 0 {lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).}
  set pid:setpoint to math().
  set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 2.5. //relative velocity vector, we base our steering on this
  set RV:mag to min(8,RV:mag). //just for safety 
   print "sign " + round(sign,3) + "      " at (5,4).
  print "setpoint" + round(pid:setpoint,0) + "      " at (5,9).
  print "dtg:    " +round(dtg(),2) + "      " at (5,8).
  print "current erorr:    " + round(abs(dtg() - talt),2) + "      " at (5,7).
  print "math" + round(math(),2)+ "      " at (5,10).
  print "VB:    " + round(VB,3) + "      " at (5,5).
  //if rcs { rcs off. set pid:setpoint to pid:setpoint - 1. }
  //1if sas { sas off. AG1 ON.} //set pid:setpoint to pid:setpoint + 1. }
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.
  set sign to (vbold - vb()).
}
FUNCTION math {
  lock mathResult to ((talt-dtg())/4).
  RETURN mathResult.
}
function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}
function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}