class SpaceObject extends Rectangle
{
  PVector loc, vel, acc;
  //Rectangle rect;
  int r =20;
  boolean debug;
  boolean remove;
  SpaceObject()
  {
    super();
    loc = new PVector(random(10,sketchPApplet.width-10), random(10,sketchPApplet.height-10));
    vel = new PVector(0, random(1, 2));
    acc = new PVector();

    this.x= (int) loc.x;
    this.y = (int) loc.y;
    this.width=(int) r;
    this.height= (int) r;
    //rect = new Rectangle((int)loc.x, (int)loc.y, r, r  );
  }

  void run()
  {
    //specialFunction();
    update();
    render();
  }
  void update()
  {
    vel.add(acc);
    loc.add(vel);
    
    bounds();
    
    this.x=(int) loc.x;
    this.y=(int) loc.y;
    
  }
  
  void bounds()
  {
   
     
  }

  void render()
  {
    
  }
}