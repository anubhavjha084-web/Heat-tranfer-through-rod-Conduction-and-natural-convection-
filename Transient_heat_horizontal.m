% Load data
data = readmatrix('nat horizontal.txt');

n = size(data,1);
time = (0:n-1);

plot(time, data(:,1), 'LineWidth', 1.5); hold on;
plot(time, data(:,2), 'LineWidth', 1.5);
plot(time, data(:,3), 'LineWidth', 1.5);
plot(time, data(:,4), 'LineWidth', 1.5);
plot(time, data(:,5), 'LineWidth', 1.5);

% Labels
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature vs Time at 5 Locations');

% Legend
legend('T1','T2','T3','T4','T5','Location','best');

grid on;