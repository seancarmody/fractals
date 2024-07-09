// utils.asy
// 
// Miscellaneous utility functions
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   9 Jun 2024
// Modified:  9 Jun 2024

// Extract the vertices of a path (cyclic or otherwise)
// Source: Charles Staats
// https://tex.stackexchange.com/questions/249659/how-to-center-a-label-inside-a-closed-path-in-asymptote
pair[] vertices(path g) { 
  return sequence(new pair(int i) { return point(g,i); }, size(g)); 
}

// Create apply a transform centred on the point P
transform contract(pair P, transform t) {return shift(P) * t * shift(-P);}

// Calculate the fixed point of a transform (no error trapping)
pair fixed(transform t)
{return inverse(identity + scale(-1) * shiftless(t)) * shift(t) * (0,0);}

// Calculate the determinant of a transform
real det(transform t)
{
  return t.xx * t.yy - t.xy * t.yx;
}

// Calculate the determinants of an array of transforms
real[] det(transform[] t)
{
  return sequence(new real(int i) {return det(t[i]);}, t.length);
}
// Delete duplicates from an integer array - note: order is *not* preserved
int[] unique(int[] arr)
{
  int[] sorted = sort(arr);
  int[] uniq = {sorted[0]};
  for (int i=1; i < sorted.length; ++i)
  {
    if (sorted[i] != sorted[i-1]) {uniq.push(sorted[i]);}
  }
  return uniq;
}

// Delete duplicates from a pair array - note: order *is* preserved
pair[] unique(pair[] arr)
{
  pair [] uniq = copy(arr);
  int current, end = uniq.length-1;
  for (int j=0; j<end; ++j)
  {
    current = j+1;
    while (current <= end)
    {
      if (uniq[current] == uniq[j]) {uniq[current] = uniq[end]; --end;}
      else {++current;}
    }
  }
  if (end < uniq.length - 1) {uniq.delete(end+1, uniq.length-1);}
  return uniq;
}

// Shift a transform to be centred on eacg of a sequence of points
from mapArray(Src=pair, Dst=transform) access map;
transform[] ptransforms(pair[] pts, transform t)
{
  return map(new transform (pair P){return shift(P) * t * shift(-P);}, pts);
}

// Shift a transform to be centred on eacg of a sequence of points on a path
transform[] ptransforms(path shp, transform t)
{
  pair[] pts = vertices(shp);
//   return sequence(new transform(int i) {return contract(pts[i], t);}, pts.length);
  return ptransforms(pts, t);
}

// Get index of leftmost point from a point set (ties return lowest point)
int leftmost(pair [] pset)
{
  int i=0;
  for (int k=1; k<pset.length; ++k)
    {
      if (pset[i].x > pset[k].x || (pset[i].x == pset[k].x && pset[i].y > pset[k].y))
        {i = k;}
    }
  return i;
}

// Return the convex hull of an array of points
// Uses the Jarvis March (aka gift wrapping) algorithm
// Calculation uses orient function to determine direction
// and values below a tolerance (default 1e-15) are treated as zero
path jarvis(pair[] pset, real tol = 1e-15)
{
  path hull;
  if (pset.length ==0) {return hull;}
  // Remove duplicates 
  pair [] pts = unique(pset); 
  // k = index of a point to add to the hull and start with leftmost point  
  // i = index of candidate point, j = index of test point 
  int i, j, left = leftmost(pts), k = left; 
  real dirn;

  do 
  {
    hull = hull--pts[k];
    i = 0;
    for (int j=0; j < pts.length; ++j)
    {
      dirn = orient(relpoint(hull, 1), pts[i], pts[j]);
      // Avoid missing a zero due to precision errors       
      if (abs(dirn) < tol) {dirn = 0;}
      if (i == k ||
          dirn > 0 ||
          (dirn == 0 && length(pts[j] - pts[k]) > length(pts[i] - pts[k]))) {i = j;}
    }
    k = i;
  } while (i != left);
  hull = hull--cycle;
  return hull;
}
