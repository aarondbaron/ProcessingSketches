
Parab par, par2;
void setup()
{
  size(500, 500);
  PVector pp1, pp2, pp3, pp4;
  pp1 = new PVector(0, 0);
  pp2= new PVector(0, height);
  pp3 = new PVector(0, height);
  pp4 = new PVector(width, height);

  par = new Parab(pp1, pp2, pp3, pp4);
  
  par2 = new Parab(pp1, pp2, pp3, pp4);
  
}


void draw()
{
  background(255);

  par.run();
  
  
}



class Parab
{

  int num=10;
  PVector p1, p2, p3, p4;
  
  Parab(PVector p1, PVector p2, PVector p3, PVector p4)
  {
    this.p1=new PVector(p1.x, p1.y);
    this.p2=new PVector(p2.x, p2.y);
    this.p3=new PVector(p3.x, p3.y);
    this.p4=new PVector(p4.x, p4.y);
    
     
  }


  void render()
  {
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


      temp1 = PVector.add(temp1, PVector.mult(dir1, space1));
      temp2 = PVector.add(temp2, PVector.mult(dir2, space2));

      int ff = (int) map (i, 0, num, 0, 255);
      stroke(ff, 255-ff, 0);

      line(temp1.x, temp1.y, temp2.x, temp2.y);
    }
  }

  void run()
  {

    render();
  }
}

