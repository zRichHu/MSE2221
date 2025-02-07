% Requires Symbolic Math Toolbox

r = 2;
L = 5;
V = 8;

syms h;

vpasolve(V == ((r^2) * acos((r-h) / r) - (r-h) * (sqrt(2 * r * h - (h^2))) * L), h)