import oscP5.*;
import netP5.*;
PVector pv;
MyPoint center;
int[] dArr;

OscP5 oscP5;

void setup() {
  size(400, 400);
  frameRate(25);
  oscP5 = new OscP5(this, 1234);
  pv = new PVector(200, 200);
  
  // initialize graphs.
  dArr = new int[10];
  for (int i=0; i< dArr.length; i++) {
    // dArr[i] = -1;
    dArr[i] = 100;
  }
  // initialize nodes.
  center = new MyPoint(200, 200);
}

void draw() {
  background(88);

  // draw Nodes
  center.draw();
  
  // draw Graphs
  for (int i=0; i< dArr.length; i++) {
    int a = (int)random(100, 300);
    int b = (int)random(100, 300);
    center.radiateDouble(new PVector(a, b), 100);
  }  
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}

