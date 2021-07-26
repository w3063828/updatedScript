
start().
gs().

set scoreToBeat to best_score.
//end of frirst loop i have a best score (1st loop)and a score to beat.
gsd().// gives us an indiviual best score for 2nd loop compares to the 1st. if its less than first it sets best score to inidivual best score
until scoreToBeat < 0.15 {

if best_score < scoreToBeat {
  set scoreToBeat to best_score. 
  gsd(). //runs normal loop as long a score is best score continues to be lower than score to beat.
}
else {
      SET theta TO  (theta + 1).
      set sign to (-1)^(theta).
      set RADIUS to (RADIUS + constant:e).
      set x_f to  sign * RADIUS  / constant:e * sin(RADIUS).
      set x_f1 to sign * RADIUS  / constant:e * COS(RADIUS).

gsdf().}// run midfied program where it adds 05 ft to bot lat lon and then searches restarts the search.
}
SET CONFIG:IPU TO 50.
//local original_length is ship:parts:length. 
//wait until ship:parts:length < original_length.

 runpath("0:/y=.ks").



function GS{ 
     global east is vectorCrossProduct(north:vector, up:vector).
     lock center to gp:position.
     local a IS body:geopositionOf(center - 10 * north:vector + 10 * east).
     local b IS body:geopositionOf(center - 10 * north:vector + 05 * east).
     local c IS body:geopositionOf(center - 10 * north:vector - 00 * east).
     local d IS body:geopositionOf(center - 10 * north:vector - 05 * east).
     local e IS body:geopositionOf(center - 10 * north:vector - 10 * east).
     local f IS body:geopositionOf(center - 05 * north:vector + 10 * east).
     local g IS body:geopositionOf(center - 05 * north:vector + 05 * east).  
     local h IS body:geopositionOf(center - 05 * north:vector - 00 * east).
     local i IS body:geopositionOf(center - 05 * north:vector - 05 * east).
     local j IS body:geopositionOf(center - 05 * north:vector - 10 * east).
     local k IS body:geopositionOf(center - 00 * north:vector + 10 * east).
     local l IS body:geopositionOf(center + 00 * north:vector + 05 * east).
     local m IS body:geopositionOf(gp:position).
     local n IS body:geopositionOf(center - 00 * north:vector - 05 * east).
     local o IS body:geopositionOf(center + 00 * north:vector - 10 * east).
     local p IS body:geopositionOf(center + 05 * north:vector + 10 * east).
     local qq IS body:geopositionOf(center + 05 * north:vector + 05 * east).
     local rr IS body:geopositionOf(center + 05 * north:vector + 00 * east).
     local s IS body:geopositionOf(center + 05 * north:vector - 05 * east). 
     local t is body:geopositionOf(center + 05 * north:vector - 10 * east).
     local u IS body:geopositionOf(center + 10 * north:vector + 10 * east).
     local vv IS body:geopositionOf(center + 10 * north:vector + 05 * east).
     local w IS body:geopositionOf(center + 10 * north:vector + 00 * east).
     local x IS body:geopositionOf(center + 10 * north:vector - 05 * east). 
     local y IS body:geopositionOf(center + 10 * north:vector - 10 * east).  

        local a_vec is a:altitudeposition(a:terrainheight).
        local b_vec is b:altitudeposition(b:terrainheight).
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
        local v_vec is vv:altitudeposition(vv:terrainheight).
        local w_vec is w:altitudeposition(w:terrainheight).
        local x_vec is x:altitudeposition(x:terrainheight).
        local y_vec is y:altitudeposition(y:terrainheight).

            local sq1 is vcrs(a_vec - g_vec, f_vec - b_vec).
            local sq2 is vcrs(b_vec - h_vec, g_vec - c_vec).
            local sq3 is vcrs(c_vec - i_vec, h_vec - d_vec).
            local sq4 is vcrs(d_vec - j_vec, i_vec - e_vec).

            local sq5 is vcrs(f_vec - l_vec, k_vec - g_vec).
            local sq6 is vcrs(g_vec - m_vec, l_vec - h_vec).
            local sq7 is vcrs(h_vec - n_vec, m_vec - i_vec).
            local sq8 is vcrs(i_vec - o_vec, n_vec - j_vec).

            local sq9 is vcrs(k_vec - q_vec, p_vec - l_vec).
            local sq10 is vcrs(l_vec - r_vec, q_vec - m_vec).
            local sq11 is vcrs(m_vec - s_vec, r_vec - n_vec).
            local sq12 is vcrs(n_vec - t_vec, s_vec - o_vec).

            local sq13 is vcrs(p_vec - v_vec, u_vec - q_vec).
            local sq14 is vcrs(q_vec - w_vec, v_vec - r_vec).
            local sq15 is vcrs(r_vec - x_vec, w_vec - s_vec).
            local sq16 is vcrs(s_vec - y_vec, x_vec - t_vec).
            global upVec IS up:vector.

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

    local xxd IS body:geopositionOf(center - (15 / 2) * north:vector - (15 / 2) * east).
    local xxc IS body:geopositionOf(center - (15 / 2) * north:vector - (05 / 2) * east).
    local xxb IS body:geopositionOf(center - (15 / 2) * north:vector + (05 / 2) * east).
    local xxa IS body:geopositionOf(center - (15 / 2) * north:vector + (15 / 2) * east).

    local xxh IS body:geopositionOf(center - (05 / 2) * north:vector - (15 / 2) * east).
    local xxg IS body:geopositionOf(center - (05 / 2) * north:vector - (05 / 2) * east).
    local xxf IS body:geopositionOf(center - (05 / 2) * north:vector + (05 / 2) * east).
    local xxe IS body:geopositionOf(center - (05 / 2) * north:vector + (15 / 2) * east).

    local xxl IS body:geopositionOf(center + (05 / 2) * north:vector - (15 / 2) * east).
    local xxk is body:geopositionOf(center + (05 / 2) * north:vector - (05 / 2) * east).
    local xxj IS body:geopositionOf(center + (05 / 2) * north:vector + (05 / 2) * east).  
    local xxi IS body:geopositionOf(center + (05 / 2) * north:vector + (15 / 2) * east).
    
    local xxp IS body:geopositionOf(center + (15 / 2) * north:vector - (15 / 2) * east).
    local xxo IS body:geopositionOf(center + (15 / 2) * north:vector - (05 / 2) * east).
    local xxn IS body:geopositionOf(center + (15 / 2) * north:vector + (05 / 2) * east).
    local xxm IS body:geopositionOf(center + (15 / 2) * north:vector + (15 / 2) * east).


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
    
      set mylist to LIST().
    set ccmp to list(sq1a,sq2a,sq3a,sq4a,sq5a,sq6a,sq7a,sq8a,sq9a,sq10a,sq11a,sq12a,sq13a,sq14a,sq15a,sq16a).
  
    mylist:ADD(ccmp).   // Element 1 is now itself a list.
   
 
    print gp at (5,4).
    print best_score at (5,5).
   // print mylist. wait 100. 
}
 
