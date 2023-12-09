//only switch if the task is still valid and hasn't been completed or failed by other means
if ("FEX_task_VIP" call BIS_fnc_taskState != "SUCCEEDED" && "FEX_task_VIP" call BIS_fnc_taskState != "FAILED") then {
	player sideChat "VIP is down, abort the mission.";

	sleep 2;

	["FEX_task_VIP","FAILED"] call BIS_fnc_taskSetState;

};