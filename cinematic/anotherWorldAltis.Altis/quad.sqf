skiptime 11;
0 setOvercast 0.2;
0 setRain 0;
//selectPlayer dude;


waitUntil {sleep 0.01;weAreReady};
/*
_camera = "camera" camCreate position dude;
_camera cameraEffect ["internal","back"];
_camera camCommand "inertia on";
player remoteControl dude;
_camera camSetTarget Logic_player;
_camera attachTo [dude, [3,5,1.1]];
_camera camCommit 0;
*/
_0 = [] spawn {
	("BIS_fnc_cinemaBorder" call BIS_fnc_rscLayer) cutRsc ["RscCinemaBorder", "PLAIN"];
	private ["_borderDialog", "_borderTop", "_borderBottom", "_height"];
	_borderDialog = uiNamespace getVariable "RscCinemaBorder";
	_borderTop = _borderDialog displayCtrl 100001;
	_borderBottom = _borderDialog displayCtrl 100002;
	_height = 0.125 * safeZoneH;
	_offset = 0.1;
	_borderTop ctrlSetPosition [safeZoneX - _offset, safeZoneY - _height - _offset, safeZoneW + 2 * _offset, _height + _offset];
	_borderTop ctrlCommit 0;
	_borderTop ctrlSetPosition [safeZoneX - _offset, safeZoneY - _offset,safeZoneW + 2 * _offset, _height + _offset];
	_borderTop ctrlCommit 0;

	_borderBottom ctrlSetPosition [safeZoneX - _offset, safeZoneY + safeZoneH, safeZoneW + 2 * _offset, _height + _offset];
	_borderBottom ctrlCommit 0;
	_borderBottom ctrlSetPosition [safeZoneX - _offset, safeZoneY + safeZoneH - _height, safeZoneW + 2 * _offset, _height + _offset];
	_borderBottom ctrlCommit 0;
};
camera_distance switchcamera "internal";
camera_distance remoteControl dude;
sleep 6;
logic_camera switchCamera "internal";
logic_camera remoteControl dude;
logic_camera setDir 229;
