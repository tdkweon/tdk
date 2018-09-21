class Circle {
  float x;
  float y;
  float r;
  float a = 192;
  float g = 192;
  float b = 192;
  float va, vg, vb;
  boolean growing = true;

  Circle (float x_, float y_) {
    x=x_;
    y=y_;
    r=1;
  }

  void grow() {
    if (growing) {
      r = r + 0.5;
    }
  }

  boolean edges() {
    return (x+r > width || x-r < 0 || y+r > height || y-r<0);
  }

  void show () {
    //noStroke();
    stroke(0);
    strokeWeight(1.5);
    va = va * 0.995 + randomGaussian() * 0.04;
    vg = vg * 0.995 + randomGaussian() * 0.04;
    vb = vb * 0.995 + randomGaussian() * 0.04;

    a += va;
    g += vg;
    b += vb;

    if ((a < 128 && va < 0) || (r > 255 && va > 0))    va = -va;
    if ((g < 128 && vg < 0) || (g > 255 && vg > 0))    vg = -vg;
    if ((b < 128 && vb < 0) || (b > 255 && vb > 0))    vb = -vb;

    fill(a, g, b,200);

    ellipse (x, y, random(r*2-2, r*2+2), random(r*2-2, r*2+2));
  }
}
