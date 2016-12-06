void setup()
{
  size(400,400);
}


void draw()
{
  background(255);
  
  PVector loc = new PVector(width/2, height/2);
  PVector loc2 = new PVector(width/2+40, height/2);
  PVector loc3 = new PVector(width/2-40, height/2);
  PVector mouseLoc = new PVector(mouseX, mouseY);
  
  PVector diff1= PVector.sub(mouseLoc, loc);
  PVector diff2= PVector.sub(mouseLoc, loc2);
  PVector diff3= PVector.sub(mouseLoc, loc3);
  
  
  float d = diff1.dot(diff2);
  //println(d);
  
  float ang2 = diff1.heading();
  float ang3 = diff1.heading();
  //println(ang);
  
  float x2 = diff1.mag()*cos(ang2);
  float y2 = diff1.mag()*sin(ang2);
  
  float x3 = diff1.mag()*cos(ang3);
  float y3 = diff1.mag()*sin(ang3);
  PVector res2 = PVector.add(loc2, new PVector(x2,y2));
  PVector res3 = PVector.add(loc3, new PVector(x3,y3));
  line(loc.x, loc.y, mouseLoc.x, mouseLoc.y);
  //line(loc2.x, loc2.y, mouseX, mouseY);
  line(loc2.x, loc2.y, res2.x , res2.y);
  
  line(loc3.x, loc3.y, res3.x , res3.y);
}