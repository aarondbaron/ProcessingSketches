import java.util.Vector;
PImage pp;
boolean colorChange;

boolean slowDown=true;

boolean useAcc=true;
float speedMult=1;



int imx, imy, dim;
Vector dits;
Dit ditarray[][];
void setup()
{
  size(500, 500);
  noStroke();
  pp = loadImage("moonwalk.jpg");

  pp.loadPixels();
  imx=pp.width;
  imy=pp.height;

  dits = new Vector();
  ditarray=new Dit[imx][imy];

  for (int i=0; i< imx; i++)
  {
    for (int j=0; j<imy; j++)
    {

      //ditarray[i][j]= new Dit(pp.get(i, j));
      Dit d = new Dit(new PVector(width/2-imx/2+i, height/2-imy/2+j), pp.get(i, j));

      ditarray[i][j]= d;
      dits.add(d);
    }
  }

  for (int i=0; i<imx*imy; i++)
  {
    //dits[i]=new Dit(p.
  }
}


void draw()
{
  background(255);
  //image(p, 0, 0);
  for (int i=0; i< imx; i++)
  {
    for (int j=0; j<imy; j++)
    {

      Dit d =ditarray[i][j];
      d.run();
      PVector p =  new PVector( mouseX-d.loc.x, mouseY-d.loc.y ) ;

      if (mousePressed)
      {
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
        else if (mouseButton==CENTER)
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
        else if (mouseButton == RIGHT)
        {
          ///


          PVector p2 =  new PVector( d.locorig.x-d.loc.x, d.locorig.y-d.loc.y ) ;
          p2.normalize();


          if (useAcc)
          {
            //p2.mult(.1);
            d.vel.add(p2);
          }
          else
          {
            //p2.mult(.5);
            
            d.vel.x=p2.x;
            d.vel.y=p2.y;
            d.vel.mult(.9);
            
            //d.loc.add(p2);
          }


          ///
        }
      }
    }
  }
}


void keyPressed()
{
  if (key=='b')
  {
    //back=!back;
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

  if (key=='a')
  {
    useAcc=!useAcc;
  }

  if (key=='g')
  {
    for (int i=0; i< dits.size();i++)
    {
      Dit d = (Dit) dits.get(i);
      PVector p =  new PVector( d.locorig.x-d.loc.x, d.locorig.y-d.loc.y ) ;
      p.normalize();


      if (useAcc)
      {
        p.mult(.1);
        d.vel.add(p);
      }
      else
      {
        d.vel.mult(.5);
        p.mult(.5);
        d.loc.add(p);
      }
    }
  }
}

