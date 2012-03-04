/*
 * The Pursue Steering Behaviour
 */
class Pursue extends Seek {
  
  Agent prey;
  float predictionTime;
  float endTime;
  
  // Initialisation
  Pursue(Agent a, Agent preyAgent, PVector t, float r) {
      super(a, t, r);
      prey = preyAgent;
      predictionTime = 5;
      endTime = 20;
  }
  
  PVector getTarget() {
    PVector prediction = PVector.mult(prey.velocity, min(getPredictedTime(), endTime));
    return PVector.add(prey.position, prediction); 
  }
  
  float getPredictedTime() {
    PVector distance = PVector.sub(prey.position, agent.position);
    float distSize = distance.mag();
    float veloSize = agent.velocity.mag() + prey.velocity.mag();
    return predictionTime * distSize / veloSize;
  }
  
  // Draw the target
  void draw() {
     pushStyle();
     fill(204, 153, 0);
     ellipse(target.x, target.y, radius, radius);
     popStyle();
  }
}
