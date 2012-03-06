
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
     PVector prediction = PVector.mult(pursuerAgent.velocity, min(getPredictedTime(), endTime));
     return PVector.add(pursuerAgent.position, prediction); 
  }
  
  float getPredictedTime() {
    PVector distance = PVector.sub(pursuerAgent.position, agent.position);
    float distSize = distance.mag();
    float veloSize = agent.velocity.mag() + pursuerAgent.velocity.mag();
    return predictionTime * distSize / veloSize;
  }
}
