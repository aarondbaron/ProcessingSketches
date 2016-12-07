class Walker
{

  long timeOut,timer;
  boolean timeUp;
  int x,y, prevx,prevy;



  Walker(int x, int y,long t)
  {
    this.x=x;
    this.y=y;
    timeOut=t;

    timer=System.currentTimeMillis();
  } 


  void run()
  {
    update();
    render();
  }

  void update()
  {
    if(System.currentTimeMillis()-timer>timeOut)
    {
      timeUp=true;
    }
    
    prevx=x;
    prevy=y;
    
    x+=(int) random(-2,2);
    y+=(int) random(-2,2);
  }

  void render()
  {

    noFill();
    stroke(0,0,0);


    line(x,y,prevx,prevy);
     line(y,x,prevy,prevx);
     line(width-x,height-y,width-prevx,height-prevy);
     line(width- y,height-x,width- prevy,height-prevx);
  }
}






