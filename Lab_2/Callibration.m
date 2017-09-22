clear;
clf;
calibration_data = csvread('DistanceCalibrationTable.csv');
measured_distance = calibration_data(:,1);
measured_raw_IR = calibration_data(:,2);
measured_voltage = 5.*(measured_raw_IR./1023);

expected_distance = [15; 20; 30; 40; 50; 60];
expected_voltage = [2.75; 2.5; 2; 1.51; 1.25; 1.02];

scatter(measured_distance, measured_voltage);
hold on
p = polyfit(measured_distance, measured_voltage, 2)
xlabel('distance (cm)')
fit_curve = polyval(p, measured_distance);
ylabel('voltage (v)')
plot(measured_distance, fit_curve)

plot(expected_distance, expected_voltage)

title(['IR Sensor Calibration Curve'])
legend('measured', 'v = .0004*d^2-.0638*d+3.3389', 'expected');

predicted_voltage = polyval(p, expected_distance);
error = predicted_voltage - expected_voltage;
% percent_error = ;