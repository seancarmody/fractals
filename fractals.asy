// fractals.asy
// Code to generate contraction fractals
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   9 Jun 2024
// Modified:  9 Jun 2024


import utils;

// Calculate fractal dimension of array of ratios
real fdim(real[] r, real tol = 1e-14, int maxiter = 100)
{
  int n = r.length, k = 0;
  real[] lr = map(log, r);
  real f, s = 1.5;
  do
  {
    f = sum(map(new real(real x) {return x^s;}, r)) - 1;
    s = s - f / sum(sequence(new real(int i) {return r[i]^s * lr[i];}, n));
    ++k;
  } while (abs(f) > tol && k < maxiter);
  return s;
}

// Calculate fractal dimension of array of contraction maps
real fdim(transform[] t, real tol = 1e-14, int maxiter = 100)
{
  real[] r = sequence(new real(int i) {return det(t[i]);}, t.length);
  return fdim(r, tol, maxiter) * 2;
}

// Generate all composites of transforms of a specified
// length from a given array of transforms
transform[] nwords(transform[] tset, int n = 3)
{
  transform [] res;
  if (n==0) {res.push(identity); return res;}
  transform[] w = nwords(tset, n - 1);
  for (transform s: tset)
  {
    for (transform t: w) {res.push(s * t);}
  }
  return res;
}

// Compose a sequence of transforms. Note that the first entry
// of the sequence is applied last
transform fold(transform[] arr)
{
  if (arr.length == 0) {return identity;}
  if (arr.length == 1) {return arr[0];}
  return arr[0] * fold(arr[1:]);  
}

// Smoothly interpolate from transform t to transform s
transform morph(transform t, transform s, real alpha)
{
  return scale(1 - alpha) * t + scale(alpha) * s;
}

// Smoothly interpolate from transform t[i] to transform s[i]
transform[] morph(transform t[], transform s[], real alpha)
{
  transform[] res;
  if (t.length == s.length)
  {
    for (int i = 0; i < t.length; ++i)
    {
      res[i] = morph(t[i], s[i], alpha);
    }
  }
  return res;
}

// Turn a string into a sequence of transforms
transform word(transform[] t, string w, string first = "A")
{
  int zero = ascii(first);
  string[] arr = array(w);
  transform[] s = sequence(new transform (int i){return t[ascii(arr[i]) - zero];}, length(w));
  return fold(s);
}

// Calculate the fixed point of a word
pair fixedword(transform[] t , string w, string first = "a")
{
  return fixed(word(t, w, first));
}

// Label a fixed point
void drawword(transform[] t , string w, 
    string lab = "", string first = "a", pair dir = NE,
  pen p = currentpen, picture pic = currentpicture)
{
  if (length(lab)==0) {
    if (length(w) > 1) {lab = "$(" + w + ")^*$";} else {lab = "$" + w + "^*$";}
  }
  pair pt = fixedword(t, w, first);
  dot(pic, pt, p);
  label(pic, lab, pt, dir, p);
}

// Generate an approximation of the convex hull
// of a contraction fractal base on generating
// the fractal to a specified depth
path hull(transform[] tset, int depth = 1)
{
  path p;
  if ((tset.length == 0)){return p;}
  transform[] frac = nwords(tset, depth);
  pair[] pts = sequence(new pair(int i) {return fixed(frac[i]);}, frac.length);
  return jarvis(pts);
}

// Draw a contraction fractal by applying the contractions 
// to a given path
void drawfrac(transform[] tset, int depth = 3, path region,
  pen p = currentpen, picture pic = currentpicture, bool border = false)
{
  transform[] frac = nwords(tset, depth);
  for (transform t: frac)
  {
    if (border) filldraw(pic, t * region, p); else fill(pic, t * region, p);
  }
  return;
}