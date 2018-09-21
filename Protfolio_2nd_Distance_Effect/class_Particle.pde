class Particle {
  float xpos;
  float ypos;
  float speed;
  float alpha = 50;
  float distance = 10;
  boolean del = false;

  Particle (float tempXpos, float tempYpos, float d) {
    xpos = tempXpos;
    ypos = tempYpos;
    distance = d;
    speed = random(0.3, 1);
  }
  void display() {
    fill(255, alpha);
    ellipse (xpos, ypos, distance, distance); //10
    ypos -= speed;
    alpha -= 0.5;
    if (ypos<height/2 -100) {
      ypos = height/2;
      alpha = 50;}
      if (alpha < 0)
      {
        del = true;
      }
    }
}