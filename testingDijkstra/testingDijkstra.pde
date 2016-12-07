/*
the purpose of this is to just draw a graph and test out dijkstra.  
 the files that were copied over from algs are the ones necessary ot make it compile.  
 
 */

EdgeWeightedDigraph G;
In in;
DijkstraSP sp;

void setup()
{
  size(800, 400);


  background(255);
  in = new In(sketchPath("tinyEWD.txt"));
  G = new EdgeWeightedDigraph(in);
  //curve(width/2, height/2, 0, height/2, width/2, 0, width/2, height/2);
  int numEdges=G.E();
  int numVertices = G.V();
  int wid=width/numVertices;
  for (int i=0; i<numVertices; i++)
  {

    fill(0, 255-i*10, 255-i*10);
    ellipse(wid/2+wid*(i), height/2, 20, 20);
  }

  noFill();
  for (DirectedEdge e : G.edges())
  {
    println(e); 
    int i=e.from();
    int fromVal=wid/2+wid*(i);
    int j = e.to();
    int toVal=wid/2+wid*(j);
    int midVal= (fromVal+toVal)/2;
    double weight = e.weight();
    //print("i" + i + "j" + j); 
    //println();


    if (fromVal>toVal)
    {
      int x1=midVal;
      int y1=-height;
      stroke(0, 255-i*10, 255-i*10);
      strokeWeight( (int) (weight*12) );
      curve(x1, y1, fromVal, height/2, toVal, height/2, x1, y1);
    } else
    {
      int x1=midVal;
      int y1=2*height ;
      stroke(0, 255-i*10, 255-i*10);
      curve(x1, y1, fromVal, height/2, toVal, height/2, x1, y1);
    }
  }

  println("SP");
  int s=0;
  sp = new DijkstraSP(G, s);

  //

  //for (DirectedEdge e : sp.pathTo(int(random( G.V())) )) {
  //  int i=e.from();
  //  int fromVal=wid/2+wid*(i);
  //  int j = e.to();
  //  int toVal=wid/2+wid*(j);
  //  int midVal= (fromVal+toVal)/2;
  //  double weight = e.weight();

  //  if (fromVal>toVal)
  //  {
  //    int x1=midVal;
  //    int y1=-height;
  //    stroke(255-i*10, 0, 0);
  //    strokeWeight( (int) (weight*12) );
  //    curve(x1, y1, fromVal, height/2, toVal, height/2, x1, y1);
  //  } else
  //  {
  //    int x1=midVal;
  //    int y1=2*height ;
  //    stroke( 255-i*10, 0, 0);
  //    curve(x1, y1, fromVal, height/2, toVal, height/2, x1, y1);
  //  }
  //}

  // print shortest path
  for (int t = 0; t < G.V(); t++) {
    if (sp.hasPathTo(t)) {
      System.out.format("%d to %d (%.2f)  ", s, t, sp.distTo(t));
      for (DirectedEdge e : sp.pathTo(t)) {
        print(e + "   ");
      }
      println();
    } else {
      System.out.format("%d to %d         no path\n", s, t);
    }
  }
}

int choice1=0;
int choice2=6;
void draw()
{
  background(255);
  drawVertices();
  drawEdges();
  drawSP(choice1, choice2);

  int wid=width/G.V();

  strokeWeight(3);
  stroke(255, 0, 0);
  ellipse(wid/2+wid*(choice1), height/2, 50, 50);
  stroke(0, 255, 0);
  ellipse(wid/2+wid*(choice2), height/2, 50, 50);
  
  text("from " + choice1 + " to " + choice2, width/2, 10);
}

void drawVertices()
{
  int numEdges=G.E();
  int numVertices = G.V();
  int wid=width/numVertices;
  stroke(0);
  strokeWeight(1);
  for (int i=0; i<numVertices; i++)
  {

    fill(0, 255-i*10, 255-i*10);

    ellipse(wid/2+wid*(i), height/2, 20, 20);
  }
}


void drawEdges()
{
  int wid=width/G.V();
  noFill();
  for (DirectedEdge e : G.edges())
  {
    //println(e); 
    int i=e.from();
    int fromVal=wid/2+wid*(i);
    int j = e.to();
    int toVal=wid/2+wid*(j);
    int midVal= (fromVal+toVal)/2;
    double weight = e.weight();
    //print("i" + i + "j" + j); 
    //println();


    if (fromVal>toVal)
    {
      int x1=midVal;
      float check = map(fromVal-toVal, 0, wid*G.V(), -height, -height*4);
      //int y1=-height;
      int y1=(int) check;
      stroke(0, 255-i*10, 255-i*10);
      strokeWeight( (int) (weight*12) );
      curve(x1, y1, fromVal, height/2, toVal, height/2, x1, y1);
    } else
    {
      int x1=midVal;
      float check = map(toVal-fromVal, 0, wid*G.V(), 2*height, 4*height);
      //int y1=2*height ;
      int y1=(int) check ;
      stroke(0, 255-i*10, 255-i*10);
      curve(x1, y1, fromVal, height/2, toVal, height/2, x1, y1);
    }
  }
}


void doSp(int start )
{
  if (G!=null)
    sp = new DijkstraSP(G, start);
}
void drawSP(int start, int to)
{
  int wid=width/G.V();
  int s=start;
  if (s!=choice1)
  {
    sp = new DijkstraSP(G, s);
  }

  for (DirectedEdge e : sp.pathTo(to ) ) {
    int i=e.from();
    int fromVal=wid/2+wid*(i);
    int j = e.to();
    int toVal=wid/2+wid*(j);
    int midVal= (fromVal+toVal)/2;

    double weight = e.weight();

    if (fromVal>toVal)
    {
      int x1=midVal;
      float check = map(fromVal-toVal, 0, wid*G.V(), -height, -height*4);
      //int y1=-height;
      int y1=(int) check;
      stroke(255-i*10, 0, 0);
      strokeWeight( (int) (weight*12) );
      curve(x1, y1, fromVal, height/2, toVal, height/2, x1, y1);
    } else
    {
      int x1=midVal;
      float check = map(toVal-fromVal, 0, wid*G.V(), 2*height, 4*height);
      //int y1=2*height ;
      int y1=(int) check ;
      stroke( 255-i*10, 0, 0);
      curve(x1, y1, fromVal, height/2, toVal, height/2, x1, y1);
    }
  }
}

boolean mode;
void keyPressed()
{
  if (key=='1')
  {
    choice1++;
    if (choice1>=G.V())
    {
      choice1=0;
    }
    // println(choice1);
    doSp(choice1 );
  }
  if (key=='2')
  {
    choice2++; 
    if (choice2>=G.V())
    {
      choice2=0;
    }
    //println(choice2);
  }
}