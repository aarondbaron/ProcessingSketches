/*
created by Aaron Albin
 
 
 
 */
import java.util.Vector;
import java.util.List;
import java.util.Comparator;
import java.util.Collections;


PVector sliceStart;
PVector sliceEnd;
PVector [] slicePair;
Vector<PVector[]> setOfLines;
Vector<CutShape> allShapes;


void setup()
{
  size(500, 500, P3D);
  CutShape ts = new CutShape("triangle");

  allShapes = new Vector<CutShape>();
  allShapes.add(ts);

  setOfLines = new Vector<PVector [] > ();
}

void draw()
{
  background(255);
  strokeWeight(1);

  for (int i=0; i<allShapes.size(); i++)
  {
    CutShape ns = allShapes.get(i);
    ns.run();
    //ts.run();
  }

  if (mousePressed)
  {
    if (sliceStart!=null)
    {
      line(sliceStart.x, sliceStart.y, mouseX, mouseY);
    }
  }

  if (slicePair!=null)
  {
    stroke(0);
    line(slicePair[0].x, slicePair[0].y, slicePair[1].x, slicePair[1].y);
  }

  if (setOfLines!=null)
  {
    stroke(0);
    for (int i=0; i<setOfLines.size(); i++)
    {
      PVector[] pair = setOfLines.get(i);
      line(pair[0].x, pair[0].y, pair[1].x, pair[1].y);
    }
  }

  stroke(0);
  fill(0);
  text("count: " + allShapes.size() + " framerate: " + frameRate, 0, 20 );
}

void keyPressed()
{

  if (key == '1')
  {
    allShapes.clear();
    CutShape ts = new CutShape("triangle");
    allShapes.add(ts);

    slicePair = null;
  }
  if (key == '2')
  {
    allShapes.clear();
    CutShape ts = new CutShape("square");
    allShapes.add(ts);

    slicePair = null;
  }
  if (key == '3')
  {
    allShapes.clear();
    CutShape ts = new CutShape("hackcircle");
    allShapes.add(ts);

    slicePair = null;
  }

  if (key == 'c')
  {
    allShapes.clear();
    CutShape ts = new CutShape("convex");
    allShapes.add(ts);

    slicePair = null;
  }


  if (key== 'm')
  {
    //allShapes.clear();
    //CutShape ts = new CutShape("triangle");
    //allShapes.add(ts);

    //setOfLines.clear();
  }
  if (keyCode == ENTER)
  {
    for (int i=0; i< setOfLines.size(); i++)
    {
      PVector[] pair = setOfLines.get(i);

      Vector<CutShape> toAdd = new Vector<CutShape>();
      Vector<CutShape> toRemove = new Vector<CutShape>();
      for (int m = 0; m < allShapes.size(); m++)
      {
        CutShape ts = allShapes.get(m);

        Vector<CutShape> newshapes=ts.cutByLine(pair);
        if (newshapes!=null)
        {
          toAdd.addAll(newshapes);
          toRemove.add(ts);
        } else
        {
          continue;
        }
      }      
      allShapes.addAll(toAdd);
      allShapes.removeAll(toRemove);
    }
  }

  if (key == ' ')
  {

    for (int i=0; i< setOfLines.size(); i++)
    {
      PVector[] pair = setOfLines.get(i);

      Vector<CutShape> toAdd = new Vector<CutShape>();
      Vector<CutShape> toRemove = new Vector<CutShape>();
      for (int m = 0; m < allShapes.size(); m++)
      {
        CutShape ts = allShapes.get(m);

        Vector<CutShape> newshapes=ts.cutByLine(pair);
        if (newshapes!=null)
        {
          toAdd.addAll(newshapes);
          toRemove.add(ts);
        } else
        {
          continue;
        }
      }      
      allShapes.addAll(toAdd);
      allShapes.removeAll(toRemove);
    }

    setOfLines.clear();

    Vector<PVector> locs = new Vector<PVector>();
    PVector summation = new PVector();
    for (int m = 0; m < allShapes.size(); m++)
    {
      CutShape ts = allShapes.get(m);
      PVector loc = ts.getLoc();      
      locs.add(loc);  
      summation.add(loc);
    }
    summation.mult(1.0/ (float) locs.size() );

    Vector<PVector> vels = new Vector<PVector>();
    for (int i=0; i < locs.size(); i++)
    {
      PVector v=PVector.sub(locs.get(i), summation);
      v.normalize();
      vels.add( v );

      CutShape ts = allShapes.get(i);
      ts.vel=v;

      ts.doRotate=true;
      ts.randomRotAmt();
    }
  }

  if (key == 'r')
  {

    for (int i=0; i<10; i++)
    {
      PVector start, end;
      if (random(1) <.5)
      {
        start = new PVector(width/8, random(height) );
        end = new PVector(width-width/8, random(height));
      } else
      {
        start = new PVector(random(width), height/8 );
        end = new PVector(random(width), height-height/8);
      }

      setOfLines.add( new PVector[]{start, end} );
    }
  }

  if (key=='f')
  {
    for (int m = 0; m < allShapes.size(); m++)
    {
      CutShape ts = allShapes.get(m);
      ts.flicker=true;
    }
  }


  if (key=='p')
  {
    /*
    segs = ts.getTrueSegs();
     println("segs:" + segs.size() );
     
     for (int i=0; i<segs.size(); i++)
     {
     PVector[] pair = segs.get(i);
     print(" " + pair[0] + " , " +  pair[1] + "__");
     }
     */

    for (int m=0; m<allShapes.size(); m++)
    {

      CutShape ts = allShapes.get(m);

      //Vector<PVector [] > tssegs = ts.getTrueSegs();
      Vector<PVector> tspoints = ts.getTruePoints();

      print("Shape " + m +  " points: ");
      for (int i=0; i<tspoints.size(); i++)
      {
        PVector pt = tspoints.get(i);
        print("" + pt);
      }
      println();
    }
  }
}

