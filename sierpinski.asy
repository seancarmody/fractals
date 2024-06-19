// sierpinksi.asy
// Draw Sierpinski 
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   18 Jun 2024
// Modified:  18 Jun 2024


settings.outformat = "pdf";
size(10cm);

import fractals;

// Create an equilateral triangle and contraction at each point
path tri = polygon(3);
transform[] t = pathcontract(tri, scale(0.5));

// Uncomment code below to generate rotation variant
// transform[] t = pathcontract(tri, rotate(45) * scale(0.515));
path h = hull(t, depth = 6);

// Draw fractal
drawfrac(t, h, depth = 9, blue);

// Add cycle points
drawword(t, "a", SE);
drawword(t, "b", N);
drawword(t, "c", SW);
drawword(t, "abc");
drawword(t, "bca");
drawword(t, "cab", red);

shipout("images/triangle", bbox(0.25cm, white));
erase();