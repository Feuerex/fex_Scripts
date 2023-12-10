_simulateMovement = _this select 0;
_numberOfObjects = 30;
_center = position iRocks;
_radius = 16;
_radiusBig = 22;
_radiusFar = 30;
_numberOfObjectsBig = 9;
_roc = "Land_BluntRock_wallH_lxWS";
_bigRocks = ["Land_BluntRock_monolith_lxWS","Land_BluntRock_spike_lxWS","Land_BluntRock_wallV_lxWS"];
_smallRocks = ["Land_BluntStone_02_lxWS", "Land_BluntRock_apart_lxWS", "Land_BluntStone_01_lxWS", "Land_BluntStones_erosion_lxWS"];

for "_i" from 0 to (_numberOfObjects - 1) do {
    _angle = _i * 1080 / _numberOfObjects;
    _myx = (_center select 0) + _radius * cos _angle;
    _y = (_center select 1) + _radius * sin _angle;
    _position = [_myx, _y, 0 + (_i * 5)];
	
	_radius = _radius + (sin (_i));
    // Spawn object
	//systemchat format ["%1, %2", _radius, _i];
    _rock = createVehicle [selectRandom _smallRocks, _position, [], 0, "CAN_COLLIDE"];
	_logicCenter = createCenter sideLogic;
	_logicGroup = createGroup _logicCenter;
	_gameLogic = _logicGroup createUnit ["Logic", _position, [], 0, "NONE"];
	_rock attachTo [_gameLogic,[0,0,0]];
	_rock setObjectScale ((random 1.5) + 0.5);
};

for "_i" from 0 to (_numberOfObjectsBig - 1) do {
    _angle = 90 + _i * 960 / _numberOfObjectsBig;
    _myx = (_center select 0) + _radiusBig * cos _angle;
    _y = (_center select 1) + _radiusBig * sin _angle;
    _position = [_myx, _y, 0 + (_i * 9)];
	
	_radiusBig = _radiusBig + (sin (_i)) * 3;
    // Spawn object
    _rock = createVehicle [selectRandom _bigRocks, _position, [], 0, "CAN_COLLIDE"];
	//createLogic
	_logicCenter = createCenter sideLogic;
	_logicGroup = createGroup _logicCenter;
	_gameLogic = _logicGroup createUnit ["Logic", _position, [], 0, "NONE"];
	_gameLogic setDir _angle;
	_rock attachTo [_gameLogic,[0,0,0]];
	_rock setObjectScale ((random 0.5) + 0.5);
	_rock setVectorUp [1, (random 1.5) -0.75, (random 0.5) + 0.5];
	if (_simulateMovement) then 
	{
		if (typeOf _rock != "Land_BluntRock_monolith_lxWS") then 
		{
			_0 = [_gameLogic] spawn 
			{
				_gameLogic = _this select 0;
				//player attachTo [_gameLogic, [0,0,0]];
				_offset = random 360;
				while {true} do 
				{
					_radius = 22;
					_angle = ((time % 360) + _offset) * 360 * 0.002;
					_myx = (position iRocks select 0) + _radius * cos _angle;
					_y = (position iRocks select 1) + _radius * sin _angle;
					_position = [_myx, _y, (getPosASL _gameLogic select 2)];
					_gameLogic SetPosASL _position;
					sleep 0.01;
				};
			};
		};
	};
};

for "_i" from 0 to (_numberOfObjects - 1) do {
    _angle = _i * 1080 / (_numberOfObjects + 10);
    _myx = (_center select 0) + _radiusFar * cos _angle;
    _y = (_center select 1) + _radiusFar * sin _angle;
    _position = [_myx, _y, 0 + (_i * 3)];
	
	_radiusFar = _radiusFar + (sin (_i));
    // Spawn object
    _rock = createVehicle [selectRandom _smallRocks, _position, [], 0, "CAN_COLLIDE"];
	_logicCenter = createCenter sideLogic;
	_logicGroup = createGroup _logicCenter;
	_gameLogic = _logicGroup createUnit ["Logic", _position, [], 0, "NONE"];
	_rock attachTo [_gameLogic,[0,0,0]];
	_rock setObjectScale ((random 1.5) + 0.5);
	_rock setVectorUp [(random 2) -1, (random 2) -1, (random 2) -1];
	if (_simulateMovement) then 
	{
		_0 = [_gameLogic] spawn 
			{
				_gameLogic = _this select 0;
				//player attachTo [_gameLogic, [0,0,0]];
				_offset = random 360;
				while {true} do 
				{
					_radiusFar = 35;
					_angle = ((time % 360) + _offset) * 360 * 0.003;
					_myx = (position iRocks select 0) - _radiusFar * cos _angle;
					_y = (position iRocks select 1) - _radiusFar * sin _angle;
					_position = [_myx, _y, (getPosASL _gameLogic select 2)];
					_gameLogic SetPosASL _position;
					sleep 0.01;
				};
			};
	};
};


_lightpoint = createVehicle ["#lightreflector", position iRocks, [], 0, "CAN_COLLIDE"];
_lightpoint setLightColor [0.1,0.45,0.75];
_lightpoint setLightAmbient [0.05,0.3, 0.6];
//original value 30
_lightpoint setLightIntensity 40000;
_lightpoint setLightConePars [90,90,1];
_lightpoint setLightVolumeShape ["a3\data_f\VolumeLightFlashlight.p3d", [6, 1.5, 6]];
_lightpoint setVectorUp [0.00,-1,0.001];


//use: _0 = [iRocks] execVM "rocks.sqf";
//iRocks - game logic to mark where the rocks spawn


