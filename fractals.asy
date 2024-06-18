// fractals.asy
// Code to generate contraction fractals
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   9 Jun 2024
// Modified:  9 Jun 2024


import utils;

// Generate all composites of transforms of a specified
// length from a given array of transforms
transform[] words(transform[] tset, int length = 3)
{
  transform [] res;
  if (length==0) {res.push(identity); return res;}
  transform[] w = words(tset, length - 1);
  for (transform s: tset)
  {
    for (transform t: w) {res.push(s * t);}
  }
  return res;
}

// Generate an approximation of the convex hull
// of a contraction fractal base on generating
// the fractal to a specified depth
path hull(transform[] tset, int depth = 1)
{
  path p;
  if ((tset.length == 0)){return p;}
  transform[] frac = words(tset, depth);
  pair[] pts = sequence(new pair(int i) {return fixed(frac[i]);}, frac.length);
  return jarvis(pts);
}

// Draw a contraction fractal by applying the contractions 
// to a given path
void drawfrac(transform[] tset, int depth = 3, path region,
  pen p = currentpen, picture pic = currentpicture, bool border = false)
{
  transform[] frac = words(tset, depth);
  for (transform t: frac)
  {
    if (border) filldraw(pic, t * region, p); else fill(pic, t * region, p);
  }
  return;
}