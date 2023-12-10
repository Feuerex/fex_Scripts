globalArray = [];
_start = _this select 0;
_first = _this select 1;
_second = _this select 2;

appendRecursively = 
{
		globalArray pushBack (getPosATL _this);
		if (count (synchronizedObjects _x) > 0) then 
		{
			{
				if (!((getPosATL _x) in globalArray)) then 
				{
					systemChat format ["%1", _x];
					_x call appendRecursively;
				};
			} forEach synchronizedObjects _x;
		};
};

{
if (!((getPosATL _x) in globalArray)) then 
	{
	_x call appendRecursively;
	};
	
} forEach synchronizedObjects _start;


//copyToClipboard str(globalArray);
//hint "Done";
_areWeDone = [_first, _second] execVM "calculatePoints.sqf";

waitUntil {sleep 0.5;scriptDone _areWeDone};
