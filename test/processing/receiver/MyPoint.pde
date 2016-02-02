class MyPoint {
  
  PVector _p;
  PVector _s;
  // No TrackInfo.
  
  MyPoint(PVector pos){
    _p = new PVector(pos.x, pos.y);
    _s = new PVector(10, 10);
  };
  MyPoint(int x, int y){
    _p = new PVector(x, y);
    _s = new PVector(10, 10);
  }
  // void update();
  void draw(){
    ellipse(_p.x, _p.y, _s.x, _s.y); 
    strokeWeight(2);
    stroke(color(255, 0, 0)); rect (10, 10, 30,30);
  };
  
  // draw radiation
  void radiate(PVector to, int length) {
    line(_p.x, _p.y, to.x, to.y);
  }
  void radiateDouble(PVector to, int length){
     
     strokeWeight(1);
     stroke(color(63, 63, 63));   line(_p.x, _p.y, to.x, to.y);
     strokeWeight(1);
     stroke(color(0, 128, 128)); line(_p.x, _p.y, _p.x + 0.5 *(to.x - _p.x), _p.y + 0.5 * (to.y - _p.y) );
     
     noStroke();
     fill(color(233, 233, 233));
     ellipse(to.x, to.y, 2,2);
  }
  
  //void setToPos(PVector){};
}
