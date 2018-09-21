void setup () 
{
  Serial.begin (9600);
}
 
void loop () 
{
  int noise = analogRead(A0);
  String output = String("a" + String(noise) + "b");
  Serial.println(output);
  delay(200);
}

