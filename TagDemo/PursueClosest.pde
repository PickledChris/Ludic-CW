/*
 * The Pursue Steering Behaviour
 */
class PursueClosest extends Seek {
  
  Agent prey;
  float predictionTime;
  float endTime;
  
  // Initialisation
  PursueClosest(Agent a, PVector t, float r) {
      super(a, t, r);
      prey = getPrey();
      predictionTime = 5;
      endTime = 20;
  }
  
  Agent getPrey() {
    // TODO calculate distance between current location and prey
    if (this.prey == null) {
      for (Agent a : this.agent.allAgents) {
         if (a != this.agent) {
           return a; 
         }
      } 
    }
    Agent closest_prey = this.prey;
    float current_closest_distance = getDistance(this.agent, prey);
    float current_target_distance = current_closest_distance;
    
    for (Agent agent : this.agent.allAgents){
      if (agent == this.agent) {
        continue;
      }
      float dist_from_hunter = getDistance(this.agent, agent);
      if (dist_from_hunter < current_closest_distance){
        current_closest_distance = dist_from_hunter;
        closest_prey = agent;
      }
      
    }
    
    Agent new_prey;
    // Only change target if new target is at least 50 closer
    if (current_closest_distance <= current_target_distance - 20){
      new_prey = closest_prey;
    }
    else{
      new_prey = prey;
    }   
    return new_prey;
  }
  
  float getDistance(Agent a1, Agent a2){
     PVector connecting_vector = PVector.sub(a1.position, a2.position);
     float distance = connecting_vector.mag();
     return distance;
  }
  
  
  
  PVector getTarget() {
    this.prey = getPrey();
    
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
  }
  
  boolean isPursueForce() {
   return true; 
  }
}
