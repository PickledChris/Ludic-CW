/*
 *
 * The SeekDemo sketch
 *
 */

// A single agent
Agent seeker1;
Agent seeker2;
// It's steering behaviour
Seek seek1;
Arrive seek2;
// Are we paused?
boolean pause;
// Is this information panel being displayed?
boolean showInfo;

// Initialisation
void setup() {
  size(1000,600); // Large display window
  pause = false;
  showInfo = true;
  
  // Create the agent
  PVector r1 = randomPoint();
  seeker1 = new Agent(10, 10, randomPoint());

  
  // creates a second agent at another ranodm point
  seeker2 = new Agent(10, 10, randomPoint());
  
  // Create a Seek behaviour
  seek1 = new Seek(seeker1, r1, 10);
  seek2 = new Arrive(seeker2, r1, 10);
  
  // Add the behaviour to the agent
  seeker1.behaviours.add(seek1);
  seeker2.behaviours.add(seek2);

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
    seeker1.update();
    seeker2.update();
  }
  
  // Draw the agent
  seeker1.draw();
  seeker2.draw();
  
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
  text("Mass of Seek (q/a) = " + seeker1.mass, 10, 65);
  text("Mass of Arrive (r/f) = " + seeker2.mass, 10, 80); 
  text("Max. Force Seek (w/s) = " + seeker1.maxForce, 10, 95);
  text("Max. Force Arrive (t/g) = " + seeker2.maxForce, 10, 110);
  text("Max. Speed Seek (e/d) = " + seeker1.maxSpeed, 10, 125);
  text("Max. Speed Arrive (y/h) = " + seeker2.maxSpeed, 10, 140);
  text("Stopping distance Arrive (u/j) = " + seeker2.arriveDist, 10, 155);
  text("Click to move the target", 10, 170);
  popStyle(); // Retrieve previous drawing style
}

/*
 * Input handlers
 */

// Mouse clicked, so move the target
void mouseClicked() {
   seek1.target = new PVector(mouseX, mouseY); 
   seek2.target = new PVector(mouseX, mouseY);
}

// Key pressed
void keyPressed() {
   if (key == ' ') {
     togglePause();
     
   } else if (key == '1' || key == '!') {
     toggleInfo();
     
   } else if (key == '2' || key == '@') {
     seeker1.toggleAnnotate();
     
     // Vary the agent's mass
   } else if (key == 'q' || key == 'Q') {
     seeker1.incMass();
   } else if (key == 'a' || key == 'A') {
     seeker1.decMass();
     
     // Vary the agent's maximum force
   } else if (key == 'w' || key == 'W') {
     seeker1.incMaxForce();
   } else if (key == 's' || key == 'S') {
     seeker1.decMaxForce();

     // Vary the agent's maximum speed
   } else if (key == 'e' || key == 'E') {
     seeker1.incMaxSpeed();
   } else if (key == 'd' || key == 'D') {
     seeker1.decMaxSpeed();

   } else if (key == 'r' || key == 'R') {
     seeker2.incMass();
   } else if (key == 'f' || key == 'F') {
     seeker2.decMass();
     
     // Vary the agent's maximum force
   } else if (key == 't' || key == 'T') {
     seeker2.incMaxForce();
   } else if (key == 'g' || key == 'G') {
     seeker2.decMaxForce();

     // Vary the agent's maximum speed
   } else if (key == 'Y' || key == 'y') {
     seeker2.incMaxSpeed();
   } else if (key == 'h' || key == 'H') {
     seeker2.decMaxSpeed();

   } else if (key == 'u' || key == 'U') {
      seeker2.incArriveDist();
   } else if (key == 'j' || key == 'J') {
      seeker2.decArriveDist(); 
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

