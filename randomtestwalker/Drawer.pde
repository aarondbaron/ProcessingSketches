class Drawer
{

  PVector loc;

  PVector remains[];


  int numtrail=2;

  int iter=0;

  int c1,c2,c3;

  float myang;
  int type;

  Drawer(PVector l)
  {
    loc=l;


    remains = new PVector[numtrail];

    for(int i=0; i < remains.length; i++ )
    {
      remains[i] = new PVector(loc.y,loc.y);
    }

    myang=random(0,2*PI);
    type=1;
  }

  void run()
  {
    update();
    render();
  }


  void update()
  {
    iter++;
    System.arraycopy(remains, 0, remains, 1, remains.length-1);

    if(mousePressed)
    {
      PVector df=new PVector(mouseX-loc.x,mouseY-loc.y);
      df.limit(4);
      int dd=0;
      if(mouseButton==LEFT)
      {
        //dd=1;


        loc.add(df);
      }
      if(mouseButton==RIGHT)
      {
        //dd=-1;
        loc.sub(df);
      }

      /*
      if(loc.x<mouseX)
       {
       loc.x+=dd;
       }
       if(loc.x>mouseX)
       {
       loc.x-=dd;
       }
       
       if(loc.y<mouseY)
       {
       loc.y+=dd;
       }
       if(loc.y>mouseY)
       {
       loc.y-=dd;
       }
       */
    }
    else
    {

      //loc.x += (int) random(-2,2);
      //loc.y += (int) random(-2,2);

      //setup 1
      float rr=0;
      float f1=0;
      float f2=0;
      if(type==1)
      {
        rr=random(0,3);
        f1= rr*random(-2,2);
        f2= rr*random(-2,2);



        if(f1>0)
        {
          c1++;
        }
        else
        {
          c1--;
        }
        if(f2>0)
        {
          c2++;
        }
        else
        {
          c2--;
        }

        if(rr>1.5)
        {
          c3++;
        }
        else
        {
          c3--;
        }
      }


      if(type==2)
      {
        rr = myang + int(random(-1,2))*.6*random(0,myang);

        f1=cos(rr);
        f2=sin(rr);

        if(f1>0)
        {
          c1++;
        }
        else
        {
          c1--;
        }
        if(f2>0)
        {
          c2++;
        }
        else
        {
          c2--;
        }

        if(rr>myang)
        {
          c3++;
        }
        else
        {
          c3--;
        }
      }


      /////
      ///check the color bound

      if(c1>255)
      {
        c1=255;
      }

      if(c1<0)
      {
        c1=0;
      }
      if(c2>255)
      {
        c2=255;
      }

      if(c2<0)
      {
        c2=0;
      }

      if(c3>255)
      {
        c3=255;
      }

      if(c3<0)
      {
        c3=0;
      }

      ////
      if(type==1)
      {
        loc.x += rr*f1;
        loc.y += rr*f2;
      }
      if(type==2)
      {
        loc.x += f1;
        loc.y += f2;
      }


      //loc.x += random(-2,2)*cos(PI/4.0);
      //loc.y += random(-2,2) * sin(PI/4.0);
    }

    remains[0]=new PVector(loc.x,loc.y);
  }

  void render()
  {

    if(iter>=remains.length)
    {
      iter=0;
    }

    for(int i = 0; i < remains.length; i++)
    {

      //stroke( 255.0* (float)i/255.0  );
      float cc= map(i,0,remains.length,0,200);
      stroke( c1,c2,c3);

      PVector p = remains[i];
      rect(p.x,p.y,ss,ss);
    }



    if(!mousePressed)
    {
      stroke(255);
      noFill();
      rect(loc.x,loc.y,ss,ss);
    }
  }
}

