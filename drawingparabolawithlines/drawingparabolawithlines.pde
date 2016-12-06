

int x1=10;
int y1=10;

int x2=10;
int y2=400;

int x3=10;
int y3=400;

int x4=400;
int y4=400;

void setup()
{
  background(255);
  size(500,500);
}

float r =0;
void draw()
{
 
  background(255);
  
  //translate(width/2,height/2);
  //rotate(r);
  
 line(x1,y1,x2,y2); 
 
 line(x3,y3,x4,y4);
 
 int startx=x1; //always
 int starty=y1;
 
 int endx =x3;
 int endy = y4; //always
 
 
 
 for(int i = 0; i< y2; i++)
 {
   if(starty>=y4 || endx>=x4)
   {
    break; 
   }
   
   starty += 10;
   endx += 10;
   
   line(startx, starty, endx,endy);
   
   
 }
 
  r+=.05;
}
