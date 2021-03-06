% deletes arduino board object if it already exists
if ~isempty(instrfind)
     fclose(instrfind);
      delete(instrfind);
end

% Create arduino object
arduino_board = arduino('COM9', 'Uno', 'Libraries', 'Servo');

% set up angle step and define number of 'ticks' per sweep of the servo
% angle bounds are 0 and 1
x_angle_step = .0125;
x_angle_ticks = 1/x_angle_step;
y_angle_ticks = 1;

% Create servo objects and servo position array
x_servo = servo(arduino_board, 'D4');
x_servo_positions = zeros(x_angle_ticks, 1);
y_servo = servo(arduino_board, 'D5');

% Define IR pin and IR data array
IR_pin = 'A0';
IR_data = zeros(x_angle_ticks, y_angle_ticks);

% Sets y_servo straight on
writePosition(y_servo, .5);

for loop = 1:3
    % Sweeps servo from 0 to 180 deg
    for x_angle = 0:x_angle_step:1
        writePosition(x_servo, x_angle);
        x_current_position = readPosition(x_servo);
        x_current_position = x_current_position*180;
        i = int8(x_angle*(1/x_angle_step) + 1);

        j = 1;

        % store servo position in the vector servo_1_positions
        x_servo_positions(i) = x_current_position;

        % read voltage from IR_pin and store it
        IR_data(i, loop) = readVoltage(arduino_board, IR_pin);

        pause(0.25);
    end
end

average_IR_data = zeros(length(x_servo_positions), 1);
for i = 1:length(x_servo_positions)
    average_IR_data(i) = mean(IR_data(i,:));
end

csvwrite('2D_IR.csv', average_IR_data);
csvwrite('2D_xpos.csv', x_servo_positions);
clear arduino_board servo_1;
