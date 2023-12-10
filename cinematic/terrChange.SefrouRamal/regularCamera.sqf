_camera = _this select 0;
_invisObject = _this select 1;
;comment "18:48:02";
_camera camPrepareTarget _invisObject;
_camera camCommitPrepared 0;
_0 = [camHere,_camera] execVM "betterCamera.sqf"