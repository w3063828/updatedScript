CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
SET TARGET TO VESSEL("space bfg").
set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
global east is vectorCrossProduct(north:vector, up:vector).
lock center to ship:position.
lock a to body:geopositionOf(center + 1500 * north:vector).
lock b to body:geopositionOf(center - 0 * north:vector + 1500 * east).
lock c to body:geopositionOf(center - 0 * north:vector - 1500 * east).
lock d to body:geopositionOf(center - 1500 * north:vector ).



LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
//lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
//AG5 ON.
//sas off.
//rcs on.
//wait 5.

//sas off.
//gear on.
set tAlt to 275 .
lock tAlt2 to max(body:geopositionOf(ship:position):terrainHeight,posi()) + talt.
lock grav to body:mu / body:position:sqrmagnitude.
lock maxAcc to ship:availablethrust / mass.
lock throttle to (grav / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).


set runmode to 1.


until vb < 10 {
    set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
    set RV:mag to min(8,RV:mag). //just for safety
    lock steering to lookdirup(up:vector * 20 + RV, facing:topvector).
    print "VB:    " + VB + "      " at (5,5).
     print "talt2:    " + talt2 + "      " at (5,7). 
    print "posi:    " + posi() + "      " at (5,8). 
   
    //print "a:    " + a:terrainHeight + "      " at (5,11).
    //print "b:    " + b:terrainHeight + "      " at (5,12).
    //print "c:    " + c:terrainHeight + "      " at (5,13).
   // print "d:    " + d:terrainHeight + "      " at (5,14).
    if VB() < 1 RUNPATH("0:/ssss.KS").
    if SAS { SAS off. RUNPATH("0:/ssss.KS"). }
    
}
RUNPATH("0:/ssss.KS").



function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
function POSI {
  

  
  local a_vec is a:terrainHeight.
  local b_vec is b:terrainHeight.
  local c_vec is c:terrainHeight.
  local d_vec is d:terrainHeight.
  LOCAL h IS max(a_vec,d_vec).
  LOCAL i IS max(b_vec,c_vec).
  local j is max(h,i).
  return  j. }
  function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.}