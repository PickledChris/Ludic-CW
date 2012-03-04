/*
 * The Wander Steering Behaviour
 */
class Wander extends Steering {
  
  // Position/size of target
  PVector target;
  float radius;
  PVector c;
  
  // Initialisation
  Wander(Agent a, PVector t, float r, PVector startTarget) {
      super(a);
      target = t;
      radius = r;
      c = startTarget;
      c.normalize();
  }
  
  PVector calculateRawForce() {
       
     PVector seek = PVector.sub(targetPos(), agent.position);
     seek.normalize();
     seek.mult(agent.maxSpeed);
     return seek;
  }
  
   PVector targetPos() {
     randomiseC();
     return PVector.add(centreOfWanderCircle(), c);
  }
  
   PVector targetPosNoRand() {
     return PVector.add(centreOfWanderCircle(), c);
  }
  
  PVector centreOfWanderCircle() {
    PVector vel = new PVector();
    vel = agent.velocity.get();  
    vel.normalize();
    vel.mult(agent.wanderDistance);
    vel.add(agent.position);
    
    return vel;
  }
  
  void randomiseC() {
    
   c.add(new PVector(agent.jitter * random(-1, 1), agent.jitter * random(-1, 1)));
    c.normalize();
    c.mult(agent.wanderCircleRadius);
    
  }
  
  // Draw the target
  void draw() {
     pushStyle();
     //fill(204, 153, 0);
     //ellipse(target.x, target.y, radius, radius);
     popStyle();
  }
}
