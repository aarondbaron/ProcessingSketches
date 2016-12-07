class Dit
{
  
  PVector loc, vel, acc;
  
  Dit(int x, int y)
  {
    loc = new PVector(x,y);
    
    float r = random(0,4);
    
    float ang = random(0, 2*PI);
    
    vel = new PVector( r*cos(ang) ,  r*sin(ang)  );
    acc = new PVector(0,.1);
    
  }
  
  void run()
  {
    update();
    render();
    
  }
  
  void update()
  {
    
    if(loc.y > height)
    {
     vel.y = vel.y * -.9;
    }
    
    vel.add(acc);
    loc.add(vel);
  }
  
  void render()
  {
    rect(loc.x,loc.y,1,1);
  }
  
  
  
  
}
