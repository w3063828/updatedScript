function GSDf{ 
 local last point is gp:position.
 local list_pos is list(body:geopositionOf(gp:position)).
 set trglat to list_pos[0] + x_factor.
 set trglon to list_pos[1] + x factor.
 set new_pos to Body:GEOPOSITIONLATLNG(trglat,trglon).
 clearscreen.

    
    lock center to new_pos.
    local A IS new_pos.
    local b IS body:geopositionOf(center + 000 * north:vector + 100 * east).
    local C IS body:geopositionOf(center + 100 * north:vector + 000 * east).
    local D IS body:geopositionOf(center + 100 * north:vector + 100 * east).
    local E IS body:geopositionOf(center - 000 * north:vector - 100 * east).
    local F IS body:geopositionOf(center - 100 * north:vector - 000 * east).
    local G IS body:geopositionOf(center - 100 * north:vector - 100 * east).
    local H IS body:geopositionOf(center + 100 * north:vector - 100 * east). 
    local I IS body:geopositionOf(center - 100 * north:vector + 100 * east).  

    local j IS body:geopositionOf(center - 200 * north:vector + 200 * east).
    local k IS body:geopositionOf(center - 100 * north:vector + 200 * east).
    local l IS body:geopositionOf(center - 000 * north:vector + 200 * east).
    local m IS body:geopositionOf(center + 100 * north:vector + 200 * east).
    local n IS body:geopositionOf(center + 200 * north:vector + 200 * east).

    local o IS body:geopositionOf(center + 200 * north:vector + 100 * east).
    local p IS body:geopositionOf(center + 200 * north:vector + 000 * east).
    local qq IS body:geopositionOf(center + 200 * north:vector - 100 * east). 
    local rr IS body:geopositionOf(center + 200 * north:vector - 200 * east).  

    local s is body:geopositionOf(center + 100 * north:vector - 200 * east).  
    local t IS body:geopositionOf(center + 000 * north:vector - 200 * east).
    local u IS body:geopositionOf(center - 100 * north:vector - 200 * east).
    local z IS body:geopositionOf(center - 200 * north:vector - 200 * east).

    local w IS body:geopositionOf(center - 200 * north:vector - 100 * east).
    local x IS body:geopositionOf(center - 200 * north:vector - 000 * east).
    local y IS body:geopositionOf(center - 200 * north:vector + 100 * east).

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

    local sq1a is 90 - vang(upVec,sq1).
    local sq2a is 90 - vang(upVec,sq2).
    local sq3a is 90 - vang(upVec,sq3).
    local sq4a is 90 - vang(upVec,sq4).
    local sq5a is 90 - vang(upVec,sq5).
    local sq6a is 90 - vang(upVec,sq6).
    local sq7a is 90 - vang(upVec,sq7).
    local sq8a is 90 - vang(upVec,sq8).
    local sq9a is 90 - vang(upVec,sq9).
    local sq10a is 90 - vang(upVec,sq10).
    local sq11a is 90 - vang(upVec,sq11).
    local sq12a is 90 - vang(upVec,sq12).
    local sq13a is 90 - vang(upVec,sq13).
    local sq14a is 90 - vang(upVec,sq14).
    local sq15a is 90 - vang(upVec,sq15).
    local sq16a is 90 - vang(upVec,sq16).
    local xxb IS body:geopositionOf(center + 050 * north:vector + 050 * east).
    local xxC IS body:geopositionOf(center - 050 * north:vector + 050 * east).
    local xxD IS body:geopositionOf(center - 050 * north:vector - 050 * east).
    local xxa is body:geopositionOf(center + 050 * north:vector - 050 * east).
    local xxE IS body:geopositionOf(center + 150 * north:vector - 050 * east).
    local xxF IS body:geopositionOf(center + 150 * north:vector + 050 * east).
    local xxG IS body:geopositionOf(center + 150 * north:vector + 150 * east).
    local xxH IS body:geopositionOf(center + 050 * north:vector + 150 * east). 
    local xxI IS body:geopositionOf(center - 050 * north:vector + 150 * east).  
    local xxj IS body:geopositionOf(center - 150 * north:vector + 150 * east).
    local xxk IS body:geopositionOf(center - 150 * north:vector + 050 * east).
    local xxl IS body:geopositionOf(center - 150 * north:vector - 050 * east).
    local xxm IS body:geopositionOf(center - 150 * north:vector - 150 * east).
    local xxn IS body:geopositionOf(center - 050 * north:vector - 150 * east).
    local xxo IS body:geopositionOf(center + 050 * north:vector - 150 * east).
    local xxp IS body:geopositionOf(center + 150 * north:vector + 150 * east).

   

 if abs(sq1a) < abs(sq2a) and abs(sq1a) < abs(sq3a) and abs(sq1a) < abs(sq4a) and abs(sq1a) < abs(sq5a) and abs(sq1a) < abs(sq6a) and abs(sq1a) < abs(sq7a) and abs(sq1a) < abs(sq8a) and abs(sq1a) < abs(sq9a) and abs(sq1a) < abs(sq10a) and abs(sq1a) < abs(sq11a) and abs(sq1a) < abs(sq12a) and abs(sq1a) < abs(sq13a) and abs(sq1a) < abs(sq14a) and abs(sq1a) < abs(sq15a) and abs(sq1a) < abs(sq16a)                { set sq1a to best_scorea.}
 if abs(sq2a) < abs(sq1a) and abs(sq2a) < abs(sq3a) and abs(sq2a) < abs(sq4a) and abs(sq2a) < abs(sq5a) and abs(sq2a) < abs(sq6a) and abs(sq2a) < abs(sq7a) and abs(sq2a) < abs(sq8a) and abs(sq2a) < abs(sq9a) and abs(sq2a) < abs(sq10a) and abs(sq2a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq2a) < abs(sq13a) and abs(sq2a) < abs(sq14a) and abs(sq2a) < abs(sq15a) and abs(sq2a) < abs(sq16a)                { set sq2a to best_scoreb.} 
 if abs(sq3a) < abs(sq1a) and abs(sq3a) < abs(sq2a) and abs(sq3a) < abs(sq4a) and abs(sq3a) < abs(sq5a) and abs(sq3a) < abs(sq6a) and abs(sq3a) < abs(sq7a) and abs(sq3a) < abs(sq8a) and abs(sq3a) < abs(sq9a) and abs(sq3a) < abs(sq10a) and abs(sq3a) < abs(sq11a) and abs(sq3a) < abs(sq12a) and abs(sq3a) < abs(sq13a) and abs(sq3a) < abs(sq14a) and abs(sq3a) < abs(sq15a) and abs(sq3a) < abs(sq16a)                { set sq3a to best_scorec.}
 if abs(sq4a) < abs(sq1a) and abs(sq4a) < abs(sq2a) and abs(sq4a) < abs(sq3a) and abs(sq4a) < abs(sq5a) and abs(sq4a) < abs(sq6a) and abs(sq4a) < abs(sq7a) and abs(sq4a) < abs(sq8a) and abs(sq4a) < abs(sq9a) and abs(sq4a) < abs(sq10a) and abs(sq4a) < abs(sq11a) and abs(sq4a) < abs(sq12a) and abs(sq4a) < abs(sq13a) and abs(sq4a) < abs(sq14a) and abs(sq4a) < abs(sq15a) and abs(sq4a) < abs(sq16a)                { set sq4a to best_scored.} 
 if abs(sq5a) < abs(sq1a) and abs(sq5a) < abs(sq2a) and abs(sq5a) < abs(sq3a) and abs(sq5a) < abs(sq4a) and abs(sq5a) < abs(sq6a) and abs(sq5a) < abs(sq7a) and abs(sq5a) < abs(sq8a) and abs(sq5a) < abs(sq9a) and abs(sq5a) < abs(sq10a) and abs(sq5a) < abs(sq11a) and abs(sq5a) < abs(sq12a) and abs(sq5a) < abs(sq13a) and abs(sq5a) < abs(sq14a) and abs(sq5a) < abs(sq15a) and abs(sq5a) < abs(sq16a)                { set sq5a to best_scoree.}
 if abs(sq6a) < abs(sq1a) and abs(sq6a) < abs(sq3a) and abs(sq6a) < abs(sq4a) and abs(sq6a) < abs(sq5a) and abs(sq6a) < abs(sq2a) and abs(sq6a) < abs(sq7a) and abs(sq6a) < abs(sq8a) and abs(sq6a) < abs(sq9a) and abs(sq6a) < abs(sq10a) and abs(sq6a) < abs(sq11a) and abs(sq6a) < abs(sq12a) and abs(sq6a) < abs(sq13a) and abs(sq6a) < abs(sq14a) and abs(sq6a) < abs(sq15a) and abs(sq6a) < abs(sq16a)                { set sq6a to best_scoref.}
 if abs(sq7a) < abs(sq1a) and abs(sq7a) < abs(sq3a) and abs(sq7a) < abs(sq4a) and abs(sq7a) < abs(sq5a) and abs(sq7a) < abs(sq6a) and abs(sq7a) < abs(sq2a) and abs(sq7a) < abs(sq8a) and abs(sq7a) < abs(sq9a) and abs(sq7a) < abs(sq10a) and abs(sq7a) < abs(sq11a) and abs(sq7a) < abs(sq12a) and abs(sq7a) < abs(sq13a) and abs(sq7a) < abs(sq14a) and abs(sq7a) < abs(sq15a) and abs(sq7a) < abs(sq16a)                { set sq7a to best_scoreg.}
 if abs(sq8a) < abs(sq1a) and abs(sq8a) < abs(sq3a) and abs(sq8a) < abs(sq4a) and abs(sq8a) < abs(sq5a) and abs(sq8a) < abs(sq6a) and abs(sq8a) < abs(sq7a) and abs(sq8a) < abs(sq2a) and abs(sq8a) < abs(sq9a) and abs(sq8a) < abs(sq10a) and abs(sq8a) < abs(sq11a) and abs(sq8a) < abs(sq12a) and abs(sq8a) < abs(sq13a) and abs(sq8a) < abs(sq14a) and abs(sq8a) < abs(sq15a) and abs(sq8a) < abs(sq16a)                { set sq8a to best_scoreh.}
 if abs(sq9a) < abs(sq1a) and abs(sq9a) < abs(sq3a) and abs(sq9a) < abs(sq4a) and abs(sq9a) < abs(sq5a) and abs(sq9a) < abs(sq6a) and abs(sq9a) < abs(sq7a) and abs(sq9a) < abs(sq8a) and abs(sq9a) < abs(sq2a) and abs(sq9a) < abs(sq10a) and abs(sq9a) < abs(sq11a) and abs(sq9a) < abs(sq12a) and abs(sq9a) < abs(sq13a) and abs(sq9a) < abs(sq14a) and abs(sq9a) < abs(sq15a) and abs(sq9a) < abs(sq16a)                { set sq9a to best_scorei.}
 if abs(sq10a) < abs(sq1a) and abs(sq10a) < abs(sq3a) and abs(sq10a) < abs(sq4a) and abs(sq10a) < abs(sq5a) and abs(sq10a) < abs(sq6a) and abs(sq10a) < abs(sq7a) and abs(sq10a) < abs(sq8a) and abs(sq10a) < abs(sq9a) and abs(sq10a) < abs(sq2a) and abs(sq10a) < abs(sq11a) and abs(sq10a) < abs(sq12a) and abs(sq10a) < abs(sq13a) and abs(sq10a) < abs(sq14a) and abs(sq10a) < abs(sq15a) and abs(sq10a) < abs(sq16a)  { set sq10a to best_scorej.}
 if abs(sq11a) < abs(sq1a) and abs(sq11a) < abs(sq3a) and abs(sq11a) < abs(sq4a) and abs(sq11a) < abs(sq5a) and abs(sq11a) < abs(sq6a) and abs(sq11a) < abs(sq7a) and abs(sq11a) < abs(sq8a) and abs(sq11a) < abs(sq9a) and abs(sq11a) < abs(sq10a) and abs(sq11a) < abs(sq11a) and abs(sq2a) < abs(sq12a) and abs(sq11a) < abs(sq13a) and abs(sq11a) < abs(sq14a) and abs(sq11a) < abs(sq15a) and abs(sq11a) < abs(sq16a)  { set sq11a to best_scorek.}
 if abs(sq12a) < abs(sq1a) and abs(sq12a) < abs(sq3a) and abs(sq12a) < abs(sq4a) and abs(sq12a) < abs(sq5a) and abs(sq12a) < abs(sq6a) and abs(sq12a) < abs(sq7a) and abs(sq12a) < abs(sq8a) and abs(sq12a) < abs(sq9a) and abs(sq12a) < abs(sq10a) and abs(sq12a) < abs(sq11a) and abs(sq12a) < abs(sq2a) and abs(sq12a) < abs(sq13a) and abs(sq12a) < abs(sq14a) and abs(sq12a) < abs(sq15a) and abs(sq12a) < abs(sq16a)  { set sq12a to best_scorel.}
 if abs(sq13a) < abs(sq1a) and abs(sq13a) < abs(sq3a) and abs(sq13a) < abs(sq4a) and abs(sq13a) < abs(sq5a) and abs(sq13a) < abs(sq6a) and abs(sq13a) < abs(sq7a) and abs(sq13a) < abs(sq8a) and abs(sq13a) < abs(sq9a) and abs(sq13a) < abs(sq10a) and abs(sq13a) < abs(sq11a) and abs(sq13a) < abs(sq12a) and abs(sq13a) < abs(sq2a) and abs(sq13a) < abs(sq14a) and abs(sq13a) < abs(sq15a) and abs(sq13a) < abs(sq16a)  { set sq13a to best_scorem.}
 if abs(sq14a) < abs(sq1a) and abs(sq14a) < abs(sq3a) and abs(sq14a) < abs(sq4a) and abs(sq14a) < abs(sq5a) and abs(sq14a) < abs(sq6a) and abs(sq14a) < abs(sq7a) and abs(sq14a) < abs(sq8a) and abs(sq14a) < abs(sq9a) and abs(sq14a) < abs(sq10a) and abs(sq14a) < abs(sq11a) and abs(sq14a) < abs(sq12a) and abs(sq14a) < abs(sq13a) and abs(sq14a) < abs(sq2a) and abs(sq14a) < abs(sq15a) and abs(sq14a) < abs(sq16a)  { set sq14a to best_scoren.}
 if abs(sq15a) < abs(sq1a) and abs(sq15a) < abs(sq2a) and abs(sq15a) < abs(sq3a) and abs(sq15a) < abs(sq4a) and abs(sq15a) < abs(sq5a) and abs(sq15a) < abs(sq6a) and abs(sq15a) < abs(sq7a) and abs(sq15a) < abs(sq8a) and abs(sq15a) < abs(sq9a)  and abs(sq15a) < abs(sq10a) and abs(sq15a) < abs(sq11a) and abs(sq15a) < abs(sq12a) and abs(sq15a) < abs(sq13a) and abs(sq15a) < abs(sq14a) and abs(sq15a) < abs(sq16a) { set sq15a to best_scoreo.}
 if abs(sq16a) < abs(sq1a) and abs(sq16a) < abs(sq3a) and abs(sq16a) < abs(sq4a) and abs(sq16a) < abs(sq5a) and abs(sq16a) < abs(sq6a) and abs(sq16a) < abs(sq7a) and abs(sq16a) < abs(sq8a) and abs(sq16a) < abs(sq9a) and abs(sq16a) < abs(sq10a) and abs(sq16a) < abs(sq11a) and abs(sq16a) < abs(sq12a) and abs(sq16a) < abs(sq13a) and abs(sq16a) < abs(sq14a) and abs(sq16a) < abs(sq15a) and abs(sq16a) < abs(sq2a)  { set sq16a to best_scorep.}


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
 
 print scoreToBeat.
 print best score.
 }
