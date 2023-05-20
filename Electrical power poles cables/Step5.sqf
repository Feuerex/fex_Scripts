//fifth step of the main logic
//validates selection and spawns the rope, along with all necessary objects

//find two positions
//first is stored in global variable
//second is current yellow sphere pos
//calculate distance between the two, spawn drone (invisible) on the first one and some tiny invisible object
//on the second one. Create a rope of given length between the two, making sure the drone goes first.
//remove both spheres and remove the saved position

if (count fex_reservedSpots >= 1) then 
{
	if ((position fex_thirdSphere) select 0 != 0 && (position fex_thirdSphere) select 1 != 0) then 
	{
	
		_firstSpot = position (fex_reservedSpots select 0);
		_secondSpot = position fex_thirdSphere;
		_distance = _firstSpot distance _secondSpot;
		_modifier = 10;
		if (_distance < 30) then 
		{
			_modifier = 10;
		};
		if (_distance > 30 && _distance < 90) then 
		{
			_modifier = 15;
		};
		if (_distance > 90) exitWith 
		{
			systemChat "Failed to connect, too far away!";
			while {count fex_reservedSpots > 0} do 
			{
				fex_reservedSpots deleteAt 0;
			};
			fex_secondSphere setPos [0,0,0];
			fex_thirdSphere setPos [0,0,0];
			fex_firstSphere setPos [0,0,0];
		};
		_distF = _distance + (_distance / _modifier);
		//TODO vypoèítat pozici na jednom z bokù, a to fakt visí tam kde by mìlo
		_drone = "";
		_nearbyDrones = nearestObjects [_firstSpot,["C_UAV_06_F"],1,true];
		if ((count _nearbyDrones) == 0) then 
		{
			_drone = "C_UAV_06_F" createVehicle [(_firstSpot select 0), (_firstSpot select 1), (_firstSpot select 2) + 1.6];
			//_drone setPos [_firstSpot select 0, _firstSpot select 1, (_firstSpot select 2) + 1.7];
			[([_firstSpot select 0, _firstSpot select 1] nearestObject "Land_VR_Block_05_F" ),_drone,[0,0,0],0,true,true] call BIS_fnc_relPosObject;
			_drone setPos [getPos _drone select 0, getPos _drone select 1, (_firstSpot select 2) + 1.7];
			_drone hideObject true;
			_drone allowDamage false;
		} else 
		{
			_drone = _nearbyDrones select 0;
		};
		_endPoint = "Intel_File2_F" createVehicle [(_secondSpot select 0), (_secondSpot select 1), (_secondSpot select 2) + 0.45];
		[([_secondSpot select 0, _secondSpot select 1] nearestObject "Land_VR_Block_05_F" ),_endPoint,[0,0,0],0,true,true] call BIS_fnc_relPosObject;
		_endPoint setPos [(position _endPoint select 0), (position _endPoint select 1), (_secondSpot select 2) + 0.45];
		_endPoint hideObject true;
		_endPoint allowDamage false;
		
		_offsetF = 0;
		_offsetS = 0;
		if (count(nearestObjects [[_firstSpot select 0, _firstSpot select 1],["Lamps_base_F"],1.1, true]) > 0) then 
		{
			_offsetF = 0;
		} else 
		{
			_offsetF = (((floor(random 2)) * 2) - 1);
		};
		if (count(nearestObjects [[_secondSpot select 0, _secondSpot select 1],["Lamps_base_F"],1.1, true]) > 0) then 
		{
			_offsetS = 0;
		} else 
		{
			_offsetS = (((floor(random 2)) * 2) - 1);
		};
		myRope = ropeCreate [_drone, [0, _offsetF, 0.08], _endPoint, [0, _offsetS , 0], _distF];
		//systemchat format ["%1", ropes _drone];
		
		while {count fex_reservedSpots > 0} do 
		{
			fex_reservedSpots deleteAt 0;
		};
		fex_secondSphere setPos [0,0,0];
		fex_thirdSphere setPos [0,0,0];
		fex_firstSphere setPos [0,0,0];
	};
};