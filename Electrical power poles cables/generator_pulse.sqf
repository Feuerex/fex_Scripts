//finds all ropes originating from input position
//finds the endpoint for each rope and calls this function again for every such endpoint
//turns connected lamps on or off depending on the generator setting

_inputObj = _this select 0;
_mode = _this select 1;
_generator = _this select 2;
_inputPos = [(position _inputObj) select 0, (position _inputObj) select 1, 0];
//find a drone at this position (any ropes leading FROM here mean there must be a drone)
_droneArr = nearestObjects [_inputPos, ["C_UAV_06_F"],1, true];
//if there are any drones, look at the ropes and get their positions
if (count _droneArr > 0) then 
{
	{
		_drPos = [position _x select 0, position _x select 1, 0];
		//Log the drone's position and if needed, add it to array
		_traversedPos = _generator getVariable "fex_traversed";
		if (! (_drPos in _traversedPos)) then 
		{
			_traversedPos pushBack [_drPos select 0, _drPos select 1, 0];
			_generator setVariable ["fex_traversed", _traversedPos, true];
			//get all ropes from the drone
			_allRopes = ropes _x;
			if (count _allRopes > 0) then 
			{
				//prepare an array for endpoints
				_allEndPoints = [];
				{
					//add every endpoint's position to array
					_allEndPoints pushBack [((ropeEndPosition _x) select 1) select 0, ((ropeEndPosition _x) select 1) select 1, 0];
				} forEach _allRopes;
				{	//search for poles at every end position
					_endObjs = nearestObjects [_x, ["Land_PowerPoleWooden_F", "Lamps_base_F"],1, true];
					if (count _endObjs > 0) then 
					{
						{_0 = [_x, _mode, _generator] execVM "generator_pulse.sqf";} forEach _endObjs;
					};
				} forEach _allEndPoints;
			};
		};
	} forEach _droneArr;
};
_lampArr = nearestObjects [_inputPos, ["Lamps_base_F"],1, true];
if (count _lampArr > 0) then 
{
	{
		if (lightIsOn _x != _mode) then 
		{
			_x switchLight _mode;
		};
	} forEach _lampArr;
	
};

