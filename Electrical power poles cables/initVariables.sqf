//initializes some variables.
//for easier access to important objects.
//I really tried to do without these, but it's really tricky to always make sure the variables
//are defined all throughout all scripts. If you know something more elegant, let me know
fex_firstSphere = "Sign_Sphere100cm_Geometry_F" createVehicle [0,0,0];
fex_secondSphere = "Sign_Sphere100cm_Geometry_F" createVehicle [0,0,0];
fex_secondSphere setObjectTexture [0,"#(argb,8,8,3)color(0.2,0.8,0.2,0.5)"];
fex_thirdSphere = "Sign_Sphere100cm_Geometry_F" createVehicle [0,0,0];
fex_thirdSphere setObjectTexture [0,"#(argb,8,8,3)color(0.2,0.8,0.2,0.5)"];
fex_reservedSpots = [];
fex_electricianActive = false;