_myVIP = _this select 0;
_timeElapsed = 0;
//wait 30 minutes for the task to fail
while {("FEX_task_VIP" call BIS_fnc_taskState) != "SUCCEEDED" && _timeElapsed < 360} do {
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