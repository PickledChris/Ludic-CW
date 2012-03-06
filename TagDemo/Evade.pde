
class Evade extends Flee {
  
   Agent predator;
  float predictionTime;
  float endTime;
  
  // Initialisation
  Evade(Agent a, Agent predatorAgent, PVector t, float r) {
      super(a, predatorAgent, t, r);
      predictionTime = 5;
      endTime = 20;
  }
  
  PVector getFleeTarget() {
     PVector prediction = PVector.mult(pursuerAgent.velocity, min(getPredictedTime(pursuerAgent), endTime));
     return PVector.add(pursuerAgent.position, prediction); 
  }
  
  float getPredictedTime(Agent pursuer) {
    PVector distance = PVector.sub(pursuer.position, agent.position);
    float distSize = distance.mag();
    float veloSize = agent.velocity.mag() + pursuer.velocity.mag();
    return predictionTime * distSize / veloSize;
  }
  
  boolean isPursueForce() {
    return false; 
  }
}
