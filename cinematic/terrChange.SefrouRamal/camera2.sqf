//Parametrized cubic curve
//Fill in your points, then let the script calculate the getPosASLs
//From this example, you can easily see how you could turn this into a simple function, feed it parameters
//and make it more generic, applicable in any situation.
_point1 = [getPosASL cam2Start select 0, getPosASL cam2Start select 1, getPosASL cam2Start select 2];
_point2 = [getPosASL cam2End select 0, getPosASL cam2End select 1, getPosASL cam2End select 2];
_key1 = [getPosASL cam2Key1 select 0, getPosASL cam2Key1 select 1, getPosASL cam2Key1 select 2];
_key2 = [getPosASL cam2Key2 select 0, getPosASL cam2key2 select 1, getPosASL cam2key2 select 2];
_target = player;

_camera = "camera" camCreate[0,0,0];
_camera cameraEffect ["internal","back"];
_camera camSetPos _point1;
_camera camCommand "intertia on";
_camera camSetTarget _target;
_camera CamCommit 0;

sleep 2;
_my2Count = 0;
_cameraHelper = camera2Helper;
_camera attachTo [_cameraHelper, [0,0,0]];
_camera camSetTarget camera2Target;
_camera camSetFocus [-1,-1];
_camera camCommit 15;
while {_my2Count < 1} do 
{
	_my2Count = _my2Count + (1 *0.01 * 0.1);
	_vec1lerp = [_point1, _key1, _my2Count] call BIS_fnc_lerpVector;
	_vec2lerp = [_key2, _point2, _my2Count] call BIS_fnc_lerpVector;
	_vec3lerp = [_key1, _key2, _my2Count] call BIS_fnc_lerpVector;
	_vec4lerp = [_vec1lerp, _vec3lerp, _my2Count] call BIS_fnc_lerpVector;
	_vec5lerp = [_vec3lerp, _vec2lerp, _my2Count] call BIS_fnc_lerpVector;
	_vec6lerp = [_vec4lerp, _vec5lerp, _my2Count] call BIS_fnc_lerpVector;
	_cam2getPosASL = _vec6lerp;
	_cameraHelper setPosASL _cam2getPosASL;
	//_test = createVehicle ["Sign_Sphere25cm_F", _cam2getPosASL, [], 0, "CAN_COLLIDE"];
	sleep 0.01;
};
sleep 2;
_camera cameraEffect ["terminate","back"];
camDestroy _camera;