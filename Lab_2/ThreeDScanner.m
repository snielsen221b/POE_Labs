% deletes arduino board object if it already exists
if ~isempty(instrfind)
     fclose(instrfind);
      delete(instrfind);
end

% Create arduino object
arduino_board = arduino('COM9', 'Uno', 'Libraries', 'Servo');

% set up angle step and define number of 'ticks' per sweep of the servo
% angle bounds are 0 and 1
x_angle_step = .025;
x_angle_ticks = 1/x_angle_step;
y_angle_step = .025;
y_angle_ticks = 1/y_angle_step;

% Create servo objects and servo position array
x_servo = servo(arduino_board, 'D4');
x_servo_positions = zeros(x_angle_ticks, 1);
y_servo = servo(arduino_board, 'D5');
y_servo_positions = zeros(y_angle_ticks, 1);

% Define IR pin and IR data array
IR_pin = 'A0';
IR_data = zeros(x_angle_ticks, y_angle_ticks, 3);


for loop = 1:3
    % Sweeps servo from 0 to 180 deg
    for x_angle = 0:x_angle_step:1
        writePosition(x_servo, x_angle);
        x_current_position = readPosition(x_servo);
        x_current_position = x_current_position*180;

        % find iteration of x servo
        i = int8(x_angle*(1/x_angle_step) + 1);

        % store x servo position in the vector x_servo_positions
        x_servo_positions(i) = x_current_position;

        for y_angle = 0:y_angle_step:1
            writePosition(y_servo, y_angle);
            y_current_position = readPosition(y_servo);
            y_current_position = y_current_position*180;

            % find iteration of y_servo
            j = int8(y_angle*(1/y_angle_step)+1);

            % store y servo position in vector y_sevo_positions
            y_servo_positions(j) = y_current_position;

            % read voltage from IR_pin and store it
            IR_data(i, j, loop) = readVoltage(arduino_board, IR_pin);
            pause(0.25);
        end
        pause(0.25);
    end
end

for i = 1:length(x_servo_positions)
    for j = 1:length(y_servo_positions)
         IR_data(i, j) = mean(IR_data(i,j,:));
     end
 end
csvwrite('3D_IR.csv',IR_data);
csvwrite('3D_xpos.csv',x_servo_positions);
csvwrite('3D_ypos.csv',y_servo_positions);
clear arduino_board servo_1;
