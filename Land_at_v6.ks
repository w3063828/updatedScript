//TODO: re-add in hillclimb solution for impact for when in hyperbolic orbits
PARAMETER landingTar,margin IS 100.
RUNONCEPATH("0:/lib_geochordnate.ks").
RUNONCEPATH("0:/lib_rocket_utilities").
RUNONCEPATH("0:/lib_mis_utilities.ks").
//LOCAl logPath IS PATH("0:/log_land_at_v6.txt").
//IF EXISTS(logPath) { DELETEPATH(logPath). }
//IF NOT EXISTS(logPath) { LOG "Cycles,Time" TO logPath. }

//control_point().
//WAIT UNTIL active_engine().
//RCS OFF.
//LOCAL ipuBackup IS CONFIG:IPU.
//SET CONFIG:IPU TO 2000.
CLEARSCREEN.
SET TERMINAL:WIDTH TO 55.
SET TERMINAL:HEIGHT TO 15.
LOCAL landingData IS mis_types_to_geochordnate(landingTar).
LOCAL landingChord IS landingData["chord"].

IF landingChord:ISTYPE("geocoordinates") {

LOCAL nodeStartTime IS TIME:SECONDS + (SHIP:ORBIT:PERIOD / 8).
LOCAL localBody IS SHIP:BODY.
LOCAL orbitalSpeed IS SQRT(localBody:MU / SHIP:ORBIT:SEMIMAJORAXIS).
LOCAL maxDv IS orbitalSpeed.
LOCAL marginHeight IS margin.// + margin_error(orbitalSpeed).
GLOBAL varConstants IS LEX(
	"landingChord",landingChord,
	"marginHeight",marginHeight,
	"landingAlt",marginHeight + landingChord:TERRAINHEIGHT,
	"initalStep",orbitalSpeed/10,
	"peTarget",(localBody:RADIUS / -1.5),
	"mode",0,
	"manipList",LIST("eta","pro","nor","rad"),
	"maxDv",maxDv
).
LOCAL refineDeorbit IS SHIP:ORBIT:PERIAPSIS < 0.

IF refineDeorbit {
	SET varConstants["mode"] TO 1.
	SET nodeStartTime TO (impact_ETA(ta_to_ma(SHIP:ORBIT:ECCENTRICITY,SHIP:ORBIT:TRUEANOMALY),SHIP:ORBIT,varConstants["landingAlt"]) / 2 + TIME:SECONDS).
	varConstants["manipList"]:REMOVE(0).
} ELSE IF ETA:APOAPSIS < 600 {
	SET nodeStartTime TO nodeStartTime + (SHIP:ORBIT:PERIOD / 4).
}
clear_all_nodes().
LOCAL baseNode IS NODE(nodeStartTime,0,0,0).
ADD baseNode.
IF varConstants["mode"] = 0 { periapsis_manipulaiton(NEXTNODE). }
LOCAL scored IS score(NEXTNODE).
LOCAL hillValues IS LEX("score",scored["score"],"stepVal",varConstants["initalStep"],"dist",scored["dist"]).
LOCAL shipISP IS isp_calc().
LOCAL timeStart IS TIME:SECONDS.
LOCAL count IS 0.
LOCAL close IS FALSE.
LOCAL done IS FALSE.
delta_time().//first call of delta_time function to set initial start time
UNTIL close{
	IF done AND (varConstants["mode"] = 0) {
		SET done TO FALSE.
		SET nodeStartTime TO nodeStartTime + (SHIP:ORBIT:PERIOD / 4).
		SET baseNode TO NODE(nodeStartTime,0,0,0).
		clear_all_nodes().
		ADD baseNode.
		periapsis_manipulaiton(NEXTNODE).
		LOCAL scored IS score(NEXTNODE).
		SET hillValues["stepVal"] TO varConstants["initalStep"].
		SET hillValues["score"] TO scored["score"].
	}
	LOCAL stepMod IS 0.
	UNTIL done {
		LOCAL stepVal IS hillValues["stepVal"].
		LOCAL anyGood IS FALSE.
		LOCAL bestNode IS LIST(hillValues["score"],"no",0,hillValues["dist"]).
		FOR manipType IN  varConstants["manipList"] {
			FOR stepTmp IN LIST(stepVal,-stepVal) {

				node_set(NEXTNODE,manipType,stepTmp).
				LOCAL scoreNew IS score(NEXTNODE).
				LOCAL DVcheck IS NEXTNODE:DELTAV:MAG < varConstants["maxDv"].
				node_set(NEXTNODE,manipType,-stepTmp).
				LOCAL nodeTmp IS LIST(scoreNew["score"],manipType,stepTmp,scoreNew["dist"]).

				IF DVcheck AND bestNode[0] > nodeTmp[0] {
					SET bestNode TO nodeTmp.
					SET anyGood TO TRUE.
					BREAK.
				}
			}
			IF anyGood { BREAK. }
		}

		IF anyGood {
			node_set(NEXTNODE,bestNode[1],bestNode[2]).
			SET stepMod TO MAX(stepMod - 0.005,0).
			SET hillValues["score"] TO bestNode[0].
			SET hillValues["dist"] TO bestNode[3].
			SET hillValues["stepVal"] TO varConstants["initalStep"] / (10^stepMod).
			SET count TO count + 1.
			CLEARSCREEN.
			PRINT "Target Coordinates: (" + ROUND(varConstants["landingChord"]:LAT,2) + "," + ROUND(varConstants["landingChord"]:LNG,2) + ")".
			PRINT "Score: " + ROUND(hillValues["score"]).
			PRINT "Dist:  " + ROUND(hillValues["dist"]).
			PRINT "Pedif: " + ROUND(NEXTNODE:ORBIT:PERIAPSIS - varConstants["peTarget"]).
			PRINT " ".
			PRINT "   Step Size: " + ROUND(hillValues["stepVal"],3).
			PRINT "  Total Time: " + ROUND(TIME:SECONDS - timeStart,3).
			PRINT "   Step Time: " + ROUND(delta_time(),2).
			PRINT "Average Time: " + ROUND((TIME:SECONDS - timeStart) / count,3).
		} ELSE {
			SET stepMod TO stepMod + 1.
			SET hillValues["stepVal"] TO varConstants["initalStep"] / (10^stepMod).
		}
		SET done TO (hillValues["stepVal"] < 0.001) OR (NOT refineDeorbit AND (NEXTNODE:ETA < (120 + burn_duration(shipISP,NEXTNODE:DELTAV:MAG)))).
	}
	SET close TO ((hillValues["dist"] < 2000) AND (NEXTNODE:DELTAV:MAG < varConstants["maxDv"])) OR (varConstants["mode"] = 1).
}
//LOG count + "," + ROUND(TIME:SECONDS - timeStart,2) TO logPath.
//IF NOT EXISTS("0:/land_at_log.txt") { LOG "avrage time" TO "0:/land_at_log.txt". }
//LOG ROUND((TIME:SECONDS - timeStart) / count,4) TO "0:/land_at_log.txt".
}
//SET CONFIG:IPU TO ipuBackup.

