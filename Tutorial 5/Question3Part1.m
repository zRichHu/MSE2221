% Constants
sigma = 0.6;
W1 = 16000;                              % Prescribed Weight for Part 1
W_values = 12000:200:20000;              % Array of Weights for Part 2
D_min_numvalues = zeros(size(W_values)); % Array for Minimum Drags Calculated Numerically in Part 2
D_min_anavalues = zeros(size(W_values)); % Array for Minimum Drags Calculated Analytically in Part 2

% Drag Formula
D = @(V) 0.01 * sigma * V^2 + (0.95/sigma) * (W/V)^2;

%% Question 3 Part 1 Solution
vMin = fminbnd(D, 0, 1000);
D_min = D(vMin);

%% Question 3 Part 2 Solution

% For-Loop for Numerical Solution
for i = 1:length(W_values)
    D = @(V) 0.01 * sigma * V^2 + (0.95/sigma) * (W_values(i)/V)^2;
    vMinNum = fminbnd(D, 0, 1000);
    D_min_numvalues(i) = D(vMinNum);
end

% For-Loop for Analytical Solution
for i = 1:length(W_values)
    syms v positive
    eqn = 0.02*sigma*v - 1.9*W_values(i)^2/(sigma*v^3) == 0;
    vMinAna = solve(eqn, v, Real=true);
    D_min_anavalues(i) = 0.01*sigma*vMinAna^2 + (0.95/sigma) * (W_values(i)/vMinAna)^2;
end
