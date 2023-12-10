player setPos position goodbye_playerSpot;
iplayer attachTo [player, [0,0,1.6]];
player setDir 182;
_camera = "camera" camCreate position player;
_camera cameraEffect ["internal","back"];
_camera camCommand "intertia on";
_camera camSetFocus [50, 1];
_camera camSetTarget iplayer;
_camera camSetPos (position goodbye_cameraSpot);
_camera camCommit 0;
_camera camSetPos [((position goodbye_cameraSpot) select 0) - 20, (position goodbye_cameraSpot) select 1, 15];
_camera camCommit 17;
fex_camera = _camera;

player switchmove "Acts_JetsCrewaidFCrouch_in_m";
player addEventHandler ["AnimDone", {
	if ((_this select 1) == "Acts_JetsCrewaidFCrouch_in_m")
	then 
	{
		_0 = [] spawn {
			sleep 3;
			player switchmove "Acts_JetsCrewaidFCrouch_out_m";
		};
	};
	if ((_this select 1) == "Acts_JetsCrewaidFCrouch_out_m")
	then 
	{
		_0 = [] spawn 
		{
			player switchmove "Acts_ComingInSpeakingWalkingOut_7";
			sleep 3;
			titleText ["","black out",0.5];
			sleep 0.5;
			//change camera now!!
			fex_camera camSetPos [position goodbye_cameraSpot2 select 0, position goodbye_cameraSpot2 select 1, 6];
			fex_camera camSetTarget player;
			fex_camera camSetFocus [-1,-1];
			fex_camera camCommit 0;
			player setDir (direction player - 180);
			player switchmove "HubSpectator_walkU";
			player removeAllEventHandlers "AnimDone";
			titleText ["","black in",0.5];
			
		};
	};
}];

