import java.util.Vector;
Vector drawers;
int numdrawers=5000;


int gc1,gc2,gc3;

int ss=1;

void setup()
{

  size(800,800);
  background(255);
  
  gc1=128;
  gc2=gc1;
  gc3=gc1;

  drawers  = new Vector();

  for(int i=0 ; i< numdrawers; i++ )
  {

    Drawer d = new Drawer(new PVector(width/2,height/2));
    d.c1=gc1;
    d.c2=gc2;
    d.c3=gc3;
    drawers.add(d);
  }
  
  rectMode(CENTER);
}

void draw()
{
  //background(255);
  
  if(keyPressed)
  {
   if(key=='a')
    {
     gc1++;
     if(gc1>255)
     {
      gc1=255 ;
     }
     
    } 
    
    if(key == 's')
    {
     gc1--;
     if(gc1<0)
     {
       gc1=0;
     } 
      
    }
    
    
     if(key=='z')
    {
     gc3++;
     if(gc3>255)
     {
      gc3=255 ;
     }
     
    } 
    
    if(key == 'x')
    {
     gc3--;
     if(gc3<0)
     {
       gc3=0;
     } 
      
    }
    
    ///////////////////
     if(key=='q')
    {
     gc2++;
     if(gc2>255)
     {
      gc2=255 ;
     }
     
    } 
    
    if(key == 'w')
    {
     gc2--;
     if(gc2<0)
     {
       gc2=0;
     } 
      
    }
    
    
    for(int i=0 ; i< numdrawers; i++ )
  {
     Drawer d = (Drawer) drawers.get(i);
     d.c1=gc1;
     d.c2=gc2;
     d.c3=gc3;
  }
    
  }
  
  for(int i=0 ; i< numdrawers; i++ )
  {

    Drawer d = (Drawer) drawers.get(i); 
    d.run();
  }
}

void keyPressed()
{
 if(key=='1')
 {
  setType(1);
  
 }

 if(key=='2')
 {
  setType(2);
 } 
  
}


void setType(int a)
{
  
  for(int i=0; i <drawers.size();i++)
  {
   Drawer d = (Drawer) drawers.get(i);
   d.type=a;
   
  } 
}




