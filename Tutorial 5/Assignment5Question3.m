% Clear Memory and Output Space
clc; clear; close all;

% Constants
sigma = 0.6;
w1 = 16000;                              % Prescribed Weight for Part 1
w_Values = 12000:200:20000;              % Array of Weights for Part 2
d_Min_Num_Values = zeros(size(w_Values)); % Array for Minimum Drags Calculated Numerically in Part 2
d_Min_Ana_Values = zeros(size(w_Values)); % Array for Minimum Drags Calculated Analytically in Part 2

% Drag Formula
Drag = @(v) 0.01 * sigma * v^2 + (0.95/sigma) * (w1/v)^2;

%% Question 3 Part 1 Solution
v_Min = fminbnd(Drag, 0, 1000);
d_Min = Drag(v_Min);
fprintf('The velocity required to minimize the drag of a payload weighing 16,000 [units] is %f [units]. \nThe corresponding drag is %f [units]. ', v_Min, d_Min);

%% Question 3 Part 2 Solution

% For-Loop for Numerical Solution
for i = 1:length(w_Values)
    Drag = @(v) 0.01 * sigma * v^2 + (0.95/sigma) * (w_Values(i)/v)^2;
    v_Min_Num = fminbnd(Drag, 0, 1000);
    d_Min_Num_Values(i) = Drag(v_Min_Num);
end

% For-Loop for Analytical Solution
for i = 1:length(w_Values)
    syms v positive
    eqn = 0.02*sigma*v - 1.9*w_Values(i)^2/(sigma*v^3) == 0;
    v_Min_Ana = solve(eqn, v, Real=true);
    d_Min_Ana_Values(i) = 0.01*sigma*v_Min_Ana^2 + (0.95/sigma) * (w_Values(i)/v_Min_Ana)^2;
end

figure;
plot(w_Values, d_Min_Num_Values, '--r', 'LineWidth', 1, 'DisplayName', 'Numerical Approach');
hold on;
plot (w_Values, d_Min_Ana_Values, ':g', 'LineWidth', 1, 'DisplayName', 'Analytical Approach')
title('Minimum Drag as a Function of Weight');
xlabel('Weight');
ylabel('Minimum Drag');
legend ('Location', 'best');
grid on;
