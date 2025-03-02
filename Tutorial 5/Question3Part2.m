sigma = 0.6;
W_values = 12000:200:20000;
D_min_values = zeros(size(W_values));

for i = 1:length(W_values)

    D = @(V) 0.01 * sigma * V^2 + (0.95/sigma) * (W_values(i)/V)^2;

    V_min = fminbnd(D, 0, 1000);

    D_min_values(i) = D(V_min);
end

figure;
plot(W_values, D_min_values);
xlabel('Weight');
ylabel('Minimum Drag');
title('Minimum Drag as a Function of Weight');
grid on;