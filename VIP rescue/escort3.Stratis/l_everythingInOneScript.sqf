_myVIP = (createGroup civilian) createUnit ["C_Man_UtilityWorker_01_F",[5035.13,5874.33,0], [], 0, "CAN_COLLIDE"];
_myVIP setPos [5035.13,5874.33,0];

sleep 3;

_myVIP switchmove "Acts_ExecutionVictim_Loop";
_myVIP allowDamage false;
_myVIP setVariable ["FEX_VIP", true];

[player, "FEX_task_preVIP", ["Rescue a VIP from enemy base", "Rescue VIP", ""], position _myVIP, "ASSIGNED", 2, true] call BIS_fnc_taskCreate;

_myVIP addaction ["Get", {
	_0 = _this spawn 
	{
	//input parameters
	params ["_VIP", ["_player", player], ["_actionID", -1]];
	//if the script was called by AddAction, we need to remove the action.
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

	[_VIP] joinSilent player; 
	_VIP groupChat "Following";
	
	_0 = [] spawn 
	{
		_timeElapsed = 0;
		while {("FEX_task_VIP" call BIS_fnc_taskState) != "SUCCEEDED" && _timeElapsed < 3.60} do 
		{
			sleep 5;
			_timeElapsed = _timeElapsed + 1;
		};
		
		//make sure to only fail if the task hasn't been completed or failed by other means
		if (("FEX_task_VIP" call BIS_fnc_taskState) != "SUCCEEDED" && ("FEX_task_VIP" call BIS_fnc_taskState) != "FAILED") then 
		{
			player sideChat "We failed to rescue them in time, aborting mission";

			sleep 2;
			
			["FEX_task_VIP","FAILED"] call BIS_fnc_taskSetState;
		};
	};

	_VIP addEventHandler ["Killed",
	{
		_0 = [] spawn 
		{
			if ("FEX_task_VIP" call BIS_fnc_taskState != "SUCCEEDED" && "FEX_task_VIP" call BIS_fnc_taskState != "FAILED") then {
				player sideChat "VIP is down, abort the mission.";

				sleep 2;

				["FEX_task_VIP","FAILED"] call BIS_fnc_taskSetState;
			};
		};
	}];
	};
},nil,9000,true,true,"","true", 5];



_heliPos = [5002.69,5850.39,0];
_helipad = createVehicle ["Land_HelipadSquare_F", _heliPos, [], 0, "NONE"];
_scriptHeli = createVehicle ["B_Heli_Light_01_F", _heliPos, [], 0, "NONE"];
_heliPilot = (createGroup west) createUnit ["B_Pilot_F", position _helipad, [], 0, "FORM"];
_heliPilot assignAsDriver _scriptHeli;
_heliPilot moveInDriver _scriptHeli;
_scriptHeli allowDamage false;
_heliPilot allowDamage false;
_scriptHeli lock 3;
_scriptHeli setCaptive true;
_heliPilot setBehaviourStrong "CARELESS";
_scriptHeli setVehicleAmmo 0;

//prepare for take-off
_scriptHeli engineOn true;
_scriptHeli land "GET IN";
_scriptHeli FlyInHeight 0;


_scriptHeli addEventHandler ["GetIn", { 
	_0 = _this spawn {
		 params ["_vehicle", "_role", "_unit", "_turret"]; 
		 
		if (_unit getVariable "FEX_VIP") then {
			if ("FEX_task_VIP" call BIS_fnc_taskState != "SUCCEEDED" && "FEX_task_VIP" call BIS_fnc_taskState != "FAILED") then {
				_unit allowDamage false;
				_vehicle sidechat "Got the VIP, moving away";
				_vehicle move [0,0,0];
				_vehicle land "NONE";
				_vehicle flyInHeight 60;

				sleep 2;

				["FEX_task_VIP","SUCCEEDED"] call BIS_fnc_taskSetState;
			};
		};
		
	};
	
}];