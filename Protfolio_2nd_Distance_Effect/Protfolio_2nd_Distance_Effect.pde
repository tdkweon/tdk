import processing.serial.*;
Serial myPort; 
String val;
String sensorName;
ArrayList<Particle> particles = new ArrayList<Particle>();
int sensor1 = 0;

void setup() {
  size(800, 800);
  noStroke();

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  println("1 " + portName);
}

void draw() {
  if ( myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    //println(val);
    if (val!=null) {
      try {
        String sub1 = val.substring(val.indexOf('a')+1, val.indexOf('b'));
        sensor1 = int(sub1);
        if (sensor1 < 5) sensor1 = 0;
        //isConnected = true;
      }
      catch(Exception e) {
        val = null;
      }
    }
  }  
  println(sensor1);
  if (sensor1>=5 && sensor1<=400){
      
    float d = sensor1/10;

    background(0);
    particles.add(new Particle(width/2+random(-10, 10), height/2+random(-10, 10), d));
    for (int i = 0; i< particles.size(); i++) {
      Particle myP = particles.get(i);
      myP.display();
      if (myP.del == true)
      {
        particles.remove(i);
      }
    }
    fill(255);
    text(particles.size(), 100, 100);
  }
}