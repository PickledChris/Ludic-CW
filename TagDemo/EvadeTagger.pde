class EvadeTagger extends Evade {
  
  // Initialisation
  EvadeTagger(Agent a, PVector t, float r) {
     super(a, null, t, r);
     predictionTime = 5;
     endTime = 20;
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
    return super.getFleeTarget();  
  }
  
}
