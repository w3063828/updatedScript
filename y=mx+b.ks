core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
LOCAL ipuBackup IS CONFIG:IPU.
SET CONFIG:IPU TO 2000.
set best_score to 1.
clearvecdraws().
//set gp to ship:body:geoposition.
clearscreen.

lock steering to up.
lock trottle to 0.5.

lock throttle to 0.
set x_f to 1.41.
set x_f1 to 1.41.
gs().
 global theta is 1500.
 global RADIUS is 2000.
set scoreToBeat to best_score.
//end of frirst lood i have a best score (1st loop)and a score to beat.
gsd().// gives us an indiviual best score for 2nd loop compares to the 1st. if its less than first it sets best score to inidivual best score
hill().

function hill {
    until scoreToBeat < 0.165 {
 if best_score < scoreToBeat {
  set scoreToBeat to best_score. 
  gsd(). //runs normal loop as long a score is best score continues to be lower than score to beat.
    } 
    else {
        set RADIUS to (RADIUS + 15).
        set theta to (theta + 5). 
        set x_f to 750 * sin(theta * RADIUS).
        set x_f1 to 750 * -COS(theta * RADIUS).
    gsdf().}// run midfied program where it adds 10 ft to bot lat lon and then searches restarts the search.
    }
    SET CONFIG:IPU TO ipuBackup.
    print "this worked "  at (5,4).
    print gp at (5,5).
}


 



function availtwr {
  return  MAX( 0.001, (MAXTHRUST*0.97) / (MASS*grav)).
}


