#include "\a3\ui_f\hpp\definedikcodes.inc"
_firstSphere = _this select 0;
_secondSphere = _this select 1;

//fourth step of the main logic
//adds mouse tracking, moves spheres around and saves positions if needed


fex_keyDownEHId = findDisplay 46 displayAddEventHandler ["MouseButtonDown", 
{

	//systemChat format ["%1", _this];
	if (_this select 1 == 0) then 
	{
		if ((position fex_firstSphere) select 0 != 0) then 
		{
			//systemchat "searching";
			_posToSearch = [position fex_firstSphere select 0, position fex_firstSphere select 1, (position fex_firstSphere select 2)];
			_block = (_posToSearch nearObjects ["Land_VR_Block_05_F",2]) select 0;
			if ((position fex_secondSphere) select 0 < 3) then 
			{
				fex_secondSphere setPos _posToSearch;
				fex_secondSphere setDir (getDir _block);
				fex_reservedSpots pushBack _block;
				if (count fex_reservedSpots > 1) then 
				{
					fex_reservedSpots deleteAt 0;
					//systemChat format ["%1", fex_reservedSpots];
				};
				fex_firstSphere setPos [0,0,0];
			} else 
			{
				//systemchat "third";
				fex_thirdSphere setPos _posToSearch;
				fex_firstSphere setPos [0,0,0];
				_0 = [] execVM "Step5.sqf";
			};
		};
	};
	if (_this select 1 == 1) then 
	{
		//logic - if second sphere is already in use, only delete the current connection.
		//otherwise, delete all ropes FROM currently selected position
		if (fex_secondSphere distance [0,0,0] > 10) then 
		{
			//systemChat "You pressed right click";
			if (count fex_reservedSpots > 0) then 
				{
					fex_reservedSpots deleteAt 0;
				};
			fex_secondSphere setPos [0,0,0];
		} else 
		{
			if ((position fex_firstSphere) select 0 != 0) then 
			{
				//systemChat "deleting connections from this place";
				_droneArr = nearestObjects [position fex_firstSphere, ["C_UAV_06_F"],1, true];
				if (count _droneArr > 0) then 
				{
					{
						_ropeArr = ropes _x;
						if (count _ropeArr > 0) then 
						{
							{
								//check rope end positions, if there is a lamp, switch it off
								_ropePos = ropeEndPosition _x;
								{_x switchLight "OFF"} forEach (nearestObjects [[(_ropePos select 1) select 0, (_ropePos select 1) select 1],["Lamps_base_F"],1,true]);
								ropeDestroy _x;
							} forEach _ropeArr;
						};
					} forEach _droneArr;
				};
			};
		};

	};
}];



//Logic - check position of first sphere. If at 000, do nothing. Else take the current position
//and find nearby VR block. At the block position + offset, move the second sphere.
//move the first sphere to 000.
//also note the VR block and its position, and prevent yellow sphere from entering this specific
//position again, until either the whole thing has been cancelled or player exited the mode.
