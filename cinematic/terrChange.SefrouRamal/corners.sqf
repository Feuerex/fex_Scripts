//call with - _0 = [N,M, place] execVM "corners.sqf";
//N = 1 for clearing EAST from point, -1 for WEST from point
//M = 1 for clearing SOUTH from point, -1 for NORTH from point
//place = name of the object where to start

_positiveX = _this select 0;
_positiveY = _this select 1;
_startHere = _this select 2;
_distance = 680;
_lowerBy = -40;
_terrainGrid = getTerrainInfo select 2;
{
	for "_i" from 0 to (abs(_positiveX) * _distance) step _terrainGrid do 
	{
		for "_j" from 0 to (abs(_positiveY) * _distance) step _terrainGrid do 
		{
			_posX = (_x select 0) + (_positiveX * _i);
			_posY = (_x select 1) + (_positiveY * _j);
			_posZ = (_x select 2) - _lowerBy;
			setTerrainHeight [[[_posX, _posY, _posZ]]];
		};
	};
	
} forEach [position _startHere];