camArray = [];
camappendRecursively = 
{
		camArray pushBack (getPosASL _this);
		if (count (synchronizedObjects _this) > 0) then 
		{
			_synchrObjects = synchronizedObjects _this;
			_synchrKeys = _synchrObjects select {typeOf _x == "Land_MetalBarrel_F"};
			_synchrEnd = _synchrObjects select {typeOf _x != "Land_MetalBarrel_F"};
			{
				if (!((getPosASL _x) in camArray)) then 
				{
					camArray pushBack (getPosASL _x);
				};
			} forEach _synchrKeys;
			{
				if (!((getPosASL _x) in camArray)) then 
				{
					_x call camappendRecursively;
				};
			} forEach _synchrEnd;
		};
};

// {
// if (!((getPosATL _x) in camArray)) then 
	// {
	// _x call camappendRecursively;
	// };
	
// } forEach synchronizedObjects _start;

//camHere3 call camappendRecursively;
cam4Start call camappendRecursively;

copyToClipboard (str camArray);
systemchat "DONE";