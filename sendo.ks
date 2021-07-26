core:part:getmodule("kOSProcessor"):doevent("Open Terminal").

clearvecdraws().
clearscreen.

gs().
wait 5.
gd().

wait 5.
hell_cat().
wait 100.


lock steering to up.
local speedlimit is 45.
set rv to 0.
wait 1.
set talt to 110.
sas off.
start().
lock RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
set RV:mag to min(8,RV:mag). //just for safety

lock steering to lookdirup(up:vector * 8 + RV, facing:topvector).
 

clearscreen.
  LOCAL desiredFore IS 0.
  LOCAL desiredstar IS 0.
  LOCAL desiredtop  IS 0.
  rcs on.
  local original_length is ship:parts:length. 
  until ship:status = "Landed" {

  set PID:setpoint to math().
  if VB < 1 { SET tAlt to max(0,tAlt - 0.4).}
   set SHIP:CONTROL:fore TO desiredFore.
   set SHIP:CONTROL:top TO desiredtop. 
   set SHIP:CONTROL:starboard TO desiredstar. 
   set pid:setpoint to math().
   set TRTM to vxcl(up:vector,gp:POSITION).
   set TRTM to VECDRAWARGS( V(0,0,0),gp:position,green,"ship",1,true).
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
    print "talt:    " + talt + "      " at (5,4).
    print "VB:    " + round(VB(),4) + "      " at (5,5).
    print "fore D " + round(axis_distance[1],3) + "      " at (5,7).
    print "star D " + round(axis_distance[2],3) + "      " at (5,8).
    print "top  D " + round(axis_distance[3],3) + "      " at (5,9). 
    print "bb " + height + "      " at (5,10). 
    print "desiredFore:  " + round(desiredFore) + "      " at (5,11).
    print "desiredstar:  " + round(desiredstar) + "      " at (5,12).
    print "desiredtop:  " + round(desiredtop) + "      " at (5,13).
    print "dtg:    " +round(dtg(),2) + "      " at (5,23).
    if abort { abort off. set talt to (talt-2).}
    if brakes { brakes off. set talt to (talt+2).}
    IF ABS(desiredFore) > RCSdeadZone { SET desiredFore TO 0. }
    IF ABS(desiredstar) > RCSdeadZone { SET desiredFore TO 0. }
    }
 

function availtwr {
  return  MAX( 0.001, (MAXTHRUST*0.97) / (MASS*grav)).
}


