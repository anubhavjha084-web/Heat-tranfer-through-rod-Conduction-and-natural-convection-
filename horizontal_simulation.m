clear; clc;
    
% 1. EXPERIMENTAL DATA (Horizontal)
temp_exp = [66.3 68.7 69.6 85.5 99.8]; 
x_exp = [12.6 10.4 6.4 3 0] / 100; 
T_inf = 31.3;
L_actual = 0.14; 
theta0 = temp_exp(end) - T_inf;

% 2. GEOMETRY & PROPERTIES
Do = 0.015;  Di = 0.014;
Ac = (pi/4)*(Do^2 - Di^2);
P = pi*Do;
k_cu = 385; 
L_corr = L_actual + Ac/P; % Corrected length for tip loss

% 3. EXPERIMENTAL FITTING (Finding h_exp)
% Uses the heat transfer solution for a fin with an insulated tip
model = @(m, x) theta0 .* cosh(m*(L_corr - x)) ./ cosh(m*L_corr);
m_fit = lsqcurvefit(model, 5, x_exp, temp_exp - T_inf);
h_exp = (m_fit^2 * k_cu * Ac) / P;

% 4. THEORETICAL CORRELATION (Convection + Radiation)
% Properties of air at Film Temp (~55C)
k_air = 0.028; nu = 1.85e-5; Pr = 0.71; beta = 1/(273+55);
g = 9.81;
sigma = 5.67e-8;     % Stefan-Boltzmann Constant [W/m^2K^4]
epsilon = 0.60;      % Emissivity
dT = mean(temp_exp) - T_inf;

% A. Natural Convection (Churchill and Chu)
Ra_d = (g * beta * dT * Do^3 / nu^2) * Pr;
Nu_d = (0.60 + (0.387 * Ra_d^(1/6)) / (1 + (0.559/Pr)^(9/16))^(8/27))^2;
h_conv = (Nu_d * k_air) / Do;

% B. Radiation
T_s_avg_K = mean(temp_exp) + 273.15; 
T_inf_K = T_inf + 273.15;
h_rad = epsilon * sigma * (T_s_avg_K + T_inf_K) * (T_s_avg_K^2 + T_inf_K^2);

% C. Total Theoretical h
h_theo = h_conv + h_rad;
m_theo = sqrt((h_theo * P) / (k_cu * Ac));

% 5. SIMULATION PROFILES
x_sim = linspace(0, L_corr, 100);
T_fitted = T_inf + theta0 .* (cosh(m_fit*(L_corr - x_sim)) ./ cosh(m_fit*L_corr));
T_theo = T_inf + theta0 .* (cosh(m_theo*(L_corr - x_sim)) ./ cosh(m_theo*L_corr));

% 6. PLOT
figure('Color', 'w');
plot(x_exp, temp_exp, 'bo', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Experimental Data'); hold on;
plot(x_sim, T_fitted, 'r-', 'LineWidth', 2, 'DisplayName', ['Fitted (h=' num2str(h_exp,'%.2f') ')']);
plot(x_sim, T_theo, 'k--', 'LineWidth', 2, 'DisplayName', ['Theoretical (h=' num2str(h_theo,'%.2f') ')']);
xlabel('Distance x (m)'); ylabel('Temp (°C)');
title('Horizontal Fin Analysis: Convection + Radiation'); legend('Location','northeast'); grid on;

fprintf('Horizontal Experimental h: %.2f W/m^2K\n', h_exp);
fprintf('Horizontal Theoretical h (Conv+Rad): %.2f W/m^2K\n', h_theo);
fprintf('--- Breakdown: h_conv = %.2f, h_rad = %.2f\n', h_conv, h_rad);