@LAZYGLOBAL on.
stage.
runpath("0:/lib_quad.ks").
runpath("0:/rs.ks").

set upVector to up:vector.
SET TARGET TO VESSEL("mr").
global velold is velocity:surface. 
local tOld is time:seconds - 0.02.
clearvecdraws().
set gravityMag to body:mu / body:position:sqrmagnitude.
set gravity to -upVector * gravityMag.			
set weightRatio to gravityMag/9.81.
set speedlimit to 0.
global shipfacing is ship:up:vector.
ag1 off. ag2 off. ag10 off.
set massOffset to 0.
set th to 0.
set sampleInterval to 0.2.
set lastTargetCycle to 0.
set doLanding to false.
set rotateSpeed to 0.
list targets in targs.
set target_i to 0.
set tarPart to 0.
set adjustedMass to mass.
set upVector to up:vector.
set gravityMag to SHIP:SENSORS:GRAV:mag.
set gravity to -upVector * gravityMag.
set weightRatio to gravityMag/9.81.
set adjustedMass to mass + massOffset.
set maxThr to ship:maxthrustat(1).
set maxTWR to maxThr / adjustedMass.
set TWR to maxTWR/9.81.
set localTWR to (ship:maxthrustat(1) / adjustedMass)/(body:mu / body:position:mag^2).
set TWR to (ship:maxthrustat(1) / adjustedMass)/9.81.
set v_acc_e_old to 0.
set h_acc_e_old to v(0,0,0).
set v_vel to verticalspeed.
set v_vel_abs to abs(v_vel).
set h_vel to vxcl(upVector,velocity:surface).
set h_vel_mag to h_vel:mag.
global tOld is time:seconds. 
global velold is velocity:surface. 
global dT is 1. 
global tarVelOld is v(0,0,0).
global tHeight is round(min(12,alt:radar + 8),2).
global th is 0.
global posI is 0.
global accI is 0.
global throtOld is 0.
global lastT is time:seconds - 1000.
//global acc_list is list().
//set i to 0. until i = 5 { acc_list:add(0). set i to i + 1. }
global posList is list().
set i to 0. until i = 10 { posList:add(ship:geoposition:terrainheight). set i to i + 1. }
lock throttle to th.
set maxClimbAng to 0.
set h_vel_mag to h_vel:mag.
global thrust_toggle is true. 
set targetGeoPos to ship:geoposition.
set targetString to "LOCAL".
set massOffset to 0.
set charging to false.
set speedlimitmax to 200.
set consoleTimer to time:seconds.
set slowTimer to time:seconds.
set forceUpdate to true.
set desiredHV to v(0,0,0).
set v_acc_dif_average to 0.
set followDist to 0.
set forceDock to false.
set autoLand to true.
set patrolRadius to 10.
set massOffset to 0.
set engineCheck to 0.
set stVec to v(0,0,0).
set focusPos to facing:topvector * 10.
set focusCamPos to facing:topvector * 1.
set vMod to 0.
set fuel to 100.
set gravitymod to 1.2.
set thrustmod to 0.85.
set h_vel to v(0,0,0).
set isDocked to false.
set ipuMod to sqrt(min(2000,config:ipu)/2000). //used to slow things down if low IPU setting 
set camMode to 0.
set destinationLabel to "".
set lastCamActivation to 0.
set showstats to false.
set ang_vel_exponential to 0.5.
global doFlip is false.
set dTavg to 0.02. 
set climbDampening to 1.5.
global terrainChecks is 2.
set availableTWR to ship:maxthrustat(1) / ship:mass.
set engineThrustLimitList to list(0,0,0,0).
set gearMods to ship:modulesnamed("ModuleWheelDeployment").
set upVector to up:vector.
set minAlt to 0.
set minimumDockTime to time:seconds.
set h_acc to v(0,0,0).
set desiredVV to 0.
set angVelAvg to 0.
set ipuMod to sqrt(min(2000,config:ipu)/2000).
set PID_hAcc to pidloop(1.6 * ipuMod,0,0.2 + 1 - weightRatio,0,90).
global PID_vAcc is pidloop(6,0,0.3,-90,90). //pidloop(8,0,0.5,-90,90).   
set PID_vAcc:setpoint to 0.
set maxTWRVec to upVector * maxTWR.
list engines in engs.
local yawRotatrons is list().
local i is 0.
for eng in engs {
	if not(eng:ignition) { eng:activate(). wait 0. }
}
dummy().
initializeTrigger().
flightcontroller().
function dummy {lock throttle to th.}
set runmode to 1.
function initializeTrigger { //called once by quad.ks right before flightcontroller()

	
		set shipFacing to facing:vector.
		set shipVelocitySurface to velocity:surface.}
		