void mousePressed()
{
  if (mouseButton==LEFT)
  {
    setOfLines.clear(); // only 

    sliceStart = new PVector(mouseX, mouseY);
  }

  if (mouseButton==RIGHT)
  {
    sliceStart = new PVector(mouseX, mouseY);
  }
  //println("slicestart: " + sliceStart);
}

/*
 alot of this code needs to be put into CutShape itself.  
 */
void mouseReleased()
{
  if (mouseButton==LEFT)
  {
    println(" ");
    println("mouseReleased");
    //step 1. find the intersection points created by the slice.  

    sliceEnd= new PVector(mouseX, mouseY);
    slicePair = new PVector[2];
    slicePair[0]= sliceStart;
    slicePair[1] = sliceEnd;

    Vector<CutShape> toAdd = new Vector<CutShape>();
    Vector<CutShape> toRemove = new Vector<CutShape>();
    for (int m=0; m<allShapes.size(); m++)
    {

      CutShape ts = allShapes.get(m);

      Vector<CutShape> newshapes= ts.cutByLine(slicePair);
      CutShape cutShape1;
      CutShape cutShape2;
      if (newshapes!=null)
      {
        // if concave gets fixed later, could be more than two.. but if convex.. only two.
        cutShape1= newshapes.get(0);
        cutShape2= newshapes.get(1);
      } else
      {
        continue;
      }
      ///
      //code was taken out and put into cutshape cutbyline
      ///

      //////
      //give the new shapes a velocity
      cutShape1.vel = PVector.sub(cutShape1.loc, cutShape2.loc).normalize();
      cutShape2.vel = PVector.sub(cutShape2.loc, cutShape1.loc).normalize();

      //// add shapes to allshapes
      toAdd.add(cutShape1);
      toAdd.add(cutShape2);
      //remove the old shape..
      toRemove.add(ts);
    }

    allShapes.addAll(toAdd);
    allShapes.removeAll(toRemove);

    println("allshapes size: "+ allShapes.size());
  }

  if (mouseButton==RIGHT)
  {
    sliceEnd= new PVector(mouseX, mouseY);
    PVector[] pair = new PVector[2];
    pair[0]=sliceStart;
    pair[1]=sliceEnd;
    setOfLines.add(pair);
  }
}

PVector lineIntersect(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) {
  double denom = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);
  if (denom == 0.0) { // Lines are parallel.
    return null;
  }
  double ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3))/denom;
  double ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3))/denom;
  if (ua >= 0.0f && ua <= 1.0f && ub >= 0.0f && ub <= 1.0f) {
    // Get the intersection point.
    //return new Point((int) (x1 + ua*(x2 - x1)), (int) (y1 + ua*(y2 - y1)));
    PVector n  = new PVector();
    n.x=  (float) (x1 + ua*(x2 - x1));
    n.y= (float) (y1 + ua*(y2 - y1));
    return n;
  }

  return null;
}

