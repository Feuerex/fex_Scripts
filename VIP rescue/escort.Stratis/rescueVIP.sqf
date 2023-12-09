//input parameters
params ["_VIP", ["_player", player], ["_actionID", -1]];
//if the script was called by AddAction, we need to remove the action.
//But there is nothing to remove if it was called by other means.
if (_actionID != -1) then 
{
	_VIP removeAction _actionID;
};
_VIP switchMove "Acts_ExecutionVictim_Unbow";
_VIP allowDamage true;

["FEX_task_preVIP","SUCCEEDED"] call BIS_fnc_taskSetState;
sleep 1;
[player, "FEX_task_VIP", ["Transport the VIP safely to a specific place", "Escort VIP", ""], [5002.69,5850.39,0], "ASSIGNED", 2, true] call BIS_fnc_taskCreate;
sleep 4.5;

//method 1 - VIP joins player's group
[_VIP] joinSilent player; 
_VIP groupChat "Following";

//add event handlers
//I have added a condition in one of helicopter waypoints - this event handler is not necessary, but functions the exact same
/*
myHeli addEventHandler ["GetIn", { 
	 params ["_vehicle", "_role", "_unit", "_turret"]; 
	 _0 = [_vehicle, _unit] execVM "takeoff.sqf";
}];
*/

_VIP addEventHandler ["Killed",{
	_0 = ["VIP is down, abort the mission."] execVM "failure.sqf";
}];

//start the timer
_0 = [] spawn {
	_timeElapsed = 0;
	//wait 30 minutes for the task to fail
	while {("FEX_task_VIP" call BIS_fnc_taskState) != "SUCCEEDED" && _timeElapsed < 360} do {
		sleep 5;
		_timeElapsed = _timeElapsed + 1;
	};
	_0 = ["We failed to rescue them in time, aborting mission"] execVM "failure.sqf";
};


