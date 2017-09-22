% deletes arduino board object if it already exists
if ~isempty(instrfind)
     fclose(instrfind);
      delete(instrfind);
end

% Create arduino object
arduino_board = arduino('COM9', 'Uno', 'Libraries', 'Servo');

% set up angle step and define number of 'ticks' per sweep of the servo
% angle bounds are 0 and 1
x_angle_step = .1;
x_angle_ticks = 1-0/x_angle_step;

% Create servo objects and servo position array
x_servo = servo(arduino_board, 'D4');
x_servo_positions = zeros(x_angle_ticks, 1);

y_angle_ticks = 1;

% Define IR pin and IR data array
IR_pin = 'A0';
IR_data = zeros(x_angle_ticks, y_angle_ticks);


% Sweeps servo from 0 to 180 deg
for angle = 0:x_angle_step:1
    writePosition(x_servo, angle);
    x_current_position = readPosition(x_servo);
    x_current_position = x_current_position*180;
    i = int8(x_angle_ticks*angle/x_angle_step + 1)
    j = 1;
    
    % store servo position in the vector servo_1_positions
    x_servo_positions(i) = x_current_position;
    
    % read voltage from IR_pin and store it
    IR_data(i, j) = readVoltage(arduino_board, IR_pin);
    
    pause(1);
end

clear arduino_board servo_1;
