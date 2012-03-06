/*
 *
 * The SeekDemo sketch
 *
 */

// Agents
ArrayList<Agent> agents = new ArrayList<Agent>();
int agent_count = 10 ;
Agent it;
  // Steering behaviours
ArrayList behaviours = new ArrayList<Agent>();
PursueClosest itPursue;

// Are we paused?
boolean pause;
// Is this information panel being displayed?
boolean showInfo;

// Initialisation
void setup() {
  size(1000,600); // Large display window
  pause = false;
  showInfo = true;
  
  // Create the agents
  for (int i = 0; i < agent_count; i = i+1) {
    agents.add(new Agent(10, 10, randomPoint(), false));
  }
  
  setIt(agents.get(0));
  
  // Create the behaviours
  for (Agent current_agent : agents) {
    current_agent.allAgents = agents;
    current_agent.behaviours.add(new PursueClosest(current_agent, randomPoint(), 10));
    current_agent.behaviours.add(new EvadeTagger(current_agent, randomPoint(), 10));
  }

  smooth(); // Anti-aliasing on
}

// Sets the agent as it
void setIt(Agent a){
  it = a;
  a.isIt = true;
}

// Pick a random point in the display window
PVector randomPoint() {
  return new PVector(random(width), random(height));
}

// The draw loop
void draw() {
  // Clear the display
  background(255); 
  
  // Move forward one step in steering simulation
  if (!pause) {
    for (int i = 0; i < agent_count; i = i+1) {
    agents.get(i).update();
    agents.get(i).draw();
  }
  }
  
  // Draw the agents
  
  
  // Draw the information panel
  if (showInfo) drawInfoPanel();
}
  
// Draw the information panel!
void drawInfoPanel() {
  pushStyle(); // Push current drawing style onto stack
  fill(0);
  text("1 - toggle display", 10, 20);
  text("2 - toggle annotation", 10, 35);
  text("Space - play/pause", 10, 50);
  //text("Mass (q/a) = " + hunter.mass, 10, 65);
  //text("Max. Force (w/s) = " + hunter.maxForce, 10, 80);
  //text("Max. Hunter Speed (e/d) = " + hunter.maxSpeed, 10, 95);
  //text("Max. Prey Speed (e/d) = " + prey.maxSpeed, 10, 110);
  //text("Hunter steering (r) = " + hunterActive() , 10, 125);
  //text("Prey steering (f) = " +  preyActive() , 10, 140);
  popStyle(); // Retrieve previous drawing style
}

/*
 * Input handlers
 */

// Key pressed
void keyPressed() {
   if (key == ' ') {
     togglePause();
     
   } else if (key == '1' || key == '!') {
     toggleInfo();
/*     
   } else if (key == '2' || key == '@') {
     hunter.toggleAnnotate();
     
     // Vary the masses
   } else if (key == 'q' || key == 'Q') {
     hunter.incMass();
     prey.incMass();
   } else if (key == 'a' || key == 'A') {
     hunter.decMass();
     prey.incMass();
     // Vary the maximum forces
   } else if (key == 'w' || key == 'W') {
     hunter.incMaxForce();
     prey.incMaxForce();
   } else if (key == 's' || key == 'S') {
     hunter.decMaxForce();
     prey.decMaxForce();
     // Vary the hunter's maximum speed
   } else if (key == 'e' || key == 'E') {
     prey.incMaxSpeed();
     hunter.maxSpeed = prey.maxSpeed  * 1.05;
   } else if (key == 'd' || key == 'D') {
     prey.decMaxSpeed();
     hunter.maxSpeed = prey.maxSpeed  * 1.05;
   } else if (key == 'r' || key == 'R') {
     toggleHunter();
   } else if (key == 'f' || key == 'F') {
     togglePrey();
*/     
   }
   
}

// Toggle the pause state
void togglePause() {
     if (pause) {
       pause = false; 
     } else {
       pause = true;
     }
}

// Toggle the display of the information panel
void toggleInfo() {
     if (showInfo) {
       showInfo = false; 
     } else {
       showInfo = true;
     }  
}

