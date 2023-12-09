//method 2 - create the unit
"C_Man_UtilityWorker_01_F" createUnit [[5035.13,5874.33,0], createGroup civilian, "myVIP = this", 0.5, "PRIVATE"];
_myVIP = myVIP;
_myVIP setPos [5035.13,5874.33,0];

sleep 3;
//give him some animation to loop, register his variable (in case you aren't allowed any global variables)
_myVIP switchmove "Acts_ExecutionVictim_Loop";
_myVIP allowDamage false;
_myVIP setVariable ["FEX_VIP", true];
//create task
[player, "FEX_task_preVIP", ["Rescue a VIP from enemy base", "Rescue VIP", ""], position _myVIP, "ASSIGNED", 2, true] call BIS_fnc_taskCreate;

//pick which variant you want to use
_myVIP addaction ["Get", "s01_rescue_Action.sqf",nil,9000,true,true,"","true", 5];

/////////////////////////////////////////////////////////////////////

//create heli on a designated position
_heliPos = [5002.69,5850.39,0];
_helipad = createVehicle ["Land_HelipadSquare_F", _heliPos, [], 0, "NONE"];
_scriptHeli = createVehicle ["B_Heli_Light_01_F", _heliPos, [], 0, "NONE"];

//prepare for take-off
_scriptHeli engineOn true;
_scriptHeli land "GET IN";
_scriptHeli FlyInHeight 0;

//give the heli an EH to register VIP getting in
_0 = [_scriptHeli, _myVIP] execVM "s03_takeoff_VehicleEH.sqf";