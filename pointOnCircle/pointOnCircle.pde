PVector circleLoc;
int r=50;
void setup()
{
  size(300, 300);
  circleLoc = new PVector(width/2, height/2);
}

void draw()
{
  background(200);
  ellipse(circleLoc.x, circleLoc.y, 2*r, 2*r);
  PVector mouseLoc = new PVector(mouseX, mouseY);
  line(mouseLoc.x, mouseLoc.y, circleLoc.x, circleLoc.y);
  
  PVector result = findClosestPointToCircumference(circleLoc, r, mouseLoc);
  
  ellipse(result.x, result.y, 10,10);
  
}

PVector findClosestPointToCircumference(PVector c, int rad, PVector newp)
{
  PVector dif = PVector.sub( newp, c);
  dif.normalize();
  dif.mult(rad);
  PVector result = new PVector(c.x+dif.x, c.y+dif.y);
  return result; 
}