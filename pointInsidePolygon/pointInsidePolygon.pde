

import java.util.Vector;

Vector<PVector> vertices;

void setup()
{
  size(400, 400);  
  vertices = new Vector<PVector>();


  vertices.add( new PVector(width/4, height/4) );
  vertices.add( new PVector(width-width/4, height/4) );
  vertices.add( new PVector(width-width/4, height-height/4) );

  vertices.add( new PVector(width/2, height/2) );

  vertices.add( new PVector(width/4, height-height/4) );
}


void draw()
{
  background(255);
  if (contains(mouseX, mouseY))
  {
    fill(0);
  } else
  {
    fill(255);
  }
  beginShape();
  for (int i=0; i <vertices.size(); i++)
  { 
    PVector v = vertices.get(i);
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}


boolean  contains(double x, double y) {

  /*
  if (vertices.size() <= 2 || !getBoundingBox().contains(x, y)) {
   return false;
   }
   */
  int npoints = vertices.size();
  double[] xpoints = new double[vertices.size()];
  double[] ypoints = new double[vertices.size()];
  for (int i=0; i <vertices.size(); i++)
  { 
    PVector v = vertices.get(i);
    xpoints[i]=v.x;
    ypoints[i]=v.y;
  }

  int hits = 0;

  int lastx = (int) xpoints[npoints - 1];
  int lasty = (int)  ypoints[npoints - 1];
  int curx, cury;

  // Walk the edges of the polygon
  for (int i = 0; i < npoints; lastx = curx, lasty = cury, i++) {

    curx = (int) xpoints[i];

    cury = (int) ypoints[i];

    if (cury == lasty) {
      continue;
    }

    int leftx;
    if (curx < lastx) {
      if (x >= lastx) {

        continue;
      }
      leftx = curx;
    } else {

      if (x >= curx) {
        continue;
      }


      leftx = lastx;
    }
    double test1, test2;
    if (cury < lasty) {
      if (y < cury || y >= lasty) {
        continue;
      }

      if (x < leftx) {


        hits++;
        continue;
      }

      test1 = x - curx;
      test2 = y - cury;
    } else {
      if (y < lasty || y >= cury) {
        continue;
      }
      if (x < leftx) {


        hits++;     
        continue;
      }

      test1 = x - lastx;



      test2 = y - lasty;
    }
    if (test1 < (test2 / (lasty - cury) * (lastx - curx))) {


      hits++;
    }
  }

  return ((hits & 1) != 0);
}