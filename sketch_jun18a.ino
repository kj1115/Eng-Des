int Led = 13 ; // Arduino built in LED
int SENSOR = 8 ; // define the Hall magnetic sensor
int val, count = 0 ; // define numeric variables 
 
void setup ()
{
  Serial.begin(9600);
  pinMode (Led, OUTPUT) ;    // define LED as output
  pinMode (SENSOR, INPUT) ;  // define the Hall magnetic sensor line as input
}
 
void loop ()
{
  val = digitalRead (SENSOR) ; // read sensor line
  if (val == LOW) // when the Hall sensor detects a magnetic field, Arduino LED lights up
  {
    digitalWrite (Led, HIGH);
    count = count + 1;
    Serial.println(count);
  }
  else
  {
    digitalWrite (Led, LOW);
  }
  delay(1);
}
