//input parameters
params ["_VIP", ["_player", player]];
//if the script was called by AddAction, we need to remove the action.
//But there is nothing to remove if it was called by other means.

_VIP switchMove "Acts_ExecutionVictim_Unbow";
_VIP allowDamage true;

["FEX_task_preVIP","SUCCEEDED"] call BIS_fnc_taskSetState;
sleep 1;
[player, "FEX_task_VIP", ["Transport the VIP safely to a specific place", "Escort VIP", ""], [5002.69,5850.39,0], "ASSIGNED", 2, true] call BIS_fnc_taskCreate;
sleep 4.5;


//method 2 - VIP goes on their own
_VIP moveTo (position myHeli);
_VIP assignAsCargo myHeli;
[_VIP] orderGetIn true;


/*
//method 3 - VIP follows the player, but isn't part of the group
while {alive _VIP} do {
sleep 6;
_randomizedPosition = [position player, 10] call BIS_fnc_randomPosTrigger;
_VIP moveTo _randomizedPosition;
};
*/

_0 = [] execVM "countdown.sqf";

_VIP addEventHandler ["Killed",{
	_0 = [] execVM "failure.sqf";
}];
