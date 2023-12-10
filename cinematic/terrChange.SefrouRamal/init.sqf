sleep 2;

_0 = [] execVM "visualEffects.sqf";
/*
_findK = [startHere, 0, -1]execVM "findKeypoints.sqf";
waitUntil {sleep 0.5; scriptDone _findK};

_findK = [continueHere, 0, 1]execVM "findKeypoints.sqf";

waitUntil {sleep 0.5; scriptDone _findK};

_findK = [finishHere, 1, -1]execVM "findKeypoints.sqf";

waitUntil {sleep 0.5; scriptDone _findK};
_corner = [-1,-1, startHere] execVM "corners.sqf";
waitUntil {sleep 0.5; scriptDone _corner};
_corner = [1,-1, continueHere] execVM "corners.sqf";
waitUntil {sleep 0.5; scriptDone _corner};
hint "All terrain changes done";
*/

//_0 = [] execVM "epicCamera.sqf";

sleep 1.5;
//_0 = [] execVM "unitplay.sqf";


_rock = [false] execVM "rocks.sqf";
waitUntil {sleep 0.5; scriptDone _rock};

/*
_0 = [] execVM "camera2.sqf";
*/

/*

*/
//_0 = [] execVM "slowcam.sqf";
/*
_0 = [] execVM "goodbye.sqf";
*/
/*
_0 = [] execVM "bezier_outside.sqf";

*/
//_0 = [] execVM "bezier_prepareASL.sqf";
/*
_0 = [] execVM "unitplay2_camera.sqf";
*/

//_0 = [] execVM "bezier_prepare.sqf";
//_0 = [] execVM "camera3.sqf";

//_0 = [] execVM "camera4.sqf";