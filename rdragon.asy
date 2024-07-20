// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   17 Jul 2024
// 
// Draw Heighway Dragon

settings.outformat = "pdf";
size(10cm);

import fractals;
import random;

real s = 1/sqrt(2);

transform[] t = 
  {
    rotate(-45) * scale(s),
    shift(1, 0) *  scale(s) * rotate(-135)
  };

// Draw fractal
genrand(t, 800000, scale = 1/800, darkgreen);

// shipout("dragon", f = bbox(0.25cm));
shipout(bbox(0.25cm));