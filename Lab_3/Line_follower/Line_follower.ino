int IR_Pin = A1;
float sensorRead;

void setup() {
  // begin serial
  Serial.begin(9600);
}

void loop() {
  // Read and print sensor value
  sensorRead = analogRead(IR_Pin);
  Serial.print
}
