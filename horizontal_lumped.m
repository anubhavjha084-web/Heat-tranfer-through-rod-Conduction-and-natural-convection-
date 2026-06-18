data = readmatrix('nat cool horizontal.txt');   

T_inf = 31.1;  % ambient temperature
sumtau=0;
[rows, cols] = size(data);% rows = time, columns = thermocouple

time = (0:rows-1)';  
deltaT = data - T_inf;
deltaT(deltaT <= 0) = NaN;% To avoid log of zero/negative
ln_T = log(deltaT);

figure;
hold on;

slopes = zeros(1, cols);   % store slopes

for i = 1:cols
    
    y = ln_T(:, i);
   
    valid = ~isnan(y); % Removing all the log(0) points
    t_valid = time(valid);
    y_valid = y(valid);
    
    p = polyfit(t_valid, y_valid, 1);
    m = p(1);
    c = p(2);
    
    slopes(i) = m;
    tau(i)=-1/m;
    sumtau=sumtau+tau(i);
  % plot(t_valid, y_valid, 'o', 'DisplayName', ['TC', num2str(i), 'data']);
    y_fit = polyval(p, t_valid);
    plot(t_valid, y_fit, '-', 'LineWidth', 1,'DisplayName', ['TC ', num2str(i), ' (time constant =', num2str(tau(i), '%.2f'), ')']);
end

xlabel('Time');
ylabel('ln(T - T_infinty})');
title('Horizontal natural convection');
legend show;
grid on;

disp('average time constant for the thermocouple:');
time_constant=sumtau/5;
%disp(time_constant);
h=43.4/time_constant;
fprintf("h_horizontal= %f",h);