//end of core logic start of functions
FUNCTION node_set { //manipulates the targetNode in one of 4 ways depending on manipType for a value of stepVal
	PARAMETER targetNode,manipType,stepVal.
	IF manipType = "eta" { SET targetNode:ETA TO targetNode:ETA + stepVal * 2. } ELSE {
	IF manipType = "pro" { SET targetNode:PROGRADE TO targetNode:PROGRADE + stepVal. } ELSE {
	IF manipType = "nor" { SET targetNode:NORMAL TO targetNode:NORMAL + stepVal. } ELSE {
	IF manipType = "rad" { SET targetNode:RADIALOUT TO targetNode:RADIALOUT + stepVal. }}}}
}

FUNCTION score { //returns the score of the node
	PARAMETER targetNode.
	LOCAL nodeOrbit IS targetNode:ORBIT.
	LOCAL peDiff IS ABS(nodeOrbit:PERIAPSIS - varConstants["peTarget"]).
	LOCAL PEweight IS 1 / 3.
//	IF varConstants["mode"] = 1 { SET PEweight TO 1 / 2. }
	IF (nodeOrbit:PERIAPSIS < 0) AND (nodeOrbit:TRANSITION <> "escape") {
		LOCAL nodeUTs IS targetNode:ETA + TIME:SECONDS.
		LOCAL nodeToImpact IS impact_ETA(nodeOrbit:MEANANOMALYATEPOCH,nodeOrbit,varConstants["landingAlt"]).
		LOCAL impactTime IS nodeToImpact + nodeUTs.

		LOCAL dist IS dist_between_coordinates(varConstants["landingChord"],ground_track(POSITIONAT(SHIP,impactTime),impactTime)).
		LOCAL scored IS dist + peDiff * PEweight.
		IF targetNode:ISTYPE("node") { SET scored TO scored + (targetNode:DELTAV:MAG * 6). }
		RETURN LEX("score",scored,"dist",dist).
	} ELSE {
		LOCAL dist IS SHIP:BODY:RADIUS * 2 * CONSTANT():PI.
		//LOCAL peDiff IS targetNode:ORBIT:PERIAPSIS - varConstants["peTarget"].
		LOCAL scored IS dist + peDiff * PEweight.
		RETURN LEX("score",scored,"dist",dist).
	}
}

