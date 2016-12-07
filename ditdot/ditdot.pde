/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/60442*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
import java.awt.event.*;
import java.util.*;

int NUMBER=6000;
Vector dits;

boolean back=true;

float speedMult=1;

int c=0;
int delta=1;

long ctimer;
long interval=1;

boolean colorChange;

boolean slowDown=true;

boolean useAcc=true;

void setup()
{
  size(640, 480);
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
    }
  }
  );

  dits = new Vector();

  for (int i=0;i<NUMBER;i++)
  {
    Dit d = new Dit();
    dits.add(d);
  }



  ctimer = System.currentTimeMillis();

  rectMode(CENTER);
}


void draw()
{
  if (back)
  {
    background(255-c);
  }



  for (int i=0;i<dits.size();i++)
  {
    Dit d = (Dit) dits.get(i);
    d.run();
    if (mousePressed)
    {

      PVector p =  new PVector( mouseX-d.loc.x, mouseY-d.loc.y ) ;
      if (mouseButton==LEFT)
      {
        if (!useAcc)
        {
          d.vel.add(p ); 
          d.vel.normalize();
          d.vel.mult(speedMult);
        }
        else
        {
          p.normalize();
          d.acc= p ;
        }
      }
      else if (mouseButton==RIGHT)
      {
        if (!useAcc)
        {
          d.vel.sub(p);
          d.vel.normalize();
          d.vel.mult(speedMult);
        }
        else
        {
          p.normalize();
          p.mult(-1);
          d.acc = p ;
        }
      }
    }
  }


  if (System.currentTimeMillis()-ctimer>interval && colorChange)
  {
    c+=delta;
    if (c>255)
    {
      c=255;
      delta=-1;
    }
    if (c<0)
    {
      c=0;
      delta=1;
    }

    ctimer+=interval;
  }
}

void keyPressed()
{
  if (key=='b')
  {
    back=!back;
  }

  if (key=='j')
  {
    //jitter them
    for (int i=0;i<dits.size();i++)
    {
      Dit d = (Dit) dits.get(i);
      d.vel.x+=2*Math.random()-1;
      d.vel.y+=2*Math.random()-1;
    }
  }

  if (key=='0')
  {
    colorChange=!colorChange;
  }

  if (key=='r')
  {

    for (int i=0;i<dits.size();i++)
    {
      Dit d = (Dit) dits.get(i);
      d.vel.mult(-1);
    }
  }

  if (key=='s')
  {
    slowDown=!slowDown;
  }
  
  if(key=='a')
  {
   useAcc=!useAcc; 
  }
}




void mouseWheel(int delta) {
  println("mouse has moved by " + delta + " units."); 

  if (delta<0)
  {
    speedMult += delta*.1;
    if (speedMult<1)
    {
      speedMult=1;
    }
  }
  else
  {
    speedMult+=delta*.1;
    if (speedMult>100)
    {
      speedMult=100;
    }
  }
  println(speedMult);
}

