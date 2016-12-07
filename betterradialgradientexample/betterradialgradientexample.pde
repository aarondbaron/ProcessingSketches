/**
 * Radial Gradient. 
 * 
 * Draws are series of concentric circles to create a gradient 
 * from one color to another.
 */

int dim;

void setup() {
  size(640, 360);
  dim = width/2;
  background(0);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  ellipseMode(RADIUS);
}

void draw() {
  background(0);
  for (int x = 0; x <= width; x+=dim) {
    drawGradient(x, height/2);
  } 
  h+=rate;
  if (h<0)
  {
    h=360;
  }
}

float h;
void drawGradient(float x, float y) {
  int radius = dim/2;
  //h = random(0, 360);
  float starth=h;
  float satmap= map(mouseX,0,width,0,100);
  float brightmap = map(mouseY, 0, height, 0,100);
  for (int r = radius; r > 0; --r) {
    fill(starth, satmap, brightmap);
    ellipse(x, y, r, r);
    starth = (starth + 1) % 360;
  }
}

int rate=1;
void keyPressed()
{
  if (key=='1')
  {
    rate++; 
    println("rate: " +rate);
    println("h: "+ h);
  }
  if (key=='2')
  {
    rate--;
    println("rate: " +rate);
    println("h: "+ h);
  }
}