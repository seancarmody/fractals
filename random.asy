// random.asy
// 
// Generate IFS through random iteration
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   7 Jul 2024

import utils;

// Structure to hold Voss tables
struct voss 
{
  real[] accept;
  int[] alias;
}

// Set up Voss tables
voss voss_tables(real[] p)
{
  voss v;
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

int rvoss(voss v)
{
  int n = v.accept.length;
//   int i = rand() % n;
  real u = unitrand();
  int i = floor(n * u);
  u = n * u - i;
  if (u < v.accept[i]){return i;}
  return v.alias[i];
}

void genrand(transform[] t, real[] w, int n = 1000, real scale = 1/100, int n0 = 10,
 pen p = currentpen, picture pic = currentpicture)
{
  if (t.length == 0) {return;}
  pair P = fixed(t[0]);
  if (t.length == 1) {fill(pic, circle(P, scale)); return;}
  voss v = voss_tables(w);
  for (int i=0; i < n; ++i)
  {
    P = t[rvoss(v)] * P;
    fill(pic, circle(P, scale), p);
  }
  return;
}