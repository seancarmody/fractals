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

// Wikipedia probabilities
// real[] w = {0.01, 0.85, 0.07, 0.07};
// Fractal dimension probabilities
// with probability 0.01 where det = 0
// real[] w = {0.01, 0.736, 0.124, 0.130};
// Adjusted fractal
// #1
// real[] w = {0.01, 0.79, 0.10, 0.10};
// #2
real[] w = {0.01, 0.77, 0.108, 0.112};

genrand(t, w, 1500000, scale = 1/800, deepgreen + opacity(1, "Multiply"));
// genrand(t, w, 500000, scale = 1/800, deepgreen);
// genrand(t, 1000000, scale = 1/500, darkgreen);

shipout("rfern", bbox(0.25cm, white));
