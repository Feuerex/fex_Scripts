camArray = [];
_start = _this select 0;
_camera = _this select 1;
/*
camappendRecursively = 
{
		camArray pushBack (getPosATL _this);
		if (count (synchronizedObjects _this) > 0) then 
		{
			_synchrObjects = synchronizedObjects _this;
			_synchrKeys = _synchrObjects select {typeOf _x == "Land_GarbageBarrel_02_F"};
			_synchrEnd = _synchrObjects select {typeOf _x != "Land_GarbageBarrel_02_F"};
			{
				if (!((getPosATL _x) in camArray)) then 
				{
					camArray pushBack (getPosATL _x);
				};
			} forEach _synchrKeys;
			{
				if (!((getPosATL _x) in camArray)) then 
				{
					_x call camappendRecursively;
				};
			} forEach _synchrEnd;
		};
};

// {
// if (!((getPosATL _x) in camArray)) then 
	// {
	// _x call camappendRecursively;
	// };
	
// } forEach synchronizedObjects _start;

_start call camappendRecursively;



copyToClipboard (str camArray);
//systemchat "DONE";
//systemchat format ["%1",camArray];
*/
camArray = [
[3125.41,1268.2,0],[3124.72,1256.76,-0.003479],[3129.6,1237.31,0.0266342],[3137.37,1235.1,-7.62939e-006],[3145.67,1243.27,-0.0445557],[3158.41,1238.08,-0.00392151],[3161.76,1231.18,0],[3168.09,1225.25,-0.00532532],[3176.97,1223.03,0.00554657],[3180.47,1225.65,-7.62939e-006],[3189.63,1233.29,0.0741959],[3188.9,1214.69,0.00956726],[3184.82,1210.93,6.10352e-005],[3180.51,1208.02,0.0942383],[3171.9,1194.12,0.020813],[3176.52,1188.41,-1.52588e-005],[3181.08,1182.04,0.0139999],[3174.69,1169.55,-0.00088501],[3172.35,1163.55,0],[3169.08,1156.84,-0.00402832],[3177.68,1149.19,-0.00331116],[3186.81,1151.26,-7.62939e-006]
];

/*
{
_obj = "Sign_Sphere25cm_F" createVehicle [_x select 0, _x select 1, 2.5];
_obj setPos [_x select 0, _x select 1, 2.5];
sleep 1;
} forEach camArray;		
*/

sleep 2.5;
_fex_moveCamera = {
	_camera = _this select 0;
	_startPoint = _this select 1;
	_endPoint = _this select 4;
	_key1 = _this select 2;
	_key2 = _this select 3;
	_myCount = 0;
	while {_myCount < 1} do 
	{
		_myCount = _myCount + (1 *0.01 * 0.6);
		_vec1lerp = [_startPoint, _key1, _myCount] call BIS_fnc_lerpVector;
		_vec2lerp = [_key2, _endPoint, _myCount] call BIS_fnc_lerpVector;
		_vec3lerp = [_key1, _key2, _myCount] call BIS_fnc_lerpVector;
		_vec4lerp = [_vec1lerp, _vec3lerp, _myCount] call BIS_fnc_lerpVector;
		_vec5lerp = [_vec3lerp, _vec2lerp, _myCount] call BIS_fnc_lerpVector;
		_vec6lerp = [_vec4lerp, _vec5lerp, _myCount] call BIS_fnc_lerpVector;
		_camposition = _vec6lerp;
		_camera camSetPos [_camposition select 0, _camposition select 1, 2.5];
		_camera CamCommit 0.02;
		sleep 0.01;
		//_obj = "Sign_Sphere25cm_F" createVehicle [_camposition select 0, _camposition select 1, 2.5];
		//_obj setPos [_camposition select 0, _camposition select 1, 2.5];
	};
};



for "_i" from 0 to ((count camArray) - 5) step 3 do 
{
	_wait = [_camera,camArray select _i,(camArray select (_i + 1)),(camArray select (_i + 2)),(camArray select (_i + 3))] spawn _fex_moveCamera;
	waitUntil {sleep 0.01;scriptDone _wait};
};
