class Enemy extends SpaceObject
{

  boolean hit;
  Enemy()
  {
    super();

    vel = new PVector(0, random(1, 7));
    //vel.normalize();
    //vel.mult(4);


    this.x= (int) loc.x;
    this.y = (int) loc.y;
    this.width=(int) r;
    this.height= (int) r;
  }



  void bounds()
  {
   
    if (loc.y>mhgt)
    {
      loc.y=0;
      loc.x= int( random(mwid));
    } 
    
  }
  void render()
  {
    if (hit)
    {
      fill(255, 0, 0);
    } else
    {
      fill(255);
    }
    ellipse(loc.x, loc.y, r, r);
  }
}