clear; clc; close all;

% 1. DATA INPUT
x_exp = [12.6 10.4 6.4 3 0] / 100; % Distance from base (m)
temp_ver = [61.7 63.6 63.8 81.7 96.1]; 
temp_hori = [66.3 68.7 69.6 85.5 99.8]; 

% 2. PLOTTING
figure('Color', 'w');
hold on;

% Plot Vertical Data (Red Circles)
plot(x_exp, temp_ver, 'ro-', 'LineWidth', 1, 'MarkerFaceColor', 'r', ...
    'MarkerSize', 8, 'DisplayName', 'Vertical Orientation');

% Plot Horizontal Data (Blue Squares)
plot(x_exp, temp_hori, 'bs-', 'LineWidth', 1, 'MarkerFaceColor', 'b', ...
    'MarkerSize', 8, 'DisplayName', 'Horizontal Orientation');

% 3. FORMATTING
grid on;
xlabel('Distance from Base x (m)');
ylabel('Temperature (°C)');
title('Experimental Temperature Data: Vertical vs Horizontal');
legend('Location', 'best');
xlim([-0.01, 0.14]); 
ylim([min([temp_ver, temp_hori])-5, max([temp_ver, temp_hori])+5]);

hold off;