//RUNPATH("0:/F1.KS").
//SET CONFIG:IPU TO 600.
set talt to 110.
sas off.
start().
lock RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
set RV:mag to min(8,RV:mag). //just for safety
set runmode to 1.
until runmode = 0 {
if runmode =1 { 
 lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
 print "VB:    " + VB + "      " at (5,5).
 print "talt:    " + FD + "      " at (5,6). 
 print "dtg:    " +round(dtg(),2) + "      " at (5,7).
 print "RUNMODE:    " + runmode + "      " at (5,8).
 print "pitch_for:    " + pitch_for() + "      " at (5,9).
 //print "dtt:    " +round(dtt(),2) + "      " at (5,10).
if vb < 10 set runmode to 2.}

if runmode = 2 {
  until dtg < 55 {
    lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
    print "VB:    " + VB + "      " at (5,5).
    print "talt:    " + FD + "      " at (5,6). 
    print "dtg:    " +round(dtg(),2) + "      " at (5,7).
    print "RUNMODE:    " + runmode + "      " at (5,8).
    print "pitch_for:    " + pitch_for() + "      " at (5,9).
    //print "dtt:    " +round(dtt(),2) + "      " at (5,10).
    set talt to max(21,talt - 0.35). 
    wait 0.}
  
  set runmode to 3.
}
//runpath("0:/f2.ks").
 if runmode = 3 { 
    set talt to 40. 
    lock steering to lookdirup(up:vector * 4 + RV, facing:topvector).
     set TRTM to vxcl(up:vector,gp:POSITION).
     set TRTM to VECDRAWARGS( V(0,0,0),target:position,green,"ship",1,true).
  if vb < 0.36 set runmode to 0.
  print "RUNMODE:    " + runmode + "      " at (5,8). 
  print "pitch_for:    " + pitch_for() + "      " at (5,9).
  print "VB:    " + VB + "      " at (5,5).
  print "talt:    " + talt + "      " at (5,6). 
  print "dtg:    " +round(dtg(),2) + "      " at (5,7).
  print "ac:    " + AC + "      " at (5,4).
  wait 0.}
 
 
}

clearscreen.

  local original_length is ship:parts:length. 
  until ship:parts:length > original_length {

  SET talt to MIN(15,AC()).
  lock steering to lookdirup(up:vector * 4 + RV, facing:topvector).
  lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
  print "pitch_for:    " + pitch_for() + "      " at (5,9).
  print "VB:    " + VB + "      " at (5,5).
  print "talt:    " + tAlt + "      " at (5,6). 
  print "dtg:    " +round(dtg(),2) + "      " at (5,7).
  print "ac:    " + AC + "      " at (5,4).  
  print "RUNMODE:    " + runmode + "      " at (5,8). 
  set TRTM to vxcl(up:vector,gp:POSITION).
  set TRTM to VECDRAWARGS( V(0,0,0),target:position,green,"ship",1,true).
   wait 0.
    IF vb < 0.04 {set tAlt to max(0,tAlt - 0.2).}
   }

 

function VB{
   return ROUND(vxcl(up:vector,gp:POSITION):mag,4).

}

FUNCTION start {
  CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal"). 
  lock TARGET TO VESSEL("UNT").
   set PortList to target:modulesnamed("ModuleDockingNode").
  for Ports in PortList {
	set port to Ports:PART.
	print port:name.
	if port:tag = "TgtDockPort" {
		set target to port.
	print "Docking port targetted".
	}}
  lock gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
  lock GRAV to body:mu / body:position:sqrmagnitude.
  lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
  lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
  global pid is pidloop(2.72727272727273, 2.36900403330529, 0.226531243370937, 0, maxtwr).
  global tOld is time:seconds - 0.02.
  gear off.
  global target_twr is 0.
  
  LOCK FD TO talt.
  lock FC to AC().
  lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
  lock maxAcc to ship:availablethrust / mass.
  lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   wait 1.5.
}

function AC {return min(15,vb * 40).}

function dtt {
 return SHIP:ALTITUDE - target:ALTITUDE.}
function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}


function east_for {
  parameter ves is ship.

  return vcrs(ves:up:vector, ves:north:vector).
}

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
  }
}

function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return 90 - vang(ves:up:vector, pointing).
}

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
  }
}

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

  return list(compass,pitch).
}

function bearing_between {
  parameter ves,thing_1,thing_2.

  local vec_1 is type_to_vector(ves,thing_1).
  local vec_2 is type_to_vector(ves,thing_2).

  local fake_north is vxcl(ves:up:vector, vec_1).
  local fake_east is vcrs(ves:up:vector, fake_north).

  local trig_x is vdot(fake_north, vec_2).
  local trig_y is vdot(fake_east, vec_2).

  return arctan2(trig_y, trig_x).
}

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
  }
}


  
  
