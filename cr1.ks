stage.
lock throttle to 1.
wait 1.
set gp to latlng(-0.09679,-79.22900). //VAB
//LOCK GRAV TO SHIP:SENSORS:GRAV:mag.
lock grav to body:mu / body:position:sqrmagnitude.
lock maxAcc to ship:availablethrust / mass.
local target_twr is 0.
lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
lock throttle to min(target_twr / maxtwr, 1).
//local pid is pidloop(1.81818181818182, 0.257861553891434, 0.924963925825365, 0, maxtwr).
local pid is pidloop(1.81818181818182, 4.05284576246403, 0.0588506568436101, 0, maxtwr).
//sas on.
//rcs on.

local speedlimit is 45.
//sas off.
gear on.
set tAlt to 180.

set runmode to 1.


until runmode = 0 {
if runmode =1 {
    set RV to vxcl(up:vector, gp:position / 8 - velocity:surface) / 2.5. //relative velocity vector, we base our steering on this
    set RV:mag to min(8,RV:mag). //just for safety 
    
    until ship:status:contains("landed") {
       set pid:setpoint to math().
       set target_twr to pid:update(time:seconds, ship:verticalspeed).
       set pid:maxoutput to maxtwr.
        if vb < 10 set tAlt to max(1,tAlt - 2). //we're above target area so start descending
        if Ship:groundspeed > speedlimit {set steering to up.}
        if Ship:groundspeed < (speedlimit - 5 ) { lock steering to lookdirup(up:vector * 45 + RV, facing:topvector).}
        print "VB:    " + VB + "      " at (5,5).
        
        print "setpoint" +round(pid:setpoint,2) + "      " at (5,9).
        print "dtg:    " +round(dtg(),2) + "      " at (5,8).
        print "current erorr:    " + round(abs(dtg() - talt),2) + "      " at (5,7).
        print "math" + round(math(),2) + "      " at (5,10).
     
    }
  


//landing throttle shutdownwww
when ship:status:contains("landed") then {
    lock throttle to 0. 
    set runmode to 0.
}}}

function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}

FUNCTION math {
  
  lock mathResult to ((talt-dtg())/4).
  RETURN mathResult.
}
function dtg {
  lock mathResult0 to (altitude - talt).
  lock mathResult1 to (altitude - ship:geoposition:terrainheight).
  return min(mathResult0,mathResult1).
}
 