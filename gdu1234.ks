runpath("0:/knu.ks"). local genetics is import("genetics.ks").
CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
genetics["seek"](lex(
  "file", "0:/v7.json",
  "autorevert", true,
  "arity", 3,
  "size", 20,
  "fitness", fitness_fn@
)).

function fitness_fn {
  parameter k.
 lock GRAV to body:mu / ((ship:altitude + body:radius)^2).
 set TARGET TO VESSEL("FG12"). 
 set gp to SHIP:BODY:GEOPOSITIONOF(TARGET:POSITION).

  LOCAL cPitch 		IS 0.
  LOCAL bPitch 		IS 0.
  LOCAL dPitch 		IS 0.
  global cAltitude 	IS 1000.
  LOCAL cPitch 		IS 0.
  LOCAL SPDLMT      IS 450.
lock throttle TO (-1 * ((SHIP:AIRSPEED-spdlmt)/spdlmt)).

stage.
LOCK STEERING TO HEADING(TARGET:HEADING,math()).
wait until altitude > 950.
  local pid is pidloop(1.8282828283, k[1], k[2], 15, -15).//k[0]
  local last_time is time:seconds.
  local total_error is 0.
  set timer to 60.
  lock tps to ship:AIRSPEED.
  set oldT to time:seconds - 0.02.
  set oldV to tps.
  wait 0.4.

  local dt is time:seconds - oldT.
	set throt_error to 0.
  set TxE to 0.
  clearscreen. 
  local start_time is time:seconds.
  until vb < 800 {
    set PID:setpoint to cAltitude.
 
    		set oldT to time:seconds.
				set accel to abs(tps-oldV)/dt.
				set oldV to tps.
    if time:seconds > start_time + 45 set cAltitude to 850.
    //if time:seconds > start_time + 90 set pid:setpoint to 950.
    //if time:seconds > start_time + 120 set pid:setpoint to 338.	
    print "acc_throt:    " + round(throt_error,2) + "      " at (5,12).
    print "modified_error:    " + round(TxE,2) + "      " at (5,13).
    print "kP: " + k[0] + "      " at (5,2). 
    print "kI: " + k[1] + "      " at (5,3).
    print "kD: " + k[2] + "      " at (5,4).
    print "Acumulated error:    " + round(total_error,2) + "      " at (5,6).
    print "alt set point:    " + pid:setpoint + "      " at (5,7).
    print "dtg:    " +round(dtg(),2) + "      " at (5,8).
    print "current erorr:    " + round(abs(cAltitude - ship:altitude),2) + "      " at (5,9).
    print "pitch:    " + round(pitch_for(),4) + "      " at (5,10).
    print "setpoint" + pid:setpoint + "      " at (5,11).
    //print "throtle_dt:    " + round(accel,2) + "      " at (5,11).
  lock cPitch TO MATH().
  lock dpitch to (cPitch + bPitch).
  set PID:setpoint to MATH1.
  lock bPitch TO PID:UPDATE(time:seconds, ship:verticalspeed).
  LOCK STEERING TO HEADING(TARGET:HEADING,dpitch).
    set total_error to total_error + abs(pid:error * (time:seconds - last_time)).
    set throt_error to throt_error + accel.
    set TxE to total_error + (throt_error / 200).
    set last_time to time:seconds.
    
   
  }

  return gaussian((TxE/100), 0, 250).
}

function gaussian {
  parameter value, targetq, width.
  return constant:e^(-1 * (value-targetq)^2 / (2*width^2)).
}
  function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}

  FUNCTION math {
  lock mathResult to ((cAltitude-altitude)/15).
  RETURN mathResult.
}

function pitch_for {
  parameter ves is ship,thing is "default".

  local pointing is ves:facing:forevector.
  if not thing:istype("string") {
    set pointing to type_to_vector(ves,thing).
  }

  return 90 - vang(ves:up:vector, pointing).
}
 FUNCTION math1 {
  lock mathResult to ((cAltitude-altitude)/10).
  RETURN mathResult.}
  
  function VB{
   return vxcl(up:vector,gp:POSITION):mag.

}