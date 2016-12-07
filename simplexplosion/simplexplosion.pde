
//Dit d;

Dit[] dits;

void setup()
{
  size(500, 500);

  //d = new Dit(width/2,height/2); 

  dits = new Dit[2000];

  for (int i = 0; i < dits.length; i++)
  {
    dits[i] = new Dit( width/2, height/2 );
  }
}

void draw()
{
  background(255);
  //d.run();

  for (int i = 0; i < dits.length; i++)
  {
    dits[i].run();
  }
}

void mousePressed()
{
  for (int i = 0; i < dits.length; i++)
  {
    dits[i] = new Dit( mouseX, mouseY );
  }
}

