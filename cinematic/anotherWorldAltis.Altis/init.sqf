weAreReady = false;

"LightShafts" ppEffectAdjust [0.3,0.3,0.35,0.31];
/*
_0 = [] spawn {
	sleep 1;
	monitors setObjectTexture [2,"screen1.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen2.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen3.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen4.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen5.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen6.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen7.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen8.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen9.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screen10.paa"];
	sleep 0.3;
	monitors setObjectTexture [2,"screenEmpty.paa"];
	sleep 1;
	_0 = [] execVM "beziercam.sqf";
	sleep 3;
	fex_idleScreens = ["screen1.paa","screen2.paa"];
	fex_activeScreens = ["screen3.paa","screen4.paa","screen5.paa","screen6.paa","screen7.paa","screen8.paa","screen9.paa","screen10.paa"];
	fex_updateFreq = 0.05;
	fex_randomFactor = 0.03;

	_playIdleScreen = {
		_totalTime = _this;
		_counter = 0;
		while {_counter < _totalTime} do {
			_number = fex_updateFreq + (random [0,(fex_randomFactor / 2), fex_randomFactor]);
			sleep _number;
			_counter = _counter + _number;
			monitors setObjectTexture [2,selectRandom fex_idleScreens];
		};
	};
	_playActiveScreen = {
		_totalTime = _this;
		_counter = 0;
		while {_counter < _totalTime} do {
			_number = fex_updateFreq + (random [0,(fex_randomFactor / 2), fex_randomFactor]);
			sleep _number;
			_counter = _counter + _number;
			monitors setObjectTexture [2,selectRandom fex_activeScreens];
		};
	};
	_wait = 1.5 spawn _playActiveScreen;
	waitUntil {scriptDone _wait};
	_wait = 3 spawn _playIdleScreen;
	waitUntil {scriptDone _wait};
	_wait = 0.9 spawn _playActiveScreen;
	waitUntil {scriptDone _wait};
	_wait = 1 spawn _playIdleScreen;
	waitUntil {scriptDone _wait};
	_wait = 3 spawn _playActiveScreen;
	waitUntil {scriptDone _wait};
	_wait = 5 spawn _playIdleScreen;
	waitUntil {scriptDone _wait};
	_wait = 1.9 spawn _playActiveScreen;
	waitUntil {scriptDone _wait};
	_wait = 5 spawn _playIdleScreen;
	waitUntil {scriptDone _wait};

};
*/
/*
_camera = "camera" camCreate position player;
_camera cameraEffect ["internal","back"];
_camera camCommand "inertia on";
;comment "17:21:21";
_camera camPrepareTarget [68169.90,92686.94,-36667.66];
_camera camPreparePos [20266.86,12987.57,1.17];
_camera camPrepareFOV 0.700;
_camera camPrepareFocus [100,1];
_camera camCommitPrepared 0;
;comment "17:21:36";

sleep 1;
_camera camPrepareFocus [2,1];
_camera camCommitPrepared 5;
sleep 5;
_0 = _camera spawn {sleep 2; _this camCommand "inertia on";};
_camera camCommand "inertia off";
_camera camPrepareTarget [71563.00,98332.29,-9081.82];
_camera camPreparePos [20266.05,12986.18,1.14];
_camera camCommitPrepared 8;
sleep 6;
//_camera camCommand "inertia on";
_camera = "camera" camCreate position player;
_camera cameraEffect ["internal","back"];
;comment "17:21:53";
_camera camPrepareTarget [119501.90,20234.43,-9763.92];
_camera camPreparePos [20254.18,12986.69,1.95];
_camera camCommitPrepared 18;

sleep 7;

[20265.3,12987.6,1.35605]
[20262.4,12988.7,1.49776]

*/




_0 = [] execVM "quad.sqf";
