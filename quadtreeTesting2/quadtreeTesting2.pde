import java.util.List;
import java.util.Vector;
import java.awt.Rectangle;

Quadtree quad;
int numcalcs;
//Vector<Rectangle> allObjects;
Vector<String> types;
int numberRects =100;
int mwid, mhgt;
Vector<SpaceObject> spaceObjects;
PApplet sketchPApplet=this;

void setup()
{
  size(600, 800, P3D);
  mwid=this.width;
  mhgt=this.height;
  quad = new Quadtree(0, new Rectangle(0, 0, width, height));
  //rectMode(CORNERS);
  //allObjects = new Vector<Rectangle>();
  spaceObjects = new Vector<SpaceObject>();
  types = new Vector<String>();
  //makeRandomRects();
  makeRandomEnemies();
  
  rectMode(CENTER);
}


void draw()
{
  background(0);

  int numtests=0;
  numcalcs=0;
  quad.clear();
  //for (int i = 0; i < allObjects.size(); i++) {
  //  quad.insert(allObjects.get(i));
  //}
  for (int i = 0; i < spaceObjects.size(); i++) {
    quad.insert(spaceObjects.get(i));
  }

  List<Rectangle> returnObjects = new ArrayList();
  //for (int i = 0; i < allObjects.size(); i++) {
  for (int i = 0; i < spaceObjects.size(); i++) {
    returnObjects.clear();
    //Rectangle theobj=allObjects.get(i);
    SpaceObject theobj = spaceObjects.get(i);
    if (theobj.remove)
    {
      spaceObjects.remove(theobj);
      i--;
      continue;
    }
    theobj.run();
    //println("didmae");
    //Rectangle theobj=sobj.rect;

    ////update
    //theobj.y+= int(random(5));
    //if (theobj.y>height)
    //{
    //  theobj.y=-theobj.height;
    //  theobj.x= int( random(width));
    //}

    //render
    //fill(255);
    //rect(theobj.x, theobj.y, theobj.width, theobj.height);
    quad.retrieve(returnObjects, theobj);

    for (int x = 0; x < returnObjects.size(); x++) {
      numtests++;

      // Run collision detection algorithm between objects // or decide not to.
      Rectangle otherobj = returnObjects.get(x);
      //must know what otherobj belongs to.
      if (theobj.equals(otherobj))
      {
        continue;
      }
      if ( (theobj instanceof Enemy && otherobj instanceof Enemy) || (theobj instanceof Projectile && otherobj instanceof Projectile) )  //
      {
        // numtests--; 
        //return;
      } else
      {
        numcalcs++;

        if (theobj.x < otherobj.x + otherobj.width &&
          theobj.x + theobj.width > otherobj.x &&
          theobj.y < otherobj.y + otherobj.height &&
          theobj.height + theobj.y > otherobj.y) {
          // collision detected!
          fill(255, 0, 0);
          rect(theobj.x+10, theobj.y+10, theobj.width-10, theobj.height-10);
          fill(255, 255, 0);
          rect(otherobj.x+10, otherobj.y+10, otherobj.width-10, otherobj.height-10);
        }
      }
    }
  }
  //int numobjects=allObjects.size();
  int numobjects=spaceObjects.size();
  int totalPossible=(numobjects*(numobjects-1));
  //println("numobjects: " + numobjects + " numtests: " + numtests + " savings: " + totalPossible + "-" + numtests + "=" + (totalPossible-numtests) );
  fill(255);
  text("numobjects: " + numobjects + " numtests: " + numtests + " numcalcs: " + numcalcs + " savings: " + totalPossible + "-" + numtests + "=" + (totalPossible-numtests) + " \nframerate: " + frameRate, 0, 20);

  if (mousePressed)
  {
    //addRect();
    spaceObjects.add(new Projectile());
  }
}

void keyPressed()
{
  if (key=='r')
  {
    // makeRandomRects();
    makeRandomEnemies();
  }
  if (key=='a')
  {
    // makeRandomRects();
    addRandomEnemies();
  }
}
//void addRect()
//{
//  int xw= 20;
//  int yh= 20;
//  Rectangle r = new Rectangle(mouseX, mouseY, xw, yh  ); 

//  allObjects.add(r);
//}

//void makeRandomRects()
//{
//  allObjects.clear();

//  for (int i=0; i<numberRects; i++) // 1000 seems to be limit.  
//  {
//    int x1= int(random(width));
//    int y1= int(random(40, height));
//    int xw= 20;
//    int yh= 20;
//    Rectangle r = new Rectangle(x1, y1, xw, yh  ); 

//    allObjects.add(r);
//  }
//}

void makeRandomEnemies()
{
  spaceObjects.clear();

  for (int i=0; i<numberRects; i++) // 1000 seems to be limit.  
  {
    spaceObjects.add( new Enemy());
  }
}

void addRandomEnemies()
{
 
  for (int i=0; i<numberRects; i++) // 1000 seems to be limit.  
  {
    spaceObjects.add( new Enemy());
  }
}