import processing.serial.*;

Serial myPort; 
String val;
String sensorName;
ArrayList<Circle> circles;
ArrayList<PVector> spots;
PImage img;
//boolean isConnected = false;

int sensor1 = 0;

int waitTime = (int) (3 * 1000); // 4 seconds
int elapseTime = 0;
int startTime = 0;

void setup() {
  println("1 "+waitTime);
  startTime = millis();
  frameRate(10);
  size(800, 800);
  background(0);
  spots = new ArrayList<PVector>();
  img = loadImage("Circle Packing.png");
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index = x + y * img.width;
      color c = img.pixels[index];
      float b = brightness(c);
      if (b > 0) {
        spots.add(new PVector(x, y));
      }
    }
  }
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  println("2 " + portName);
  circles = new ArrayList<Circle>();
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

  if (sensor1 == 0) {
    if (hasFinished()){
      startTime = millis();
      println("Elapse " + waitTime + " seconds");
      for (int i = circles.size() - 1; i >= 0; i--) {
        //Circle part = circles.get(i);
        circles.remove(i);
      }
      background(0);
    }
  }
  else{
    startTime = millis();
    int useable = sensor1;
    println("=>" + sensor1);
  
    int total = useable/5;
    int count = 0;
  
    while (count < total) {
      boolean b=true;
      if (sensor1>450) {
        b = false;
      }
      Circle newC = newCircle(b);
      if (newC != null) {
        circles.add(newC);
        count++;
      }
    }
  
    for (Circle c : circles) {
      if (c.growing) {
        if (c.edges()) {
          c.growing = false;
        } else {
          for (Circle other : circles) {
            if (c != other) {
              float d = dist(c.x, c.y, other.x, other.y);
              if (d-2< c.r + other.r) {
                c.growing = false;
                break;
              }
            }
          }
        }
      }
      c.show();
      c.grow();
    }
  }

}

boolean hasFinished() {
  //println(millis() - startTime);
  return (millis() - startTime) > waitTime;
}

Circle newCircle(boolean b) {
  if (b){// (startTime < 15000) {
    int r = int(random(0, spots.size()));
    PVector spot = spots.get(r);
    float x = spot.x;
    float y = spot.y;

    boolean valid = true;
    for (Circle c : circles) {
      float d = dist(x, y, c.x, c.y);
      if (d < c.r) {
        valid = false;
        break;
      }
    }

    if (valid) {
      return new Circle (x, y);
    } else {
      return null;
    }
  } else {
    float x = random(width);
    float y = random(height);

    boolean valid = true;
    for (Circle c : circles) {
      float d = dist(x, y, c.x, c.y);
      if (d < c.r) {
        valid = false;
        break;
      }
    }

    if (valid) {
      return new Circle (x, y);
    } else {
      return null;
    }
  }
}