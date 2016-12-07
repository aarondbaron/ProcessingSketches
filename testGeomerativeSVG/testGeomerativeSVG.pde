
import geomerative.*;

RShape rp;
RShape polyshp;

void setup()
{
  size(400, 400);
  RG.init(this);
  rp = RG.loadShape("images/sword1.svg"); // fist is embeded in   child  ..
  println(rp.children.length);
  RShape[] children= rp.children;
  RShape rp2 = children[0];
  println(rp2.children.length);
  RShape[] children2= rp2.children;
  RShape rp3 = children2[0];
  println(rp3.children.length);
}

boolean jitter2;
int fillcount;
int counter;
void draw()
{
  background(255);
  RShape[] children= rp.children;
  RShape rp2 = children[0];
  RShape[] children2= rp2.children;
  rp2 =children2[0];
  children2=rp2.children;
  translate(-rp2.getWidth()/2 + mouseX, -rp2.getHeight()/2 + mouseY); // dont' know why
  if(frameCount%4==0)
  {
  counter++;
  }

  for (int i=0; i<children2.length; i++)
  {
    PVector randvec2;
    if (jitter2)
    {
      // float m=map(vel.y, 0, 2.5, 0, 1);
      float m=2;

      //randvec2=new PVector(random(-1, 1), random(-1, 1));
      randvec2=new PVector(random(-m, m), random(-m, m));
    } else
    {
      randvec2= new PVector();
    }
    pushMatrix();       
    translate(randvec2.x, randvec2.y); // shift each of the children by some different random amount
    //pp.width=0; // setting this hhas no effect
    // pp.height=0; // setting this has no effect.
    //println(i + " " + (pp.width) + "," + pp.height + "--" + p3.width + "," + p3.height+ "--" + p2.width + "," + p2.height);

    int rval=255-40*abs(fillcount-i);
    float sw=2;
    color cc=color(100+i*5);
    if(i==counter%children2.length)
    {
     cc = color(255); 
    }
    color cc2=color(0);
    children2[i].setFill(cc);
    //children2[i].setFill(false);
    children2[i].setStroke(cc2);
    children2[i].setStrokeWeight(sw);
    RG.shape(children2[i]);

    //    float pointSeparation = map(constrain(abs(vel.y), 0, 10), 0, 10, 200, 3);

    //    // We create the polygonized version
    //    RG.setPolygonizer(RG.UNIFORMLENGTH);
    //    RG.setPolygonizerLength(pointSeparation);

    //    polyshp = RG.polygonize(children2[i]);
    //    // We draw the polygonized group with the SVG styles
    //    RG.shape(polyshp);

    popMatrix();
  }
}