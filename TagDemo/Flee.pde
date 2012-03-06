/*
 * The Flee Steering Behaviour
 */
class Flee extends Seek {
  
  Agent pursuerAgent;
  
  // Initialisation
  Flee(Agent a, Agent targetA, PVector t, float r) {
      super(a, t, r);
      pursuerAgent = targetA;
  }
  
  /*
  * gets the vector between the agent and pursuer and moves the vector onto the
  * agent's current position.
  */
  PVector getTarget() {
    PVector distToTarget = PVector.sub(agent.position, getFleeTarget());
    distToTarget.add(agent.position);
    return distToTarget;
    
  }
  
  PVector getFleeTarget() {
     return pursuerAgent.position; 
  }

  
  // Draw the target
  void draw() {
  }
}
