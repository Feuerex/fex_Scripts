_fex_moveCamera = {
	_camera = _this select 0;
	_startPoint = _this select 1;
	_endPoint = _this select 4;
	_key1 = _this select 2;
	_key2 = _this select 3;
	_myCount = 0;
	while {_myCount < 1} do 
	{
		_myCount = _myCount + (1 *0.01 * 0.1);
		_vec1lerp = [_startPoint, _key1, _myCount] call BIS_fnc_lerpVector;
		_vec2lerp = [_key2, _endPoint, _myCount] call BIS_fnc_lerpVector;
		_vec3lerp = [_key1, _key2, _myCount] call BIS_fnc_lerpVector;
		_vec4lerp = [_vec1lerp, _vec3lerp, _myCount] call BIS_fnc_lerpVector;
		_vec5lerp = [_vec3lerp, _vec2lerp, _myCount] call BIS_fnc_lerpVector;
		_vec6lerp = [_vec4lerp, _vec5lerp, _myCount] call BIS_fnc_lerpVector;
		_camposition = _vec6lerp;
		_camera camSetPos _camposition;
		_camera CamCommit 0;
		sleep 0.01;
	};
};

_camera = "camera" camCreate position player;
_camera cameraEffect ["internal","back"];
_camera camCommand "intertia on";

_positions = [[3131.39,1225.75,74.38],[3127.04,1260.66,14.00],[3131.03,1287.33,30.40],[3082.79,1308.50,107.22],[3100.49,1166.80,55.40],[3118.90,1212.64,78.48],[3162.77,1228.64,13.63],[3184.24,1211.56,4.37],[3173.92,1177.06,5.03],[3176.69,1149.71,6.20],[3203.51,1170.15,5.95],[3234.30,1185.75,9.45],[3271.71,1213.22,10.56],[3294.03,1267.57,75.73],[3302.77,1311.76,61.90],[3314.04,1372.27,61.86],[3276.27,1397.62,86.03],[3215.96,1417.22,37.86],[3143.32,1384.41,82.33],[3122.12,1339.43,57.09],[3112.23,1322.84,43.94]];

for "_i" from 0 to ((count _positions) - 5) step 3 do 
{
	_wait = [_camera,_positions select _i,(_positions select (_i + 1)),(_positions select (_i + 2)),(_positions select (_i + 3))] spawn _fex_moveCamera;
	waitUntil {sleep 0.01;scriptDone _wait};
};
