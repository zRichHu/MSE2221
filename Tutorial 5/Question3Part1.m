sigma = 0.6;
W = 16000;

D = @(V) 0.01 * sigma * V^2 + (0.95/sigma) * (W/V)^2;

V_min = fminbnd(D, 0, 1000)

D_min = D(V_min)