// spiral.asy
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   7 Jul 2024

// https://math.stackexchange.com/questions/1900337/how-to-optimally-adjust-the-probabilities-for-the-random-ifs-algorithm

settings.outformat = "pdf";
size(300);

import random;

transform[] t = {
    scale(0.98) * rotate(137.5),
    shift(1,0) * scale(0.1)
  };

// Override sampling probabilities
// Fractal dimension weighted
// real[] w = {0.969768, 0.0302322};
// Equal weighted
// real[] w = {0.5, 0.5};
// Determinant weighted
// real[] w = {0.989695, 0.010305};

// genrand(t, w, 100000, scale = 1/800);
genrand(t, 100000, scale = 1/800);

shipout("spiral", bbox(0.25cm, white));