FUNCTION impact_ETA {//returns the seconds between maDeg1 and terrain impact
	PARAMETER maDeg1,orbitIn,impactAlt.
	LOCAL ecc IS orbitIn:ECCENTRICITY.
	LOCAL orbPer IS orbitIn:PERIOD.
	LOCAL sma IS orbitIn:SEMIMAJORAXIS.
	LOCAL rad IS varConstants["landingAlt"] + orbitIn:BODY:RADIUS.
	LOCAL taOfAlt IS 360 - ARCCOS((-sma * ecc ^2 + sma - rad) / (ecc * rad)).
	
	LOCAL maDeg2 IS ta_to_ma(ecc,taOfAlt).
	
	LOCAL timeDiff IS orbPer * ((maDeg2 - maDeg1) / 360).
	
	RETURN MOD(timeDiff + orbPer, orbPer).
}

FUNCTION ta_to_ma {//converts a true anomaly(degrees) to the mean anomaly (degrees), also found in lib_orbital_math, NOTE: only works for non hyperbolic orbits
	PARAMETER ecc,taDeg.
	LOCAL eaDeg IS ARCTAN2( SQRT(1-ecc^2)*SIN(taDeg), ecc + COS(taDeg)).
	LOCAL maDeg IS eaDeg - (ecc * SIN(eaDeg) * CONSTANT:RADtoDEG).
	RETURN MOD(maDeg + 360,360).
}

FUNCTION periapsis_manipulaiton {//manipulates the PE after node to be below the peTarget
	PARAMETER targetNode.
	LOCAL peTarget IS varConstants["peTarget"].
	LOCAL stepVal IS varConstants["initalStep"].
	LOCAL stepMod IS 10.
	LOCAL lowerLimit IS peTarget - 1.
	LOCAL upperLimit IS peTarget + 1.
	LOCAL done IS FALSE.
	UNTIL done{
		IF targetNode:ORBIT:PERIAPSIS > upperLimit {
			SET targetNode:PROGRADE TO targetNode:PROGRADE - stepVal.
			IF targetNode:ORBIT:PERIAPSIS < lowerLimit {
				SET stepVal TO stepVal / stepMod.
				SET targetNode:PROGRADE TO targetNode:PROGRADE + stepVal.
			}
		} ELSE IF targetNode:ORBIT:PERIAPSIS < lowerLimit {
			SET targetNode:PROGRADE TO targetNode:PROGRADE + stepVal.
			IF targetNode:ORBIT:PERIAPSIS > upperLimit {
				SET stepVal TO stepVal / stepMod.
				SET targetNode:PROGRADE TO targetNode:PROGRADE - stepVal.
			}
		}
		SET done TO (targetNode:ORBIT:PERIAPSIS > lowerLimit) AND (targetNode:ORBIT:PERIAPSIS < upperLimit).
	}
}

FUNCTION margin_error { //approximates vertical drop needed for the craft to stop
	PARAMETER orbitalSpeed.
	//LOCAL velSpeed IS ((orbitalSpeed^2)/2)^0.5.
	//LOCAL srfGrav IS ((SHIP:BODY:MU / (SHIP:BODY:RADIUS ^ 2)) + (SHIP:BODY:MU / (SHIP:ORBIT:SEMIMAJORAXIS ^ 2))) / 2.
	LOCAL srfGrav IS SHIP:BODY:MU / (SHIP:BODY:RADIUS ^ 2).
//	LOCAL orbGrav IS SHIP:BODY:MU / (SHIP:ORBIT:SEMIMAJORAXIS ^ 2).
	LOCAL burnTime IS 0.
	LOCAL burnTimePre IS 0.
	LOCAL shipISP IS isp_calc().

	UNTIL FALSE {
		//SET surBurnTime TO burn_duration(shipISP,(SQRT((burnTime * srfGrav + velSpeed) ^ 2) + velSpeed ^ 2)).
		//LOCAL orbBurnTime IS burn_duration(shipISP,SQRT(((burnTime * orbGrav + velSpeed) ^ 2) + velSpeed ^ 2)).
		SET burnTime TO burn_duration(shipISP,SQRT(((burnTime * srfGrav) ^ 2) + orbitalSpeed ^ 2)).
		//SET burnTime TO burn_duration(shipISP,(burnTime * srfGrav + orbitalSpeed)).
		IF ABS(burnTime - burnTimePre) < 0.01 { RETURN (1/30 * srfGrav * burnTime^2). }// - (1/2 * orbGrav * burnTime^2). }
//		IF ABS(burnTime - burnTimePre) < 0.01 { RETURN (srfGrav * (burnTime / 2)^2). }// - (1/2 * orbGrav * burnTime^2). }
		SET burnTimePre TO burnTime.
	}
}