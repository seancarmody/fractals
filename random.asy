// random.asy
// 
// Generate IFS through random iteration
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   7 Jul 2024

import utils;
import fractals;

// Structure to hold Voss tables
struct vose 
{
  real[] accept;
  int[] alias;
}

// Set up Vose tables for Walker-Vose alias sampling method
vose vose_tables(real[] p)
{
  vose v;
  int i, j, n = p.length;
  real[] u;
  real s = sum(p);
  int[] a, over, under;
  for(i=0; i<n; ++i)
  {
    p[i] = p[i] / s;
    u[i] = p[i] * n;
    if (u[i] > 1) {over.push(i);}
    if (u[i] < 1) {under.push(i);}
  }
  while (over.length > 0 && under.length > 0){
    i = over[0];
    j = under[0];
    a[j] = i;
    under.delete(0);
    u[i] = u[i] + u[j] - 1;
    if (u[i] < 1)
      {
        over.delete(0);
        under.push(i);
      }
  }
  while (over.length > 0)
  {
    u[over[0]] = 1;
    over.delete(0);
  }
  v.accept = u;
  v.alias = a;
  return v;
}

int rvose(vose v)
{
  int n = v.accept.length;
//   int i = rand() % n;
  real u = unitrand();
  int i = floor(n * u);
  u = n * u - i;
  if (u < v.accept[i]){return i;}
  return v.alias[i];
}

// Calculate sampling probabilities array of contraction maps
real[] psamp(transform[] t, real pzero = 0.01, real tol = 1e-14, int maxiter = 100)
{
  real[] p, r = sequence(new real(int i) {return abs(det(t[i]));}, t.length);
  real tot, s = fdim(r, tol, maxiter);
  p = map(new real(real x) {return abs(x)^s;}, r);
  int nz = 0;
  for(int i; i < p.length; ++i) {if (p[i] == 0) {--nz;}}
  real tot = 1 - nz * pzero;
  for (int i; i < p.length; ++i)
  {
    if (p[i] == 0)
    {
      p[i] = pzero;
    } else
    {
      p[i] = p[i] * tot;
    }
  }
  return p;
}

void genrand(transform[] t, real[] w = psamp(t), int n = 50000,
  real scale = 1/500, int n0 = 10,
  pen p = currentpen, picture pic = currentpicture)
{
  if (t.length == 0) {return;}
  pair P = fixed(t[0]);
  if (t.length == 1) {fill(pic, circle(P, scale)); return;}
  vose v = vose_tables(w);
  for (int i=0; i < n; ++i)
  {
    P = t[rvose(v)] * P;
    fill(pic, circle(P, scale), p);
  }
  return;
}