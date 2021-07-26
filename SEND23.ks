core:part:getmodule("kOSProcessor"):doevent("Open Terminal").

clearvecdraws().
clearscreen.

gs().
gd().

wait 20.
lock steering to up.
rcs on.
lock throttle to 0.5.
wait until dtg() > 45.
lock GRAV to body:mu / body:position:sqrmagnitude.
set last_time to time:seconds. 
lock maxtwr to ship:maxthrust / (GRAV * ship:mass).  
SET TALT TO 45.
set runmode to 1.
//global pid is pidloop(1.81818181818182, 2.49928371956297, 0.0954323966262449, 0, maxtwr).
global pid is pidloop(1.81818181818182, 0.456998571460453, 0.521911117675102, 0, maxtwr).
set gp to body:geopositionOf(ship:position).
clearscreen.
until runmode = 0 {
if runmode =1 { 
  
   SET aa TO VECDRAWARGS(  a:ALTITUDEPOSITION(a:TERRAINHEIGHT+100),  a:POSITION - a:ALTITUDEPOSITION(a:TERRAINHEIGHT+100),  red, "A", 1, true). 
   SET ab TO VECDRAWARGS(  b:ALTITUDEPOSITION(b:TERRAINHEIGHT+100),  b:POSITION - b:ALTITUDEPOSITION(b:TERRAINHEIGHT+100),  blue, " B", 1, true).   
   SET ac TO VECDRAWARGS(  c:ALTITUDEPOSITION(c:TERRAINHEIGHT+100),  c:POSITION - c:ALTITUDEPOSITION(c:TERRAINHEIGHT+100),  green, " C", 1, true).
   SET ad TO VECDRAWARGS(  d:ALTITUDEPOSITION(d:TERRAINHEIGHT+100),  d:POSITION - d:ALTITUDEPOSITION(d:TERRAINHEIGHT+100),  red, " d", 1, true).  
   SET ae to VECDRAWARGS(  e:ALTITUDEPOSITION(e:TERRAINHEIGHT+100),  e:POSITION - e:ALTITUDEPOSITION(e:TERRAINHEIGHT+100),  blue, " e", 1, true). 
   SET af TO VECDRAWARGS(  f:ALTITUDEPOSITION(f:TERRAINHEIGHT+100),  f:POSITION - f:ALTITUDEPOSITION(f:TERRAINHEIGHT+100),   green, " f", 1, true).   
   SET ag TO VECDRAWARGS(  g:ALTITUDEPOSITION(g:TERRAINHEIGHT+100),  g:POSITION - g:ALTITUDEPOSITION(g:TERRAINHEIGHT+100),  red, " g", 1, true).  
   SET ah TO VECDRAWARGS(  h:ALTITUDEPOSITION(h:TERRAINHEIGHT+100),  h:POSITION - h:ALTITUDEPOSITION(d:TERRAINHEIGHT+100),  blue, " h", 1, true).  
   SET ai TO VECDRAWARGS(  I:ALTITUDEPOSITION(I:TERRAINHEIGHT+100),  I:POSITION - I:ALTITUDEPOSITION(I:TERRAINHEIGHT+100),  green, " i", 1, true). 
   SET aj TO VECDRAWARGS(  J:ALTITUDEPOSITION(J:TERRAINHEIGHT+100),  J:POSITION - J:ALTITUDEPOSITION(J:TERRAINHEIGHT+100),  blue, " j", 1, true).   
   SET ak TO VECDRAWARGS(  k:ALTITUDEPOSITION(k:TERRAINHEIGHT+100),  k:POSITION - k:ALTITUDEPOSITION(k:TERRAINHEIGHT+100),  green, " k", 1, true). 
   SET al TO VECDRAWARGS(  l:ALTITUDEPOSITION(l:TERRAINHEIGHT+100),  l:POSITION - l:ALTITUDEPOSITION(l:TERRAINHEIGHT+100),  red, " l", 1, true).  
   SET am TO VECDRAWARGS(  m:ALTITUDEPOSITION(m:TERRAINHEIGHT+100),  m:POSITION - m:ALTITUDEPOSITION(m:TERRAINHEIGHT+100),  red, " m", 1, true). 
   SET an TO VECDRAWARGS(  n:ALTITUDEPOSITION(n:TERRAINHEIGHT+100),  n:POSITION - n:ALTITUDEPOSITION(n:TERRAINHEIGHT+100),  green, " n", 1, true).
   SET ao TO VECDRAWARGS(  o:ALTITUDEPOSITION(o:TERRAINHEIGHT+100),  o:POSITION - o:ALTITUDEPOSITION(l:TERRAINHEIGHT+100),  red, " o", 1, true).  
   SET ap TO VECDRAWARGS(  p:ALTITUDEPOSITION(p:TERRAINHEIGHT+100),  p:POSITION - p:ALTITUDEPOSITION(p:TERRAINHEIGHT+100),  red, " p", 1, true). 
   SET aq TO VECDRAWARGS(  qq:ALTITUDEPOSITION(qq:TERRAINHEIGHT+100),  qq:POSITION - qq:ALTITUDEPOSITION(qq:TERRAINHEIGHT+100),  blue, " q", 1, true).   
   SET ar TO VECDRAWARGS(  rr:ALTITUDEPOSITION(rr:TERRAINHEIGHT+100),  rr:POSITION - rr:ALTITUDEPOSITION(rr:TERRAINHEIGHT+100),  green, " r", 1, true).
   SET as TO VECDRAWARGS(  s:ALTITUDEPOSITION(s:TERRAINHEIGHT+100),  s:POSITION - s:ALTITUDEPOSITION(s:TERRAINHEIGHT+100),  red, " s", 1, true).  
   SET att TO VECDRAWARGS(  t:ALTITUDEPOSITION(t:TERRAINHEIGHT+100),  t:POSITION - t:ALTITUDEPOSITION(t:TERRAINHEIGHT+100),  red, " t", 1, true). 
   SET au TO VECDRAWARGS(  u:ALTITUDEPOSITION(u:TERRAINHEIGHT+100),  u:POSITION - u:ALTITUDEPOSITION(u:TERRAINHEIGHT+100),  green, " u", 1, true).  
   SET av TO VECDRAWARGS(  z:ALTITUDEPOSITION(z:TERRAINHEIGHT+100),  z:POSITION - z:ALTITUDEPOSITION(s:TERRAINHEIGHT+100),  red, " v", 1, true). 
   SET aw TO VECDRAWARGS(  w:ALTITUDEPOSITION(w:TERRAINHEIGHT+100),  w:POSITION - w:ALTITUDEPOSITION(w:TERRAINHEIGHT+100),  red, " w", 1, true). 
   SET ax TO VECDRAWARGS(  x:ALTITUDEPOSITION(x:TERRAINHEIGHT+100),  x:POSITION - x:ALTITUDEPOSITION(x:TERRAINHEIGHT+100),  blue, " x", 1, true).   
   SET Vzc TO VECDRAWARGS(  y:ALTITUDEPOSITION(y:TERRAINHEIGHT+100),  y:POSITION - y:ALTITUDEPOSITION(y:TERRAINHEIGHT+100),  green, " y", 1, true).  
   







  set target_twr to maxtwr.
  until ship:status = "Landed" {
  set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) /8. //relative velocity vector, we base our steering on this
  set RV:mag to min(8,RV:mag). //just for safety
  
  set pid:setpoint to 0.
  set pid:maxoutput to maxtwr.
  lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  lock throttle to min(target_twr / maxtwr, 1).
      print "box 1 " + xxb + "      " at (5,4).
    print "box 2 " + xxc    + "      " at (5,5).
    print "box 3 " + xxd    + "      " at (5,6). 
    print "box 4 " +   xxa    + "      " at (5,19). 
    print "box 5 " + xxe   + "      " at (5,7).
    print "box 6 " + xxf  + "      " at (5,8).
    print "box 7 " + xxg + "      " at (5,9). 
    print "box 8 " + xxh  + "      " at (5,10).
    print "box 9 " + xxi  + "      " at (5,11).
    print "box 10 " + xxj + "      " at (5,12). 
    print "box 11 " + xxk     + "      " at (5,13).
    print "box 12 " +  xxl     + "      " at (5,14).
    print "box 13 " +  xxm     + "      " at (5,15). 
    print "box 14 " +   xxn    + "      " at (5,16). 
    print "box 15 " +   xxo    + "      " at (5,17).
    print "box 16 " +   xxp    + "      " at (5,18).
}
}}

