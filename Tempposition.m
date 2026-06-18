clc; clear; close all;

x = [0 0.035 0.06 0.082 0.101];   % position (m)
T = [157.7 147.8 133.5 126.7 124.3]; % temperature (°C)

figure;
plot(x, T, 'o-', 'LineWidth', 2);

xlabel('Position along rod (m)');
ylabel('Temperature (°C)');
title('Temperature Variation along Rod');

grid on;