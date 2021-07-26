lock GRAV to body:mu / body:position:sqrmagnitude.
  lock throttle to (2* Ship:Mass * GRAV / ship:availablethrust).
  lock maxtwr to ship:maxthrust / (GRAV * ship:mass).
  global pid is pidloop(1.81818181818182, 0.456998571460453, 0.521911117675102, 0, maxtwr).
  global tOld is time:seconds - 0.02.
  gear off.
  global target_twr is 0.
  global desiredFore IS 0.
  global desiredstar IS 0.
  global desiredtop  IS 0.
  global shipFacing IS ship:facing.
  global axisSpeed IS axis_speed().
  global RCSdeadZone IS 0.05.
  global PIDtop is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDfore is pidloop(4, 0.1, 0.1, -10, 10).
  global PIDstar is pidloop(4, 0.1, 0.1, -10, 10).
  //global pid is pidloop(2.72727272727273, 2.20912375148098, 0.24925924297199, 0, maxtwr).
  global last_time is time:seconds.
  global total_error is 0.
  LOCK FD TO talt.
  lock FC to AC().
  set height to 45.
  lock talt2 to max(gp:terrainheight,ship:geoposition:terrainheight) + talt.
  lock maxAcc to ship:availablethrust / mass.
  lock throttle to (GRAV / maxAcc + (talt2 - min(talt2 + 30,apoapsis)) / 100 - verticalspeed / 50) / vdot(up:vector,facing:vector).
   wait 1.5.
