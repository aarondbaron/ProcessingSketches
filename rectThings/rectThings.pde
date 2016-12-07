import java.util.Vector;

Vector things;
long timer;

int mx=25;
int rate=2;
int mxrate=40;
boolean slowDown=true;
//boolean increasing = true;
int num=1000;
void setup()
{
  size(1000, 500);
  things = new Vector();
  for (int i=0 ;i < num; i++)
  {
    //things.add(new Thing( new PVector(num*i /width, height/2)));
    float f1= (float) width/ (float) num;
    float f2 = (float) height/ (float) num;

    things.add(new Thing( new PVector( i*f1, i* f2)));
  }

  timer=System.currentTimeMillis();
  rectMode(CENTER);
}


void draw()
{
  background(0);

  for (int i =0; i< things.size(); i++)
  {
    Thing t= (Thing)things.get(i);
    t.run(); 

    if (mousePressed)
    {
      PVector m = new PVector(mouseX, mouseY);
      t.acc = PVector.sub(m, t.loc);
      t.acc.normalize();
    }
  }
}

void keyPressed()
{
  if (key=='s')
  {
    slowDown=!slowDown;
  } 

  if (key=='1')
  {
    print("pressed 1");
    rate++;
    if (rate>mxrate)
    {
      rate=mxrate;
    }
  }
  if (key=='2')
  {
    print("pressed 2");

    rate--;
    if (rate<0)
    {
      rate=0;
    }
  }
}

