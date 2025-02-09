%{
Initializing Arrays for the Z = 100 Line and
Constants used in Impedance Formula
%}
freq_array = linspace(1000, 5000, 1000);
omega_array = 2*pi*freq_array;
constImped_array = 100*ones(1,1000);
imped_array = zeros(size(omega_array));

% Function for Calculating Impedance Values
function value = zImped(omega)
R = 225;
C = 0.0000006;
L = 0.5;

value = 1/(sqrt(1/R^2 + (omega*C - 1/(omega*L))^2));
end

%{
Populating Impedance Array Using the 
Impedance Function and Angular Frequency Values 
%}
for k = 1:1000
    imped_array(k) = zImped(omega_array(k));
end

% Graph the Impedance Function and Line of Constant Impedance Together
plot(freq_array, imped_array, 'k', 'LineWidth', 2, 'DisplayName', 'RLC Impedance');
hold on;
plot (freq_array, constImped_array, 'r', 'LineWidth', 1, 'DisplayName', 'Z = 100Ω');
ylabel('Impedance (Ω)');
xlabel('Angular Frequency (rad)');
title('Impedance of a RLC Circuit with Varying Frequency');
legend;
ginput(1);