// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   17 Jul 2024
// 
// Draw Heighway Dragon

settings.outformat = "pdf";
size(10cm);

import fractals;

path h = (0,0)--(1,0);
real s = 1/sqrt(2);

transform[] t = 
  {
    rotate(-45) * scale(s),
    shift(1, 0) *  scale(s) * rotate(-135)
  };

// Draw fractal
drawfrac(t, h, depth = 18, border = true, darkgreen);

// shipout("dragon", f = bbox(0.25cm));
shipout(bbox(0.25cm));