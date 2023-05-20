//first step of the main logic
//adds necessary action, and if needed, removes the Event Handler that tracks mouse clicks

if (_this select 0 != -1) then 
{
	(_this select 1) removeAction (_this select 0);
	{deleteVehicle _x;} forEach ((position player) nearObjects ["Land_VR_Block_05_F", 500]);
	(_this select 2) setPos [0,0,0];
	(_this select 3) setPos [0,0,0];
	fex_thirdSphere setPos [0,0,0];
	if (fex_keyDownEHId != -1) then 
	{
		(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", fex_keyDownEHId];
	};
};
//systemChat format ["%1", _this];
(_this select 1) addAction 
[
"Become an electrician", 
	{
	_0 = [(_this select 3) select 0, (_this select 3) select 1] execVM 'Step2.sqf';
	fex_electricianActive = true;
	
	[_this select 2, _this select 0, (_this select 3) select 0, (_this select 3) select 1] execVM 'removeElAction.sqf';
	},[_this select 2,_this select 3],1.5,true,true,"","true",4
];