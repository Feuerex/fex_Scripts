dude switchMove "Acts_Hilltop_Calibration_Heli_In";
dude disableAI "ANIM";
dude addEventHandler ["AnimDone", 
{
	params ["_unit", "_anim"];
	if (_anim == "Acts_Hilltop_Calibration_Heli_In") then 
	{
		_unit switchMove "Acts_Hilltop_Calibration_Heli_Out";
	};
	if (_anim == "Acts_Hilltop_Calibration_Heli_Out") then 
	{
		_unit playMoveNow "Acts_Hilltop_Calibration_Loop";
		_0 = [_unit] spawn {sleep 0.01;(_this select 0) switchMove "Acts_CivilStand_Default";sleep 0.5;(_this select 0) switchMove "AmovPercMwlkSnonWnonDf";};
	};
}];

fex_speed = 0.3;
_fex_moveCamera = {
	
	_camera = _this select 0;
	_startPoint = _this select 1;
	_endPoint = _this select 4;
	_key1 = _this select 2;
	_key2 = _this select 3;
	_myCount = 0;

	while {_myCount < 1} do 
	{
		if (fex_cam3Change && fex_speed > 0.08) then 
		{
			fex_speed = fex_speed - 0.001;
		};
		_myCount = _myCount + (0.9 *0.01 * fex_speed);
		_vec1lerp = [_startPoint, _key1, _myCount] call BIS_fnc_lerpVector;
		_vec2lerp = [_key2, _endPoint, _myCount] call BIS_fnc_lerpVector;
		_vec3lerp = [_key1, _key2, _myCount] call BIS_fnc_lerpVector;
		_vec4lerp = [_vec1lerp, _vec3lerp, _myCount] call BIS_fnc_lerpVector;
		_vec5lerp = [_vec3lerp, _vec2lerp, _myCount] call BIS_fnc_lerpVector;
		_vec6lerp = [_vec4lerp, _vec5lerp, _myCount] call BIS_fnc_lerpVector;
		_camposition = _vec6lerp;
		_camera camSetPos _camposition;
		if (fex_cam3Change) then 
		{
			if (fex_cam3Counter == 0) then 
			{
				fex_cam3Position = position camTarget _camera;
			};
			_camera camSetTarget fex_cam3Position;
			if (fex_cam3Counter < 105) then 
			{
				fex_cam3Counter = fex_cam3Counter + 1;
				fex_cam3Position = [fex_cam3Position select 0, fex_cam3Position select 1, (fex_cam3Position select 2) + (fex_cam3Counter / (2000 * (fex_speed*20)))];
			};
			if (fex_cam3Counter >= 105 && fex_cam3Counter < 165) then 
			{
				fex_cam3Counter = fex_cam3Counter + 0.75;
				fex_cam3Position = [fex_cam3Position select 0, fex_cam3Position select 1, (fex_cam3Position select 2) + (fex_cam3Counter / (2000 * (fex_speed*30)))];
			};
			if (fex_cam3Counter >= 165 && fex_cam3Counter < 245) then 
			{
				fex_cam3Counter = fex_cam3Counter + 0.5;
				fex_cam3Position = [fex_cam3Position select 0, fex_cam3Position select 1, (fex_cam3Position select 2) + (fex_cam3Counter / (2000 * (fex_speed*40)))];
			};
			if (fex_cam3Counter >= 245 && fex_cam3Counter < 305) then 
			{
				fex_cam3Counter = fex_cam3Counter + 0.25;
				fex_cam3Position = [fex_cam3Position select 0, fex_cam3Position select 1, (fex_cam3Position select 2) + (fex_cam3Counter / (2000 * (fex_speed*80)))];
			};
			if (fex_cam3Counter >= 305) then 
			{
				fex_cam3Counter = fex_cam3Counter + 0.05;
				fex_cam3Position = [fex_cam3Position select 0, fex_cam3Position select 1, (fex_cam3Position select 2) + (fex_cam3Counter / (2000 * (fex_speed*320)))];
			};
			
		};
		_camera camCommit 0.01;
		//systemchat format ["%1", fex_cam3Counter];
		/*
		cam_obj setPos _camposition;
		if (!isNil "fex_cam3Position") then {
		fex_obj setPos fex_cam3Position;
		} else { fex_obj setPos position dude};
		*/
		sleep 0.01;
	};
};

_camera = "camera" camCreate position player;
_camera cameraEffect ["internal","back"];
_camera camCommand "intertia on";
_camera camSetFocus [-1,-1];
_camera camSetTarget dude;
_camera camCommit 0;


fex_cam3Change = false;
fex_cam3Counter = 0;
/*
fex_obj = "Sign_Sphere100cm_F" createVehicle position player;
cam_obj = "Sign_Sphere25cm_F" createVehicle position player;
*/
_0 = [] spawn {sleep 3.5; fex_cam3Change = true;};

_positions = [[3213.79,1406.39,4.29127],[3214.62,1395.93,6.24679],[3219.55,1382.87,7.99817],[3224.53,1378.76,11],[3229.65,1375.06,13.9993],[3235.27,1363.79,20.8311],[3235.04,1355.64,25.6033],[3234.68,1348.92,30.0573],[3240.3,1337.64,36.8888],[3245.68,1333.02,47.0886]];

for "_i" from 0 to ((count _positions) - 5) step 3 do 
{
	_wait = [_camera,_positions select _i,(_positions select (_i + 1)),(_positions select (_i + 2)),(_positions select (_i + 3))] spawn _fex_moveCamera;
	waitUntil {sleep 0.01;scriptDone _wait};
};