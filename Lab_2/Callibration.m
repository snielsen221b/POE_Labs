% calibrates IR sensor based on 10 meaurements each of 10 distances
% d is the polyfit result (gives distance in cm as a function of IR
% voltage)
% e is the percent error
function [d, e] = Callibration()
    clear;
    clf;
    calibration_data = csvread('DistanceCalibrationTable.csv');
    measured_distance = calibration_data(:,1);
    measured_raw_IR = calibration_data(:,2:end);

    average_raw_IR = zeros(length(measured_distance),1)
    for i=1:length(measured_distance)
        average_raw_IR(i) = mean(measured_raw_IR(i,:));
    end

    measured_voltage = 5.*(average_raw_IR./1023);

    % values taken from the IR sensor data sheet [citation]
    expected_distance = [15; 20; 30; 40; 50; 60];
    expected_voltage = [2.75; 2.5; 2; 1.51; 1.25; 1.02];
    
    %v = polyfit(measured_distance, measured_voltage, 2);
    d = polyfit(measured_voltage, measured_distance, 2)
    %fit_curve = polyval(v, measured_distance);
    fit_curve = polyval(d, measured_voltage);
    
    
    %predicted_voltage = polyval(v, expected_distance);
    predicted_distance = polyval(d, expected_voltage);
    %percent_error = (predicted_voltage - expected_voltage)/expected_voltage*100;
    error = predicted_distance - expected_distance;
    percent_error = (abs(error)./predicted_distance)*100;
    
    e = mean(percent_error)
    
    figure(1)
        clf
        scatter(measured_voltage,measured_distance);
        hold on
        plot(measured_voltage, fit_curve)
        plot(expected_voltage, expected_distance)

        xlabel('Distance (cm)')
        ylabel('Voltage (v)')
        title('IR Sensor Calibration Curve')
        legend('Measured', 'Calibration Curve', 'Expected');
    
    figure(2)
        clf
        plot(expected_distance, percent_error);
        hold on
        
        xlabel('Distance (cm)')
        ylabel('Percent Error (%)')
        title('Percent Error vs. Distance');
    
end