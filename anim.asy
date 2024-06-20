// anim.asy
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   18 Jun 2024
// Modified:  18 Jun 2024

import animation;
size(0,500);

import fractals;

animation mov;

// Create an equilateral triangle and contraction at each point
path tri = polygon(3);
transform[] t = ptransforms(tri, scale(0.5));

// Draw fractal

for (int i = 0; i < 11; ++i)
{
  save();
  drawfrac(t, tri, depth = i, blue);
  mov.add();
  restore();
}

erase();

// Merge the images into a gif animation.
mov.movie(BBox(0.25cm, white),loops=10,delay=250);