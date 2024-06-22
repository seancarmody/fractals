// sierpinksi.asy
// Draw Sierpinski triangle
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   18 Jun 2024
// Modified:  22 Jun 2024

// To convert pdf output to png:
// pdftoppm triangle.pdf -png -singlefile triangle
settings.outformat = "pdf";
size(250);

import fractals;

// Create an equilateral triangle and contraction at each point
path tri = polygon(3);
transform[] t = ptransforms(tri, scale(0.5));

// Uncomment code below to generate rotation variant
// transform[] t = ptransforms(tri, rotate(45) * scale(0.515));
path h = hull(t, depth = 6);

// Draw fractal
drawfrac(t, h, depth = 9, lightblue);

// Draw line through 3-cycles and 2-cycle
pair bc = fixedword(t, "bc");
pair A = fixedword(t, "a");
draw(bc--A, mediumgrey);

// Add cycle points
drawword(t, "a", "$A = a^\ast$", SE);
drawword(t, "b", "$B$", N);
drawword(t, "c", "$C$", SW);
drawword(t, "bc", NW);
drawword(t, "abc");
drawword(t, "bca");
drawword(t, "cab", grey);

shipout("triangle", bbox(0.25cm, white));

// Don't save a default image
erase();