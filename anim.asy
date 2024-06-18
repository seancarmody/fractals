// anim.asy
//
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   18 Jun 2024
// Modified:  18 Jun 2024

import animation;

settings.outformat = "pdf";
size(10cm);

import fractals;

animation mov;

// Create an equilateral triangle and contraction at each point
path tri = polygon(3);
transform[] t = pathcontract(tri, scale(0.5));

// Draw fractal

for (int i = 0, i < 10; ++i)
{
  save();
  drawfrac(t, tri, depth = i, blue);
  restore();
}

shipout("images/triangle", bbox(0.25cm, white));
erase();