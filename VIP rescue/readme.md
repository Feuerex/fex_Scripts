This folder contains 4 variations of the same mission concept - rescuing and escorting a VIP to safety.

See video here https://youtu.be/mfbQSqXwqiY

How to use 
- select the variation you want to use
- unpack your selected folder to Documents/Arma 3/missions
- Run Arma 3
- open the mission in EDEN editor and enjoy

- for example, selecting the third variant, you'd want to place escort3.Stratis to your /missions/ folder and then open a scenario called "escort3" on Stratis island.


Brief description of differences between each scenario

#####escort.Stratis#####

Default mission flow.

EDEN is required

VIP is rescued via AddAction

Helicopter gets an EventHandler

#####escort2.Stratis#####

Default mission flow.

EDEN is NOT required

VIP is rescued by coming close and performing the "salute" gesture

VIP moves on their own to the helicopter

VIP gets an event handler for detecting when he gets inside the heli

#####escort3.Stratis#####

Default mission flow.

EDEN is NOT required

Everything is in one big script

VIP is rescued via AddAction

Heli gets the Event Handler

#####escort4.Stratis#####

Default mission flow.

EDEN is NOT required

VIP is rescued via AddAction

Helicopter gets an EventHandler

Global variables are not used (although I used SetVariable to store some values in object namespaces, so it's not perfect either)
