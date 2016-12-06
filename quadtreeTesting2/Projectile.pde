class Projectile extends SpaceObject
{
  int r=10;
  boolean hit;
  Projectile()
  {
    super();
    loc.y=mhgt-10;
    loc.x = mwid/2;
    vel = PVector.sub( new PVector(mouseX, mouseY), this.loc);
    vel.normalize();
    vel.mult(4);


    this.x= (int) loc.x;
    this.y = (int) loc.y;
    this.width=(int) r;
    this.height= (int) r;
  }
  void bounds()
  {

    if (loc.y<0)
    {
      remove=true;
    }
  }

  void render()
  {
    if (hit)
    {
      fill(0, 255, 0);
    } else
    {
      fill(0, 0, 255);
    }
    ellipse(loc.x, loc.y, r, r);
  }
}