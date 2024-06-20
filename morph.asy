// morph.asy
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   18 Jun 2024
// Modified:  18 Jun 2024

import animation;
import fractals;

size(0,500);

animation mov;

path tri = polygon(3);
transform[] t0 = ptransforms(tri, scale(0.5));
transform[] t1 = ptransforms(tri, rotate(60)*scale(0.3, 0.7));

for (int i=0; i < 21; ++i)
{
  save();
  transform[] s = morph(t0, t1, i/20);
  path h = hull(s, depth = 6);
  drawfrac(s, h, blue, depth = 7);
  draw(hull(s, depth = 1), lightgrey);
  draw(h, lightgrey);
  mov.add();
  restore();
}

erase();

// Merge the images into a gif animation.
mov.movie(BBox(0.25cm, white),loops=4,delay=100);

