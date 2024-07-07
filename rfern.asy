// rfern.asy
// Draw Barnsley Fern using random points
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   7 Jul 2024

settings.outformat = "pdf";
size(300);

import random;

transform[] t = {
  (0,    0,     0,     0,     0, 0.16),
  (0, 1.60,  0.85,  0.04, -0.04, 0.85),
  (0, 1.60,  0.20, -0.26,  0.23, 0.22),
  (0, 0.44, -0.15,  0.28,  0.26, 0.24)
};

real[] w = {0.01, 0.85, 0.07, 0.07};

genrand(t, w, 1000000, scale = 1/500, darkgreen);

shipout("rfern", bbox(0.25cm, white));
