set ms to ship:modulesnamed("Moduleroboticservohinge"). for m in ms { m:setfield("locked", false). }. set frontmods to list(). 
set backmods to list(). 
set hinges to ship:partsdubbedpattern("hinge"). for h in hinges if vdot(ship:facing:vector, h:position) > 0 { frontmods:add(h:getmodulebyindex(0)). } else { backmods:add(h:getmodulebyindex(0)).} . function front { parameter angle is 0. for m in frontmods m:setfield("target angle", angle). }. function back
{
parameter angle is 0. for m in backmods m:setfield("target angle", angle). 
}
function setAngle { parameter targetAngle. front(180 + targetAngle). back(180 - targetAngle).} for mod in ship:modulesnamed("ModuleWheelDeployment") mod:setfield("deploy shielded",true). set ms to ship:modulesnamed("Moduleroboticservohinge").
for m in ms
{
    m:setfield("locked", false).
}
set frontmods to list().
set backmods to list().
set hinges to ship:partsdubbedpattern("hinge").
for h in hinges {
    if vdot(ship:facing:vector, h:position) > 0 {
        frontmods:add(h:getmodulebyindex(0)).
    }
    else {
         backmods:add(h:getmodulebyindex(0)).
    } 
}

function front {
    parameter angle is 0.
    for m in frontmods m:setfield("target angle", angle).
}

function back {
     parameter angle is 0.
    for m in backmods m:setfield("target angle", angle).
}

function setAngle {
    parameter targetAngle.
    front(180 + targetAngle).
    back(180 - targetAngle).
}

for mod in ship:modulesnamed("ModuleWheelDeployment") {
    mod:setfield("deploy shielded",true).
}

set pitch_pid to pidloop(kp, ki, kd, -180, 180).
set fincontrol to true.
when true then {
    set pitch to arcsin(facing:vector*up:vector).
    set err to pitch-target_pitch.
    setAngle(pitch_pid:update(time:seconds, err).
    return fincontrol.
}