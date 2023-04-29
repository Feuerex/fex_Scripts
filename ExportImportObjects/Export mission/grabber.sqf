/*
	File: objectGrabber.sqf
	Author: Joris-Jan van 't Land

	Description:
	Converts a set of placed objects to an object array for the DynO mapper.
	Places this information in the debug output for processing.

	Parameter(s):
	_this select 0: position of the anchor point (Array)
	_this select 1: size of the covered area (Scalar)
	_this select 2: grab object orientation? (Boolean) [default: false]
	
	Returns:
	Ouput text (String)
*/

private ["_anchorPos", "_anchorDim", "_grabOrientation", "_triggerObj"];
_anchorPos = _this param [0, [0, 0], [[]]];
_anchorDim = _this param [1, 50, [-1]];
_grabOrientation = _this param [2, false, [false]];
_triggerObj = _this param [3, objNull, [objNull]];

private ["_objs"];
//first edit - instead of just editor-placed objects, we need both world objects and any editor-placed objects on top.
_objs = nearestTerrainObjects [_anchorPos, [], _anchorDim];
_objs = _objs + nearestObjects [_anchorPos, [], _anchorDim];




//hint format ["%1", _objs];
//systemChat toString _objs;

//Formatting for output
private ["_br", "_tab", "_outputText"];
_br = toString [13, 10];
_tab = toString [9];

hint "Object scanning begins now. Please wait...";
//Adding meta-data
_outputText = "/*" + _br + "Grab data:" + _br;
_outputText = _outputText + "Mission: " + (if (missionName == "") then {"Unnamed"} else {missionName}) + _br;
_outputText = _outputText + "World: " + worldName + _br;
_outputText = _outputText + "Anchor position: [" + (str (_anchorPos select 0)) + ", " + (str (_anchorPos select 1)) + "]" + _br;
_outputText = _outputText + "Area size: " + (str _anchorDim) + _br;
_outputText = _outputText + "Using orientation of objects: " + (if (_grabOrientation) then {"yes"} else {"no"}) + _br + "*/" + _br + _br;
_outputText = _outputText + "[" + _br;

//second edit - we NEED unfiltered results that include anything and everything, so the whole section for filtering objects is removed.
//First filter illegal objects
/*
{
	//Exclude non-dynamic objects (world objects)
	private ["_allDynamic"];
	_allDynamic = allMissionObjects "All";
	
	if (false) then 
	{	
		//Exclude characters
		private ["_sim"];
		_sim = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "simulation");
		
		if (_sim in ["soldier"]) then
		{
			_objs set [_forEachIndex, -1];
		};
	} 
	else 
	{
		_objs set [_forEachIndex, -1];
	};
} forEach _objs;
*/

//_objs = _objs - [-1];

//Process remaining objects
{
	private ["_type", "_ASL", "_objPos", "_dX", "_dY", "_z", "_azimuth", "_fuel", "_damage", "_orientation", "_varName", "_init", "_simulation", "_replaceBy", "_outputArray"];
	_type = typeOf _x;
	_ASL = _x getVariable ["ASL", false];
	if (!_ASL) then {_objPos = position _x;} else {_objPos = getPosASL _x;}; //To cover some situations (inside objects with multiple roadways)
	_dX = (_objPos select 0) - (_anchorPos select 0);
	_dY = (_objPos select 1) - (_anchorPos select 1);
	_z = _objPos select 2;
	_azimuth = direction _x;
	_fuel = fuel _x;
	_damage = damage _x;
	if (_grabOrientation) then {_orientation = _x call BIS_fnc_getPitchBank;} else {_orientation = [];};
	_varName = vehicleVarName _x;
	_init = _x getVariable ["init", ""];
	//TODO: re-enable once 3D editor simulation is fixed
	//_simulation = simulationEnabled _x;
	_simulation = _x getVariable ["simulation", true];
	
	_replaceBy = _x getVariable ["replaceBy", ""];
	if (_replaceBy != "") then {_type = _replaceBy;};
	_placingPoint = "";
	_scale = 1;
	//third edit - added a piece of code to handle objects without a classname (will be spawned as simpleObjects instead)
	if (_type == "") then {_type = (getModelInfo _x) select 1; _placingPoint = (getModelInfo _x) select 3; _scale = getObjectScale _x};
	//fourth edit - added info about object placing point for simpleObjects to the output array
	if (_type != "") then {
	_outputArray = [_type, [_dX, _dY, _z], _azimuth, _fuel, _damage, _orientation, _varName, _init, _simulation, _placingPoint, _scale, _ASL];

	_outputText = _outputText + _tab + (str _outputArray);
	};
	_outputText = if (_forEachIndex < ((count _objs) - 1) && _type != "") then {_outputText + ", " + _br} else {_outputText + _br};
	if (count _outputText > 9999500) then 
	{
		_outputText = _outputText + "]";
		copyToClipboard _outputText;
		hintC "String limit reached. The script has saved data into your clipboard, please save them to an empty script/text editor.\nObject scanning will be split into multiple parts. Once you confirm this message, internal variables will be cleared and object scanning will continue. Once scanning is fully complete, you will be informed of it by a hint message. Please don't forget to paste the data from each part of the scanning process.";
		_outputText = "";
		//Adding meta-data
		_outputText = "/*" + _br + "Grab data:" + _br;
		_outputText = _outputText + "Mission: " + (if (missionName == "") then {"Unnamed"} else {missionName}) + _br;
		_outputText = _outputText + "World: " + worldName + _br;
		_outputText = _outputText + "Anchor position: [" + (str (_anchorPos select 0)) + ", " + (str (_anchorPos select 1)) + "]" + _br;
		_outputText = _outputText + "Area size: " + (str _anchorDim) + _br;
		_outputText = _outputText + "Using orientation of objects: " + (if (_grabOrientation) then {"yes"} else {"no"}) + _br + "*/" + _br + _br;
		_outputText = _outputText + "[" + _br;
	};
	//debugLog (format ["Log: objectGrabber: %1", _outputArray]);
} forEach (_objs inAreaArray _triggerObj);
systemchat format ["%1",_outputText select [count _outputText -4,4]];
if ("," in (_outputText select [count _outputText -4,4])) then {_outputText = _outputText select [0,count _outputText -4];systemchat "removed"};
_outputText = _outputText + "]";
copyToClipboard _outputText;
hint "Scanning complete. Data (of this part of scanning, if there were multiple) have been saved to your clipboard.";

_outputText