 core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
clearscreen.
set KKK to time:seconds.
local hover_pid is pidloop(2.7, 4.4, 0.12, 0, 1).
lock GRAV to body:mu / body:position:sqrmagnitude.
toggle Ag3.  
toggle ag5.
  wait 10.
toggle Ag6.  
  wait 10.
set runmode to 1.
until runmode = 0 {
if runmode =1 { 
  local t is 0.
  lock steering to up.
  lock throttle to t.
 set t to hover(30). wait 0.
 print "t:    " + t + "      " at (5,5). 
}

function hover {
  parameter setpoint.
  set hover_pid:setpoint to setpoint.
  set hover_pid:maxoutput to availtwr().
  return min(
    hover_pid:update(kkk, ship:verticalspeed) /
    max(cos(vang(up:vector, ship:facing:vector)), 0.0001) /
    max(availtwr(), 0.0001),
   
      1
  ).
}

function availtwr {
  return  MAX( 0.001, (MAXTHRUST*0.97) / (MASS*grav1)).
}}
