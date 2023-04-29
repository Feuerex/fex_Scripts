
_trig = _this select 0;
_orient = _this select 1;
_trigPos = getPosASL _trig;
_trigArea = triggerArea _trig;
_a = _trigArea select 0;
_b = _trigArea select 1;
_isRectangle = _trigArea select 3;
_radius = (_a max _b)*2;
if (_isRectangle) then 
{
_radius = (_a max _b) * 1.42;
};

_0 = [_trigPos, _radius, _orient, _trig] execVM "grabber.sqf";


/*
_center = _this select 0;
//do NOT increase past 100 or you'll risk overloading the memory reserved for 1 variable, and lose data
_maxSize = 100;
_finalArray = "[[";
_smallArray = "";
for "_i" from -(_maxSize) to _maxSize step 1 do 
{
	for "_j" from -(_maxSize) to _maxSize step 1 do 
	{
		_posX = ((_center select 0) + _i);
		_posY = ((_center select 1) + _j);
		_pos = [_i, _j, getTerrainHeightASL [_posX, _posY]];
		if (_i == _maxSize && _j == _maxSize) then 
		{
			_smallArray  = _smallArray + str _pos;
		} else 
		{
			_smallArray  = _smallArray + str _pos + ",";
		};
	};
	_finalArray = _finalArray + toString [13,10] +  _smallArray;
	_smallArray = "";
	sleep 0.01;
};
_finalArray = _finalArray + "]];";
copyToClipboard _finalArray;
hint "Copied!";
*/