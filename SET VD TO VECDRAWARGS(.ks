SET VD TO VECDRAWARGS(
              a:ALTITUDEPOSITION(a:TERRAINHEIGHT+100),
              a:POSITION - a:ALTITUDEPOSITION(a:TERRAINHEIGHT+100),
              red, "THIS IS A THE SPOT", 1, true). 
SET Ve TO VECDRAWARGS(
              b:ALTITUDEPOSITION(b:TERRAINHEIGHT+100),
              b:POSITION - b:ALTITUDEPOSITION(b:TERRAINHEIGHT+100),
              blue, "THIS IS B THE SPOT", 1, true).   
SET Vf TO VECDRAWARGS(
              c:ALTITUDEPOSITION(c:TERRAINHEIGHT+100),
              c:POSITION - c:ALTITUDEPOSITION(c:TERRAINHEIGHT+100),
              green, "THIS IS C THE SPOT", 1, true).      
SET Vg TO VECDRAWARGS(
              d:ALTITUDEPOSITION(d:TERRAINHEIGHT+100),
              d:POSITION - d:ALTITUDEPOSITION(d:TERRAINHEIGHT+100),
              red, "THIS IS d THE SPOT", 1, true).                                  
