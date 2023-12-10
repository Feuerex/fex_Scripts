_first = _this select 0;
_second = _this select 1;
finalArray = [];
_gridSize = getTerrainInfo select 2;
for "_i" from 0 to ((count globalArray) - 2) step 1 do 
{
	_curr = globalArray select _i;
	_next = globalArray select (_i + 1);
	_dist = _curr distance _next;
	finalArray pushBack _curr;
	for "_j" from 0 to _dist step 1 do 
	{
		_pos = [_curr, _next, _j, _gridSize] call BIS_fnc_interpolateVectorConstant; _object = "Sign_Sphere25cm_F" createVehicle _pos; _object setPos _pos;
		finalArray pushBack _pos;
	};
};

copyToClipboard str finalArray;
//hint "Done";

_areWeDone = [_first, _second] execVM "terrainHeight.sqf";

waitUntil {sleep 0.5; scriptDone _areWeDone};

