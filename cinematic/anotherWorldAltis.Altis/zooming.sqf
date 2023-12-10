skipTime 12.5;
sleep 2;
_camera = "camera" camCreate position player;


	

_camera cameraEffect ["internal","back"];

_camera camCommand "inertia on";


setTimeMultiplier 120;
300 setOvercast 1;
//_0 = [] spawn {for "_i" from 0 to 4000 step 1 do {sleep 0.01;skipTime (1/600)};};
;comment "18:56:19";
_camera camPrepareTarget [71818.91,-76165.69,18513.29];
_camera camPreparePos [20173.87,19950.27,777.04];
_camera camPrepareFOV 0.900;
_camera camCommitPrepared 0;
;comment "18:57:42";
_camera camPrepareTarget [-71000.89,76000.99,37177.51];
_camera camPreparePos [0.83,3.18,5966.21];
_camera camPrepareFOV 0.900;
_camera camCommitPrepared 20;
