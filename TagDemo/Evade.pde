
class Evade extends Flee {
  
   Agent predator;
  float predictionTime;
  float endTime;
  
  // Initialisation
  Evade(Agent a, Agent predatorAgent, PVector t, float r) {
      super(a, predatorAgent, t, r);
      predictionTime = 5;
      endTime = 5;
  }
  
  PVector getFleeTarget() {
    
    PVector prediction = PVector.mult(pursuerAgent.velocity, min(getPredictedTime(pursuerAgent), endTime));
    PVector predictionDist = PVector.sub(prediction, pursuerAgent.position);
    PVector pursueDist = PVector.sub(this.agent.position, pursuerAgent.position);
    if (predictionDist.mag() < pursueDist.mag()) {
      return PVector.add(pursuerAgent.position, prediction);   
    } else {
      return pursuerAgent.position; 
    }
    
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
