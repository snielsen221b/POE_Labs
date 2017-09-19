arduino_board = arduino('com9', 'Uno', 'Libraries', 'Servo');

% Create servo objects
servo_1 = servo(arduino_board, 'D4');

% Sweeps servo from 0 to 180 deg
for angle = 0:.2:1
    angle
    writePosition(servo_1);
    current_position = readPosition(servo_1);
    current_position = current_position*180
end