function GS{ 
    global east is vectorCrossProduct(north:vector, up:vector).
    lock center to ship:position.
    global A IS body:geopositionOf(ship:position).
    global b IS body:geopositionOf(center + 000 * north:vector + 100 * east).
    global C IS body:geopositionOf(center + 100 * north:vector + 000 * east).
    global D IS body:geopositionOf(center + 100 * north:vector + 100 * east).
    global E IS body:geopositionOf(center - 000 * north:vector - 100 * east).
    global F IS body:geopositionOf(center - 100 * north:vector - 000 * east).
    global G IS body:geopositionOf(center - 100 * north:vector - 100 * east).
    global H IS body:geopositionOf(center + 100 * north:vector - 100 * east). 
    global I IS body:geopositionOf(center - 100 * north:vector + 100 * east).  

    global j IS body:geopositionOf(center - 200 * north:vector + 200 * east).
    global k IS body:geopositionOf(center - 100 * north:vector + 200 * east).
    global l IS body:geopositionOf(center - 000 * north:vector + 200 * east).
    global m IS body:geopositionOf(center + 100 * north:vector + 200 * east).
    global n IS body:geopositionOf(center + 200 * north:vector + 200 * east).

    global o IS body:geopositionOf(center + 200 * north:vector + 100 * east).
    global p IS body:geopositionOf(center + 200 * north:vector + 000 * east).
    global qq IS body:geopositionOf(center + 200 * north:vector - 100 * east). 
    global rr IS body:geopositionOf(center + 200 * north:vector - 200 * east).  

    global s is body:geopositionOf(center + 100 * north:vector - 200 * east).  
    global t IS body:geopositionOf(center + 000 * north:vector - 200 * east).
    global u IS body:geopositionOf(center - 100 * north:vector - 200 * east).
    global z IS body:geopositionOf(center - 200 * north:vector - 200 * east).

    global w IS body:geopositionOf(center - 200 * north:vector - 100 * east).
    global x IS body:geopositionOf(center - 200 * north:vector - 000 * east).
    global y IS body:geopositionOf(center - 200 * north:vector + 100 * east).

    global a_vec is a:altitudeposition(a:terrainheight).
    global b_vec is f:altitudeposition(f:terrainheight).
    global c_vec is c:altitudeposition(c:terrainheight).
    global D_vec is d:altitudeposition(d:terrainheight).
    global E_vec is e:altitudeposition(e:terrainheight).
    global F_vec is f:altitudeposition(F:terrainheight).
    global G_vec is g:altitudeposition(G:terrainheight).
    global H_vec is h:altitudeposition(H:terrainheight).
    global I_vec is i:altitudeposition(I:terrainheight).
    global j_vec is j:altitudeposition(j:terrainheight).
    global k_vec is k:altitudeposition(k:terrainheight).
    global l_vec is l:altitudeposition(l:terrainheight).
    global m_vec is m:altitudeposition(m:terrainheight).
    global n_vec is n:altitudeposition(m:terrainheight).
    global o_vec is o:altitudeposition(o:terrainheight).
    global p_vec is p:altitudeposition(p:terrainheight).
    global q_vec is qq:altitudeposition(qq:terrainheight).
    global r_vec is rr:altitudeposition(rr:terrainheight).
    global s_vec is s:altitudeposition(s:terrainheight).
    global t_vec is t:altitudeposition(t:terrainheight).
    global U_vec is u:altitudeposition(u:terrainheight).
    global v_vec is z:altitudeposition(z:terrainheight).
    global w_vec is w:altitudeposition(w:terrainheight).
    global x_vec is x:altitudeposition(x:terrainheight).
    global y_vec is y:altitudeposition(y:terrainheight).

    global sq1 is vcrs(c_vec - a_vec, b_vec - d_vec).
    global sq2 is vcrs(c_vec - a_vec, h_vec - e_vec).
    global sq3 is vcrs(a_vec - f_vec, e_vec - g_vec).
    global sq4 is vcrs(a_vec - f_vec, d_vec - b_vec).
    global sq5 is vcrs(b_vec - i_vec, l_vec - k_vec).
    global sq6 is vcrs(b_vec - d_vec, l_vec - m_vec).
    global sq7 is vcrs(d_vec - o_vec, m_vec - n_vec).
    global sq8 is vcrs(c_vec - p_vec, d_vec - o_vec).
    global sq9 is vcrs(h_vec - q_vec, c_vec - p_vec).
    global sq10 is vcrs(s_vec - r_vec, h_vec - q_vec).
    global sq11 is vcrs(t_vec - s_vec, e_vec - h_vec).
    global sq12 is vcrs(u_vec - t_vec, g_vec - e_vec).
    global sq13 is vcrs(v_vec - u_vec, w_vec - g_vec).
    global sq14 is vcrs(w_vec - g_vec, x_vec - f_vec).
    global sq15 is vcrs(x_vec - f_vec, i_vec - y_vec).
    global sq16 is vcrs(i_vec - y_vec, j_vec - k_vec).
    global upVec IS up:vector.

    global sq1a is 90 - vang(upVec,sq1).
    global sq2a is 90 - vang(upVec,sq2).
    global sq3a is 90 - vang(upVec,sq3).
    global sq4a is 90 - vang(upVec,sq4).
    global sq5a is 90 - vang(upVec,sq5).
    global sq6a is 90 - vang(upVec,sq6).
    global sq7a is 90 - vang(upVec,sq7).
    global sq8a is 90 - vang(upVec,sq8).
    global sq9a is 90 - vang(upVec,sq9).
    global sq10a is 90 - vang(upVec,sq10).
    global sq11a is 90 - vang(upVec,sq11).
    global sq12a is 90 - vang(upVec,sq12).
    global sq13a is 90 - vang(upVec,sq13).
    global sq14a is 90 - vang(upVec,sq14).
    global sq15a is 90 - vang(upVec,sq15).
    global sq16a is 90 - vang(upVec,sq16).
   SET ab TO VECDRAWARGS(  sq2,  upVec,  blue, " B", 1, true).   
   SET aa TO VECDRAWARGS(  sq1,  upVec,  red, "A", 1, true). 
  SET acd TO VECDRAWARGS(  sq3,  upVec,  green, " C", 1, true).
   SET ad TO VECDRAWARGS(  sq4,  upVec,  red, "sq4", 1, true).  
   SET ae to VECDRAWARGS(  sq5,  upVec,  blue, " e", 1, true). 
   SET af TO VECDRAWARGS(  sq6,  upVec,  green, " f", 1, true).   
   SET ag TO VECDRAWARGS(  sq7,  upVec,  red, " g", 1, true).  
   SET ah TO VECDRAWARGS(  sq8,  upVec,  blue, " h", 1, true).  
   SET ai TO VECDRAWARGS(  sq9,  upVec,  green, " i", 1, true). 
   SET aj TO VECDRAWARGS(  sq10, upVec,  blue, " j", 1, true).   
   SET ak TO VECDRAWARGS(  sq11, upVec,  green, " k", 1, true). 
   SET al TO VECDRAWARGS(  sq12, upVec,  red, " l", 1, true).  
   SET am TO VECDRAWARGS(  sq13, upVec,  red, " m", 1, true). 
   SET an TO VECDRAWARGS(  sq14, upVec,  green, " n", 1, true).
   SET ao TO VECDRAWARGS(  sq15, upVec,  red, " o", 1, true).  
   SET ap TO VECDRAWARGS(  sq16, upVec,  red, " p", 1, true). 
  
   //SET aa TO VECDRAWARGS(  a:ALTITUDEPOSITION(a:TERRAINHEIGHT+100),  a:POSITION - a:ALTITUDEPOSITION(a:TERRAINHEIGHT+100),  red, "A", 1, true). 
  // SET ab TO VECDRAWARGS(  b:ALTITUDEPOSITION(b:TERRAINHEIGHT+100),  b:POSITION - b:ALTITUDEPOSITION(b:TERRAINHEIGHT+100),  blue, " B", 1, true).   
   //SET acd TO VECDRAWARGS(  c:ALTITUDEPOSITION(c:TERRAINHEIGHT+100),  c:POSITION - c:ALTITUDEPOSITION(c:TERRAINHEIGHT+100),  green, " C", 1, true).
   //SET ad TO VECDRAWARGS(  d:ALTITUDEPOSITION(d:TERRAINHEIGHT+100),  d:POSITION - d:ALTITUDEPOSITION(d:TERRAINHEIGHT+100),  red, " d", 1, true).  
  // SET ae to VECDRAWARGS(  e:ALTITUDEPOSITION(e:TERRAINHEIGHT+100),  e:POSITION - e:ALTITUDEPOSITION(e:TERRAINHEIGHT+100),  blue, " e", 1, true). 
  // SET af TO VECDRAWARGS(  f:ALTITUDEPOSITION(f:TERRAINHEIGHT+100),  f:POSITION - f:ALTITUDEPOSITION(f:TERRAINHEIGHT+100),  green, " f", 1, true).   
  // SET ag TO VECDRAWARGS(  g:ALTITUDEPOSITION(g:TERRAINHEIGHT+100),  g:POSITION - g:ALTITUDEPOSITION(g:TERRAINHEIGHT+100),  red, " g", 1, true).  
  // SET ah TO VECDRAWARGS(  h:ALTITUDEPOSITION(h:TERRAINHEIGHT+100),  h:POSITION - h:ALTITUDEPOSITION(d:TERRAINHEIGHT+100),  blue, " h", 1, true).  
  // SET ai TO VECDRAWARGS(  I:ALTITUDEPOSITION(I:TERRAINHEIGHT+100),  I:POSITION - I:ALTITUDEPOSITION(I:TERRAINHEIGHT+100),  green, " i", 1, true). 
  // SET aj TO VECDRAWARGS(  J:ALTITUDEPOSITION(J:TERRAINHEIGHT+100),  J:POSITION - J:ALTITUDEPOSITION(J:TERRAINHEIGHT+100),  blue, " j", 1, true).   
  // SET ak TO VECDRAWARGS(  k:ALTITUDEPOSITION(k:TERRAINHEIGHT+100),  k:POSITION - k:ALTITUDEPOSITION(k:TERRAINHEIGHT+100),  green, " k", 1, true). 
  // SET al TO VECDRAWARGS(  l:ALTITUDEPOSITION(l:TERRAINHEIGHT+100),  l:POSITION - l:ALTITUDEPOSITION(l:TERRAINHEIGHT+100),  red, " l", 1, true).  
  // SET am TO VECDRAWARGS(  m:ALTITUDEPOSITION(m:TERRAINHEIGHT+100),  m:POSITION - m:ALTITUDEPOSITION(m:TERRAINHEIGHT+100),  red, " m", 1, true). 
  // SET an TO VECDRAWARGS(  n:ALTITUDEPOSITION(n:TERRAINHEIGHT+100),  n:POSITION - n:ALTITUDEPOSITION(n:TERRAINHEIGHT+100),  green, " n", 1, true).
  // SET ao TO VECDRAWARGS(  o:ALTITUDEPOSITION(o:TERRAINHEIGHT+100),  o:POSITION - o:ALTITUDEPOSITION(l:TERRAINHEIGHT+100),  red, " o", 1, true).  
   //SET ap TO VECDRAWARGS(  p:ALTITUDEPOSITION(p:TERRAINHEIGHT+100),  p:POSITION - p:ALTITUDEPOSITION(p:TERRAINHEIGHT+100),  red, " p", 1, true). 
   //SET aq TO VECDRAWARGS(  qq:ALTITUDEPOSITION(qq:TERRAINHEIGHT+100),  qq:POSITION - qq:ALTITUDEPOSITION(qq:TERRAINHEIGHT+100),  blue, " q", 1, true).   
  // SET ar TO VECDRAWARGS(  rr:ALTITUDEPOSITION(rr:TERRAINHEIGHT+100),  rr:POSITION - rr:ALTITUDEPOSITION(rr:TERRAINHEIGHT+100),  green, " r", 1, true).
 //  SET as TO VECDRAWARGS(  s:ALTITUDEPOSITION(s:TERRAINHEIGHT+100),  s:POSITION - s:ALTITUDEPOSITION(s:TERRAINHEIGHT+100),  red, " s", 1, true).  
  // SET att TO VECDRAWARGS(  t:ALTITUDEPOSITION(t:TERRAINHEIGHT+100),  t:POSITION - t:ALTITUDEPOSITION(t:TERRAINHEIGHT+100),  red, " t", 1, true). 
  // SET au TO VECDRAWARGS(  u:ALTITUDEPOSITION(u:TERRAINHEIGHT+100),  u:POSITION - u:ALTITUDEPOSITION(u:TERRAINHEIGHT+100),  green, " u", 1, true).  
 //  SET av TO VECDRAWARGS(  z:ALTITUDEPOSITION(z:TERRAINHEIGHT+100),  z:POSITION - z:ALTITUDEPOSITION(s:TERRAINHEIGHT+100),  red, " v", 1, true). 
  // SET aw TO VECDRAWARGS(  w:ALTITUDEPOSITION(w:TERRAINHEIGHT+100),  w:POSITION - w:ALTITUDEPOSITION(w:TERRAINHEIGHT+100),  red, " w", 1, true). 
  // SET ax TO VECDRAWARGS(  x:ALTITUDEPOSITION(x:TERRAINHEIGHT+100),  x:POSITION - x:ALTITUDEPOSITION(x:TERRAINHEIGHT+100),  blue, " x", 1, true).   
  // SET Vzc TO VECDRAWARGS(  y:ALTITUDEPOSITION(y:TERRAINHEIGHT+100),  y:POSITION - y:ALTITUDEPOSITION(y:TERRAINHEIGHT+100),  green, " y", 1, true).  
  
}
function Gd{ 
  local east is vectorCrossProduct(north:vector, up:vector).
  lock center to ship:position.
    global xxb IS body:geopositionOf(center + 050 * north:vector + 050 * east).
    global xxC IS body:geopositionOf(center - 050 * north:vector + 050 * east).
    global xxD IS body:geopositionOf(center - 050 * north:vector - 050 * east).
    global xxa is body:geopositionOf(center + 050 * north:vector - 050 * east).
    global xxE IS body:geopositionOf(center + 150 * north:vector - 050 * east).
    global xxF IS body:geopositionOf(center + 150 * north:vector + 050 * east).
    global xxG IS body:geopositionOf(center + 150 * north:vector + 150 * east).
    global xxH IS body:geopositionOf(center + 050 * north:vector + 150 * east). 
    global xxI IS body:geopositionOf(center - 050 * north:vector + 150 * east).  
    global xxj IS body:geopositionOf(center - 150 * north:vector + 150 * east).
    global xxk IS body:geopositionOf(center - 150 * north:vector + 050 * east).
    global xxl IS body:geopositionOf(center - 150 * north:vector - 050 * east).
    global xxm IS body:geopositionOf(center - 150 * north:vector - 150 * east).
    global xxn IS body:geopositionOf(center - 050 * north:vector - 150 * east).
    global xxo IS body:geopositionOf(center + 050 * north:vector - 150 * east).
    global xxp IS body:geopositionOf(center + 150 * north:vector + 150 * east).
    set mylist to LIST().
  set ccmp to list(sq1a,sq2a,sq3a,sq4a,sq5a,sq6a,sq7a,sq8a,sq9a,sq10a,sq11a,sq12a,sq13a,sq14a,sq15a,sq16a). 
  mylist:ADD(ccmp).   // Element 1 is now itself a list.
 print mylist.
 wait 7.
  set ccmp to list(xxb,xxc,xxd,xxa,xxE,xxf,xxg,xxh,xxi,xxj,xxk,xxl,xxm,xxn,xxo,xxp).
 mylist:ADD(ccmp).
 clearscreen.
 print mylist. wait 7.
}// Helper functions

