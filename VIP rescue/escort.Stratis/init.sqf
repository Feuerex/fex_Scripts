//method 1 - simply reference an already created unit somewhere in the editor
_myVIP = myVIP;


sleep 3;

_myVIP switchmove "Acts_ExecutionVictim_Loop";
_myVIP allowDamage false;
_myVIP setVariable ["FEX_VIP", true];

[player, "FEX_task_preVIP", ["Rescue a VIP from enemy base", "Rescue VIP", ""], position _myVIP, "ASSIGNED", 2, true] call BIS_fnc_taskCreate;


_myVIP addaction ["Get", "rescueVIP.sqf",nil,9000,true,true,"","true", 5];