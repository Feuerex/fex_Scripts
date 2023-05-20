//this script handles the overall generator functions.
//handles the actions of the generator, tracks the damage, spawns related effects.
//runs other generator related scripts when necessary.

_generator = _this select 0;
_generator setVariable ["fex_state", "OFF"];

if ((_generator getEventHandlerInfo ["HandleDamage",0]) select 0 == false) then 
{
	_generator addEventHandler ["HandleDamage",
	{
		_0 = [_this, _thisEventHandler] spawn 
		{
			_generator = ((_this select 0) select 0);
			//systemChat "shutting down";
			//make sure it doesn't run repeatedly on further damage to the generator
			_generator removeEventHandler ["HandleDamage", _this select 1];
			_generator setVariable ["fex_state", "OFF"];
			if (!isNull (_generator getVariable "fex_loop_sound")) then 
			{
				deleteVehicle (_generator getVariable "fex_loop_sound");
			};
			removeAllActions _generator;
			sleep 0.5;
			_0 = [_generator, (_generator getVariable "fex_state")] execVM "generator.sqf";
			
			//Make sure the generator stays indestructible, to prevent it from disappearing
			_generator addEventHandler ["HandleDamage",{0}];
			
			_particle_emitter_0 = "#particlesource" createVehicle ([position _generator select 0, position _generator select 1, 0.8] );
			_particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,5,0],"","Billboard",1,11,[0,0,0],[0,0,0.4],0.05,1.25,1.1,1,[0.6,1,0.6,1,2],[[0.5,0.5,0.5,0.7],[0.6,0.6,0.6,0.4],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.08],[0.9,0.9,0.9,0.01]],[1000],0.2,0.2,"","","",0,false,0,[[0,0,0,0]],[0,1,0]];
			_particle_emitter_0 setParticleRandom [0,[0.1,0.1,0.1],[0.6,0.6,0.6],10,0.2,[0,0,0,0],0,0,1,0];
			_particle_emitter_0 setParticleCircle [0,[0,0,0]];
			_particle_emitter_0 setParticleFire [0,0,0];
			_particle_emitter_0 setDropInterval 0.04;
			[_particle_emitter_0, _generator] spawn {sleep 120;deleteVehicle (_this select 0); (_this select 1) removeAllEventHandlers "HandleDamage";};
		};0
	}];
};

(_generator) addAction 
[
"Switch ON", 
	{
		(_this select 0) removeAction (_this select 2);
		//play startup sound
		(_this select 0) setVariable ["fex_state", "ON"];
		(_this select 0) say3D "startUp";
		sleep 0.85;
		_0 = [_this select 0] spawn 
		{
			while {(_this select 0) getVariable "fex_state" == "ON"} do 
			{
				//(_this select 0) SetVariable ["fex_s_lamps",0];
				_0 = [_this select 0, ((_this select 0) getVariable "fex_state")] execVM "generator.sqf";
				sleep 1;
			};
		};
		//play loop sound on loop
		_soundSource = createSoundSource ["gen_loop", position (_this select 0), [], 0];
		(_this select 0) setVariable ["fex_loop_sound", _soundSource];
		(_this select 0) addAction ["Switch OFF", 
		{
			(_this select 0) removeAction (_this select 2);
			//play shutOff sound
			(_this select 0) setVariable ["fex_state", "OFF"];
			(_this select 0) say3D "shutOff";
			sleep 0.5;
			deleteVehicle (_this select 3);
			_0 = [_this select 0, ((_this select 0) getVariable "fex_state")] execVM "generator.sqf";
			sleep 2.5;
			[_this select 0] execVM "generator_controller.sqf";
		}, _soundSource,1.5,true,true,"","true",4];
	},nil,1.5,true,true,"","true",4
];