function GS{ 
    global east is vectorCrossProduct(north:vector, up:vector).
    lock center to target:position.
    local A IS body:geopositionOf(target:position).
    local b IS body:geopositionOf(center + 00 * north:vector + 10 * east).
    local C IS body:geopositionOf(center + 10 * north:vector + 00 * east).
    local D IS body:geopositionOf(center + 10 * north:vector + 10 * east).
    local E IS body:geopositionOf(center - 00 * north:vector - 10 * east).
    local F IS body:geopositionOf(center - 10 * north:vector - 00 * east).
    local G IS body:geopositionOf(center - 10 * north:vector - 10 * east).
    local H IS body:geopositionOf(center + 10 * north:vector - 10 * east). 
    local I IS body:geopositionOf(center - 10 * north:vector + 10 * east).  

    local j IS body:geopositionOf(center - 20 * north:vector + 20 * east).
    local k IS body:geopositionOf(center - 10 * north:vector + 20 * east).
    local l IS body:geopositionOf(center - 00 * north:vector + 20 * east).
    local m IS body:geopositionOf(center + 10 * north:vector + 20 * east).
    local n IS body:geopositionOf(center + 20 * north:vector + 20 * east).

    local o IS body:geopositionOf(center + 20 * north:vector + 10 * east).
    local p IS body:geopositionOf(center + 20 * north:vector + 00 * east).
    local qq IS body:geopositionOf(center + 20 * north:vector - 10 * east). 
    local rr IS body:geopositionOf(center + 20 * north:vector - 20 * east).  

    local s is body:geopositionOf(center + 10 * north:vector - 20 * east).  
    local t IS body:geopositionOf(center + 00 * north:vector - 20 * east).
    local u IS body:geopositionOf(center - 10 * north:vector - 20 * east).
    local z IS body:geopositionOf(center - 20 * north:vector - 20 * east).

    local w IS body:geopositionOf(center - 20 * north:vector - 10 * east).
    local x IS body:geopositionOf(center - 20 * north:vector - 00 * east).
    local y IS body:geopositionOf(center - 20 * north:vector + 10 * east).

    local a_vec is a:altitudeposition(a:terrainheight).
    local b_vec is f:altitudeposition(f:terrainheight).
    local c_vec is c:altitudeposition(c:terrainheight).
    local D_vec is d:altitudeposition(d:terrainheight).
    local E_vec is e:altitudeposition(e:terrainheight).
    local F_vec is f:altitudeposition(F:terrainheight).
    local G_vec is g:altitudeposition(G:terrainheight).
    local H_vec is h:altitudeposition(H:terrainheight).
    local I_vec is i:altitudeposition(I:terrainheight).
    local j_vec is j:altitudeposition(j:terrainheight).
    local k_vec is k:altitudeposition(k:terrainheight).
    local l_vec is l:altitudeposition(l:terrainheight).
    local m_vec is m:altitudeposition(m:terrainheight).
    local n_vec is n:altitudeposition(m:terrainheight).
    local o_vec is o:altitudeposition(o:terrainheight).
    local p_vec is p:altitudeposition(p:terrainheight).
    local q_vec is qq:altitudeposition(qq:terrainheight).
    local r_vec is rr:altitudeposition(rr:terrainheight).
    local s_vec is s:altitudeposition(s:terrainheight).
    local t_vec is t:altitudeposition(t:terrainheight).
    local U_vec is u:altitudeposition(u:terrainheight).
    local v_vec is z:altitudeposition(z:terrainheight).
    local w_vec is w:altitudeposition(w:terrainheight).
    local x_vec is x:altitudeposition(x:terrainheight).
    local y_vec is y:altitudeposition(y:terrainheight).

    local sq1 is vcrs(c_vec - a_vec, b_vec - d_vec).
    local sq2 is vcrs(c_vec - a_vec, h_vec - e_vec).
    local sq3 is vcrs(a_vec - f_vec, e_vec - g_vec).
    local sq4 is vcrs(a_vec - f_vec, d_vec - b_vec).
    local sq5 is vcrs(b_vec - i_vec, l_vec - k_vec).
    local sq6 is vcrs(b_vec - d_vec, l_vec - m_vec).
    local sq7 is vcrs(d_vec - o_vec, m_vec - n_vec).
    local sq8 is vcrs(c_vec - p_vec, d_vec - o_vec).
    local sq9 is vcrs(h_vec - q_vec, c_vec - p_vec).
    local sq10 is vcrs(s_vec - r_vec, h_vec - q_vec).
    local sq11 is vcrs(t_vec - s_vec, e_vec - h_vec).
    local sq12 is vcrs(u_vec - t_vec, g_vec - e_vec).
    local sq13 is vcrs(v_vec - u_vec, w_vec - g_vec).
    local sq14 is vcrs(w_vec - g_vec, x_vec - f_vec).
    local sq15 is vcrs(x_vec - f_vec, i_vec - y_vec).
    local sq16 is vcrs(i_vec - y_vec, j_vec - k_vec).
    local upVec IS up:vector.
    local sq1a is vang(upVec,sq1).
    local sq2a is vang(upVec,sq2).
    local sq3a is vang(upVec,sq3).
    local sq4a is vang(upVec,sq4).
    local sq5a is vang(upVec,sq5).
    local sq6a is vang(upVec,sq6).
    local sq7a is vang(upVec,sq7).
    local sq8a is vang(upVec,sq8).
    local sq9a is vang(upVec,sq9).
    local sq10a is vang(upVec,sq10).
    local sq11a is vang(upVec,sq11).
    local sq12a is vang(upVec,sq12).
    local sq13a is vang(upVec,sq13).
    local sq14a is vang(upVec,sq14).
    local sq15a is vang(upVec,sq15).
    local sq16a is vang(upVec,sq16).
    local xxb IS body:geopositionOf(center + 05 * north:vector + 05 * east).
    local xxC IS body:geopositionOf(center - 05 * north:vector + 05 * east).
    local xxD IS body:geopositionOf(center - 05 * north:vector - 05 * east).
    local xxa is body:geopositionOf(center + 05 * north:vector - 05 * east).
    local xxE IS body:geopositionOf(center + 15 * north:vector - 05 * east).
    local xxF IS body:geopositionOf(center + 15 * north:vector + 05 * east).
    local xxG IS body:geopositionOf(center + 15 * north:vector + 15 * east).
    local xxH IS body:geopositionOf(center + 05 * north:vector + 15 * east). 
    local xxI IS body:geopositionOf(center - 05 * north:vector + 15 * east).  
    local xxj IS body:geopositionOf(center - 15 * north:vector + 15 * east).
    local xxk IS body:geopositionOf(center - 15 * north:vector + 5 * east).
    local xxl IS body:geopositionOf(center - 15* north:vector - 05 * east).
    local xxm IS body:geopositionOf(center - 15 * north:vector - 15 * east).
    local xxn IS body:geopositionOf(center - 05 * north:vector - 15 * east).
    local xxo IS body:geopositionOf(center + 05 * north:vector - 15 * east).
    local xxp IS body:geopositionOf(center + 15 * north:vector + 15 * east).
    set mylist to LIST().
    set ccmp to list(sq1a,sq2a,sq3a,sq4a,sq5a,sq6a,sq7a,sq8a,sq9a,sq10a,sq11a,sq12a,sq13a,sq14a,sq15a,sq16a).
  
    mylist:ADD(ccmp).   // Element 1 is now itself a list.
    //print mylist. wait 1. 
    //print mylist.
    //wait 7.
    //set ccmp to list(xxb,xxc,xxd,xxa,xxE,xxf,xxg,xxh,xxi,xxj,xxk,xxl,xxm,xxn,xxo,xxp).
    //mylist:ADD(ccmp).
    clearscreen.
    //print mylist.// wait 7.
    if abs(sq1a) < abs(sq2a) and abs(sq1a) < abs(sq3a) and abs(sq1a) < abs(sq4a) and abs(sq1a) < abs(sq5a) and abs(sq1a) < abs(sq6a) and abs(sq1a) < abs(sq7a) and abs(sq1a) < abs(sq8a) and abs(sq1a) < abs(sq9a) and abs(sq1a) < abs(sq10a) and abs(sq1a) < abs(sq11a) and abs(sq1a) < abs(sq12a) and abs(sq1a) < abs(sq13a) and abs(sq1a) < abs(sq14a) and abs(sq1a) < abs(sq15a) and abs(sq1a) < abs(sq16a)                {set gp to xxb. set best_score to abs( sq1a).}
    if abs(sq2a) < abs(sq1a) and abs(sq2a) < abs(sq3a) and abs(sq2a) < abs(sq4a) and abs(sq2a) < abs(sq5a) and abs(sq2a) < abs(sq6a) and abs(sq2a) < abs(sq7a) and abs(sq2a) < abs(sq8a) and abs(sq2a) < abs(sq9a) and abs(sq2a) < abs(sq10a) and abs(sq2a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq2a) < abs(sq13a) and abs(sq2a) < abs(sq14a) and abs(sq2a) < abs(sq15a) and abs(sq2a) < abs(sq16a)                {set gp to xxc. set best_score to abs( sq2a).} 
    if abs(sq3a) < abs(sq1a) and abs(sq3a) < abs(sq2a) and abs(sq3a) < abs(sq4a) and abs(sq3a) < abs(sq5a) and abs(sq3a) < abs(sq6a) and abs(sq3a) < abs(sq7a) and abs(sq3a) < abs(sq8a) and abs(sq3a) < abs(sq9a) and abs(sq3a) < abs(sq10a) and abs(sq3a) < abs(sq11a) and abs(sq3a) < abs(sq12a) and abs(sq3a) < abs(sq13a) and abs(sq3a) < abs(sq14a) and abs(sq3a) < abs(sq15a) and abs(sq3a) < abs(sq16a)                {set gp to xxd. set best_score to abs( sq3a).}
    if abs(sq4a) < abs(sq1a) and abs(sq4a) < abs(sq2a) and abs(sq4a) < abs(sq3a) and abs(sq4a) < abs(sq5a) and abs(sq4a) < abs(sq6a) and abs(sq4a) < abs(sq7a) and abs(sq4a) < abs(sq8a) and abs(sq4a) < abs(sq9a) and abs(sq4a) < abs(sq10a) and abs(sq4a) < abs(sq11a) and abs(sq4a) < abs(sq12a) and abs(sq4a) < abs(sq13a) and abs(sq4a) < abs(sq14a) and abs(sq4a) < abs(sq15a) and abs(sq4a) < abs(sq16a)                {set gp to xxa. set best_score to abs( sq4a).} 
    if abs(sq5a) < abs(sq1a) and abs(sq5a) < abs(sq2a) and abs(sq5a) < abs(sq3a) and abs(sq5a) < abs(sq4a) and abs(sq5a) < abs(sq6a) and abs(sq5a) < abs(sq7a) and abs(sq5a) < abs(sq8a) and abs(sq5a) < abs(sq9a) and abs(sq5a) < abs(sq10a) and abs(sq5a) < abs(sq11a) and abs(sq5a) < abs(sq12a) and abs(sq5a) < abs(sq13a) and abs(sq5a) < abs(sq14a) and abs(sq5a) < abs(sq15a) and abs(sq5a) < abs(sq16a)                {set gp to xxe. set best_score to abs( sq5a).}
    if abs(sq6a) < abs(sq1a) and abs(sq6a) < abs(sq3a) and abs(sq6a) < abs(sq4a) and abs(sq6a) < abs(sq5a) and abs(sq6a) < abs(sq2a) and abs(sq6a) < abs(sq7a) and abs(sq6a) < abs(sq8a) and abs(sq6a) < abs(sq9a) and abs(sq6a) < abs(sq10a) and abs(sq6a) < abs(sq11a) and abs(sq6a) < abs(sq12a) and abs(sq6a) < abs(sq13a) and abs(sq6a) < abs(sq14a) and abs(sq6a) < abs(sq15a) and abs(sq6a) < abs(sq16a)                {set gp to xxf. set best_score to abs( sq6a).}
    if abs(sq7a) < abs(sq1a) and abs(sq7a) < abs(sq3a) and abs(sq7a) < abs(sq4a) and abs(sq7a) < abs(sq5a) and abs(sq7a) < abs(sq6a) and abs(sq7a) < abs(sq2a) and abs(sq7a) < abs(sq8a) and abs(sq7a) < abs(sq9a) and abs(sq7a) < abs(sq10a) and abs(sq7a) < abs(sq11a) and abs(sq7a) < abs(sq12a) and abs(sq7a) < abs(sq13a) and abs(sq7a) < abs(sq14a) and abs(sq7a) < abs(sq15a) and abs(sq7a) < abs(sq16a)                {set gp to xxg. set best_score to abs( sq7a).}
    if abs(sq8a) < abs(sq1a) and abs(sq8a) < abs(sq3a) and abs(sq8a) < abs(sq4a) and abs(sq8a) < abs(sq5a) and abs(sq8a) < abs(sq6a) and abs(sq8a) < abs(sq7a) and abs(sq8a) < abs(sq2a) and abs(sq8a) < abs(sq9a) and abs(sq8a) < abs(sq10a) and abs(sq8a) < abs(sq11a) and abs(sq8a) < abs(sq12a) and abs(sq8a) < abs(sq13a) and abs(sq8a) < abs(sq14a) and abs(sq8a) < abs(sq15a) and abs(sq8a) < abs(sq16a)                {set gp to xxh. set best_score to abs( sq8a).}
    if abs(sq9a) < abs(sq1a) and abs(sq9a) < abs(sq3a) and abs(sq9a) < abs(sq4a) and abs(sq9a) < abs(sq5a) and abs(sq9a) < abs(sq6a) and abs(sq9a) < abs(sq7a) and abs(sq9a) < abs(sq8a) and abs(sq9a) < abs(sq2a) and abs(sq9a) < abs(sq10a) and abs(sq9a) < abs(sq11a) and abs(sq9a) < abs(sq12a) and abs(sq9a) < abs(sq13a) and abs(sq9a) < abs(sq14a) and abs(sq9a) < abs(sq15a) and abs(sq9a) < abs(sq16a)                {set gp to xxi. set best_score to abs( sq9a).}
    if abs(sq10a) < abs(sq1a) and abs(sq10a) < abs(sq3a) and abs(sq10a) < abs(sq4a) and abs(sq10a) < abs(sq5a) and abs(sq10a) < abs(sq6a) and abs(sq10a) < abs(sq7a) and abs(sq10a) < abs(sq8a) and abs(sq10a) < abs(sq9a) and abs(sq10a) < abs(sq2a) and abs(sq10a) < abs(sq11a) and abs(sq10a) < abs(sq12a) and abs(sq10a) < abs(sq13a) and abs(sq10a) < abs(sq14a) and abs(sq10a) < abs(sq15a) and abs(sq10a) < abs(sq16a)  {set gp to xxj. set best_score to abs(sq10a).}
    if abs(sq11a) < abs(sq1a) and abs(sq11a) < abs(sq3a) and abs(sq11a) < abs(sq4a) and abs(sq11a) < abs(sq5a) and abs(sq11a) < abs(sq6a) and abs(sq11a) < abs(sq7a) and abs(sq11a) < abs(sq8a) and abs(sq11a) < abs(sq9a) and abs(sq11a) < abs(sq10a) and abs(sq11a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq11a) < abs(sq13a) and abs(sq11a) < abs(sq14a) and abs(sq11a) < abs(sq15a) and abs(sq11a) < abs(sq16a)  {set gp to xxk. set best_score to abs(sq11a).}
    if abs(sq12a) < abs(sq1a) and abs(sq12a) < abs(sq3a) and abs(sq12a) < abs(sq4a) and abs(sq12a) < abs(sq5a) and abs(sq12a) < abs(sq6a) and abs(sq12a) < abs(sq7a) and abs(sq12a) < abs(sq8a) and abs(sq12a) < abs(sq9a) and abs(sq12a) < abs(sq10a) and abs(sq12a) < abs(sq11a) and abs(sq12a) < abs(sq2a) and abs(sq12a) < abs(sq13a) and abs(sq12a) < abs(sq14a) and abs(sq12a) < abs(sq15a) and abs(sq12a) < abs(sq16a)  {set gp to xxl. set best_score to abs(sq12a).}
    if abs(sq13a) < abs(sq1a) and abs(sq13a) < abs(sq3a) and abs(sq13a) < abs(sq4a) and abs(sq13a) < abs(sq5a) and abs(sq13a) < abs(sq6a) and abs(sq13a) < abs(sq7a) and abs(sq13a) < abs(sq8a) and abs(sq13a) < abs(sq9a) and abs(sq13a) < abs(sq10a) and abs(sq13a) < abs(sq11a) and abs(sq13a) < abs(sq12a) and abs(sq13a) < abs(sq2a) and abs(sq13a) < abs(sq14a) and abs(sq13a) < abs(sq15a) and abs(sq13a) < abs(sq16a)  {set gp to xxm. set best_score to abs(sq13a).}
    if abs(sq14a) < abs(sq1a) and abs(sq14a) < abs(sq3a) and abs(sq14a) < abs(sq4a) and abs(sq14a) < abs(sq5a) and abs(sq14a) < abs(sq6a) and abs(sq14a) < abs(sq7a) and abs(sq14a) < abs(sq8a) and abs(sq14a) < abs(sq9a) and abs(sq14a) < abs(sq10a) and abs(sq14a) < abs(sq11a) and abs(sq14a) < abs(sq12a) and abs(sq14a) < abs(sq13a) and abs(sq14a) < abs(sq2a) and abs(sq14a) < abs(sq15a) and abs(sq14a) < abs(sq16a)  {set gp to xxn. set best_score to abs(sq14a).}
    if abs(sq15a) < abs(sq1a) and abs(sq15a) < abs(sq2a) and abs(sq15a) < abs(sq3a) and abs(sq15a) < abs(sq4a) and abs(sq15a) < abs(sq5a) and abs(sq15a) < abs(sq6a) and abs(sq15a) < abs(sq7a) and abs(sq15a) < abs(sq8a) and abs(sq15a) < abs(sq9a)  and abs(sq15a) < abs(sq10a) and abs(sq15a) < abs(sq11a) and abs(sq15a) < abs(sq12a) and abs(sq15a) < abs(sq13a) and abs(sq15a) < abs(sq14a) and abs(sq15a) < abs(sq16a) {set gp to xxo. set best_score to abs(sq15a).}
    if abs(sq16a) < abs(sq1a) and abs(sq16a) < abs(sq3a) and abs(sq16a) < abs(sq4a) and abs(sq16a) < abs(sq5a) and abs(sq16a) < abs(sq6a) and abs(sq16a) < abs(sq7a) and abs(sq16a) < abs(sq8a) and abs(sq16a) < abs(sq9a) and abs(sq16a) < abs(sq10a) and abs(sq16a) < abs(sq11a) and abs(sq16a) < abs(sq12a) and abs(sq16a) < abs(sq13a) and abs(sq16a) < abs(sq14a) and abs(sq16a) < abs(sq15a) and abs(sq16a) < abs(sq2a)  {set gp to xxp. set best_score to abs(sq16a).}
    clearscreen.
    
     
    print gp at (5,4).
    print best_score at (5,5).
    print "1st loop" at (5,6).
    //wait 1.
}



