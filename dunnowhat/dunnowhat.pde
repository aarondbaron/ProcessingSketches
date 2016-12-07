

int[][] arr;

long timer;

int prevx,prevy;
int px,py;

int numTimes=20;
float ang,r;

void setup()
{
  size(600,600);

  background(255);

  arr= new int[200][200];

  timer=System.currentTimeMillis();


  px=width/2;
  py=height/2;

  prevx=px;
  prevy=py;

  rectMode(CENTER);
}


void draw()
{
  fill(0);
  if(mousePressed)
  {

    if(key=='r')
    {
      int difx=mouseX-width/2;
      int dify=mouseY-height/2;

      ang=atan2(dify,difx);

      r=pow(px,2) + pow(py,2);
      r=sqrt(r);
    }

    px=mouseX;
    py=mouseY;
    prevx=px;
    prevy=py;
  }

  for(int i=0; i<numTimes;i++)
  {

    if(key=='r')
    {


      px = (int)( width/2  +  r*cos(ang));
      py = (int)( height/2 + r*sin(ang));
      ang+=.1;
    }
    else
    {
      px += (int) random(-2,2);
      py += (int) random(-2,2);
    }



    stroke(0,0,0,20);
    strokeWeight(1);
    //rect(px,py,2,2);
    //rect(py,px,2,2);

    //rect(width-px,height-py,1,1);
    //rect(width- py,height-px,1,1);

    ///
    //alternate

    line(px,py,prevx,prevy);
    line(py,px,prevy,prevx);

    line(width-px,height-py,width-prevx,height-prevy);
    line(width- py,height-px,width- prevy,height-prevx);
  }
  /*
  if(mousePressed)
   {
   loadPixels();
   
   for(int i=0; i<pixels.length;i++)
   {
   
   int location=mouseX+mouseY*width;
   
   int location2=mouseY+mouseX*height;
   
   //pixels[i]=pixels[pixels.length-1-i];
   //pixels[location2]=pixels[location];
   
   
   
   
   px++;
   if(px>width)
   {
   px=0;
   py++;
   }
   
   if(py>height)
   {
   py=0;
   }
   }
   
   
   updatePixels();
   }
   */

  /*
  loadPixels();
   if(!mousePressed )
   {
   
   for(int i=0; i<pixels.length;i++)
   {
   px++;
   if(px>width)
   {
   px=0;
   py++; 
   }
   
   if(py>height)
   {
   py=0; 
   }
   
   pixels[i]=get(px-1,py);
   }
   }
   updatePixels();
   */




  prevx=px;
  prevy=py;
}

void keyPressed()
{
  if(key=='b')
  {
    background(255);
  }
}

