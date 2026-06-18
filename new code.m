clc; clear; close all;

T_rod  = [157.7 147.8 133.5 126.7 124.3];
T_surf = [60 56 54 50 48];
T_inf  = 31.3;

x = [0 3.5 6.6 8.2 10.1] / 100;
L = 0.117;

do = 0.015;
di = 0.014;
d_ins = 0.042;

Ac = (pi/4)*(do^2 - di^2);
P  = pi*do;

k     = 389;
k_ins = 0.04;

theta  = T_rod - T_inf;
theta0 = theta(1);

model = @(m,x) theta0 .* ...
    (cosh(m*(L - x)) + (m*Ac/P).*sinh(m*(L - x))) ./ ...
    (cosh(m*L) + (m*Ac/P).*sinh(m*L));

m_fit = lsqcurvefit(model, 20, x, theta);

h_eff = (m_fit^2 * k * Ac) / P;

fprintf('m = %.4f\n', m_fit);
fprintf('h_eff = %.2f W/m^2-K\n', h_eff);

Q_total = h_eff * L * P * (mean(T_rod) - T_inf);
fprintf('Total heat transfer = %.3f W\n', Q_total);

A_surf = P * L;

R_eff = 1 / (h_eff * A_surf);
R_ins = log(d_ins/do) / (2*pi*k_ins*L);
R_air = R_eff - R_ins;

h_air = 1 / (R_air * A_surf);

fprintf('h_outsurface = %.2f W/m^2-K\n', h_air);

x_fit = linspace(0, L, 100);
T_fit = model(m_fit, x_fit) + T_inf;

figure;
plot(x, T_rod, 'o', 'LineWidth', 2); hold on;
plot(x_fit, T_fit, 'LineWidth', 2);
xlabel('x (m)');
ylabel('Temperature (°C)');
title('Rod Temperature Distribution');
legend('Data','Fit');
grid on;

figure;
plot(x, T_surf, 's-', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor','blue');
xlabel('x (m)');
ylabel('Surface Temperature (°C)');
title('Insulation Surface Temperature');
grid on;

B = m_fit * Ac / P;

q_cond = k * Ac * m_fit * theta0 * ...
    (sinh(m_fit*L) + B*cosh(m_fit*L)) / ...
    (cosh(m_fit*L) + B*sinh(m_fit*L));

fprintf('Heat transfer (conduction at base) = %.3f W\n', q_cond);

Ts = mean(T_surf);
TsK = Ts + 273;
TinfK = T_inf + 273;

sigma = 5.67e-8;
epsilon = 0.6;

q_rad = sigma * epsilon * A_surf * (TsK^4 - TinfK^4);
h_rad = q_rad / (A_surf * (Ts - T_inf));

fprintf('h_rad = %.2f W/m^2-K\n', h_rad);
fprintf('Heat loss (radiation) = %.3f W\n', q_rad);

q_conv = h_air * A_surf * (Ts - T_inf);

fprintf('Heat loss (convection) = %.3f W\n', q_conv);

fprintf('Total heat (conv + rad) = %.3f W\n', q_conv + q_rad);