function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * GRAV - velocity:surface).
}

local display_data is lex(
  "step", "waiting"
).
function display {
  parameter update is lex().
  for key in update:keys set display_data[key] to update[key].
  local i is 0.
  for key in display_data:keys {print (key + ": " +display_data[key]):padright(terminal:width) at (0, i).set i to i + 1.
  }
}

function unrotate {
  parameter v. if v:typename <> "Vector" set v to v:vector.
  return lookdirup(v, ship:facing:topvector).
}

function radar {return altitude - body:geopositionof(ship:position):terrainheight.
  }


function availtwr {
  return  MAX( 0.001, MAXTHRUST / (MASS*GRAV)).
}
FUNCTION math {  
  lock mathResult to ((talt-dtg())).
  RETURN mathResult.}

function dtg {
 SET GG TO 0.
 LOCK GG TO ship:bounds:bottomaltradar.
   return GG.
} 



function VB{
   return ROUND(vxcl(up:vector,gp:POSITION):mag,4).

}

FUNCTION start {
  lock GRAV to body:mu / body:position:sqrmagnitude.
  lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
  lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
  global pid is pidloop(1.81818181818182, 0.456998571460453, 0.521911117675102, 0, maxtwr).
  global tOld is time:seconds - 0.02.
  gear off.
  global target_twr is 0.
  global desiredFore IS 0.
  global desiredstar IS 0.
  global desiredtop  IS 0.
  global shipFacing IS ship:facing.
  global axisSpeed IS axis_speed().
  global RCSdeadZone IS 0.05.
  global PIDtop is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDfore is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDstar is pidloop(4, 0.1, 0.1, -10, 10).
  //global pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
  global last_time is time:seconds.
  global total_error is 0.
  LOCK FD TO talt.
  lock FC to AC().
  set height to 45.
  lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
  lock maxAcc to ship:availablethrust / mass.
  lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   wait 1.5.

}

function AC {return min((height + 100),height + (VB*20)).}

function dtt {
 return SHIP:ALTITUDE - target:ALTITUDE.}


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

  return vang(ves:up:vector, pointing).
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
function dtg {
 SET GG TO 0.
 LOCK GG TO ship:bounds:bottomaltradar.
   return GG.
}
FUNCTION math {  
  lock mathResult to ((talt-dtg())/4).
  RETURN mathResult.
}
function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}
FUNCTION mathf {
  lock mathResult to -1 *(axis_distance[1]/6).
  RETURN mathResult.
}
FUNCTION maths {
  lock mathResult to -1 * (axis_distance[2]/6).
  RETURN mathResult.
}
FUNCTION matht {
  lock mathResult to -1 * (axis_distance[3]/6).
  RETURN mathResult.
}
FUNCTION shutdown_stack {
	RCS OFF.
	UNLOCK STEERING.
	UNLOCK THROTTLE.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	SET SHIP:CONTROL:FORE TO 0.
	SET SHIP:CONTROL:TOP TO 0.
	SET SHIP:CONTROL:STARBOARD TO 0.

}

 FUNCTION mathGG {
  lock mathResult to min((height +10) ,(height + (VB*20))).
  RETURN mathResult.
} 

