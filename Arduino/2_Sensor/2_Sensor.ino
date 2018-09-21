const int TriggerPin = 8; //Trig pin
const int EchoPin = 9; //Echo pin

void setup () 
{
  // initialize a distance sensor
  pinMode(TriggerPin, OUTPUT); // Trigger is an output pin
  pinMode(EchoPin, INPUT); // Echo is an input pin

  Serial.begin (9600);
}
 
void loop () 
{
  int noise = analogRead(A0);
  String output = String("noise=" + String(noise));
  Serial.println(output);

  digitalWrite(TriggerPin, LOW);
  delayMicroseconds(2);
  digitalWrite(TriggerPin, HIGH); // Trigger pin to HIGH
  delayMicroseconds(10); // 10us high
  digitalWrite(TriggerPin, LOW); // Trigger pin to HIGH

  long duration = 0;
  duration = pulseIn(EchoPin, HIGH); // Waits for the echo pin to get high
  // returns the Duration in microseconds

  long distance = Distance(duration); // Use function to calculate the distance
  String output2 = String("distance=" + String(distance));
  Serial.println(output2);
  
  delay(250);
}

long Distance(long time)
{
  // Calculates the Distance in mm
  // ((time)*(Speed of sound))/ toward and backward of object) * 10

  long distanceCalc; // Calculation variable
  distanceCalc = ((time / 2.9) / 2); // Actual calculation in mm
  //distanceCalc = time / 74 / 2; // Actual calculation in inches
  return distanceCalc; // return calculated value
}
