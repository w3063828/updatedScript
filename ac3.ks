core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
local target_twr is 0.
lock g to body:mu / ((ship:altitude + body:radius)^2).
lock maxtwr to ship:maxthrust / (g * ship:mass).
lock throttle to min(target_twr / maxtwr, 1).
lock steering to lookdirup(up:vector, facing:topvector).
set ship:control:pilotmainthrottle to 0.
SET TALT TO 45.
clearscreen.
set target_twr to maxtwr.
wait until alt:radar > 100.


global pid is pidloop(1.81818181818182, 0.456998571460453, 0.521911117675102, 0, maxtwr).

until ship:verticalspeed < 0 {
  set pid:setpoint to ((talt-dtg())/2).  
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.01.
     print "pid set point:    " + PID:SETPOINT + "      " at (5,3). 
     print "dtg:    " +round(dtg(),2) + "      " at (5,4).
}



until ship:status = "Landed" {
  set pid:setpoint to ((talt-dtg())/8).    
  set pid:maxoutput to maxtwr.
  set target_twr to pid:update(time:seconds, ship:verticalspeed).
  wait 0.01.
    print "pid set point:    " + PID:SETPOINT + "      " at (5,3). 
     print "dtg:    " +round(dtg(),2) + "      " at (5,4).
}

function dtg {
 SET GG TO 0.
 LOCK GG TO ship:bounds:bottomaltradar.
   return GG.
} 
