void setup()
{
  size(400, 400);

  perpPoint1 = new PVector(width/2-40, height/2);
  perpPoint2 = new PVector(width/2+40, height/2);
  centerPoint = PVector.add(perpPoint1, perpPoint2);
  centerPoint.mult(.5);
}

PVector perpPoint1, perpPoint2, centerPoint;
float mouseHeading;
void draw()
{
  background(255);
  stroke(0);
  ellipse(centerPoint.x, centerPoint.y, 20, 20);


  line(perpPoint1.x, perpPoint1.y, perpPoint2.x, perpPoint2.y);
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
  PVector res2 = PVector.add(loc2, new PVector(x2, y2));
  PVector res3 = PVector.add(loc3, new PVector(x3, y3));
  line(loc.x, loc.y, mouseLoc.x, mouseLoc.y);
  //line(loc2.x, loc2.y, mouseX, mouseY);
  //line(loc2.x, loc2.y, res2.x, res2.y);

  //line(loc3.x, loc3.y, res3.x, res3.y);

  ellipse(centerPoint.x, centerPoint.y, 20, 20);
  stroke(255, 0, 0);
  ellipse(perpPoint1.x, perpPoint1.y, 10, 10);
  stroke(255, 255, 0);
  ellipse(perpPoint2.x, perpPoint2.y, 10, 10);

  mouseHeading=diff1.heading()+HALF_PI;
  float nx = (perpPoint1.x-centerPoint.x)*cos(mouseHeading) + (perpPoint1.y-centerPoint.y)*sin(mouseHeading) + centerPoint.x;
  float ny = (perpPoint1.x-centerPoint.x)*sin(mouseHeading) + (perpPoint1.y-centerPoint.y)*cos(mouseHeading) + centerPoint.y;
  PVector temp = new PVector(nx, ny);

  float nx2 = (perpPoint2.x-centerPoint.x)*cos(mouseHeading) + (perpPoint2.y-centerPoint.y)*sin(mouseHeading) + centerPoint.x;
  float ny2 = (perpPoint2.x-centerPoint.x)*sin(mouseHeading) + (perpPoint2.y-centerPoint.y)*cos(mouseHeading) + centerPoint.y;
  PVector temp2 = new PVector(nx2, ny2);
  //PVector temp = new PVector(perpPoint1.x, perpPoint1.y);
  //temp.sub(mouseLoc);
  //temp.rotate(perpPoint1.heading()+mouseHeading);
  //temp.add(mouseLoc);
  stroke(255, 0, 0);
  ellipse(temp.x, temp.y, 20, 20);
  stroke(255, 255, 0);
  ellipse(temp2.x, temp2.y, 20, 20);


  PVector end1 = new PVector(temp.x+diff1.mag()*cos(diff1.heading()), temp.y+diff1.mag()*sin(diff1.heading()));
  PVector end2 = new PVector(temp2.x+diff1.mag()*cos(diff1.heading()), temp2.y+diff1.mag()*sin(diff1.heading()));

  line(temp.x, temp.y, end1.x, end1.y);

  line(temp2.x, temp2.y, end2.x, end2.y);
}