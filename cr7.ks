CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
//stage.
//set target to waypoint:"Area C8ZP Gamma".
lock TARGET TO VESSEL("jORFRID'S dEBRIS").
   set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
global east is vectorCrossProduct(north:vector, up:vector).
lock center to ship:position.
lock a to body:geopositionOf(center + 500 * north:vector).
lock b to body:geopositionOf(center - 0 * north:vector + 250 * east).
lock c to body:geopositionOf(center - 0 * north:vector - 250 * east).
lock d to body:geopositionOf(center + 500 * north:vector ).
lock e to body:geopositionOf(center + 100 * north:vector + 100 ).
lock f to body:geopositionOf(center + 100 * north:vector - 100).

//LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
//lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
//AG5 ON.
//sas off.
//rcs on.
//wait 5.

//sas off.
//gear on.
local tAlt is 60 .
lock talt2 to max(Posi(),ship:geoposition:terrainheight) + talt.
local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).
lock throttle to min(target_twr / maxtwr, 1).
local speedlimit is 20.

set ship:control:pilotmainthrottle to 0.
//stage.
local pid is pidloop(1.81818181818182, 4.05284576246403, 0.0588506568436101, 0, maxtwr).
//local pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
//local pid is pidloop(1.81818181818182, 0.257861553891434, 0.924963925825365, 0, maxtwr).
//local pid is pidloop(1.81818181818182, 4.07785993530615, 0.058489658441312, 0, maxtwr).//rover
until vb < 30 {
  set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
  set RV:mag to min(8,RV:mag). //just for safety
  if Ship:groundspeed > speedlimit {lock steering to RETROGRADE.}//up.}
  if vb < 100  { lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).}
  
  
  if Ship:groundspeed < (speedlimit - 5 ) { lock steering to lookdirup(up:vector * 45 + RV, facing:topvector).}
  set pid:setpoint to math().
  print "VB:    " + round(VB(),2) + "      " at (5,3).
  print "posi:    " +round(posi(),2) + "      " at (5,8). 
  print "setpoint" + round(pid:setpoint,2) + "      " at (5,9).
  print "dtg:    " +round(dtg(),2) + "      " at (5,6).
  print "current erorr:    " + round(abs(dtg() - talt),2) + "      " at (5,7).
  print "math" + round(math(),2)+ "      " at (5,10).
  print "talt2:    " + round(talt2,2) + "      " at (5,5). 
  print "talt:    " + round(talt,2) + "      " at (5,4).  
  
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  
  if abort { abort off. RUNPATH("0:/ssss.KS").}
}

RUNPATH("0:/ssss.KS").

FUNCTION math {
  lock mathResult to ((Max(talt,talt2)-ship:altitude)/4).
  RETURN mathResult.
}

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
function POSI {
  

  
  local a_vec is a:terrainHeight.
  local b_vec is b:terrainHeight.
  local c_vec is c:terrainHeight.
  local d_vec is d:terrainHeight.
  local e_vec is d:terrainHeight.
  local f_vec is d:terrainHeight.
  LOCAL h IS max(a_vec,d_vec).
  LOCAL i IS max(b_vec,c_vec).
  local j is max(e_vec,f_vec).
  local k is max(h,i).
  local L is max(j,k).
  return  l. }
  function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.}