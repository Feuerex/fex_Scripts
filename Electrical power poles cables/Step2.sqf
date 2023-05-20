//second part of the main logic
//spawns VR blocks around any nearby lamps and power poles

_firstSphere = _this select 0;
_secondSphere = _this select 1;
//systemChat format ["%1", _this];
{
	_pole = "Land_VR_Block_05_F" createVehicle [position _x select 0, position _x select 1, 19.5];
	_pole setDir (getDir _x);
	_pole SetPos [position _x select 0, position _x select 1, 9.5];
	
	_pole setObjectTexture [0,""];
	_pole setObjectTexture [1,""];
	_pole setObjectMaterial [0,""];
	_pole setObjectMaterial [1,""];
	
} forEach (nearestObjects [(position player),["Land_PowerPoleWooden_F","Lamps_base_F"], 500]);

_0 =[_firstSphere, _secondSphere] execVM "Step3.sqf";
_0 = [_firstSphere, _secondSphere] execVM "Step4.sqf";

