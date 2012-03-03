
class Arrive extends Steering {
  
  PVector target;
  float radius;
  
   // Initialisation
  Arrive(Agent a, PVector t, float r) {
      super(a);
      target = t;
      radius = r;
  }
  
  
  PVector calculateRawForce() {
      // Check that agent's centre is not over target
      float doff = PVector.dist(target, agent.position);
      float speed = agent.maxSpeed;
      
      if (doff < radius) {
        speed = 0;
      } else if (doff < agent.arriveDist) {
        speed = agent.maxSpeed * doff / agent.arriveDist;
      }
      
      PVector seek = PVector.sub(target, agent.position);
      seek.normalize();
      seek.mult(speed);
      seek.sub(agent.velocity);
      return seek;
  
    
  }
  
  // Draw the target
  void draw() {
     pushStyle();
     fill(204, 153, 0);
     ellipse(target.x, target.y, radius, radius);
     popStyle();
  }
  
  
}
