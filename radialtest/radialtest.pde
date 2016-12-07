
int a;

float x,y, prevx,prevy;
float ang,r;

boolean once;

void setup()
{
  background(255);
  size(600,600);
  
  rectMode(CENTER);
  prevx=width/2;
  prevy=height/2;
  x=prevx;
  y=prevy;
}


void draw()
{
  a++;

  if(mousePressed)
  {
    
    int px=mouseX-width/2;
    int py= mouseY-height/2;
    
    float tr=pow(px,2) + pow(py,2);
    tr=sqrt(tr);
        

    if(!once)
    {
      ang=atan2(py,px);
      once=true;
    }
    r=tr;
  }
  else
  {
   once=false; 
  }
  
  prevx=x;
  prevy=y;
  x=width/2+r*cos(ang);
  y=height/2+r*sin(ang);
  
  ang+=.1;
  
  noFill();
  stroke(0,0,0,50);
  rect(x,y,1,1);
  rect(y,x,1,1);  
  rect(width-x,height-y,1,1);
  rect(height-y,width-x,1,1);
  
  line(x,y,prevx,prevy);
  line(y,x,prevy,prevx);  
  line(width-x,height-y,width-prevx,height-prevy);
  line(height-y,width-x,height-prevy,width-prevx);
  
  
}

