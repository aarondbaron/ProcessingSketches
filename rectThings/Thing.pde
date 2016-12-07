class Thing
{
  PVector loc, vel, acc;
  int sz=10;
  boolean increasing =true;
  Thing(PVector loc)
  {
    this.loc=loc;
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);

    this.sz=10;
  }

  void run()
  {
    update();
    render();
  }

  void update()
  {
    if (System.currentTimeMillis() - timer<1000)
    {
      timer=timer+1000; 

      if (increasing)
      {
        sz=sz+rate;
      }
      else
      {
        sz=sz-rate;
      }

      if (sz<0)
      {
        sz=0;
        increasing=true;
      }
      if (sz>mx)
      {
        sz=mx;
        increasing=false;
      }
    }

    if (mousePressed)
    {
    }
    else
    {
      acc.mult(0);
    }
    vel.add(acc);
    loc.add(vel);

    if (loc.x<0 || loc.x>width)
    {
      vel.x *= -1;
    }
    if (loc.y<0 || loc.y>height)
    {
      vel.y *= -1;
    }
    
    if(slowDown)
    {
      vel.mult(.99); 
    }
  }

  void render()
  {
    rect(loc.x, loc.y, sz, sz);
  }
}

