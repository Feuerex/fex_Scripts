//The action "stop being an electrician". Also makes sure the action to become one comes back
_actionID = _this select 0;
_tools = _this select 1;
_tools removeAction _actionID;
_tools addAction ["Stop being an electrician",{fex_electricianActive = false; [_this select 2,_this select 0, (_this select 3) select 0, (_this select 3) select 1] execVM 'Step1.sqf';},[_this select 2, _this select 3],1.5,true,true,"","true",4];