//Parametrized cubic curve
//Fill in your points, then let the script calculate the positions
//From this example, you can easily see how you could turn this into a simple function, feed it parameters
//and make it more generic, applicable in any situation.
_point1 = [20265.86,12986.57,1.17];
_point2 = [20254.18,12986.69,1.95];
_key1 = [20266.3,12984.8,1.17];
_key2 = [20260.1,12989.8,1.17];
_target = [119501.90,20234.43,-9763.92];


_camera = "camera" camCreate position player;


_camera cameraEffect ["internal","back"];
_camera camCommand "inertia on";
_camera camSetPos _point1;
_camera camSetFOV 0.2;
cameraPath setPos _point1;
_camera attachTo [cameraPath, [0,0,0]];
_camera camSetTarget [78058.63,94456.30,-4633.38];
_camera CamCommit 0;
sleep 8;

_handle = _camera spawn {
_this camPrepareFOV 0.7;
_this camCommitPrepared 9;
sleep 7.9;
};
waitUntil {sleep 0.01; scriptDone _handle};

myCount = 0;
_easeInOut = 0;
_0 = _camera spawn {
_this camPrepareTarget [78058.63,94456.30,-4633.38];
_this camCommitPrepared 0;
_this camPrepareTarget [119501.90,20234.43,-9763.92];
_this camCommitPrepared 13;
};
_easeInOut = 0;


while {myCount < 1} do 
{
if (_easeInOut < 0.2 && myCount < 0.5) then 
{
	_easeInOut = _easeInOut + 0.001;
};
	myCount = myCount + (0.6 *0.01 * _easeInOut );
	_vec1lerp = [_point1, _key1, myCount] call BIS_fnc_lerpVector;
	_vec2lerp = [_key2, _point2, myCount] call BIS_fnc_lerpVector;
	_vec3lerp = [_key1, _key2, myCount] call BIS_fnc_lerpVector;
	_vec4lerp = [_vec1lerp, _vec3lerp, myCount] call BIS_fnc_lerpVector;
	_vec5lerp = [_vec3lerp, _vec2lerp, myCount] call BIS_fnc_lerpVector;
	_vec6lerp = [_vec4lerp, _vec5lerp, myCount] call BIS_fnc_lerpVector;
	camposition = _vec6lerp;
	cameraPath setPos camposition;

	//_camera CamCommit 0;
	sleep 0.01;
};
sleep 7;
_camera cameraEffect ["terminate","back"];
camDestroy _camera;
