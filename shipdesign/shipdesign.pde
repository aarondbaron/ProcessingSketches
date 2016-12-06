

int[][] arr;

long timer;

float prevx,prevy;
float px,py;

int numTimes=20;
float ang,r;

float sc;

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
  
  sc=1.0;
}


void draw()
{
  scale(sc);
  
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
    else
    {
    
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


        px = ( width/2  +  r*cos(ang));
        py = ( height/2 + r*sin(ang));
        ang+=.1;
        rect(px,py,1,1);
      
    }
    else
    {
      px += (int) random(-2,2);
      py += (int) random(-2,2);
    }



    stroke(0,0,0,20);
    if(sc>.0001)
    {
    strokeWeight(1.0/sc);
    }

    /*
    rect(px,py,2,2);
    rect(py,px,2,2);
    rect(width-px,height-py,1,1);
    rect(width- py,height-px,1,1);
    */

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
  
  if(key=='a')
  {
   sc+=.1; 
   int lim=3;
   if(sc>lim)
   {
    sc=lim; 
   }
   println(sc);
    
  }
  if(key=='s')
  {
   sc-=.1;
   if(sc<0)
   {
    sc=0;
    
   } 
   println(sc);
  }
}

