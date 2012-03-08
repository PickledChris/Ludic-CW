class EvadeTagger extends Evade {
  
  PVector c;
  float wanderDistance = 40f;
  float wanderCircleRadius = 20f;
  float jitter = 2f;
  
  // Initialisation
  EvadeTagger(Agent a, PVector t, float r) {
     super(a, null, t, r);
     predictionTime = 5;
     endTime = 20;
     c = new PVector(100,100);
     c.normalize();
  }
  
  
  PVector getFleeTarget() {
    
    for (Agent a  : agent.allAgents) {
      if (a == this.agent) {
        continue;
      } else if (a.isIt) {
        this.pursuerAgent = a;
        break; 
      }
    }
    
    
    PVector diff = PVector.sub(pursuerAgent.position, agent.position);
    if (diff.mag() > 200 + random(-25, 25)) {
      return targetPos(); 
    } else {
      return super.getFleeTarget();  
    }
  }
  
  // WANDER STUFF
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
    if (vel.mag() == 0) {
      vel = new PVector(1, 1);
      vel.normalize(); 
    }
    vel.mult(wanderDistance);
    vel.add(agent.position);
    
    return vel;
  }
  
  void randomiseC() {
    
   c.add(new PVector(jitter * random(-1, 1), jitter * random(-1, 1)));
    c.normalize();
    c.mult(wanderCircleRadius);
    
  }
  
}
