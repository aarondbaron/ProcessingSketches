class Dit
{

  color c;
  PVector loc, vel, acc;  
  PVector locorig;
  Dit()
  {
    loc = new PVector((float) Math.random()*width, (float)Math.random()*height);
    vel= new PVector(   (float) ( 2*Math.random()-1), (float) (2*Math.random()-1));
    vel.normalize();  

    locorig = new PVector(loc.x, loc.y);
    acc= new PVector();
  }
  
  Dit(color c)
  {
    loc = new PVector((float) Math.random()*width, (float)Math.random()*height);
    vel= new PVector(   (float) ( 2*Math.random()-1), (float) (2*Math.random()-1));
    vel.normalize();  

    locorig = new PVector(loc.x, loc.y);
    acc= new PVector();
    
    this.c=color(c);
  }
  
  Dit(PVector loc, color c)
  {
    this.loc=loc;
    vel= new PVector( 0,0);

    locorig = new PVector(loc.x, loc.y);
    acc= new PVector();
    
    this.c=color(c);
  }


  void run()
  {
    update();
    render();
  }
  void update()
  {

    if (useAcc)
    {
      vel.add(acc);
    }
    loc.add(vel);

    if (loc.x<0 || loc.x>width)
    {
      vel.x *= -1;
    }
    if (loc.y<0 || loc.y>height)
    {
      vel.y *= -1;
    }

    if (slowDown)
    {
      vel.mult(.99);
    }

    acc.mult(0);
  }

  void render()
  {
    //stroke(c,c,c);
    
    fill(c);
    rect(loc.x, loc.y, 1, 1);
  }
}

