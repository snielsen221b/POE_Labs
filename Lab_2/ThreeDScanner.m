% deletes arduino board object if it already exists
if ~isempty(instrfind)
     fclose(instrfind);
      delete(instrfind);
end

arduino_board = arduino('COM9', 'Uno', 'Libraries', 'Servo');

% Create servo objects
servo_1 = servo(arduino_board, 'D4');
servo_1_positions = servo()

% Sweeps servo from 0 to 180 deg
for angle = 0:.1:1
    angle
    writePosition(servo_1, angle);
    current_position = readPosition(servo_1);
    current_position = current_position*180
    pause(2);
end
