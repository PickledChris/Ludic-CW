class Flee extends Steering {
  
  // Position/size of target
  PVector target;
  float radius;
  
  // Initialisation
  Flee(Agent a, PVector t, float r) {
      super(a);
      target = t;
      radius = r;
  }
  
  PVector calculateRawForce() {
      //TODO
    return new PVector(0,0);   
  }
  
  // Draw the target
  void draw() {
     pushStyle();
     popStyle();
  }
}