function availtwr {
  return  MAX( 0.001, (MAXTHRUST*0.97) / (MASS*grav)).
}


function GS{ 
global east is vectorCrossProduct(north:vector, up:vector).
lock center to ship:position.
global A IS body:geopositionOf(ship:position).
global b IS body:geopositionOf(center + 00 * north:vector + 10 * east).
global C IS body:geopositionOf(center + 10 * north:vector + 00 * east).
global D IS body:geopositionOf(center + 10 * north:vector + 10 * east).
global E IS body:geopositionOf(center - 00 * north:vector - 10 * east).
global F IS body:geopositionOf(center - 10 * north:vector - 00 * east).
global G IS body:geopositionOf(center - 10 * north:vector - 10 * east).
global H IS body:geopositionOf(center + 10 * north:vector - 10 * east). 
global I IS body:geopositionOf(center - 10 * north:vector + 10 * east).  

global j IS body:geopositionOf(center - 20 * north:vector + 20 * east).
global k IS body:geopositionOf(center - 10 * north:vector + 20 * east).
global l IS body:geopositionOf(center - 00 * north:vector + 20 * east).
global m IS body:geopositionOf(center + 10 * north:vector + 20 * east).
global n IS body:geopositionOf(center + 20 * north:vector + 20 * east).

global o IS body:geopositionOf(center + 20 * north:vector + 10 * east).
global p IS body:geopositionOf(center + 20 * north:vector + 00 * east).
global qq IS body:geopositionOf(center + 20 * north:vector - 10 * east). 
global rr IS body:geopositionOf(center + 20 * north:vector - 20 * east).  

global s is body:geopositionOf(center + 10 * north:vector - 20 * east).  
global t IS body:geopositionOf(center + 00 * north:vector - 20 * east).
global u IS body:geopositionOf(center - 10 * north:vector - 20 * east).
global z IS body:geopositionOf(center - 20 * north:vector - 20 * east).

global w IS body:geopositionOf(center - 20 * north:vector - 10 * east).
global x IS body:geopositionOf(center - 20 * north:vector - 00 * east).
global y IS body:geopositionOf(center - 20 * north:vector + 10 * east).













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

global sq1a is 90 - vang(upVec,sq1).  if abs(sq1a) > abs(sq2a) and abs(sq1a) > abs(sq3a) and abs(sq1a) > abs(sq4a) and abs(sq1a) > abs(sq5a) and abs(sq1a) > abs(sq6a) and abs(sq1a) > abs(sq7a) and abs(sq1a) > abs(sq8a) and abs(sq1a) > abs(sq9a) and abs(sq1a) > abs(sq10a) and abs(sq1a) > abs(sq11a) and abs(sq1a) > abs(sq12a) and abs(sq1a) > abs(sq13a) and abs(sq1a) > abs(sq14a) and abs(sq1a) > abs(sq16a){set gp to xxb.}
global sq2a is 90 - vang(upVec,sq2).  if abs(sq2a) > abs(sq1a) and abs(sq2a) > abs(sq3a) and abs(sq2a) > abs(sq4a) and abs(sq2a) > abs(sq5a) and abs(sq2a) > abs(sq6a) and abs(sq2a) > abs(sq7a) and abs(sq2a) > abs(sq8a) and abs(sq2a) > abs(sq9a) and abs(sq2a) > abs(sq10a) and abs(sq2a) > abs(sq11a) and abs(sq2a) > abs(sq12a) and abs(sq2a) > abs(sq13a) and abs(sq2a) > abs(sq14a) and abs(sq2a) > abs(sq16a){set gp to xxc.}
global sq3a is 90 - vang(upVec,sq3).  if abs(sq3a) > abs(sq1a) and abs(sq3a) > abs(sq2a) and abs(sq3a) > abs(sq4a) and abs(sq3a) > abs(sq5a) and abs(sq3a) > abs(sq6a) and abs(sq3a) > abs(sq7a) and abs(sq3a) > abs(sq8a) and abs(sq3a) > abs(sq9a) and abs(sq3a) > abs(sq10a) and abs(sq3a) > abs(sq11a) and abs(sq3a) > abs(sq12a) and abs(sq3a) > abs(sq13a) and abs(sq3a) > abs(sq14a) and abs(sq3a) > abs(sq16a){set gp to xxd.}
 global sq4a is 90 - vang(upVec,sq4). if abs(sq4a) > abs(sq1a) and abs(sq4a) > abs(sq2a) and abs(sq4a) > abs(sq3a) and abs(sq4a) > abs(sq5a) and abs(sq4a) > abs(sq6a) and abs(sq4a) > abs(sq7a) and abs(sq4a) > abs(sq8a) and abs(sq4a) > abs(sq9a) and abs(sq4a) > abs(sq10a) and abs(sq4a) > abs(sq11a) and abs(sq4a) > abs(sq12a) and abs(sq4a) > abs(sq13a) and abs(sq4a) > abs(sq14a) and abs(sq4a) > abs(sq16a){set gp to xxa.} 
                                      if abs(sq5a) > abs(sq1a) and abs(sq5a) > abs(sq2a) and abs(sq5a) > abs(sq3a) and abs(sq5a) > abs(sq4a) and abs(sq5a) > abs(sq6a) and abs(sq5a) > abs(sq7a) and abs(sq5a) > abs(sq8a) and abs(sq5a) > abs(sq9a) and abs(sq5a) > abs(sq10a) and abs(sq5a) > abs(sq11a) and abs(sq5a) > abs(sq12a) and abs(sq5a) > abs(sq13a) and abs(sq5a) > abs(sq14a) and abs(sq5a) > abs(sq16a){set gp to xxe.}
global sq5a is 90 - vang(upVec,sq5).  if abs(sq6a) > abs(sq1a) and abs(sq6a) > abs(sq3a) and abs(sq6a) > abs(sq4a) and abs(sq6a) > abs(sq5a) and abs(sq6a) > abs(sq2a) and abs(sq6a) > abs(sq7a) and abs(sq6a) > abs(sq8a) and abs(sq6a) > abs(sq9a) and abs(sq6a) > abs(sq10a) and abs(sq6a) > abs(sq11a) and abs(sq6a) > abs(sq12a) and abs(sq6a) > abs(sq13a) and abs(sq6a) > abs(sq14a) and abs(sq6a) > abs(sq16a){set gp to xxf.}
global sq6a is 90 - vang(upVec,sq6).  if abs(sq7a) > abs(sq1a) and abs(sq7a) > abs(sq3a) and abs(sq7a) > abs(sq4a) and abs(sq7a) > abs(sq5a) and abs(sq7a) > abs(sq6a) and abs(sq7a) > abs(sq2a) and abs(sq7a) > abs(sq8a) and abs(sq7a) > abs(sq9a) and abs(sq7a) > abs(sq10a) and abs(sq7a) > abs(sq11a) and abs(sq7a) > abs(sq12a) and abs(sq7a) > abs(sq13a) and abs(sq7a) > abs(sq14a) and abs(sq7a) > abs(sq16a){set gp to xxg.}
global sq7a is 90 - vang(upVec,sq7).  if abs(sq8a) > abs(sq1a) and abs(sq8a) > abs(sq3a) and abs(sq8a) > abs(sq4a) and abs(sq8a) > abs(sq5a) and abs(sq8a) > abs(sq6a) and abs(sq8a) > abs(sq7a) and abs(sq8a) > abs(sq2a) and abs(sq8a) > abs(sq9a) and abs(sq8a) > abs(sq10a) and abs(sq8a) > abs(sq11a) and abs(sq8a) > abs(sq12a) and abs(sq8a) > abs(sq13a) and abs(sq8a) > abs(sq14a) and abs(sq8a) > abs(sq16a){set gp to xxh.}
global sq8a is 90 - vang(upVec,sq8).  if abs(sq9a) > abs(sq1a) and abs(sq9a) > abs(sq3a) and abs(sq9a) > abs(sq4a) and abs(sq9a) > abs(sq5a) and abs(sq9a) > abs(sq6a) and abs(sq9a) > abs(sq7a) and abs(sq9a) > abs(sq8a) and abs(sq9a) > abs(sq2a) and abs(sq9a) > abs(sq10a) and abs(sq9a) > abs(sq11a) and abs(sq9a) > abs(sq12a) and abs(sq9a) > abs(sq13a) and abs(sq9a) > abs(sq14a) and abs(sq9a) > abs(sq16a){set gp to xxi.}
global sq9a is 90 - vang(upVec,sq9).  if abs(sq2a) > abs(sq1a) and abs(sq2a) > abs(sq3a) and abs(sq2a) > abs(sq4a) and abs(sq2a) > abs(sq5a) and abs(sq2a) > abs(sq6a) and abs(sq2a) > abs(sq7a) and abs(sq2a) > abs(sq8a) and abs(sq2a) > abs(sq9a) and abs(sq2a) > abs(sq10a) and abs(sq2a) > abs(sq11a) and abs(sq2a) > abs(sq12a) and abs(sq2a) > abs(sq13a) and abs(sq2a) > abs(sq14a) and abs(sq2a) > abs(sq16a){set gp to xxj.}
global sq10a is 90 - vang(upVec,sq10).if abs(sq2a) > abs(sq1a) and abs(sq2a) > abs(sq3a) and abs(sq2a) > abs(sq4a) and abs(sq2a) > abs(sq5a) and abs(sq2a) > abs(sq6a) and abs(sq2a) > abs(sq7a) and abs(sq2a) > abs(sq8a) and abs(sq2a) > abs(sq9a) and abs(sq2a) > abs(sq10a) and abs(sq2a) > abs(sq11a) and abs(sq2a) > abs(sq12a) and abs(sq2a) > abs(sq13a) and abs(sq2a) > abs(sq14a) and abs(sq2a) > abs(sq16a){set gp to xxk.}
global sq11a is 90 - vang(upVec,sq11).if abs(sq2a) > abs(sq1a) and abs(sq2a) > abs(sq3a) and abs(sq2a) > abs(sq4a) and abs(sq2a) > abs(sq5a) and abs(sq2a) > abs(sq6a) and abs(sq2a) > abs(sq7a) and abs(sq2a) > abs(sq8a) and abs(sq2a) > abs(sq9a) and abs(sq2a) > abs(sq10a) and abs(sq2a) > abs(sq11a) and abs(sq2a) > abs(sq12a) and abs(sq2a) > abs(sq13a) and abs(sq2a) > abs(sq14a) and abs(sq2a) > abs(sq16a){set gp to xxl.}
global sq12a is 90 - vang(upVec,sq12).if abs(sq2a) > abs(sq1a) and abs(sq2a) > abs(sq3a) and abs(sq2a) > abs(sq4a) and abs(sq2a) > abs(sq5a) and abs(sq2a) > abs(sq6a) and abs(sq2a) > abs(sq7a) and abs(sq2a) > abs(sq8a) and abs(sq2a) > abs(sq9a) and abs(sq2a) > abs(sq10a) and abs(sq2a) > abs(sq11a) and abs(sq2a) > abs(sq12a) and abs(sq2a) > abs(sq13a) and abs(sq2a) > abs(sq14a) and abs(sq2a) > abs(sq16a){set gp to xxm.}
global sq13a is 90 - vang(upVec,sq13).if abs(sq2a) > abs(sq1a) and abs(sq2a) > abs(sq3a) and abs(sq2a) > abs(sq4a) and abs(sq2a) > abs(sq5a) and abs(sq2a) > abs(sq6a) and abs(sq2a) > abs(sq7a) and abs(sq2a) > abs(sq8a) and abs(sq2a) > abs(sq9a) and abs(sq2a) > abs(sq10a) and abs(sq2a) > abs(sq11a) and abs(sq2a) > abs(sq12a) and abs(sq2a) > abs(sq13a) and abs(sq2a) > abs(sq14a) and abs(sq2a) > abs(sq16a){set gp to xxn.}
global sq14a is 90 - vang(upVec,sq14).if abs(sq2a) > abs(sq1a) and abs(sq2a) > abs(sq3a) and abs(sq2a) > abs(sq4a) and abs(sq2a) > abs(sq5a) and abs(sq2a) > abs(sq6a) and abs(sq2a) > abs(sq7a) and abs(sq2a) > abs(sq8a) and abs(sq2a) > abs(sq9a) and abs(sq2a) > abs(sq10a) and abs(sq2a) > abs(sq11a) and abs(sq2a) > abs(sq12a) and abs(sq2a) > abs(sq13a) and abs(sq2a) > abs(sq14a) and abs(sq2a) > abs(sq16a){set gp to xxo.}
global sq15a is 90 - vang(upVec,sq15).if abs(sq2a) > abs(sq1a) and abs(sq2a) > abs(sq3a) and abs(sq2a) > abs(sq4a) and abs(sq2a) > abs(sq5a) and abs(sq2a) > abs(sq6a) and abs(sq2a) > abs(sq7a) and abs(sq2a) > abs(sq8a) and abs(sq2a) > abs(sq9a) and abs(sq2a) > abs(sq10a) and abs(sq2a) > abs(sq11a) and abs(sq2a) > abs(sq12a) and abs(sq2a) > abs(sq13a) and abs(sq2a) > abs(sq14a) and abs(sq2a) > abs(sq16a){set gp to xxp.}
global sq16a is 90 - vang(upVec,sq16).

  
}
function Gd{ 
local east is vectorCrossProduct(north:vector, up:vector).
  lock center to ship:position.
global xxb IS body:geopositionOf(center + 05 * north:vector + 05 * east).
global xxC IS body:geopositionOf(center - 05 * north:vector + 05 * east).
global xxD IS body:geopositionOf(center - 05 * north:vector - 05 * east).
global xxa is body:geopositionOf(center + 05 * north:vector - 05 * east).
global xxE IS body:geopositionOf(center + 15 * north:vector - 05 * east).
global xxF IS body:geopositionOf(center + 15 * north:vector + 05 * east).
global xxG IS body:geopositionOf(center + 15 * north:vector + 15 * east).
global xxH IS body:geopositionOf(center + 05 * north:vector + 15 * east). 
global xxI IS body:geopositionOf(center - 05 * north:vector + 15 * east).  
global xxj IS body:geopositionOf(center - 15 * north:vector + 15 * east).
global xxk IS body:geopositionOf(center - 15 * north:vector + 5 * east).
global xxl IS body:geopositionOf(center - 15* north:vector - 05 * east).
global xxm IS body:geopositionOf(center - 15 * north:vector - 15 * east).
global xxn IS body:geopositionOf(center - 05 * north:vector - 15 * east).
global xxo IS body:geopositionOf(center + 05 * north:vector - 15 * east).
global xxp IS body:geopositionOf(center + 15 * north:vector + 15 * east).
set mylist to LIST().
  set ccmp to list(sq1a,sq2a,sq3a,sq4a,sq5a,sq6a,sq7a,sq8a,sq9a,sq10a,sq11a,sq12a,sq13a,sq14a,sq15a,sq16a). 
mylist:ADD(ccmp).   // Element 1 is now itself a list.
print mylist.
  wait 5.
set ccmp to list(xxb,xxc,xxd,xxa,xxE,xxf,xxg,xxh,xxi,xxj,xxk,xxl,xxm,xxn,xxo,xxp).
mylist:ADD(ccmp).
clearscreen.
print mylist.
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