function flightcontroller {
	
	// ########################
	// ### THRUST AND STUFF ###
	// >>
	set totalThrust to v(0,0,0).
	set i to 0. until i = 8 { //engine vecdraws and thrust vector
		set totalThrust to totalThrust + engs[i]:facing:vector * engs[i]:thrust.
		
		//if thMark {
		//	set engineThrustLimitList[i] to engineThrustLimitList[i] * 0.8 + (th * (engs[i]:thrustlimit/100)) * 0.2. 
		//	set vecs[i]:VEC to engs[i]:facing:vector * (engDist * engineThrustLimitList[i]).
		//	set vecs[i]:START to engs[i]:position.
		//}
		set i to i + 1.}}
		set slowTimer to time:seconds.
		set forceUpdate to false.
		
		//max tilt stuff
		set maxNeutTilt to 20.
	    //else set maxNeutTilt to arccos(gravityMag / maxTWR). 
		set maxHA to sin(maxNeutTilt) * maxTWR.
			
until runmode = 0 { 
	if runmode = 1 {
		set angVelAvg to angVelAvg * 0.9 + 0.1 * ship:angularvel:mag.
		print "avg angvel: " + angVelAvg + "      " at (0,9).
		set targetGeoPos to body:geopositionof(ship:position).
		set targetPos to targetGeoPos:position.
		set targetPosXcl to vxcl(upVector, targetPos).
		set v_dif to (shipVelocitySurface - velold)/dT.
		set velold to shipVelocitySurface.
		set h_acc to vxcl(upVector, v_dif).
		set v_acc to vdot(upVector, v_dif).
		set posCheckHeight to min(altitude , ship:geoposition:terrainheight).
		
		if lastT + sampleInterval < time:seconds { //sampleInterval is 0.2 seconds on slower speeds, lower on higher speeds
			set lastT to time:seconds.
			
			

		
		// store / access last 10 highest heights - use highest 
			set posList[posI] to posCheckHeight.
			set highPos to posCheckHeight.
			for p in posList {
				set highPos to max(highPos,p).
			}
			set posI to posI + 1.
			if posI = 10 set posI to 0.
		}
	
		if targetPosXcl:mag < 800 set posCheckHeight to max(posCheckHeight,targetGeoPos:terrainheight).
		
		set tAlt to max(0,max(posCheckHeight, highPos)).
		
		set tAlt to max(minAlt,tAlt + tHeight).
		set altErr to tAlt - altitude. //negative = drone above target height
		set altErrAbs to abs(altErr).
		// <<
		
		// #####################################
		// ### DesiredVV (vertical velocity) ###  
		// >>
		set tilt to vang(upVector,shipFacing).
		
		set acc_freefall to gravityMag * gravitymod. // the larger the modifier the more overshoot & steeper climb
		set acc_maxthr to (maxTWR - gravityMag) * thrustmod. 
		
		if altErr < 0 set max_acc to acc_maxthr.
		else set max_acc to acc_freefall.
		
		//set burn_duration to v_vel_abs/abs(max_acc). //fix  
		//set burn_distance to (v_vel * burn_duration) + (0.5 * max_acc * (burn_duration^2)). //fix  
		
		local driftDist is min(0,(tilt/90) * v_vel) * 0.5. 
		
		set desiredVVOld to desiredVV.
		if altErr > 0 { //below target alt
			set desiredVV to sqrt( 2 * (max(0.01,altErrAbs - v_vel * climbDampening) ) * max_acc ). //sqrt( 2 * (altErrAbs^0.9) * max_acc ).
			set desiredVV to max(desiredVV, tan(maxClimbAng) * h_vel_mag * 1.5). //make sure we climb steep enough 
		}
		else { //above
			//set desiredVV to sqrt( 2 * max(0.1,altErrAbs + driftDist + v_vel*0.16) * max_acc ). 
			//set desiredVV to  sqrt( 2 * (altErrAbs * 0.9) * max_acc ).
			set desiredVV to -desiredVV.
		}
		 if altErrAbs < 1 set desiredVV to altErr*2.
		
		set stVVec to desiredVV - v_vel.
		
		//set dvv_error to vecdraw(v(0,0,0),upVector * stVVec/2,rgba(0.5,0.5,0,1),round(stVVec,1),1,true,0.2). 
		// <<
		
		// ########################################
		// ### DesiredHV (horizontal velocity) ####
		// >>
		
		//set speedlimit to min(speedlimitmax,30*TWR).
		
		

		set desiredHV:mag to min(speedlimit,desiredHV:mag).
		
		set stVec to desiredHV - h_vel.
		set stVec to stVec + max(0,(h_vel_mag - 100) / 50) * vxcl(desiredHV,stVec). //focus on closing down sideslip as velocity goes above 100
		
			
		
		// <<
		
		// ######################################## 
		// ### targetVec & desired acceleration ###
		// >>
		
		set desiredHAcc to stVec.
		set PID_hAcc:maxoutput to maxTWR.
		set desiredHAcc:mag to PID_hAcc:update(time:seconds, -stVec:mag).
		
		set PID_vAcc:maxoutput to maxTWR.
		set PID_vAcc:minoutput to -maxTWR - gravityMag.
		
		set desiredVAccVal to PID_vAcc:update(time:seconds, -stVVec).
		
		
		if desiredVAccVal < -gravityMag { 
			set desiredVAccVal to -gravityMag + (desiredVAccVal + gravityMag)/8. //  /4
		}
		
		set desiredVAcc to upVector * desiredVAccVal.
		
		set verticalAcc to desiredVAcc - gravity.
		set desiredAccVec to desiredHAcc + verticalAcc.
		// need to cap the horizontal part
		if desiredAccVec:mag > maxTWR  {
			if (desiredVAccVal + gravityMag) > maxTWR { //if verticalAcc:mag > maxTWR {
				
				set desiredAccVec to verticalAcc + desiredHAcc * 0.25. 
			}
			else if desiredVAccVal > 0 { //need to cap it, but can still do some of it 
				// total^2 = vert^2 + hor^2
				// hor = sqrt(total^2 - vert^2)
				set desiredHAcc:mag to sqrt((maxTWR^2) - (verticalAcc:mag^2)).
				set desiredAccVec to verticalAcc + desiredHAcc.
			}
		}
			
		set targetVec to desiredAccVec:normalized.
		
	
		
		
		// ### Tilt Cap ###
		
		set targetVecTilt to vang(upVector,targetVec). 
		updateVec(targetVec).
		// <<
		
		// ################
		// ### Throttle ###
		print "maxtwr: " + maxTWRVec + "      " at (4,10).
		
		set curMaxVAcc to vdot(upVector,maxTWRVec).
        print "cur: " + curMaxVAcc + "      " at (5,10).
		set thMid to 1.
		
		//set throttle so desired vertical acc is achieved 
		set th to vdot(upVector,verticalAcc) / max(0.01,curMaxVAcc).
		
		local angleErrorMod is max( 0.1 , vdot(shipFacing,targetVec) ).

		//set th to (desiredAccVec:mag * angleErrorMod) / maxTWR.
		if tilt > 90 set th to max(gravityMag * 2 / maxTWR, (angleErrorMod * desiredHAcc:mag) / maxTWR ).
		
		set th to max(0.01,min(1,th)).
		// << 

		// ######################## 
		// ### engine balancing ###
		// >>



		
		
		
	
		set angVel to ship:angularvel.
		set pitch_vel to -vdot(facing:starvector, angVel).
		set roll_vel to vdot(facing:topvector, angVel).
		
		
		if vang(targetVec,shipFacing) > 15 or max(abs(pitch_vel),abs(roll_vel)) > 0.2 set th to max(th,thMid * 0.5). //give a bit of extra power to steer when needed.
		//set throt to max(0.01,th).
		set pitch_err to vdot(facing:vector, targetVecTop).
	set roll_err to vdot(facing:starvector, targetVecStar).
	
	set pitch_vel_target to pitch_err * 2.
	set roll_vel_target to roll_err * 2.
	set pitch_vel to -vdot(facing:starvector, ship:angularvel).
	set roll_vel to vdot(facing:vector, ship:angularvel).
global PID_pitch is pidloop(50, 0, 0.3, -100, 100). //(75, 0, 2, -100, 100).  
global PID_roll is pidloop(50, 0, 0.3, -100, 100). //(75, 0, 2, -100, 100).
global PID_yaw is pidloop(50, 0, 0.3, -100, 100). //(75, 0, 2, -100, 100).
		
		set PID_pitch:setpoint to pitch_vel_target.
		set pitch_distr to PID_pitch:update(time:seconds, pitch_vel) / th. // / throt.
		
		set PID_roll:setpoint to roll_vel_target.
		set roll_distr to PID_roll:update(time:seconds, roll_vel) / th. // / throt.
		
		
		//since steering reduces effective thrust, up the throttle to match the intended thrust
		local thrustDuringSteering is (400 - min(100,abs(pitch_distr)) - min(100,abs(roll_distr)))/400.
		set th to min(1,th / thrustDuringSteering).
		
		
		// ######################
		// ### Vecdraws mmMMm ###
		// >>
		
		
		//if miscMark set vecs[markAcc]:VEC to v_dif/2.
	
		
		//set vecs[markStar]:vec to facing:starvector*4.
		//set vecs[markTop]:vec to facing:topvector*4.
		//set vecs[markFwd]:vec to facing:forevector*4.
	
		
		// #############################
		// ### Yaw rotatron controls ###
		// >>
		if yawControl {
			set yawAngVel to vdot(shipFacing, angVel).
			if ship:control:pilotroll > 0 set targetRot to 6 - th * 4.
			else if ship:control:pilotroll < 0 set targetRot to -6 + (th * 4).
			else {
				if abs(yawAngVel) > 0.002 { 
					set targetRot to min(5,abs(yawAngVel) * 8 * (5/TWR) * (1.25 - th)).   
					if yawAngVel > 0 set targetRot to -targetRot.
				}
				else set targetRot to 0.
			}
			
			for s in yawRotatrons {
				s:moveto(targetRot,1).
			}
			
		} // <<
	}
	
	//keep the thing running at 25hz
	if tOld = time:seconds wait 0.03. 
	else wait 0.
}


function updateVec {
	local markTar is vecs_add(v(0,0,0),v(0,0,0),cyan,"",0.2).
	parameter targetVec.
	set targetVecStar to vxcl(facing:vector, targetVec).
	set targetVecTop to vxcl(facing:starvector, targetVec).
		set vecs[markTar]:start to ship:geoposition:position.
		global pList is list().
		for pm in pList {
			set vecs[pm]:show to false.
		}
	}