// fern.asy
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   3 Jul 2024

settings.outformat = "pdf";
size(300);

import fractals;

transform[] t = {
  (0,    0,     0,     0,     0, 0.16),
  (0, 1.60,  0.85,  0.04, -0.04, 0.85),
  (0, 1.60,  0.20, -0.26,  0.23, 0.22),
  (0, 0.44, -0.15,  0.28,  0.26, 0.24)
};

// Calculate hull
path h = hull(t, depth = 5);

// Draw fractal
drawfrac(t, h, depth = 11, mediumgreen);

shipout("fern", bbox(0.25cm, white));
