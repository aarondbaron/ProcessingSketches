class CutShape
{
  boolean flicker;
  boolean dead;
  int flickerRate=5;
  int c1, c2, c3;
  Vector<PVector> points;
  PVector loc, vel;

  boolean doRotate;
  float rotX;
  float rotXAmt=.1;

  float rotY;
  float rotYAmt=.1;
  CutShape(Vector<PVector> pts)
  {
    //assumes that the pts were given in true form.. (not relative)    

    //deep copy.
    Vector <PVector> np = new Vector<PVector>();
    for (int i=0; i<pts.size(); i++)
    {
      PVector p = pts.get(i);
      //println(p);
      PVector pc= new PVector(p.x, p.y);

      np.add(pc);
    }

    this.points=np;

    c1= int( random(255) );
    c2= int( random(255) );
    c3= int( random(255) );

    PVector summation = new PVector();
    for (int i=0; i< points.size(); i++)
    {
      summation.add(points.get(i));
      //print(points.get(i) + " ");
    }
    //println();
    loc = new PVector((float) summation.x/ (float) points.size(), (float)  summation.y/ (float) points.size());
    println("CutShape created loc: " + loc);
    //fix the points by subtracting the loc ..make them relative
    for (int i=0; i< this.points.size(); i++)
    {
      PVector p = points.get(i);
      p.sub(loc);
    }

    vel = new PVector();
  }


  CutShape(String s)
  {
    if (s.toLowerCase().equals("triangle") ) 
    {
      points = new Vector<PVector>();

      points.add( new PVector(width/2, height/4) );
      points.add( new PVector(width/4, height-height/4) );
      points.add( new PVector(width-width/4, height-height/4) );
    }
    if (s.toLowerCase().equals("square") ) 
    {
      points = new Vector<PVector>();
      points.add( new PVector(width-width/4, height/4) );
      points.add( new PVector(width/4, height/4) );
      points.add( new PVector(width/4, height-height/4) );
      points.add( new PVector(width-width/4, height-height/4) );
    }
    if (s.toLowerCase().equals("convex") ) 
    {
      points = new Vector<PVector>();

      points.add( new PVector(width/4, height/4) );
      points.add( new PVector(width-width/4, height/4) );
      points.add( new PVector(width-width/4, height-height/4) );

      points.add( new PVector(width/2, height/2) );

      points.add( new PVector(width/4, height-height/4) );
    }
    if (s.toLowerCase().equals("hackcircle") ) 
    {
      points = new Vector<PVector>();
      PVector rad = new PVector(width/2, height/2); 
      float r=150;
      int num=30;
      float ang= 2.0*PI / (float) num; 

      for (int i=0; i<num; i++)
      {
        points.add( new PVector(rad.x + r*cos(ang*i), rad.y + r*sin(ang*i) ) );
      }
    }

    PVector summation = new PVector();
    for (int i=0; i< points.size(); i++)
    {
      summation.add(points.get(i));
    }
    loc = new PVector((float) summation.x/ (float) points.size(), (float)  summation.y/ (float) points.size());

    //fix the points by subtracting the loc ..make them relative
    for (int i=0; i< points.size(); i++)
    {
      PVector p = points.get(i);
      p.sub(loc);
    }

    c1= int( random(255) );
    c2= int( random(255) );
    c3= int( random(255) );

    vel = new PVector();
  }



  //////////////////////////////////
  void run()
  {
    update();
    render();
  }
  void update()
  {

    if (doRotate)
    {
      rotX+=rotXAmt;
      rotXAmt*=.99;

      rotY+=rotYAmt;
      rotYAmt*=.99;
    }

    if (flicker)
    {
      if (frameCount%45==0)
      {
        flickerRate--;
      }
      if (flickerRate<1)
      {
        flickerRate=1; 
        dead = true;
      }
    }

    loc.add(vel);
    vel.mult(.98);
  }
  void render()
  {
    //noFill();
    if (flicker)
    {
      if (flickerRate>1)
      {
        if (frameCount % flickerRate==0)
        {
          noFill();
          noStroke();
        } else
        {
          fill( c1) ;
          stroke(c1, c2, c3);
        }
      } else
      {
        noFill();
        noStroke();
      }
    } else {
      fill( c1) ;
      stroke(c1, c2, c3);
    }


    pushMatrix();
    translate(loc.x, loc.y);
    if (doRotate)
    {
      rotateX(rotX);
      rotateY(rotY);
    }

    beginShape();
    for (int i = 0; i<points.size(); i++)
    {
      PVector v = points.get(i);
      //vertex(v.x+loc.x, v.y+loc.y);
      vertex(v.x, v.y);
    }
    endShape(CLOSE);

    //ellipse(loc.x, loc.y, 3, 3);
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  PVector getLoc()
  {
    return loc;
  }


  //////
  //this will be relative to 0 positions because the loc was subtracted from it
  Vector<PVector[]> getSegments()
  {
    Vector<PVector[]> result = new Vector<PVector[]>();


    //PVector[] pair = new PVector[2];// this is bad ...did not work
    for (int i=0; i< points.size(); i++)
    {
      PVector[] pair = new PVector[2]; // this is correct

      PVector pi= points.get(i);
      PVector pi2 = points.get( (i+1) % points.size());

      pair[0] = pi;
      pair[1] = pi2;
      print("relativepoints: " + pair[0] + " , " +  pair[1] + "__");
      result.add(pair);
    }
    return result;
  }

  //again relative 
  Vector<PVector> getPoints()
  {
    return points;
  }

  /////////////////////////
  Vector<PVector> getTruePoints()  //these are the as shown on screen points
  {
    Vector<PVector> result = new Vector<PVector>();
    for (int i=0; i< points.size(); i++)
    {
      result.add ( PVector.add(points.get(i), loc)  );
    }    
    return result;
  }

  //this will be the true positions on screen 
  Vector<PVector[]> getTrueSegs() // should refactor to getTrueSegs();
  {
    Vector<PVector[]> result = new Vector<PVector[]>();


    //PVector[] pair = new PVector[2];// this is bad ...did not work
    for (int i=0; i< points.size(); i++)
    {
      PVector[] pair = new PVector[2]; // this is correct

      PVector pi= points.get(i);
      PVector pi2 = points.get( (i+1) % points.size());

      pair[0] = PVector.add(pi, loc);
      pair[1] = PVector.add(pi2, loc);
      //print("truepoints:  " + pair[0] + " , " +  pair[1] + "__");
      result.add(pair);
    }
    //println();


    return result;
  }




  //Utilities
  ////////////////////


  Vector<CutShape> cutByLine(PVector[] slicePair)
  {
    //step 1. find the intersection points created by the slice.       
    Vector<CutShape> res = new Vector<CutShape>();    
    Vector<PVector>  intersectionPoints = new Vector<PVector>();
    Vector<PVector [] > segs = this.getTrueSegs();

    //step 1. add intersection points to both
    for (int i=0; i<segs.size(); i++)
    {
      PVector[] pair = segs.get(i);   

      PVector intersectionPoint = lineIntersect(slicePair[0], slicePair[1], pair[0], pair[1]);

      if (intersectionPoint!=null)
      {
        intersectionPoints.add(intersectionPoint);
      }
    }  
    if (intersectionPoints.size()==0)
    {
      println("no intersection");
      return null;
    }
    if (intersectionPoints.size()==1)
    {
      println("only one point-- no slice");
      return null;
    }

    Vector<PVector>  shape1Points = new Vector<PVector>();
    Vector<PVector>  shape2Points = new Vector<PVector>();
    shape1Points.addAll(intersectionPoints);
    shape2Points.addAll(intersectionPoints); // these are true points.  

    //step 2. assign remaining points
    //iterate through all the vertices and add them to each sprite's shape
    Vector<PVector> tsTruePoints = this.getTruePoints();
    for (int i=0; i<tsTruePoints.size(); i++)
    {
      //get our vertex from the polygon
      //PVector point = ts.points.get(i);
      PVector point = tsTruePoints.get(i);

      //you check if our point is not the same as our entry or exit point first
      PVector diffFromEntryPoint = PVector.sub(point, slicePair[0]);
      PVector diffFromExitPoint = PVector.sub(point, slicePair[1]);

      if ((diffFromEntryPoint.x == 0 && diffFromEntryPoint.y == 0) || (diffFromExitPoint.x == 0 && diffFromExitPoint.y == 0))
      {
      } else 
      {
        float determinant = calculate_determinant_2x3(slicePair[0], slicePair[1], point);

        if (determinant > 0)
        {
          //if the determinant is positive, then the three points are in clockwise order
          shape1Points.add(point);
        } else
        {
          //if the determinant is 0, the points are on the same line. if the determinant is negative, then they are in counter-clockwise order
          shape2Points.add(point);
        }
      }
    }

    // step 3.. fix order
    Vector<PVector> testpoints1 = arrangeVertices(shape1Points);
    Vector<PVector> testpoints2 = arrangeVertices(shape2Points);

    CutShape cutShape1= new CutShape(testpoints1);
    CutShape cutShape2= new CutShape(testpoints2);

    res.add(cutShape1);
    res.add(cutShape2);

    return res;
  }


  //

  double CalcSignedDistance(/*const QLineF &line, const QPointF &p*/)
  {
    //return (p.x()-line.p1().x())*(line.p2().x()-line.p1().x())+
    //(p.y()-line.p1().y())*(line.p2().y()-line.p1().y());
    return 0;
  }


  void randomRotAmt()
  {
    rotXAmt=random(-.1, .1);
    rotYAmt=random(-.1, .1);
  }
}