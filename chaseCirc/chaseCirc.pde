import java.util.Vector;
Circ cc;

Vector<Circ> circles;

int addFrameCount=60*5;
int addFrameCounter;
void setup()
{
  size(400, 400);
  cc= new Circ();

  circles= new Vector<Circ>();
  circles.add(cc);

  mouseLoc = new PVector(mouseX, mouseY);
}


int pcount;
PVector mouseLoc;
void draw()
{
  background(0);

  mouseLoc.x=mouseX;
  mouseLoc.y=mouseY;


  boolean test=true;
  int totalcount=0;
  for (int i=0; i<circles.size(); i++)
  {
    Circ c = circles.get(i); 
    c.run();
    c.setAcc(PVector.sub(mouseLoc, c.loc).normalize().mult( random(.6,1.02) ) );

    test=test && !c.touching;
    totalcount+=c.ccount;
  }
  
  if(test)
  {
   pcount++; 
  }
  




  if (frameCount - addFrameCounter > addFrameCount)
  {
    addFrameCounter= frameCount; 
    circles.add( new Circ());
  }

  println("pcount: " + pcount + " totalcount: " +totalcount + " number: " + circles.size());
}

class Circ
{
  PVector loc, vel, acc;
  int r=20;

  color c;
  int ccount;
  boolean touching;
  
  float velLimit;
  Circ()
  {
    switch(int(random(4)))
    {
      case 0:
      break;
      case 1:
      break;
      case 2:
      break;
      case 3:
      break;
    }
    loc = new PVector(random(width), random(height));
    vel = new PVector();
    acc = new PVector();

    c = color(255, 255, 255);
    
    velLimit= random(6,10);
  }

  void run()
  {
    update();
    render();
  }


  void setAcc(PVector p)
  {
    acc.x=p.x;
    acc.y=p.y;
  }
  void update()
  {
    if(loc.x<r/2)
    {
     loc.x=r/2;
     vel.x*=-1;     
    }
    if(loc.y<r/2)
    {
     loc.y=r/2;
     vel.y*=-1;     
    }
    if(loc.x>width-r/2)
    {
     loc.x=width-r/2;
     vel.x*=-1;     
    }
    if(loc.y>height-r/2)
    {
     loc.y=height-r/2;
     vel.y*=-1;     
    }

    if (PVector.dist(mouseLoc, this.loc)< this.r)
    {
      touching=true;
      ccount++;
    } else
    {
      touching=false;
    }

    vel.add(acc);
    vel.limit(velLimit);
    vel.mult(.99);
    loc.add(vel);
  }

  void render()
  {
    fill(c);
    ellipse(loc.x, loc.y, r, r);
  }
}