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
      if (PVector.dist(target, agent.position) > radius) {
        // Calculate Seek Force
        PVector seek = PVector.sub(target, agent.position);
        seek.normalize();
        seek.mult(agent.maxSpeed);
        seek.sub(agent.velocity);
        return seek;
      } else  {
        // If agent's centre is over target stop fleeing
        return new PVector(0,0); 
      }     
  }
  
  // Draw the target
  void draw() {
     pushStyle();
     popStyle();
  }
}
