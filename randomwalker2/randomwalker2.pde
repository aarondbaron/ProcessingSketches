import java.util.Vector;

Vector walkers;
int x,y;

int timeout=2000;
void setup()
{
  size(600,600,P3D); 
  background(255);

  walkers=new Vector();

  //drawRandomBoxes();

  x=width/2;
  y=height/2;
}


int numTimes=1;
void draw()
{
  if(mousePressed&&mouseButton==LEFT)
  {
    x=mouseX;
    y=mouseY;

    walkers.add(new Walker(x,y,timeout));
  } 
  for(int i=0;i<numTimes;i++)
  {
    //x+=(int)random(-2,2);
    //y+=(int)random(-2,2);
    //walkers.add(new Walker(x,y,5000));
  }




  if(!mousePressed)
  {
    int i= (int) random(1,width);
    int j = (int) random(1,height);
    color c1 =color((int)random(100, 200), (int)random(100, 200), 0);
    c1=color((int)random(100, 200), (int)random(100, 200), (int)random(100, 200));
    floodFill(i, j, c1);
    floodFill(j, i, c1);
    floodFill(width-i, height-j, c1);
    floodFill(height-j, width-i, c1);
  }

  for(int i=0;i<walkers.size(); i++)
  {

    Walker w= (Walker) walkers.get(i);

    w.run();

    if(w.timeUp)
    {
      walkers.remove(w);
      i--;
    }
  }
  
  
  
  if(keyPressed)
  {
    if(key=='1')
    {
      timeout+=(125);
      println(timeout);
      for(int i=0;i<walkers.size(); i++)
      {
        Walker w= (Walker) walkers.get(i);  
        w.timeOut=timeout;       
      }
      
    }
    if(key=='2')
    {
      timeout-=125;
      if(timeout<125)
      {
        timeout=125;
        
      }
      println(timeout);
      
      for(int i=0;i<walkers.size(); i++)
      {
        Walker w= (Walker) walkers.get(i);  
        w.timeOut=timeout;              
      }
      
      
    }
  }
  
}




/////////////////
void mousePressed() {

  /*
  if(mouseButton==RIGHT)
   {
   color c1 =color((int)random(100, 200), (int)random(100, 200), 0);
   floodFill(mouseX, mouseY, c1);
   floodFill(mouseY, mouseX, c1);
   floodFill(width-mouseX, height-mouseY, c1);
   floodFill(height-mouseY, width-mouseX, c1);
   }
   */


  
}




/////////////////////
public void floodFill(int x, int y, int col)
{
  // If the pixel we are starting with is already black, we won't paint
  if (get(x, y) == (int)color(0,0,0)) {
    return;
  }

  // Create the pixel queue.  Assume the worst case where every pixel in the
  // image may be in the queue.
  int pixelQueue[] = new int[width * height];
  int pixelQueueSize = 0;

  // Add the start pixel to the queue (we created a single array of ints,
  // even though we are enqueuing two numbers.  We put the y value in the
  // upper 16 bits of the integer, and the x in the lower 16.  This gives
  // a limit of 65536x65536 pixels, that should be enough.)

  pixelQueue[0] = (y << 16) + x;
  pixelQueueSize = 1;

  // Color the start pixel.
  set(x, y, col);

  // Keep going while there are pixels in the queue.
  while (pixelQueueSize > 0) {

    // Get the x and y values of the next pixel in the queue
    x = pixelQueue[0] & 0xffff;
    y = (pixelQueue[0] >> 16) & 0xffff;

    // Remove the first pixel from the queue.  Rather than move all the
    // pixels in the queue, which would take forever, just take the one
    // off the end and move it to the beginning (order doesn't matter here).

    pixelQueueSize--;
    pixelQueue[0] = pixelQueue[pixelQueueSize];

    // If we aren't on the left side of the image, see if the pixel to the
    // left has been painted.  If not, paint it and add it to the queue.
    if (x > 0) {
      if ((get(x-1, y) != (int)color(0,0,0)) &&
        (get(x-1, y) != col))
      {
        set(x-1, y, col);
        pixelQueue[pixelQueueSize] =
          (y << 16) + x-1;
        pixelQueueSize++;
      }
    }

    // If we aren't on the top of the image, see if the pixel above
    // this one has been painted.  If not, paint it and add it to the queue.
    if (y > 0) {
      if ((get(x, y-1) != (int)color(0,0,0)) &&
        (get(x, y-1) != col))
      {
        set(x, y-1, col);
        pixelQueue[pixelQueueSize] =
          ((y-1) << 16) + x;
        pixelQueueSize++;
      }
    }

    // If we aren't on the right side of the image, see if the pixel to the
    // right has been painted.  If not, paint it and add it to the queue.
    if (x < width-1) {
      if ((get(x+1, y) != (int)color(0,0,0)) &&
        (get(x+1, y) != col))
      {
        set(x+1, y, col);
        pixelQueue[pixelQueueSize] =
          (y << 16) + x+1;
        pixelQueueSize++;
      }
    }

    // If we aren't on the bottom of the image, see if the pixel below
    // this one has been painted.  If not, paint it and add it to the queue.
    if (y < height-1) {
      if ((get(x, y+1) != (int)color(0,0,0)) &&
        (get(x, y+1) != col))
      {
        set(x, y+1, col);
        pixelQueue[pixelQueueSize] =

          ((y+1) << 16) + x;
        pixelQueueSize++;
      }
    }
  }

  updatePixels();
}

void drawRandomBoxes() {
  for(int i=0; i<30; i++) {
    int x = (int)random(0, width);
    int y = (int)random(0, height);
    int w = (int)random(40, 400);
    int h = (int)random(40, 400);
    pushMatrix();
    // rotateZ(random(PI));
    rect(x, y, w, h);
    popMatrix();
  }
}



void keyPressed()
{
  if(key=='b')
  {
    background(255);
  }
}