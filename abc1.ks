local hover_pid is pidloop(0.51543463882990181, 0.3734305021353066, 0.52321681985631585, 0,1).
SET start_time TO time:seconds.
lock grav1 to body:mu / body:position:sqrmagnitude.
main().



function main{
until time:seconds > start_time + 30 {
  hover(15).}
runpath("0:/a3.ks").}

function hover {
  parameter setpoint.
  set hover_pid:setpoint to setpoint.
  set hover_pid:maxoutput to availtwr().
  return min(
    hover_pid:update(time:seconds, ship:verticalspeed) /
    max(cos(vang(up:vector, ship:facing:vector)), 0.0001) /
    max(availtwr(), 0.0001),
    1
  ).
}

function availtwr {
  return  MAX( 0.001, MAXTHRUST / (MASS*grav1)).
}
