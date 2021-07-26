runpath("0:/knu.ks"). local genetics is import("genetics.ks").

genetics["seek"](lex(
  "file", "0:/vd.json",
  "autorevert", true,
  "arity", 3,
  "size", 40,
  "fitness", fitness_fn@
)).

function fitness_fn {
  parameter k.
  local pid_throttle is 0.
  lock throttle to pid_throttle.
  lock tps to pid_throttle.
  lock steering to up.
  set ship:control:pilotmainthrottle to 0.
  stage.
  rcs on.
  toggle gear.
  local pid is pidloop(k[0], k[1], k[2], 0, 10).
  local last_time is time:seconds.
  local total_error is 0.
  set timer to 57.
  set pid:setpoint to 13.
  set oldT to time:seconds - 0.02.
  set oldV to tps.
  wait 0.4.
  local dt is time:seconds - oldT.
	set throt_error to 0.
  set TxE to 0.
  clearscreen. 
  local start_time is time:seconds.
  until time:seconds > start_time + timer {
    
    		set oldT to time:seconds.
				set accel to abs(tps-oldV)/dt.
				set oldV to tps.
    if time:seconds > start_time + 30 set pid:setpoint to 26.
    if time:seconds > start_time + 45 set pid:setpoint to 15.	
    print "kP: " + k[0] + "      " at (5,2). 
    print "kI: " + k[1] + "      " at (5,3).
    print "kD: " + k[2] + "      " at (5,4).
    print "Acumulated error:    " + round(total_error,2) + "      " at (5,6).
    print "alt set point:    " + pid:setpoint + "      " at (5,7).
    print "dtg:    " +round(dtg(),2) + "      " at (5,8).
    print "current erorr:    " + round(abs(dtg() - pid:setpoint),2) + "      " at (5,9).
    print "throtle:    " + round(pid_throttle,2) + "      " at (5,10).
    print "throtle_dt:    " + round(accel,2) + "      " at (5,11).
    set pid_throttle to pid:update(time:seconds, dtg()).
    set total_error to total_error + abs(pid:error * (time:seconds - last_time)).
    set throt_error to throt_error + accel.
    set TxE to total_error + (throt_error / 200).
    set last_time to time:seconds.
    print "acc_throt:    " + round(throt_error,2) + "      " at (5,12).
    print "modified_error:    " + round(TxE,2) + "      " at (5,13).
  
    
    
  }

  return gaussian(TxE, 0, 250).
}

function gaussian {
  parameter value, targetq, width.
  return constant:e^(-1 * (value-targetq)^2 / (2*width^2)).
}
  function dtg {
  return altitude - body:geopositionOf(ship:position):terrainHeight.
}

  