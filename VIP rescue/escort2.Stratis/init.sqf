//Create the VIP
//method 2 - create the unit

"C_Man_UtilityWorker_01_F" createUnit [[5035.13,5874.33,0], createGroup civilian, "myVIP = this", 0.5, "PRIVATE"];
_myVIP = myVIP;
_myVIP setPos [5035.13,5874.33,0];

sleep 3;

_myVIP switchmove "Acts_ExecutionVictim_Loop";
_myVIP allowDamage false;
_myVIP setVariable ["FEX_VIP", true];

[player, "FEX_task_preVIP", ["Rescue a VIP from enemy base", "Rescue VIP", ""], position _myVIP, "ASSIGNED", 2, true] call BIS_fnc_taskCreate;


//method 3 - gesture
player addEventHandler ["AnimChanged", {
	params ["_unit", "_anim"];
	//_myVIP = _unit getVariable "myVIP";
	_allowedAnims = ["amovpercmstpslowwrfldnon_salute","amovpercmstpsraswrfldnon_salute"];
	if ((toLower _anim in _allowedAnims) && _unit distance myVIP <= 10) then {
		_0 = [myVIP] execVM "rescueVIP.sqf";
		_unit removeEventHandler ["AnimChanged",_thisEventHandler];
	};
}];

//create heli on a designated position
_heliPos = [5002.69,5850.39,0];
_helipad = createVehicle ["Land_HelipadSquare_F", _heliPos, [], 0, "NONE"];
_scriptHeli = createVehicle ["B_Heli_Light_01_F", _heliPos, [], 0, "NONE"];
//create pilot for the heli, move him inside
_heliPilot = (createGroup west) createUnit ["B_Pilot_F", position _helipad, [], 0, "FORM"];
_heliPilot assignAsDriver _scriptHeli;
_heliPilot moveInDriver _scriptHeli;
//disable damage on both of them
_scriptHeli allowDamage false;
_heliPilot allowDamage false;
//lock the heli for the player
_scriptHeli lock 3;
//set the heli as captive (enemies won't target it) and careless behavior (it won't target enemies)
_scriptHeli setCaptive true;
_heliPilot setBehaviourStrong "CARELESS";
_scriptHeli setVehicleAmmo 0;

//prepare for take-off
_scriptHeli engineOn true;
_scriptHeli land "GET IN";
_scriptHeli FlyInHeight 0;
myHeli = _scriptHeli;


//add the EH to VIP
_myVIP addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	if (_vehicle == myHeli) then 
	{
		_0 = [_vehicle, _unit] execVM "takeoff.sqf";
	};
}];