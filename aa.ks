  CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal"). 
  lock TARGET TO VESSEL("sBN 1 probe").
  //lock TARGET TO VESSEL("sbn 1").
  set PortList to target:modulesnamed("ModuleDockingNode").
  for Ports in PortList {
  set port to Ports:PART.
	print port:name.
	if port:tag = "TgtDockPort" {
	
	print "Docking port targetted".
	}}

set height to port:bounds:bottomaltradar.


set leg_part to ship:partstagged("hdd")[0].
CLEARSCREEN.
print "dtg:    " +round(dtg(),2) + "      " at (5,4).
 print "bb " + height + "      " at (5,5). 
function dtg {
    local bounds_box is leg_part:bounds.
    return bounds_box:bottomaltradar.}
