
PVector p1, p2, p3, p4;

int x1=10;
int y1=10;

int x2=10;
int y2=400;

int x3=10;
int y3=400;

int x4=400;
int y4=400;

float r =0;

int num=10;

PFont f;

void setup()
{
  background(255);
  size(500, 500);


  p1 = new PVector(x1, y1);
  p2 = new PVector(x2, y2);
  p3 = new PVector(x3, y3);
  p4 = new PVector(x4, y4);

  f = createFont("Arial", 16, true); // Arial, 16 point, anti-aliasing on

  textFont(f, 12);
}


void draw()
{

  background(255);

  //translate(width/2,height/2);
  //rotate(r);

  p1.x=mouseX;
  p1.y=mouseY;


  if (mousePressed && mouseButton ==RIGHT)
  {
    num++;
  } 
  if (mousePressed && mouseButton ==LEFT)
  {
    num--; 
    if (num<0)
    {
      num=0;
    }
  }

  stroke (0, 255, 0);

  line(p1.x, p1.y, p2.x, p2.y); 

  stroke (255, 0, 0);
  line(p3.x, p3.y, p4.x, p4.y);





  PVector temp1= new PVector(p1.x, p1.y);
  PVector temp2= new PVector(p3.x, p3.y);
  PVector dir1 = PVector.sub(p2, p1);
  PVector dir2 = PVector.sub(p4, p3);

  float space1 = dir1.mag()/ (float) num;
  float space2 = dir2.mag()/ (float) num;


  dir1.normalize();
  dir2.normalize();


  for (int i = 0; i< num; i++)
  {

    /*
    if (temp1.y>=p4.y || temp2.x>=p4.x)
     {
     break;
     }
     */


    temp1 = PVector.add(temp1, PVector.mult(dir1, space1));
    temp2 = PVector.add(temp2, PVector.mult(dir2, space2));


    //line(startx, starty, endx, endy);
    int ff = (int) map (i, 0, num, 0, 255);
    stroke(ff, 255-ff, 0);

    line(temp1.x, temp1.y, temp2.x, temp2.y);
  }

  r+=.05;


  fill(0);
  text("Parabola with lines: Right Mouse to add more lines, Left Mouse to remove lines", 10, height-10);
  text("Or use = and - keys", 10, height);
}


void keyPressed()
{
  if (key=='=')
  {
    num++;
  } 
  if (key=='-')
  {
    num--; 
    if (num<0)
    {
      num=0;
    }
  }
}

