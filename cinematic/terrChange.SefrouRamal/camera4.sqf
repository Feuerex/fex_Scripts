_positions = [[3167.12,1303.35,145.683],[3177.87,1306.8,142.374],[3187.27,1273.3,138.76],[3186.44,1265.73,136.569],[3185.89,1258.47,133.809],[3214.7,1272.53,130.852],[3220.74,1256.88,124.971],[3226.62,1243.88,120.537],[3240.27,1227.25,120.915],[3246.98,1225.84,117.852],[3254.64,1225.81,112.985],[3274.49,1241.53,119.221],[3279.76,1248.11,122.073],[3287.65,1257.2,125.369],[3332.36,1259.6,109.221],[3342.34,1243.81,109.87],[3354.31,1227.82,111.407],[3347.74,1186.23,108.856],[3340.49,1178.14,108.82],[3332.34,1170.86,109.194],[3277.38,1160.47,113.106],[3272.08,1146.88,121.193],[3267.17,1136.04,128.402],[3238.89,1133.63,144.924],[3228.23,1140.72,147.715],[3219.89,1144.34,150.702],[3212.38,1148.05,149.189],[3190.1,1136.27,145.896]];



_fex_moveCamera = {
	
	_camera = _this select 0;
	_startPoint = _this select 1;
	_endPoint = _this select 4;
	_key1 = _this select 2;
	_key2 = _this select 3;
	_myCount = 0;

	while {_myCount < 1} do 
	{

		_myCount = _myCount + (0.9 *0.01 * 0.3);
		_vec1lerp = [_startPoint, _key1, _myCount] call BIS_fnc_lerpVector;
		_vec2lerp = [_key2, _endPoint, _myCount] call BIS_fnc_lerpVector;
		_vec3lerp = [_key1, _key2, _myCount] call BIS_fnc_lerpVector;
		_vec4lerp = [_vec1lerp, _vec3lerp, _myCount] call BIS_fnc_lerpVector;
		_vec5lerp = [_vec3lerp, _vec2lerp, _myCount] call BIS_fnc_lerpVector;
		_vec6lerp = [_vec4lerp, _vec5lerp, _myCount] call BIS_fnc_lerpVector;
		_camposition = _vec6lerp;
		
		fex_camobj setPosASL _camposition;

		_camera camCommit 0.01;
		
		//systemchat format ["%1", fex_cam3Counter];
		//_cam_obj = "Sign_Sphere25cm_F" createVehicle _camposition;
		//_cam_obj setPosASL _camposition;
		sleep 0.01;
	};
};
_camera = "camera" camCreate position player;
_camera cameraEffect ["internal","back"];
_camera camCommand "intertia on";
_camera camSetFocus [-1,-1];
_camera camSetTarget player;
_camera camCommit 0;



fex_camobj = "Sign_Sphere25cm_F" createVehicle position player;
fex_camobj hideobject true;

_0 = [_camera] execVM "camera4_unitPlay.sqf";


_camera attachTo [fex_camobj, [0,0,0]];
for "_i" from 0 to ((count _positions) - 5) step 3 do 
{
	_wait = [_camera,_positions select _i,(_positions select (_i + 1)),(_positions select (_i + 2)),(_positions select (_i + 3))] spawn _fex_moveCamera;
	waitUntil {sleep 0.1;scriptDone _wait};
};