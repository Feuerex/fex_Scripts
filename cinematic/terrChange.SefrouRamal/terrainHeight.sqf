//either 0 or 1, input parameter - decide which axis to use from points
_XorY = _this select 0;
//either 1 or -1, input parameter - decide whether to affect terrain in the positive or negative direction from the source points
_dirX = _this select 1;
//max distance to lower terrain away from points - add fog so that you don't need to lower everything, it would take ages
_distance = 880;
//lower by this amount
_lowerBy = -40;
//terrain grid - minimum value to step, smaller number doesn't help, higher leaves gaps. Use GetTerrainInfo to discover
//_terrainGrid = 2.5;
_terrainGrid = getTerrainInfo select 2;
_heightArray = [];
{
	_currHeight = getTerrainHeightASL [(_x select 0), _x select 1, _x select 2];
	_heightArray pushBack _currHeight;
	for "_i" from 0 to (abs(_dirX) * _distance) step _terrainGrid do 
	{
		
		if (_XorY == 0) then 
		{
			_posX = (_x select 0) + (_dirX * _i);
			_posY = _x select 1;
			_posZ = (_x select 2) - _lowerBy;
			setTerrainHeight [[[_posX, _posY, _posZ]]];
		};
		if (_XorY == 1) then 
		{
			_posX = (_x select 0);
			_posY = (_x select 1) + (_dirX * _i);
			_posZ = (_x select 2) - _lowerBy;
			setTerrainHeight [[[_posX, _posY, _posZ]]];
		};
	};
	
} forEach finalArray;
_a = 0;
rocks = 0;
_lastPlace = finalArray select 0;
_placedRecently = 10;
{
	sleep 0.01;
	/*
	if (count ([(_x select 0) + (_dirX * 3), (_x select 1)] nearObjects ["Land_BluntRock_monolith_lxWS",8]) < 1) then {
	*/
	_currentPlace = [(_x select 0), (_x select 1),0];
	if ((_placedRecently > 2) OR (_lastPlace distance _currentPlace) > 4) then 
	{
		_rock = "Land_BluntRock_monolith_lxWS" createVehicle [(_x select 0), (_x select 1), _heightArray select _a];
		_rock setDir (random 30) - 15;
		if (_XorY == 0) then {
		_rock setPosASL [(_x select 0) + (_dirX * -4.5), (_x select 1), (_heightArray select _a) - 15];
		};
		if (_XorY == 1) then {
		_rock setPosASL [(_x select 0), (_x select 1)+ (_dirX * -4.5), (_heightArray select _a) - 15];
		};
		_rockLong = "Land_BluntRock_wallH_lxWS" createVehicle [(_x select 0), (_x select 1), (_x select 2)];
		_rockLong attachTo [_rock, [_dirX, 0,-35]];
		_rockLong setObjectScale 3;
		_rockLong SetVectorUp [0.0001,-1000,-1];
		rocks = rocks + 1;
		_placedRecently = 0;
	} else 
	{
		_placedRecently = _placedRecently + 1;
	};
	_lastPlace = _currentPlace;
	_a = _a + 1;
} forEach finalArray;

hint format ["Done. \n FinalArray: %1 \n Rocks: %2", count finalArray, rocks];
//get current value -> _XorY -> get opposite value -> abs(_XorY - 1);