function tmizz {
  return round(time:seconds - start_time,0).
}



FUNCTION start {
    core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
    global ipuBackup IS CONFIG:IPU.
    if ipuBackup > 201 {set ipuBackup to 200.} 
    set gp to ship:body:geoposition. 
    SET CONFIG:IPU TO 2000.
    set best_score to 1.
    set start_time to time:seconds.
    clearvecdraws().
    set x_f to 1.41.
    set x_f1 to 1.41.
    SET x_f2 TO 1.
    SET X_F3 TO 1.
    global theta is 1.
    global RADIUS is 20.
    clearscreen.
      lock surfaceElevation to body:geopositionOf(ship:position):terrainHeight.
      lock betterALTRADAR to max( 0.1, ALTITUDE - surfaceElevation).
}


function GSD{ 
     local east is vectorCrossProduct(north:vector, up:vector).
     lock center to gp:position.
     local a IS body:geopositionOf(center - 10 * north:vector + 10 * east).
     local b IS body:geopositionOf(center - 10 * north:vector + 05 * east).
     local c IS body:geopositionOf(center - 10 * north:vector - 00 * east).
     local d IS body:geopositionOf(center - 10 * north:vector - 05 * east).
     local e IS body:geopositionOf(center - 10 * north:vector - 10 * east).
     local f IS body:geopositionOf(center - 05 * north:vector + 10 * east).
     local g IS body:geopositionOf(center - 05 * north:vector + 05 * east).  
     local h IS body:geopositionOf(center - 05 * north:vector - 00 * east).
     local i IS body:geopositionOf(center - 05 * north:vector - 05 * east).
     local j IS body:geopositionOf(center - 05 * north:vector - 10 * east).
     local k IS body:geopositionOf(center - 00 * north:vector + 10 * east).
     local l IS body:geopositionOf(center + 00 * north:vector + 05 * east).
     local m IS body:geopositionOf(gp:position).
     local n IS body:geopositionOf(center - 00 * north:vector - 05 * east).
     local o IS body:geopositionOf(center + 00 * north:vector - 10 * east).
     local p IS body:geopositionOf(center + 05 * north:vector + 10 * east).
     local qq IS body:geopositionOf(center + 05 * north:vector + 05 * east).
     local rr IS body:geopositionOf(center + 05 * north:vector + 00 * east).
     local s IS body:geopositionOf(center + 05 * north:vector - 05 * east). 
     local t is body:geopositionOf(center + 05 * north:vector - 10 * east).
     local u IS body:geopositionOf(center + 10 * north:vector + 10 * east).
     local vv IS body:geopositionOf(center + 10 * north:vector + 05 * east).
     local w IS body:geopositionOf(center + 10 * north:vector + 00 * east).
     local x IS body:geopositionOf(center + 10 * north:vector - 05 * east). 
     local y IS body:geopositionOf(center + 10 * north:vector - 10 * east).  

        local a_vec is a:altitudeposition(a:terrainheight).
        local b_vec is b:altitudeposition(b:terrainheight).
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
        local v_vec is vv:altitudeposition(vv:terrainheight).
        local w_vec is w:altitudeposition(w:terrainheight).
        local x_vec is x:altitudeposition(x:terrainheight).
        local y_vec is y:altitudeposition(y:terrainheight).

               local sq1 is vcrs(a_vec - g_vec, f_vec - b_vec).
            local sq2 is vcrs(b_vec - h_vec, g_vec - c_vec).
            local sq3 is vcrs(c_vec - i_vec, h_vec - d_vec).
            local sq4 is vcrs(d_vec - j_vec, i_vec - e_vec).

            local sq5 is vcrs(f_vec - l_vec, k_vec - g_vec).
            local sq6 is vcrs(g_vec - m_vec, l_vec - h_vec).
            local sq7 is vcrs(h_vec - n_vec, m_vec - i_vec).
            local sq8 is vcrs(i_vec - o_vec, n_vec - j_vec).

            local sq9 is vcrs(k_vec - q_vec, p_vec - l_vec).
            local sq10 is vcrs(l_vec - r_vec, q_vec - m_vec).
            local sq11 is vcrs(m_vec - s_vec, r_vec - n_vec).
            local sq12 is vcrs(n_vec - t_vec, s_vec - o_vec).

            local sq13 is vcrs(p_vec - v_vec, u_vec - q_vec).
            local sq14 is vcrs(q_vec - w_vec, v_vec - r_vec).
            local sq15 is vcrs(r_vec - x_vec, w_vec - s_vec).
            local sq16 is vcrs(s_vec - y_vec, x_vec - t_vec).

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
    
    local xxd IS body:geopositionOf(center - (15 / 2) * north:vector - (15 / 2) * east).
    local xxc IS body:geopositionOf(center - (15 / 2) * north:vector - (05 / 2) * east).
    local xxb IS body:geopositionOf(center - (15 / 2) * north:vector + (05 / 2) * east).
    local xxa IS body:geopositionOf(center - (15 / 2) * north:vector + (15 / 2) * east).

    local xxh IS body:geopositionOf(center - (05 / 2) * north:vector - (15 / 2) * east).
    local xxg IS body:geopositionOf(center - (05 / 2) * north:vector - (05 / 2) * east).
    local xxf IS body:geopositionOf(center - (05 / 2) * north:vector + (05 / 2) * east).
    local xxe IS body:geopositionOf(center - (05 / 2) * north:vector + (15 / 2) * east).

    local xxl IS body:geopositionOf(center + (05 / 2) * north:vector - (15 / 2) * east).
    local xxk is body:geopositionOf(center + (05 / 2) * north:vector - (05 / 2) * east).
    local xxj IS body:geopositionOf(center + (05 / 2) * north:vector + (05 / 2) * east).  
    local xxi IS body:geopositionOf(center + (05 / 2) * north:vector + (15 / 2) * east).
    
    local xxp IS body:geopositionOf(center + (15 / 2) * north:vector - (15 / 2) * east).
    local xxo IS body:geopositionOf(center + (15 / 2) * north:vector - (05 / 2) * east).
    local xxn IS body:geopositionOf(center + (15 / 2) * north:vector + (05 / 2) * east).
    local xxm IS body:geopositionOf(center + (15 / 2) * north:vector + (15 / 2) * east).

    local best_scorea is 050.
    local best_scoreb is 050.
    local best_scorec is 050.
    local best_scored is 050.
    local best_scoree is 050.
    local best_scoref is 050.
    local best_scoreg is 050.
    local best_scoreh is 050.
    local best_scorei is 050.
    local best_scorej is 050.
    local best_scorek is 050.
    local best_scorel is 050.
    local best_scorem is 050.
    local best_scoren is 050.
    local best_scoreo is 050.
    local best_scorep is 050.

   

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

  

    //print mylist. //wait 1. 
    clearscreen. 
    print gp at (5,4).
    print best_score at (5,5).
    print "gsd" at (5,6).
     print round(x_f,3) at (5,7).
     print round(x_f1,3) at (5,8).
      print tmizz at (5,9).
    //wait 1.
    
}
function GSDf { 
   
     local center1 is (ship:position).
	   set new_Pos to body:geopositionOf(center1 + x_f * north:vector + x_f1 * east).
     lock center to new_pos:position.
     local a IS body:geopositionOf(center - 10 * north:vector + 10 * east).
     local b IS body:geopositionOf(center - 10 * north:vector + 05 * east).
     local c IS body:geopositionOf(center - 10 * north:vector - 00 * east).
     local d IS body:geopositionOf(center - 10 * north:vector - 05 * east).
     local e IS body:geopositionOf(center - 10 * north:vector - 10 * east).
     local f IS body:geopositionOf(center - 05 * north:vector + 10 * east).
     local g IS body:geopositionOf(center - 05 * north:vector + 05 * east).  
     local h IS body:geopositionOf(center - 05 * north:vector - 00 * east).
     local i IS body:geopositionOf(center - 05 * north:vector - 05 * east).
     local j IS body:geopositionOf(center - 05 * north:vector - 10 * east).
     local k IS body:geopositionOf(center - 00 * north:vector + 10 * east).
     local l IS body:geopositionOf(center + 00 * north:vector + 05 * east).
     local m IS new_pos.
     local n IS body:geopositionOf(center - 00 * north:vector - 05 * east).
     local o IS body:geopositionOf(center + 00 * north:vector - 10 * east).
     local p IS body:geopositionOf(center + 05 * north:vector + 10 * east).
     local qq IS body:geopositionOf(center + 05 * north:vector + 05 * east).
     local rr IS body:geopositionOf(center + 05 * north:vector + 00 * east).
     local s IS body:geopositionOf(center + 05 * north:vector - 05 * east). 
     local t is body:geopositionOf(center + 05 * north:vector - 10 * east).
     local u IS body:geopositionOf(center + 10 * north:vector + 10 * east).
     local vv IS body:geopositionOf(center + 10 * north:vector + 05 * east).
     local w IS body:geopositionOf(center + 10 * north:vector + 00 * east).
     local x IS body:geopositionOf(center + 10 * north:vector - 05 * east). 
     local y IS body:geopositionOf(center + 10 * north:vector - 10 * east).  

        local a_vec is a:altitudeposition(a:terrainheight).
        local b_vec is b:altitudeposition(b:terrainheight).
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
        local v_vec is vv:altitudeposition(vv:terrainheight).
        local w_vec is w:altitudeposition(w:terrainheight).
        local x_vec is x:altitudeposition(x:terrainheight).
        local y_vec is y:altitudeposition(y:terrainheight).






              local sq1 is vcrs(a_vec - g_vec, f_vec - b_vec).
            local sq2 is vcrs(b_vec - h_vec, g_vec - c_vec).
            local sq3 is vcrs(c_vec - i_vec, h_vec - d_vec).
            local sq4 is vcrs(d_vec - j_vec, i_vec - e_vec).

            local sq5 is vcrs(f_vec - l_vec, k_vec - g_vec).
            local sq6 is vcrs(g_vec - m_vec, l_vec - h_vec).
            local sq7 is vcrs(h_vec - n_vec, m_vec - i_vec).
            local sq8 is vcrs(i_vec - o_vec, n_vec - j_vec).

            local sq9 is vcrs(k_vec - q_vec, p_vec - l_vec).
            local sq10 is vcrs(l_vec - r_vec, q_vec - m_vec).
            local sq11 is vcrs(m_vec - s_vec, r_vec - n_vec).
            local sq12 is vcrs(n_vec - t_vec, s_vec - o_vec).

            local sq13 is vcrs(p_vec - v_vec, u_vec - q_vec).
            local sq14 is vcrs(q_vec - w_vec, v_vec - r_vec).
            local sq15 is vcrs(r_vec - x_vec, w_vec - s_vec).
            local sq16 is vcrs(s_vec - y_vec, x_vec - t_vec).

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

    local xxd IS body:geopositionOf(center - (15 / 2) * north:vector - (15 / 2) * east).
    local xxc IS body:geopositionOf(center - (15 / 2) * north:vector - (05 / 2) * east).
    local xxb IS body:geopositionOf(center - (15 / 2) * north:vector + (05 / 2) * east).
    local xxa IS body:geopositionOf(center - (15 / 2) * north:vector + (15 / 2) * east).

    local xxh IS body:geopositionOf(center - (05 / 2) * north:vector - (15 / 2) * east).
    local xxg IS body:geopositionOf(center - (05 / 2) * north:vector - (05 / 2) * east).
    local xxf IS body:geopositionOf(center - (05 / 2) * north:vector + (05 / 2) * east).
    local xxe IS body:geopositionOf(center - (05 / 2) * north:vector + (15 / 2) * east).

    local xxl IS body:geopositionOf(center + (05 / 2) * north:vector - (15 / 2) * east).
    local xxk is body:geopositionOf(center + (05 / 2) * north:vector - (05 / 2) * east).
    local xxj IS body:geopositionOf(center + (05 / 2) * north:vector + (05 / 2) * east).  
    local xxi IS body:geopositionOf(center + (05 / 2) * north:vector + (15 / 2) * east).
    
    local xxp IS body:geopositionOf(center + (15 / 2) * north:vector - (15 / 2) * east).
    local xxo IS body:geopositionOf(center + (15 / 2) * north:vector - (05 / 2) * east).
    local xxn IS body:geopositionOf(center + (15 / 2) * north:vector + (05 / 2) * east).
    local xxm IS body:geopositionOf(center + (15 / 2) * north:vector + (15 / 2) * east).

    local best_scorea is 050.
    local best_scoreb is 050.
    local best_scorec is 050.
    local best_scored is 050.
    local best_scoree is 050.
    local best_scoref is 050.
    local best_scoreg is 050.
    local best_scoreh is 050.
    local best_scorei is 050.
    local best_scorej is 050.
    local best_scorek is 050.
    local best_scorel is 050.
    local best_scorem is 050.
    local best_scoren is 050.
    local best_scoreo is 050.
    local best_scorep is 050.

   

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




  SET am TO VECDRAWARGS(  m:ALTITUDEPOSITION(m:TERRAINHEIGHT+10),  m:POSITION - m:ALTITUDEPOSITION(m:TERRAINHEIGHT+10),  red, " m", 1, true). 

  
    print gp at (5,4).
    print best_score at (5,10).
    print "gsdF" at (5,6).
     print round(scoretobeat,2) at (5,5).
     print round(x_f,3) at (5,7).
     print round(x_f1,3) at (5,8).
      print tmizz at (5,9).
    wait 0. 
     clearscreen.
}