PVector lineIntersect(PVector p1, PVector p2, PVector p3, PVector p4) {

  int x1 = (int) p1.x;
  int y1 = (int) p1.y;
  int x2 = (int) p2.x;
  int y2 = (int) p2.y; 
  int x3 = (int) p3.x; 
  int y3 = (int) p3.y; 
  int x4 = (int) p4.x;
  int y4 = (int) p4.y;

  double denom = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);
  if (denom == 0.0) { // Lines are parallel.
    return null;
  }
  double ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3))/denom;
  double ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3))/denom;
  if (ua >= 0.0f && ua <= 1.0f && ub >= 0.0f && ub <= 1.0f) {
    // Get the intersection point.
    //return new Point((int) (x1 + ua*(x2 - x1)), (int) (y1 + ua*(y2 - y1)));
    PVector n  = new PVector();
    n.x=  (float) (x1 + ua*(x2 - x1));
    n.y= (float) (y1 + ua*(y2 - y1));
    return n;
  }

  return null;
}


float calculate_determinant_2x3(PVector p1, PVector p2, PVector p3) 
{
  return p1.x*p2.y+p2.x*p3.y+p3.x*p1.y-p1.y*p2.x-p2.y*p3.x-p3.y*p1.x;
}


Vector<PVector> arrangeVertices(Vector<PVector> vertices)  
{
  int count= vertices.size();
  float determinant;
  int iCounterClockWise = 1;
  int iClockWise = count - 1;

  PVector referencePointA, referencePointB;
  Vector <PVector> sortedVertices = new Vector<PVector>();
  for (int jj=0; jj<vertices.size(); jj++)
  {
    PVector p = vertices.get(jj);
    //println(p);
    PVector pc= new PVector(p.x, p.y);

    sortedVertices.add(pc);
  }

  //sort all vertices in ascending order according to their x-coordinate so you can get two points of a line
  //qsort(vertices, count, sizeof(b2Vec2), comparator);
  sortPoints("x", vertices);

  //sortedVertices[0] = vertices[0];
  sortedVertices.set(0, vertices.get(0) ) ;
  referencePointA = vertices.get(0);          //leftmost point
  referencePointB = vertices.get(vertices.size()-1);    //rightmost point

  //you arrange the points by filling our vertices in both clockwise and counter-clockwise directions using the determinant function
  for (int i=1; i<count-1; i++)
  {
    //determinant = calculate_determinant_2x3(referencePointA.x, referencePointA.y, referencePointB.x, referencePointB.y, vertices[i].x, vertices[i].y);
    PVector vi = vertices.get(i);
    determinant = calculate_determinant_2x3(referencePointA, referencePointB, vi);

    if (determinant<0)
    {
      //sortedVertices[iCounterClockWise++] = vertices[i];
      sortedVertices.set( iCounterClockWise++, vi );
    } else 
    {
      //sortedVertices[iClockWise--] = vertices[i];
      sortedVertices.set( iClockWise--, vi );
    }
  }

  //sortedVertices[iCounterClockWise] = vertices[count-1];
  sortedVertices.set( iCounterClockWise, vertices.get(count-1) );
  return sortedVertices;
}



/* 
 // how to generically sort any object
 public void sort(final String field, List<ItemLocation> itemLocationList) {
 Collections.sort(itemLocationList, new Comparator<ItemLocation>() {
 @Override
 public int compare(ItemLocation o1, ItemLocation o2) {
 if(field.equals("icon")) {
 return o1.icon.compareTo(o2.icon);
 } if(field.equals("title")) {
 return o1.title.compareTo(o2.title);
 } else if(field.equals("message")) {
 return o1.message.compareTo(o2.message);
 } 
 .
 . fill in the rest of the fields...
 .
 else if(field.equals("locSeen")) {
 return o1.locSeen.compareTo(o2.locSeen);
 } 
 }           
 });
 }
 */

/*
how to sort pvector
 */
void sortPoints(final String field, List<PVector> itemLocationList) {
  Collections.sort(itemLocationList, new Comparator<PVector>() {
    @Override
      public int compare(PVector o1, PVector o2) {

      if (field.equals("x")) {
        if (o1.x<o2.x)
        {
          return -1;
        }
        if (o1.x>o2.x)
        {
          return 1;
        }
        if (o1.x==o2.x)
        {
          return 0;
        }
        //return o1.x.compareTo(  Float (o2.x) );
      } else 
      if (field.equals("y")) {
        if (o1.y<o2.y)
        {
          return -1;
        }
        if (o1.y>o2.y)
        {
          return 1;
        }
        if (o1.y==o2.y)
        {
          return 0;
        }
      } else 
      if (field.equals("z")) {
        if (o1.z<o2.z)
        {
          return -1;
        }
        if (o1.z>o2.z)
        {
          return 1;
        }
        if (o1.z==o2.z)
        {
          return 0;
        }
      } 
      //
      println("shoudl not have reached here.");
      return 0;
    }
  }
  );
}