function GSD{ 
    local east is vectorCrossProduct(north:vector, up:vector).
    lock center to gp:position.
    local A IS body:geopositionOf(gp:position).
    local b IS body:geopositionOf(center + 00 * north:vector + 10 * east).
    local C IS body:geopositionOf(center + 10 * north:vector + 00 * east).
    local D IS body:geopositionOf(center + 10 * north:vector + 10 * east).
    local E IS body:geopositionOf(center - 00 * north:vector - 10 * east).
    local F IS body:geopositionOf(center - 10 * north:vector - 00 * east).
    local G IS body:geopositionOf(center - 10 * north:vector - 10 * east).
    local H IS body:geopositionOf(center + 10 * north:vector - 10 * east). 
    local I IS body:geopositionOf(center - 10 * north:vector + 10 * east).  

    local j IS body:geopositionOf(center - 20 * north:vector + 20 * east).
    local k IS body:geopositionOf(center - 10 * north:vector + 20 * east).
    local l IS body:geopositionOf(center - 00 * north:vector + 20 * east).
    local m IS body:geopositionOf(center + 10 * north:vector + 20 * east).
    local n IS body:geopositionOf(center + 20 * north:vector + 20 * east).

    local o IS body:geopositionOf(center + 20 * north:vector + 10 * east).
    local p IS body:geopositionOf(center + 20 * north:vector + 00 * east).
    local qq IS body:geopositionOf(center + 20 * north:vector - 10 * east). 
    local rr IS body:geopositionOf(center + 20 * north:vector - 20 * east).  

    local s is body:geopositionOf(center + 10 * north:vector - 20 * east).  
    local t IS body:geopositionOf(center + 00 * north:vector - 20 * east).
    local u IS body:geopositionOf(center - 10 * north:vector - 20 * east).
    local z IS body:geopositionOf(center - 20 * north:vector - 20 * east).

    local w IS body:geopositionOf(center - 20 * north:vector - 10 * east).
    local x IS body:geopositionOf(center - 20 * north:vector - 00 * east).
    local y IS body:geopositionOf(center - 20 * north:vector + 10 * east).


    local a_vec is a:altitudeposition(a:terrainheight).
    local b_vec is f:altitudeposition(f:terrainheight).
    local c_vec is c:altitudeposition(c:terrainheight).
    local D_vec is d:altitudeposition(d:terrainheight).
    local E_vec is e:altitudeposition(e:terrainheight).
    local F_vec is f:altitudeposition(F:terrainheight).
    local G_vec is g:altitudeposition(G:terrainheight).
    local H_vec is h:altitudeposition(H:terrainheight).
    local I_vec is i:altitudeposition(I:terrainheight).
    local j_vec is j:altitudeposition(j:terrainheight).
    local k_vec is k:altitudeposition(k:terrainheight).
    local l_vec is l:altitudeposition(l:terrainheight).
    local m_vec is m:altitudeposition(m:terrainheight).
    local n_vec is n:altitudeposition(m:terrainheight).
    local o_vec is o:altitudeposition(o:terrainheight).
    local p_vec is p:altitudeposition(p:terrainheight).
    local q_vec is qq:altitudeposition(qq:terrainheight).
    local r_vec is rr:altitudeposition(rr:terrainheight).
    local s_vec is s:altitudeposition(s:terrainheight).
    local t_vec is t:altitudeposition(t:terrainheight).
    local U_vec is u:altitudeposition(u:terrainheight).
    local v_vec is z:altitudeposition(z:terrainheight).
    local w_vec is w:altitudeposition(w:terrainheight).
    local x_vec is x:altitudeposition(x:terrainheight).
    local y_vec is y:altitudeposition(y:terrainheight).

    local sq1 is vcrs(c_vec - a_vec, b_vec - d_vec).
    local sq2 is vcrs(c_vec - a_vec, h_vec - e_vec).
    local sq3 is vcrs(a_vec - f_vec, e_vec - g_vec).
    local sq4 is vcrs(a_vec - f_vec, d_vec - b_vec).
    local sq5 is vcrs(b_vec - i_vec, l_vec - k_vec).
    local sq6 is vcrs(b_vec - d_vec, l_vec - m_vec).
    local sq7 is vcrs(d_vec - o_vec, m_vec - n_vec).
    local sq8 is vcrs(c_vec - p_vec, d_vec - o_vec).
    local sq9 is vcrs(h_vec - q_vec, c_vec - p_vec).
    local sq10 is vcrs(s_vec - r_vec, h_vec - q_vec).
    local sq11 is vcrs(t_vec - s_vec, e_vec - h_vec).
    local sq12 is vcrs(u_vec - t_vec, g_vec - e_vec).
    local sq13 is vcrs(v_vec - u_vec, w_vec - g_vec).
    local sq14 is vcrs(w_vec - g_vec, x_vec - f_vec).
    local sq15 is vcrs(x_vec - f_vec, i_vec - y_vec).
    local sq16 is vcrs(i_vec - y_vec, j_vec - k_vec).
    local upVec IS up:vector.

    local sq1a is vang(upVec,sq1).
    local sq2a is vang(upVec,sq2).
    local sq3a is vang(upVec,sq3).
    local sq4a is vang(upVec,sq4).
    local sq5a is vang(upVec,sq5).
    local sq6a is vang(upVec,sq6).
    local sq7a is vang(upVec,sq7).
    local sq8a is vang(upVec,sq8).
    local sq9a is vang(upVec,sq9).
    local sq10a is vang(upVec,sq10).
    local sq11a is vang(upVec,sq11).
    local sq12a is vang(upVec,sq12).
    local sq13a is vang(upVec,sq13).
    local sq14a is vang(upVec,sq14).
    local sq15a is vang(upVec,sq15).
    local sq16a is vang(upVec,sq16).
    local xxb IS body:geopositionOf(center + 05 * north:vector + 05 * east).
    local xxC IS body:geopositionOf(center - 05 * north:vector + 05 * east).
    local xxD IS body:geopositionOf(center - 05 * north:vector - 05 * east).
    local xxa is body:geopositionOf(center + 05 * north:vector - 05 * east).
    local xxE IS body:geopositionOf(center + 15 * north:vector - 05 * east).
    local xxF IS body:geopositionOf(center + 15 * north:vector + 05 * east).
    local xxG IS body:geopositionOf(center + 15 * north:vector + 15 * east).
    local xxH IS body:geopositionOf(center + 05 * north:vector + 15 * east). 
    local xxI IS body:geopositionOf(center - 05 * north:vector + 15 * east).  
    local xxj IS body:geopositionOf(center - 15 * north:vector + 15 * east).
    local xxk IS body:geopositionOf(center - 15 * north:vector + 5 * east).
    local xxl IS body:geopositionOf(center - 15* north:vector - 05 * east).
    local xxm IS body:geopositionOf(center - 15 * north:vector - 15 * east).
    local xxn IS body:geopositionOf(center - 05 * north:vector - 15 * east).
    local xxo IS body:geopositionOf(center + 05 * north:vector - 15 * east).
    local xxp IS body:geopositionOf(center + 15 * north:vector + 15 * east).
    local best_scorea is 100.
    local best_scoreb is 100.
    local best_scorec is 100.
    local best_scored is 100.
    local best_scoree is 100.
    local best_scoref is 100.
    local best_scoreg is 100.
    local best_scoreh is 100.
    local best_scorei is 100.
    local best_scorej is 100.
    local best_scorek is 100.
    local best_scorel is 100.
    local best_scorem is 100.
    local best_scoren is 100.
    local best_scoreo is 100.
    local best_scorep is 100.

 if abs(sq1a) < abs(sq2a) and abs(sq1a) < abs(sq3a) and abs(sq1a) < abs(sq4a) and abs(sq1a) < abs(sq5a) and abs(sq1a) < abs(sq6a) and abs(sq1a) < abs(sq7a) and abs(sq1a) < abs(sq8a) and abs(sq1a) < abs(sq9a) and abs(sq1a) < abs(sq10a) and abs(sq1a) < abs(sq11a) and abs(sq1a) < abs(sq12a) and abs(sq1a) < abs(sq13a) and abs(sq1a) < abs(sq14a) and abs(sq1a) < abs(sq15a) and abs(sq1a) < abs(sq16a)                 { set best_scorea to abs( sq1a).}
 if abs(sq2a) < abs(sq1a) and abs(sq2a) < abs(sq3a) and abs(sq2a) < abs(sq4a) and abs(sq2a) < abs(sq5a) and abs(sq2a) < abs(sq6a) and abs(sq2a) < abs(sq7a) and abs(sq2a) < abs(sq8a) and abs(sq2a) < abs(sq9a) and abs(sq2a) < abs(sq10a) and abs(sq2a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq2a) < abs(sq13a) and abs(sq2a) < abs(sq14a) and abs(sq2a) < abs(sq15a) and abs(sq2a) < abs(sq16a)                 { set best_scoreb to abs( sq2a).} 
 if abs(sq3a) < abs(sq1a) and abs(sq3a) < abs(sq2a) and abs(sq3a) < abs(sq4a) and abs(sq3a) < abs(sq5a) and abs(sq3a) < abs(sq6a) and abs(sq3a) < abs(sq7a) and abs(sq3a) < abs(sq8a) and abs(sq3a) < abs(sq9a) and abs(sq3a) < abs(sq10a) and abs(sq3a) < abs(sq11a) and abs(sq3a) < abs(sq12a) and abs(sq3a) < abs(sq13a) and abs(sq3a) < abs(sq14a) and abs(sq3a) < abs(sq15a) and abs(sq3a) < abs(sq16a)                 { set best_scorec to abs( sq3a).}
 if abs(sq4a) < abs(sq1a) and abs(sq4a) < abs(sq2a) and abs(sq4a) < abs(sq3a) and abs(sq4a) < abs(sq5a) and abs(sq4a) < abs(sq6a) and abs(sq4a) < abs(sq7a) and abs(sq4a) < abs(sq8a) and abs(sq4a) < abs(sq9a) and abs(sq4a) < abs(sq10a) and abs(sq4a) < abs(sq11a) and abs(sq4a) < abs(sq12a) and abs(sq4a) < abs(sq13a) and abs(sq4a) < abs(sq14a) and abs(sq4a) < abs(sq15a) and abs(sq4a) < abs(sq16a)                 { set best_scored to abs( sq4a).} 
 if abs(sq5a) < abs(sq1a) and abs(sq5a) < abs(sq2a) and abs(sq5a) < abs(sq3a) and abs(sq5a) < abs(sq4a) and abs(sq5a) < abs(sq6a) and abs(sq5a) < abs(sq7a) and abs(sq5a) < abs(sq8a) and abs(sq5a) < abs(sq9a) and abs(sq5a) < abs(sq10a) and abs(sq5a) < abs(sq11a) and abs(sq5a) < abs(sq12a) and abs(sq5a) < abs(sq13a) and abs(sq5a) < abs(sq14a) and abs(sq5a) < abs(sq15a) and abs(sq5a) < abs(sq16a)                 { set best_scoree to abs( sq5a).}
 if abs(sq6a) < abs(sq1a) and abs(sq6a) < abs(sq3a) and abs(sq6a) < abs(sq4a) and abs(sq6a) < abs(sq5a) and abs(sq6a) < abs(sq2a) and abs(sq6a) < abs(sq7a) and abs(sq6a) < abs(sq8a) and abs(sq6a) < abs(sq9a) and abs(sq6a) < abs(sq10a) and abs(sq6a) < abs(sq11a) and abs(sq6a) < abs(sq12a) and abs(sq6a) < abs(sq13a) and abs(sq6a) < abs(sq14a) and abs(sq6a) < abs(sq15a) and abs(sq6a) < abs(sq16a)                 { set best_scoref to abs( sq6a).}
 if abs(sq7a) < abs(sq1a) and abs(sq7a) < abs(sq3a) and abs(sq7a) < abs(sq4a) and abs(sq7a) < abs(sq5a) and abs(sq7a) < abs(sq6a) and abs(sq7a) < abs(sq2a) and abs(sq7a) < abs(sq8a) and abs(sq7a) < abs(sq9a) and abs(sq7a) < abs(sq10a) and abs(sq7a) < abs(sq11a) and abs(sq7a) < abs(sq12a) and abs(sq7a) < abs(sq13a) and abs(sq7a) < abs(sq14a) and abs(sq7a) < abs(sq15a) and abs(sq7a) < abs(sq16a)                 { set best_scoreg to abs( sq7a).}
 if abs(sq8a) < abs(sq1a) and abs(sq8a) < abs(sq3a) and abs(sq8a) < abs(sq4a) and abs(sq8a) < abs(sq5a) and abs(sq8a) < abs(sq6a) and abs(sq8a) < abs(sq7a) and abs(sq8a) < abs(sq2a) and abs(sq8a) < abs(sq9a) and abs(sq8a) < abs(sq10a) and abs(sq8a) < abs(sq11a) and abs(sq8a) < abs(sq12a) and abs(sq8a) < abs(sq13a) and abs(sq8a) < abs(sq14a) and abs(sq8a) < abs(sq15a) and abs(sq8a) < abs(sq16a)                 { set best_scoreh to abs( sq8a).}
 if abs(sq9a) < abs(sq1a) and abs(sq9a) < abs(sq3a) and abs(sq9a) < abs(sq4a) and abs(sq9a) < abs(sq5a) and abs(sq9a) < abs(sq6a) and abs(sq9a) < abs(sq7a) and abs(sq9a) < abs(sq8a) and abs(sq9a) < abs(sq2a) and abs(sq9a) < abs(sq10a) and abs(sq9a) < abs(sq11a) and abs(sq9a) < abs(sq12a) and abs(sq9a) < abs(sq13a) and abs(sq9a) < abs(sq14a) and abs(sq9a) < abs(sq15a) and abs(sq9a) < abs(sq16a)                 { set best_scorei to abs( sq9a).}
 if abs(sq10a) < abs(sq1a) and abs(sq10a) < abs(sq3a) and abs(sq10a) < abs(sq4a) and abs(sq10a) < abs(sq5a) and abs(sq10a) < abs(sq6a) and abs(sq10a) < abs(sq7a) and abs(sq10a) < abs(sq8a) and abs(sq10a) < abs(sq9a) and abs(sq10a) < abs(sq2a) and abs(sq10a) < abs(sq11a) and abs(sq10a) < abs(sq12a) and abs(sq10a) < abs(sq13a) and abs(sq10a) < abs(sq14a) and abs(sq10a) < abs(sq15a) and abs(sq10a) < abs(sq16a)  { set best_scorej to abs(sq10a).}
 if abs(sq11a) < abs(sq1a) and abs(sq11a) < abs(sq3a) and abs(sq11a) < abs(sq4a) and abs(sq11a) < abs(sq5a) and abs(sq11a) < abs(sq6a) and abs(sq11a) < abs(sq7a) and abs(sq11a) < abs(sq8a) and abs(sq11a) < abs(sq9a) and abs(sq11a) < abs(sq10a) and abs(sq11a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq11a) < abs(sq13a) and abs(sq11a) < abs(sq14a) and abs(sq11a) < abs(sq15a) and abs(sq11a) < abs(sq16a)  { set best_scorek to abs(sq11a).}
 if abs(sq12a) < abs(sq1a) and abs(sq12a) < abs(sq3a) and abs(sq12a) < abs(sq4a) and abs(sq12a) < abs(sq5a) and abs(sq12a) < abs(sq6a) and abs(sq12a) < abs(sq7a) and abs(sq12a) < abs(sq8a) and abs(sq12a) < abs(sq9a) and abs(sq12a) < abs(sq10a) and abs(sq12a) < abs(sq11a) and abs(sq12a) < abs(sq2a) and abs(sq12a) < abs(sq13a) and abs(sq12a) < abs(sq14a) and abs(sq12a) < abs(sq15a) and abs(sq12a) < abs(sq16a)  { set best_scorel to abs(sq12a).}
 if abs(sq13a) < abs(sq1a) and abs(sq13a) < abs(sq3a) and abs(sq13a) < abs(sq4a) and abs(sq13a) < abs(sq5a) and abs(sq13a) < abs(sq6a) and abs(sq13a) < abs(sq7a) and abs(sq13a) < abs(sq8a) and abs(sq13a) < abs(sq9a) and abs(sq13a) < abs(sq10a) and abs(sq13a) < abs(sq11a) and abs(sq13a) < abs(sq12a) and abs(sq13a) < abs(sq2a) and abs(sq13a) < abs(sq14a) and abs(sq13a) < abs(sq15a) and abs(sq13a) < abs(sq16a)  { set best_scorem to abs(sq13a).}
 if abs(sq14a) < abs(sq1a) and abs(sq14a) < abs(sq3a) and abs(sq14a) < abs(sq4a) and abs(sq14a) < abs(sq5a) and abs(sq14a) < abs(sq6a) and abs(sq14a) < abs(sq7a) and abs(sq14a) < abs(sq8a) and abs(sq14a) < abs(sq9a) and abs(sq14a) < abs(sq10a) and abs(sq14a) < abs(sq11a) and abs(sq14a) < abs(sq12a) and abs(sq14a) < abs(sq13a) and abs(sq14a) < abs(sq2a) and abs(sq14a) < abs(sq15a) and abs(sq14a) < abs(sq16a)  { set best_scoren to abs(sq14a).}
 if abs(sq15a) < abs(sq1a) and abs(sq15a) < abs(sq2a) and abs(sq15a) < abs(sq3a) and abs(sq15a) < abs(sq4a) and abs(sq15a) < abs(sq5a) and abs(sq15a) < abs(sq6a) and abs(sq15a) < abs(sq7a) and abs(sq15a) < abs(sq8a) and abs(sq15a) < abs(sq9a)  and abs(sq15a) < abs(sq10a) and abs(sq15a) < abs(sq11a) and abs(sq15a) < abs(sq12a) and abs(sq15a) < abs(sq13a) and abs(sq15a) < abs(sq14a) and abs(sq15a) < abs(sq16a) { set best_scoreo to abs(sq15a).}
 if abs(sq16a) < abs(sq1a) and abs(sq16a) < abs(sq3a) and abs(sq16a) < abs(sq4a) and abs(sq16a) < abs(sq5a) and abs(sq16a) < abs(sq6a) and abs(sq16a) < abs(sq7a) and abs(sq16a) < abs(sq8a) and abs(sq16a) < abs(sq9a) and abs(sq16a) < abs(sq10a) and abs(sq16a) < abs(sq11a) and abs(sq16a) < abs(sq12a) and abs(sq16a) < abs(sq13a) and abs(sq16a) < abs(sq14a) and abs(sq16a) < abs(sq15a) and abs(sq16a) < abs(sq2a)  { set best_scorep to abs(sq16a).}

     if best_scorea < scoreToBeat {set gp to xxb. set best_score to best_scorea.}
     if best_scoreb < scoreToBeat {set gp to xxc. set best_score to best_scoreb.}
     if best_scorec < scoreToBeat {set gp to xxd. set best_score to best_scorec.}
     if best_scored < scoreToBeat {set gp to xxa. set best_score to best_scored.}
     if best_scoree < scoreToBeat {set gp to xxe. set best_score to best_scoree.}
     if best_scoref < scoreToBeat {set gp to xxf. set best_score to best_scoref.}
     if best_scoreg < scoreToBeat {set gp to xxg. set best_score to best_scoreg.}
     if best_scoreh < scoreToBeat {set gp to xxh. set best_score to best_scoreh.}
     if best_scorei < scoreToBeat {set gp to xxi. set best_score to best_scorei.}
     if best_scorej < scoreToBeat {set gp to xxj. set best_score to best_scorej.}
     if best_scorek < scoreToBeat {set gp to xxk. set best_score to best_scorek.}
     if best_scorel < scoreToBeat {set gp to xxl. set best_score to best_scorel.}
     if best_scorem < scoreToBeat {set gp to xxm. set best_score to best_scorem.}
     if best_scoren < scoreToBeat {set gp to xxn. set best_score to best_scoren.}
     if best_scoreo < scoreToBeat {set gp to xxo. set best_score to best_scoreo.}
     if best_scorep < scoreToBeat {set gp to xxp. set best_score to best_scorep.}
  
   set mylist to LIST().
    set ccmp to list(sq1a,sq2a,sq3a,sq4a,sq5a,sq6a,sq7a,sq8a,sq9a,sq10a,sq11a,sq12a,sq13a,sq14a,sq15a,sq16a).
  
    mylist:ADD(ccmp).   // Element 1 is now itself a list.
    print mylist. //wait 1. 
    clearscreen. 
    print gp at (5,4).
    print best_score at (5,5).
    print "gsd" at (5,6).
    //wait 1.
    
}
 function GSDf { 
   
    local center is (gp:position).
	  set new_Pos to body:geopositionOf(center + x_f * north:vector + x_f1 * east).
    lock center to new_pos:position.
    local A IS new_pos.
    local b IS body:geopositionOf(center + 00 * north:vector + 10 * east).
    local C IS body:geopositionOf(center + 10 * north:vector + 00 * east).
    local D IS body:geopositionOf(center + 10 * north:vector + 10 * east).
    local E IS body:geopositionOf(center - 00 * north:vector - 10 * east).
    local F IS body:geopositionOf(center - 10 * north:vector - 00 * east).
    local G IS body:geopositionOf(center - 10 * north:vector - 10 * east).
    local H IS body:geopositionOf(center + 10 * north:vector - 10 * east). 
    local I IS body:geopositionOf(center - 10 * north:vector + 10 * east).  

    local j IS body:geopositionOf(center - 20 * north:vector + 20 * east).
    local k IS body:geopositionOf(center - 10 * north:vector + 20 * east).
    local l IS body:geopositionOf(center - 00 * north:vector + 20 * east).
    local m IS body:geopositionOf(center + 10 * north:vector + 20 * east).
    local n IS body:geopositionOf(center + 20 * north:vector + 20 * east).

    local o IS body:geopositionOf(center + 20 * north:vector + 10 * east).
    local p IS body:geopositionOf(center + 20 * north:vector + 00 * east).
    local qq IS body:geopositionOf(center + 20 * north:vector - 10 * east). 
    local rr IS body:geopositionOf(center + 20 * north:vector - 20 * east).  

    local s is body:geopositionOf(center + 10 * north:vector - 20 * east).  
    local t IS body:geopositionOf(center + 00 * north:vector - 20 * east).
    local u IS body:geopositionOf(center - 10 * north:vector - 20 * east).
    local z IS body:geopositionOf(center - 20 * north:vector - 20 * east).

    local w IS body:geopositionOf(center - 20 * north:vector - 10 * east).
    local x IS body:geopositionOf(center - 20 * north:vector - 00 * east).
    local y IS body:geopositionOf(center - 20 * north:vector + 10 * east).

    local a_vec is a:altitudeposition(a:terrainheight).
    local b_vec is f:altitudeposition(f:terrainheight).
    local c_vec is c:altitudeposition(c:terrainheight).
    local D_vec is d:altitudeposition(d:terrainheight).
    local E_vec is e:altitudeposition(e:terrainheight).
    local F_vec is f:altitudeposition(F:terrainheight).
    local G_vec is g:altitudeposition(G:terrainheight).
    local H_vec is h:altitudeposition(H:terrainheight).
    local I_vec is i:altitudeposition(I:terrainheight).
    local j_vec is j:altitudeposition(j:terrainheight).
    local k_vec is k:altitudeposition(k:terrainheight).
    local l_vec is l:altitudeposition(l:terrainheight).
    local m_vec is m:altitudeposition(m:terrainheight).
    local n_vec is n:altitudeposition(m:terrainheight).
    local o_vec is o:altitudeposition(o:terrainheight).
    local p_vec is p:altitudeposition(p:terrainheight).
    local q_vec is qq:altitudeposition(qq:terrainheight).
    local r_vec is rr:altitudeposition(rr:terrainheight).
    local s_vec is s:altitudeposition(s:terrainheight).
    local t_vec is t:altitudeposition(t:terrainheight).
    local U_vec is u:altitudeposition(u:terrainheight).
    local v_vec is z:altitudeposition(z:terrainheight).
    local w_vec is w:altitudeposition(w:terrainheight).
    local x_vec is x:altitudeposition(x:terrainheight).
    local y_vec is y:altitudeposition(y:terrainheight).

    local sq1 is vcrs(c_vec - a_vec, b_vec - d_vec).
    local sq2 is vcrs(c_vec - a_vec, h_vec - e_vec).
    local sq3 is vcrs(a_vec - f_vec, e_vec - g_vec).
    local sq4 is vcrs(a_vec - f_vec, d_vec - b_vec).
    local sq5 is vcrs(b_vec - i_vec, l_vec - k_vec).
    local sq6 is vcrs(b_vec - d_vec, l_vec - m_vec).
    local sq7 is vcrs(d_vec - o_vec, m_vec - n_vec).
    local sq8 is vcrs(c_vec - p_vec, d_vec - o_vec).
    local sq9 is vcrs(h_vec - q_vec, c_vec - p_vec).
    local sq10 is vcrs(s_vec - r_vec, h_vec - q_vec).
    local sq11 is vcrs(t_vec - s_vec, e_vec - h_vec).
    local sq12 is vcrs(u_vec - t_vec, g_vec - e_vec).
    local sq13 is vcrs(v_vec - u_vec, w_vec - g_vec).
    local sq14 is vcrs(w_vec - g_vec, x_vec - f_vec).
    local sq15 is vcrs(x_vec - f_vec, i_vec - y_vec).
    local sq16 is vcrs(i_vec - y_vec, j_vec - k_vec).
    local upVec IS up:vector.

    local sq1a is vang(upVec,sq1).
    local sq2a is vang(upVec,sq2).
    local sq3a is vang(upVec,sq3).
    local sq4a is vang(upVec,sq4).
    local sq5a is vang(upVec,sq5).
    local sq6a is vang(upVec,sq6).
    local sq7a is vang(upVec,sq7).
    local sq8a is vang(upVec,sq8).
    local sq9a is vang(upVec,sq9).
    local sq10a is vang(upVec,sq10).
    local sq11a is vang(upVec,sq11).
    local sq12a is vang(upVec,sq12).
    local sq13a is vang(upVec,sq13).
    local sq14a is vang(upVec,sq14).
    local sq15a is vang(upVec,sq15).
    local sq16a is vang(upVec,sq16).
    local xxb IS body:geopositionOf(center + 05 * north:vector + 05 * east).
    local xxC IS body:geopositionOf(center - 05 * north:vector + 05 * east).
    local xxD IS body:geopositionOf(center - 05 * north:vector - 05 * east).
    local xxa is body:geopositionOf(center + 05 * north:vector - 05 * east).
    local xxE IS body:geopositionOf(center + 15 * north:vector - 05 * east).
    local xxF IS body:geopositionOf(center + 15 * north:vector + 05 * east).
    local xxG IS body:geopositionOf(center + 15 * north:vector + 15 * east).
    local xxH IS body:geopositionOf(center + 05 * north:vector + 15 * east). 
    local xxI IS body:geopositionOf(center - 05 * north:vector + 15 * east).  
    local xxj IS body:geopositionOf(center - 15 * north:vector + 15 * east).
    local xxk IS body:geopositionOf(center - 15 * north:vector + 5 * east).
    local xxl IS body:geopositionOf(center - 15* north:vector - 05 * east).
    local xxm IS body:geopositionOf(center - 15 * north:vector - 15 * east).
    local xxn IS body:geopositionOf(center - 05 * north:vector - 15 * east).
    local xxo IS body:geopositionOf(center + 05 * north:vector - 15 * east).
    local xxp IS body:geopositionOf(center + 15 * north:vector + 15 * east).
     local best_scorea is 100.
    local best_scoreb is 100.
    local best_scorec is 100.
    local best_scored is 100.
    local best_scoree is 100.
    local best_scoref is 100.
    local best_scoreg is 100.
    local best_scoreh is 100.
    local best_scorei is 100.
    local best_scorej is 100.
    local best_scorek is 100.
    local best_scorel is 100.
    local best_scorem is 100.
    local best_scoren is 100.
    local best_scoreo is 100.
    local best_scorep is 100.

   

 if abs(sq1a) < abs(sq2a) and abs(sq1a) < abs(sq3a) and abs(sq1a) < abs(sq4a) and abs(sq1a) < abs(sq5a) and abs(sq1a) < abs(sq6a) and abs(sq1a) < abs(sq7a) and abs(sq1a) < abs(sq8a) and abs(sq1a) < abs(sq9a) and abs(sq1a) < abs(sq10a) and abs(sq1a) < abs(sq11a) and abs(sq1a) < abs(sq12a) and abs(sq1a) < abs(sq13a) and abs(sq1a) < abs(sq14a) and abs(sq1a) < abs(sq15a) and abs(sq1a) < abs(sq16a)                 { set best_scorea to abs( sq1a).}
 if abs(sq2a) < abs(sq1a) and abs(sq2a) < abs(sq3a) and abs(sq2a) < abs(sq4a) and abs(sq2a) < abs(sq5a) and abs(sq2a) < abs(sq6a) and abs(sq2a) < abs(sq7a) and abs(sq2a) < abs(sq8a) and abs(sq2a) < abs(sq9a) and abs(sq2a) < abs(sq10a) and abs(sq2a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq2a) < abs(sq13a) and abs(sq2a) < abs(sq14a) and abs(sq2a) < abs(sq15a) and abs(sq2a) < abs(sq16a)                 { set best_scoreb to abs( sq2a).} 
 if abs(sq3a) < abs(sq1a) and abs(sq3a) < abs(sq2a) and abs(sq3a) < abs(sq4a) and abs(sq3a) < abs(sq5a) and abs(sq3a) < abs(sq6a) and abs(sq3a) < abs(sq7a) and abs(sq3a) < abs(sq8a) and abs(sq3a) < abs(sq9a) and abs(sq3a) < abs(sq10a) and abs(sq3a) < abs(sq11a) and abs(sq3a) < abs(sq12a) and abs(sq3a) < abs(sq13a) and abs(sq3a) < abs(sq14a) and abs(sq3a) < abs(sq15a) and abs(sq3a) < abs(sq16a)                 { set best_scorec to abs( sq3a).}
 if abs(sq4a) < abs(sq1a) and abs(sq4a) < abs(sq2a) and abs(sq4a) < abs(sq3a) and abs(sq4a) < abs(sq5a) and abs(sq4a) < abs(sq6a) and abs(sq4a) < abs(sq7a) and abs(sq4a) < abs(sq8a) and abs(sq4a) < abs(sq9a) and abs(sq4a) < abs(sq10a) and abs(sq4a) < abs(sq11a) and abs(sq4a) < abs(sq12a) and abs(sq4a) < abs(sq13a) and abs(sq4a) < abs(sq14a) and abs(sq4a) < abs(sq15a) and abs(sq4a) < abs(sq16a)                 { set best_scored to abs( sq4a).} 
 if abs(sq5a) < abs(sq1a) and abs(sq5a) < abs(sq2a) and abs(sq5a) < abs(sq3a) and abs(sq5a) < abs(sq4a) and abs(sq5a) < abs(sq6a) and abs(sq5a) < abs(sq7a) and abs(sq5a) < abs(sq8a) and abs(sq5a) < abs(sq9a) and abs(sq5a) < abs(sq10a) and abs(sq5a) < abs(sq11a) and abs(sq5a) < abs(sq12a) and abs(sq5a) < abs(sq13a) and abs(sq5a) < abs(sq14a) and abs(sq5a) < abs(sq15a) and abs(sq5a) < abs(sq16a)                 { set best_scoree to abs( sq5a).}
 if abs(sq6a) < abs(sq1a) and abs(sq6a) < abs(sq3a) and abs(sq6a) < abs(sq4a) and abs(sq6a) < abs(sq5a) and abs(sq6a) < abs(sq2a) and abs(sq6a) < abs(sq7a) and abs(sq6a) < abs(sq8a) and abs(sq6a) < abs(sq9a) and abs(sq6a) < abs(sq10a) and abs(sq6a) < abs(sq11a) and abs(sq6a) < abs(sq12a) and abs(sq6a) < abs(sq13a) and abs(sq6a) < abs(sq14a) and abs(sq6a) < abs(sq15a) and abs(sq6a) < abs(sq16a)                 { set best_scoref to abs( sq6a).}
 if abs(sq7a) < abs(sq1a) and abs(sq7a) < abs(sq3a) and abs(sq7a) < abs(sq4a) and abs(sq7a) < abs(sq5a) and abs(sq7a) < abs(sq6a) and abs(sq7a) < abs(sq2a) and abs(sq7a) < abs(sq8a) and abs(sq7a) < abs(sq9a) and abs(sq7a) < abs(sq10a) and abs(sq7a) < abs(sq11a) and abs(sq7a) < abs(sq12a) and abs(sq7a) < abs(sq13a) and abs(sq7a) < abs(sq14a) and abs(sq7a) < abs(sq15a) and abs(sq7a) < abs(sq16a)                 { set best_scoreg to abs( sq7a).}
 if abs(sq8a) < abs(sq1a) and abs(sq8a) < abs(sq3a) and abs(sq8a) < abs(sq4a) and abs(sq8a) < abs(sq5a) and abs(sq8a) < abs(sq6a) and abs(sq8a) < abs(sq7a) and abs(sq8a) < abs(sq2a) and abs(sq8a) < abs(sq9a) and abs(sq8a) < abs(sq10a) and abs(sq8a) < abs(sq11a) and abs(sq8a) < abs(sq12a) and abs(sq8a) < abs(sq13a) and abs(sq8a) < abs(sq14a) and abs(sq8a) < abs(sq15a) and abs(sq8a) < abs(sq16a)                 { set best_scoreh to abs( sq8a).}
 if abs(sq9a) < abs(sq1a) and abs(sq9a) < abs(sq3a) and abs(sq9a) < abs(sq4a) and abs(sq9a) < abs(sq5a) and abs(sq9a) < abs(sq6a) and abs(sq9a) < abs(sq7a) and abs(sq9a) < abs(sq8a) and abs(sq9a) < abs(sq2a) and abs(sq9a) < abs(sq10a) and abs(sq9a) < abs(sq11a) and abs(sq9a) < abs(sq12a) and abs(sq9a) < abs(sq13a) and abs(sq9a) < abs(sq14a) and abs(sq9a) < abs(sq15a) and abs(sq9a) < abs(sq16a)                 { set best_scorei to abs( sq9a).}
 if abs(sq10a) < abs(sq1a) and abs(sq10a) < abs(sq3a) and abs(sq10a) < abs(sq4a) and abs(sq10a) < abs(sq5a) and abs(sq10a) < abs(sq6a) and abs(sq10a) < abs(sq7a) and abs(sq10a) < abs(sq8a) and abs(sq10a) < abs(sq9a) and abs(sq10a) < abs(sq2a) and abs(sq10a) < abs(sq11a) and abs(sq10a) < abs(sq12a) and abs(sq10a) < abs(sq13a) and abs(sq10a) < abs(sq14a) and abs(sq10a) < abs(sq15a) and abs(sq10a) < abs(sq16a)  { set best_scorej to abs(sq10a).}
 if abs(sq11a) < abs(sq1a) and abs(sq11a) < abs(sq3a) and abs(sq11a) < abs(sq4a) and abs(sq11a) < abs(sq5a) and abs(sq11a) < abs(sq6a) and abs(sq11a) < abs(sq7a) and abs(sq11a) < abs(sq8a) and abs(sq11a) < abs(sq9a) and abs(sq11a) < abs(sq10a) and abs(sq11a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq11a) < abs(sq13a) and abs(sq11a) < abs(sq14a) and abs(sq11a) < abs(sq15a) and abs(sq11a) < abs(sq16a)  { set best_scorek to abs(sq11a).}
 if abs(sq12a) < abs(sq1a) and abs(sq12a) < abs(sq3a) and abs(sq12a) < abs(sq4a) and abs(sq12a) < abs(sq5a) and abs(sq12a) < abs(sq6a) and abs(sq12a) < abs(sq7a) and abs(sq12a) < abs(sq8a) and abs(sq12a) < abs(sq9a) and abs(sq12a) < abs(sq10a) and abs(sq12a) < abs(sq11a) and abs(sq12a) < abs(sq2a) and abs(sq12a) < abs(sq13a) and abs(sq12a) < abs(sq14a) and abs(sq12a) < abs(sq15a) and abs(sq12a) < abs(sq16a)  { set best_scorel to abs(sq12a).}
 if abs(sq13a) < abs(sq1a) and abs(sq13a) < abs(sq3a) and abs(sq13a) < abs(sq4a) and abs(sq13a) < abs(sq5a) and abs(sq13a) < abs(sq6a) and abs(sq13a) < abs(sq7a) and abs(sq13a) < abs(sq8a) and abs(sq13a) < abs(sq9a) and abs(sq13a) < abs(sq10a) and abs(sq13a) < abs(sq11a) and abs(sq13a) < abs(sq12a) and abs(sq13a) < abs(sq2a) and abs(sq13a) < abs(sq14a) and abs(sq13a) < abs(sq15a) and abs(sq13a) < abs(sq16a)  { set best_scorem to abs(sq13a).}
 if abs(sq14a) < abs(sq1a) and abs(sq14a) < abs(sq3a) and abs(sq14a) < abs(sq4a) and abs(sq14a) < abs(sq5a) and abs(sq14a) < abs(sq6a) and abs(sq14a) < abs(sq7a) and abs(sq14a) < abs(sq8a) and abs(sq14a) < abs(sq9a) and abs(sq14a) < abs(sq10a) and abs(sq14a) < abs(sq11a) and abs(sq14a) < abs(sq12a) and abs(sq14a) < abs(sq13a) and abs(sq14a) < abs(sq2a) and abs(sq14a) < abs(sq15a) and abs(sq14a) < abs(sq16a)  { set best_scoren to abs(sq14a).}
 if abs(sq15a) < abs(sq1a) and abs(sq15a) < abs(sq2a) and abs(sq15a) < abs(sq3a) and abs(sq15a) < abs(sq4a) and abs(sq15a) < abs(sq5a) and abs(sq15a) < abs(sq6a) and abs(sq15a) < abs(sq7a) and abs(sq15a) < abs(sq8a) and abs(sq15a) < abs(sq9a)  and abs(sq15a) < abs(sq10a) and abs(sq15a) < abs(sq11a) and abs(sq15a) < abs(sq12a) and abs(sq15a) < abs(sq13a) and abs(sq15a) < abs(sq14a) and abs(sq15a) < abs(sq16a) { set best_scoreo to abs(sq15a).}
 if abs(sq16a) < abs(sq1a) and abs(sq16a) < abs(sq3a) and abs(sq16a) < abs(sq4a) and abs(sq16a) < abs(sq5a) and abs(sq16a) < abs(sq6a) and abs(sq16a) < abs(sq7a) and abs(sq16a) < abs(sq8a) and abs(sq16a) < abs(sq9a) and abs(sq16a) < abs(sq10a) and abs(sq16a) < abs(sq11a) and abs(sq16a) < abs(sq12a) and abs(sq16a) < abs(sq13a) and abs(sq16a) < abs(sq14a) and abs(sq16a) < abs(sq15a) and abs(sq16a) < abs(sq2a)  { set best_scorep to abs(sq16a).}


     if best_scorea < scoreToBeat {set gp to xxb. set best_score to best_scorea.}
     if best_scoreb < scoreToBeat {set gp to xxc. set best_score to best_scoreb.}
     if best_scorec < scoreToBeat {set gp to xxd. set best_score to best_scorec.}
     if best_scored < scoreToBeat {set gp to xxa. set best_score to best_scored.}
     if best_scoree < scoreToBeat {set gp to xxe. set best_score to best_scoree.}
     if best_scoref < scoreToBeat {set gp to xxf. set best_score to best_scoref.}
     if best_scoreg < scoreToBeat {set gp to xxg. set best_score to best_scoreg.}
     if best_scoreh < scoreToBeat {set gp to xxh. set best_score to best_scoreh.}
     if best_scorei < scoreToBeat {set gp to xxi. set best_score to best_scorei.}
     if best_scorej < scoreToBeat {set gp to xxj. set best_score to best_scorej.}
     if best_scorek < scoreToBeat {set gp to xxk. set best_score to best_scorek.}
     if best_scorel < scoreToBeat {set gp to xxl. set best_score to best_scorel.}
     if best_scorem < scoreToBeat {set gp to xxm. set best_score to best_scorem.}
     if best_scoren < scoreToBeat {set gp to xxn. set best_score to best_scoren.}
     if best_scoreo < scoreToBeat {set gp to xxo. set best_score to best_scoreo.}
     if best_scorep < scoreToBeat {set gp to xxp. set best_score to best_scorep.}
 
   

    print gp at (5,4).
    print best_score at (5,5).
    print "gsdF" at (5,6).
     print scoretobeat  at (5,7).
     print x_f at (5,7).
     print x_f1 at (5,8).
    //wait 2.
    
}