function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * GRAV - velocity:surface).
}

global display_data is lex(
  "step", "waiting"
).
function display {
  parameter update is lex().
  for key in update:keys set display_data[key] to update[key].
  global i is 0.
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
function hell_cat{
global best_score is 1.
 if abs(sq1a) < abs(sq2a) and abs(sq1a) < abs(sq3a) and abs(sq1a) < abs(sq4a) and abs(sq1a) < abs(sq5a) and abs(sq1a) < abs(sq6a) and abs(sq1a) < abs(sq7a) and abs(sq1a) < abs(sq8a) and abs(sq1a) < abs(sq9a) and abs(sq1a) < abs(sq10a) and abs(sq1a) < abs(sq11a) and abs(sq1a) < abs(sq12a) and abs(sq1a) < abs(sq13a) and abs(sq1a) < abs(sq14a) and abs(sq1a) < abs(sq15a) and abs(sq1a) < abs(sq16a)                {set gp to xxb. set sq1a to best_score.}
 if abs(sq2a) < abs(sq1a) and abs(sq2a) < abs(sq3a) and abs(sq2a) < abs(sq4a) and abs(sq2a) < abs(sq5a) and abs(sq2a) < abs(sq6a) and abs(sq2a) < abs(sq7a) and abs(sq2a) < abs(sq8a) and abs(sq2a) < abs(sq9a) and abs(sq2a) < abs(sq10a) and abs(sq2a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq2a) < abs(sq13a) and abs(sq2a) < abs(sq14a) and abs(sq2a) < abs(sq15a) and abs(sq2a) < abs(sq16a)                {set gp to xxc. set sq2a to best_score.} 
 if abs(sq3a) < abs(sq1a) and abs(sq3a) < abs(sq2a) and abs(sq3a) < abs(sq4a) and abs(sq3a) < abs(sq5a) and abs(sq3a) < abs(sq6a) and abs(sq3a) < abs(sq7a) and abs(sq3a) < abs(sq8a) and abs(sq3a) < abs(sq9a) and abs(sq3a) < abs(sq10a) and abs(sq3a) < abs(sq11a) and abs(sq3a) < abs(sq12a) and abs(sq3a) < abs(sq13a) and abs(sq3a) < abs(sq14a) and abs(sq3a) < abs(sq15a) and abs(sq3a) < abs(sq16a)                {set gp to xxd. set sq3a to best_score.}
 if abs(sq4a) < abs(sq1a) and abs(sq4a) < abs(sq2a) and abs(sq4a) < abs(sq3a) and abs(sq4a) < abs(sq5a) and abs(sq4a) < abs(sq6a) and abs(sq4a) < abs(sq7a) and abs(sq4a) < abs(sq8a) and abs(sq4a) < abs(sq9a) and abs(sq4a) < abs(sq10a) and abs(sq4a) < abs(sq11a) and abs(sq4a) < abs(sq12a) and abs(sq4a) < abs(sq13a) and abs(sq4a) < abs(sq14a) and abs(sq4a) < abs(sq15a) and abs(sq4a) < abs(sq16a)                {set gp to xxa. set sq4a to best_score.} 
 if abs(sq5a) < abs(sq1a) and abs(sq5a) < abs(sq2a) and abs(sq5a) < abs(sq3a) and abs(sq5a) < abs(sq4a) and abs(sq5a) < abs(sq6a) and abs(sq5a) < abs(sq7a) and abs(sq5a) < abs(sq8a) and abs(sq5a) < abs(sq9a) and abs(sq5a) < abs(sq10a) and abs(sq5a) < abs(sq11a) and abs(sq5a) < abs(sq12a) and abs(sq5a) < abs(sq13a) and abs(sq5a) < abs(sq14a) and abs(sq5a) < abs(sq15a) and abs(sq5a) < abs(sq16a)                {set gp to xxe. set sq5a to best_score.}
 if abs(sq6a) < abs(sq1a) and abs(sq6a) < abs(sq3a) and abs(sq6a) < abs(sq4a) and abs(sq6a) < abs(sq5a) and abs(sq6a) < abs(sq2a) and abs(sq6a) < abs(sq7a) and abs(sq6a) < abs(sq8a) and abs(sq6a) < abs(sq9a) and abs(sq6a) < abs(sq10a) and abs(sq6a) < abs(sq11a) and abs(sq6a) < abs(sq12a) and abs(sq6a) < abs(sq13a) and abs(sq6a) < abs(sq14a) and abs(sq6a) < abs(sq15a) and abs(sq6a) < abs(sq16a)                {set gp to xxf. set sq6a to best_score.}
 if abs(sq7a) < abs(sq1a) and abs(sq7a) < abs(sq3a) and abs(sq7a) < abs(sq4a) and abs(sq7a) < abs(sq5a) and abs(sq7a) < abs(sq6a) and abs(sq7a) < abs(sq2a) and abs(sq7a) < abs(sq8a) and abs(sq7a) < abs(sq9a) and abs(sq7a) < abs(sq10a) and abs(sq7a) < abs(sq11a) and abs(sq7a) < abs(sq12a) and abs(sq7a) < abs(sq13a) and abs(sq7a) < abs(sq14a) and abs(sq7a) < abs(sq15a) and abs(sq7a) < abs(sq16a)                {set gp to xxg. set sq7a to best_score.}
 if abs(sq8a) < abs(sq1a) and abs(sq8a) < abs(sq3a) and abs(sq8a) < abs(sq4a) and abs(sq8a) < abs(sq5a) and abs(sq8a) < abs(sq6a) and abs(sq8a) < abs(sq7a) and abs(sq8a) < abs(sq2a) and abs(sq8a) < abs(sq9a) and abs(sq8a) < abs(sq10a) and abs(sq8a) < abs(sq11a) and abs(sq8a) < abs(sq12a) and abs(sq8a) < abs(sq13a) and abs(sq8a) < abs(sq14a) and abs(sq8a) < abs(sq15a) and abs(sq8a) < abs(sq16a)                {set gp to xxh. set sq8a to best_score.}
 if abs(sq9a) < abs(sq1a) and abs(sq9a) < abs(sq3a) and abs(sq9a) < abs(sq4a) and abs(sq9a) < abs(sq5a) and abs(sq9a) < abs(sq6a) and abs(sq9a) < abs(sq7a) and abs(sq9a) < abs(sq8a) and abs(sq9a) < abs(sq2a) and abs(sq9a) < abs(sq10a) and abs(sq9a) < abs(sq11a) and abs(sq9a) < abs(sq12a) and abs(sq9a) < abs(sq13a) and abs(sq9a) < abs(sq14a) and abs(sq9a) < abs(sq15a) and abs(sq9a) < abs(sq16a)                {set gp to xxi. set sq9a to best_score.}
 if abs(sq10a) < abs(sq1a) and abs(sq10a) < abs(sq3a) and abs(sq10a) < abs(sq4a) and abs(sq10a) < abs(sq5a) and abs(sq10a) < abs(sq6a) and abs(sq10a) < abs(sq7a) and abs(sq10a) < abs(sq8a) and abs(sq10a) < abs(sq9a) and abs(sq10a) < abs(sq2a) and abs(sq10a) < abs(sq11a) and abs(sq10a) < abs(sq12a) and abs(sq10a) < abs(sq13a) and abs(sq10a) < abs(sq14a) and abs(sq10a) < abs(sq15a) and abs(sq10a) < abs(sq16a)  {set gp to xxj. set sq10a to best_score.}
 if abs(sq11a) < abs(sq1a) and abs(sq11a) < abs(sq3a) and abs(sq11a) < abs(sq4a) and abs(sq11a) < abs(sq5a) and abs(sq11a) < abs(sq6a) and abs(sq11a) < abs(sq7a) and abs(sq11a) < abs(sq8a) and abs(sq11a) < abs(sq9a) and abs(sq11a) < abs(sq10a) and abs(sq11a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq11a) < abs(sq13a) and abs(sq11a) < abs(sq14a) and abs(sq11a) < abs(sq15a) and abs(sq11a) < abs(sq16a)  {set gp to xxk. set sq11a to best_score.}
 if abs(sq12a) < abs(sq1a) and abs(sq12a) < abs(sq3a) and abs(sq12a) < abs(sq4a) and abs(sq12a) < abs(sq5a) and abs(sq12a) < abs(sq6a) and abs(sq12a) < abs(sq7a) and abs(sq12a) < abs(sq8a) and abs(sq12a) < abs(sq9a) and abs(sq12a) < abs(sq10a) and abs(sq12a) < abs(sq11a) and abs(sq12a) < abs(sq2a) and abs(sq12a) < abs(sq13a) and abs(sq12a) < abs(sq14a) and abs(sq12a) < abs(sq15a) and abs(sq12a) < abs(sq16a)  {set gp to xxl. set sq12a to best_score.}
 if abs(sq13a) < abs(sq1a) and abs(sq13a) < abs(sq3a) and abs(sq13a) < abs(sq4a) and abs(sq13a) < abs(sq5a) and abs(sq13a) < abs(sq6a) and abs(sq13a) < abs(sq7a) and abs(sq13a) < abs(sq8a) and abs(sq13a) < abs(sq9a) and abs(sq13a) < abs(sq10a) and abs(sq13a) < abs(sq11a) and abs(sq13a) < abs(sq12a) and abs(sq13a) < abs(sq2a) and abs(sq13a) < abs(sq14a) and abs(sq13a) < abs(sq15a) and abs(sq13a) < abs(sq16a)  {set gp to xxm. set sq13a to best_score.}
 if abs(sq14a) < abs(sq1a) and abs(sq14a) < abs(sq3a) and abs(sq14a) < abs(sq4a) and abs(sq14a) < abs(sq5a) and abs(sq14a) < abs(sq6a) and abs(sq14a) < abs(sq7a) and abs(sq14a) < abs(sq8a) and abs(sq14a) < abs(sq9a) and abs(sq14a) < abs(sq10a) and abs(sq14a) < abs(sq11a) and abs(sq14a) < abs(sq12a) and abs(sq14a) < abs(sq13a) and abs(sq14a) < abs(sq2a) and abs(sq14a) < abs(sq15a) and abs(sq14a) < abs(sq16a)  {set gp to xxn. set sq14a to best_score.}
 if abs(sq15a) < abs(sq1a) and abs(sq15a) < abs(sq2a) and abs(sq15a) < abs(sq3a) and abs(sq15a) < abs(sq4a) and abs(sq15a) < abs(sq5a) and abs(sq15a) < abs(sq6a) and abs(sq15a) < abs(sq7a) and abs(sq15a) < abs(sq8a) and abs(sq15a) < abs(sq9a)  and abs(sq15a) < abs(sq10a) and abs(sq15a) < abs(sq11a) and abs(sq15a) < abs(sq12a) and abs(sq15a) < abs(sq13a) and abs(sq15a) < abs(sq14a) and abs(sq15a) < abs(sq16a) {set gp to xxo. set sq15a to best_score.}
 if abs(sq16a) < abs(sq1a) and abs(sq16a) < abs(sq3a) and abs(sq16a) < abs(sq4a) and abs(sq16a) < abs(sq5a) and abs(sq16a) < abs(sq6a) and abs(sq16a) < abs(sq7a) and abs(sq16a) < abs(sq8a) and abs(sq16a) < abs(sq9a) and abs(sq16a) < abs(sq10a) and abs(sq16a) < abs(sq11a) and abs(sq16a) < abs(sq12a) and abs(sq16a) < abs(sq13a) and abs(sq16a) < abs(sq14a) and abs(sq16a) < abs(sq15a) and abs(sq16a) < abs(sq2a)  {set gp to xxp. set sq16a to best_score.}

print gp.}


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
  LOCAL desiredFore IS 0.
  LOCAL desiredstar IS 0.
  LOCAL desiredtop  IS 0.
  LOCAL shipFacing IS ship:facing.
  global axisSpeed IS axis_speed().
  global RCSdeadZone IS 0.05.
  global PIDtop is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDfore is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDstar is pidloop(4, 0.1, 0.1, -10, 10).
  //local pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
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

