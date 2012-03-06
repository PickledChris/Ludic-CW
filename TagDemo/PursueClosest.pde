/*
 * The Pursue Steering Behaviour
 */
class PursueClosest extends Seek {
  
  Agent prey;
  float predictionTime;
  float endTime;
  ArrayList<Agent> prey_list;
  
  // Initialisation
  PursueClosest(Agent a, ArrayList<Agent> preyAgents, PVector t, float r) {
      super(a, t, r);
      prey_list = preyAgents;
      prey = getPrey();
      predictionTime = 5;
      endTime = 20;
  }
  
  Agent getPrey() {
    // TODO calculate distance between current location and prey
    Agent new_prey;
    Agent closest_prey = prey;
    float current_closest_distance = getDistance(this.agent, prey);
    float current_target_distance = current_closest_distance;
    
    for (int i = 0; i < prey_list.size() ; i = i+1){
      Agent agent = prey_list.get(i);
      float dist_from_hunter = getDistance(this.agent, agent);
      if (dist_from_hunter < current_closest_distance){
        current_closest_distance = dist_from_hunter;
        closest_prey = agent;
      }
    }
    
    // Only change target if new target is at least 50 closer
    if (current_closest_distance <= current_target_distance - 50){
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
}
