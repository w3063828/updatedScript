CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
SET TARGET TO VESSEL("rt").
lock grav TO SHIP:SENSORS:GRAV:mag.
local pid is pidloop(0.23512961948290467, 0.097932885400950909, 0.23396590165793896, 0,1).
stage.
//ag2 on.
global tOld is time:seconds. 
set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
set pid:setpoint to 130.
lock VB to vxcl(SHIP:FACING:FOREVECTOR,TARGET:POSITION):mag.
set runmode to 1.


until runmode = 0 { 
 if runmode = 1 { 
   set pid_throttle to pid:update(time:seconds, dtg()).
    lock throttle to pid_throttle.
    set RV to vxcl(SHIP:FACING:FOREVECTOR, gp:position / 8 - velocity:surface) / 8. //relative velocity vector, we base our steering on this
    set RV:mag to min(8,RV:mag). //just for safety
    lock steering to lookdirup(up:vector * 10 + RV, facing:topvector).
   
    if vxcl(up:vector,gp:position):mag < 5 set tAlt to 25. //we're above target area so start descending
        if abort { abort off. set runmode to 2.}
    if ag8 { ag8 off. set runmode to 0.}
    print "RUNMODE:    " + runmode + "      " at (5,4).
    print "vb" + VB + "      " at (5,5).
    print "tvert speed " + verticalspeed  + "      " at (5,6).
    if gear { gear off. set pid:setpoint to pid:setpoint - 1. }
    if brakes { brakes off. set pid:setpoint to pid:setpoint + 1. }
    wait 0.
    if gp = 0 {set runmode to 2.}
    else {set runmode to 1.}
    }
        
    if runmode = 2 { 
    set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).
    lock tAlt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + tAlt.
    lock grav TO SHIP:SENSORS:GRAV:mag.
  
    
    set pid:setpoint to 50.
    lock steering to heading(300,70).
            set pid:setpoint to tAlt.
            set target_twr to pid:update(time:seconds,tAlt).
            if abort { abort off. set runmode to 1.}
            if ag8 { ag8 off. set runmode to 0.}
            print "RUNMODE:    " + runmode + "      " at (5,4).
            print "vb" + VB + "      " at (5,5).
            wait 0.}
}
function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}

if tOld = time:seconds wait 0.03. 
	else wait 0.