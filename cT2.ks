//RUNPATH("0:/F1.KS").
//SET CONFIG:IPU TO 600.
start().
lock RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
set RV:mag to min(8,RV:mag). //just for safety
until vb < 45 {
 lock steering to lookdirup(up:vector * 4 + RV, facing:topvector).
 print "VB:    " + VB + "      " at (5,5).
 print "dtg:    " +round(dtg(),2) + "      " at (5,7).

wait 0.2.
}

RUNPATH("0:/F1.KS").


function VB{
   return ROUND(vxcl(up:vector,gp:POSITION):mag,4).

}

FUNCTION start {
  CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal"). 
  lock TARGET TO VESSEL("scr").
  lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
  lock GRAV to body:mu / body:position:sqrmagnitude.
  lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
  lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
  global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
  global tOld is time:seconds - 0.02.
  gear off.
  global target_twr is 0.
  set tAlt to 320.
  LOCK FD TO tAlt.
  lock tAlt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + tAlt.
  lock maxAcc to ship:availablethrust / mass.
  lock throttle to (GRAV / maxAcc + (tAlt2 - min(tAlt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   wait 1.5.

}

function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}

