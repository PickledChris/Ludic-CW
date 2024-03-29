/*
 *
 * The SeekDemo sketch
 *
 */

// Agents
Agent hunter;
Agent prey;
// Steering behaviours
Seek seek;
Pursue pursue;
Flee flee;
Evade evade;
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
  hunter = new Agent(10, 10, randomPoint());
  prey = new Agent(10, 10, randomPoint());
  // Create a Seek behaviour
  seek = new Seek(hunter, prey.position, 10);
  pursue = new Pursue(hunter, prey, randomPoint(), 10);
  flee = new Flee(prey, hunter, hunter.position, 10);
  evade = new Evade(prey, hunter, randomPoint(), 10);
  // Add the default behaviour to the agent
  hunter.behaviours.add(seek);
  hunter.behaviours.add(pursue);
  seek.active = false;
  prey.behaviours.add(flee);
  prey.behaviours.add(evade);
  flee.active = false;
  
  // Make the hunter faster
  hunter.maxSpeed = 5.5;

  smooth(); // Anti-aliasing on
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
    hunter.update();
    prey.update();
  }
  
  // Draw the agents
  hunter.draw();
  prey.draw();
  
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
  text("Mass (q/a) = " + hunter.mass, 10, 65);
  text("Max. Force (w/s) = " + hunter.maxForce, 10, 80);
  text("Max. Hunter Speed (e/d) = " + hunter.maxSpeed, 10, 95);
  text("Max. Prey Speed (e/d) = " + prey.maxSpeed, 10, 110);
  text("Hunter steering (r) = " + hunterActive() , 10, 125);
  text("Prey steering (f) = " +  preyActive() , 10, 140);
  if (hunter.finished) {
    text("Hunter finish time = " + hunter.getFinishTime(), 10, 155);
  }
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
   }
   
}

void toggleHunter() {
  seek.active = !seek.active;
  pursue.active = !pursue.active;
}

void togglePrey(){
  flee.active = !flee.active;
  evade.active = !evade.active;
}

String hunterActive(){
   if (seek.active) {
     return "Seek";
   } 
   else{
     return "Persue";
   } 
}

String preyActive(){
   if (flee.active) {
     return "Flee";
   } 
   else{
     return "Evade";
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

