// sierpinksi.asy
// Draw Sierpinski 
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   18 Jun 2024
// Modified:  18 Jun 2024

settings.outformat = "pdf";
size(300);

import fractals;

// Create an equilateral triangle and contraction at each point
path tri = polygon(3);
transform[] t = ptransforms(tri, scale(0.5));

// Uncomment code below to generate rotation variant
// transform[] t = ptransforms(tri, rotate(45) * scale(0.515));
path h = hull(t, depth = 6);

// Draw fractal
drawfrac(t, h, depth = 9, lightblue);

// Add cycle points
drawword(t, "a", "$A$", SE);
drawword(t, "b", "$B$", N);
drawword(t, "c", "$C$", SW);
drawword(t, "abc");
drawword(t, "bca");
drawword(t, "cab", blue);

shipout("images/triangle", bbox(0.25cm, white));
// Don't save a default image
erase();