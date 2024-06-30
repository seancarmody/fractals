// sierpinksi.asy
// Draw Sierpinski triangle
//
// Author:    Sean Carmody (sean@stubbornmule.net)
// Created:   18 Jun 2024
// Modified:  22 Jun 2024

// To convert pdf output to png:
// pdftoppm triangle.pdf -png -singlefile triangle
settings.outformat = "pdf";
size(300);

import fractals;

// Create an equilateral triangle and contraction at each point
path tri = reverse(rotate(240) * polygon(3));
transform[] t = ptransforms(tri, scale(0.5));

// Uncomment code below to generate rotation variant
// transform[] t = ptransforms(tri, rotate(45) * scale(0.515));
path h = hull(t, depth = 6);

// Draw fractal
drawfrac(t, h, depth = 9, lightblue);

// Draw line through 3-cycles and 2-cycle
pair bc = fixedword(t, "bc");
pair ab = fixedword(t, "ab");
pair cb = fixedword(t, "cb");
pair abc = fixedword(t, "abc");
pair abcb = fixedword(t, "abcb");
pair A = point(tri, 0);
pair B = point(tri, 1);
pair C = point(tri, 2);
draw(bc--A, mediumgrey);
draw(ab--C, mediumgrey);
draw(ab--cb, mediumgrey);
draw(B--abc, mediumgrey);

// Add cycle points
drawword(t, "a", "$A = a^\ast$", SW);
drawword(t, "b", "$B = b^\ast$", N);
drawword(t, "c", "$C = c^\ast$", SE);
drawword(t, "ab", W);
drawword(t, "bc", E);
drawword(t, "cb", E);
drawword(t, "abc", S);
drawword(t, "bca", SE, grey);
drawword(t, "cab", S, grey);
drawword(t, "abcb", N);
drawword(t, "bcba", N, grey);
drawword(t, "babc", W, grey);
drawword(t, "cbab", S, grey);

shipout("triangle", bbox(0.25cm, white));

// Don't save a default image
erase();