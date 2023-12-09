if ("FEX_task_VIP" call BIS_fnc_taskState != "FAILED") then 
{
	_vehicle = _this select 0;
	_unit = _this select 1;
	if (_unit getVariable "FEX_VIP") then 
	{
		_unit allowDamage false;
		_vehicle sidechat "Got the VIP, moving away";
		_vehicle move [0,0,0];
		_vehicle land "NONE";
		_vehicle flyInHeight 60;

		sleep 2;

		["FEX_task_VIP","SUCCEEDED"] call BIS_fnc_taskSetState;

	};

};

