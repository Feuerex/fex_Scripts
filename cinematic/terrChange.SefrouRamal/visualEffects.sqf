PP_colorC = ppEffectCreate ["ColorCorrections",1500];
PP_colorC ppEffectEnable true;
PP_colorC ppEffectAdjust [0.96,1.23,-0.22,[0.37,0.77,0.98,-0.15],[1.92,1,2.44,1.1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
PP_colorC ppEffectCommit 0;

sleep 1;
//1.76 originally
setAperture 2.56;