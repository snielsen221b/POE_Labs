const int IR_SENSOR = A0;
float sensorRead;
float voltage;

void setup() {
  Serial.begin(9600);
}
  
void loop() {
  // Read and print sensor value and voltage from 0V to 5V
  sensorRead = analogRead(IR_SENSOR);
  Serial.print(sensorRead); 
  Serial.print(" ");
  voltage = map_Voltage(sensorRead);
  Serial.println(voltage);


}

// Maps sensor value to its voltage output from 0V to 5V
float map_voltage(float sensorRead){
  voltage = 5*(sensorRead/1023);
  return voltage;
}

// Maps sensor value to distance from sensor, accurate from distances
float map_distance(float sensorRead){
  //distance = 
}
