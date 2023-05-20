//third part of the main logic
//tracks cursor target, moves sphere around to highlight the object player is pointing at

_firstSphere = _this select 0;
_secondSphere = _this select 1;
while {fex_electricianActive} do 
{
	sleep 0.2;
	//hintSilent format ["%1", cursorTarget];
	if ((typeOf cursortarget == "Land_VR_Block_05_F") and (((position _firstSphere select 0) < 1) or (position _firstSphere select 0) != (position cursorTarget select 0)) and !(cursorTarget in fex_reservedSpots)) then 
	{
		//systemChat "adding";
		_firstSphere setPos [(position cursorTarget select 0), (position cursorTarget select 1), (position cursorTarget select 2) + 1.6];
		_firstSphere setDir (getDir cursorTarget);
	};
	if ((cursorTarget != _firstSphere && (typeOf cursortarget != "Land_VR_Block_05_F")) and ((position _firstSphere select 0) > 1)) then 
	{
		//systemChat "removing";
		_firstSphere setPos [0,0,0];
	};
}