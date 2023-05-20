
//idea - keep generator-specific variable that will check a site of ropes.
//make a recursive function that will travel from a pole to all connected (fromObject) ropes
//if the other side has a lamp, light up the lamp and continue
//if the other side has a pole, continue
//in either way, it should mark the location as traversed, and it should only travel to places
//that haven't yet been traversed

//this script only sets up the variable, finds nearby poles, and runs the recursive script for them



_generator = _this select 0;
_mode = _this select 1;
_generator setVariable ["fex_traversed", [], true];
_nearbyPoles = nearestObjects [_generator, ["Land_PowerPoleWooden_F"],10];
{_0 = [_x, _mode,_generator] execVM "generator_pulse.sqf";} forEach _nearbyPoles;