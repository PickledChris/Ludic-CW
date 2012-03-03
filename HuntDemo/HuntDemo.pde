/*
 *
 * The SeekDemo sketch
 *
 */

// A single agent
Agent seeker;
// It's steering behaviour
Seek seek;
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
  seeker = new Agent(10, 10, randomPoint());
  // Create a Seek behaviour
  seek = new Seek(seeker, randomPoint(), 10);
  // Add the behaviour to the agent
  seeker.behaviours.add(seek);

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
  if (!pause) seeker.update();
  
  // Draw the agent
  seeker.draw();
  
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
  text("Mass (q/a) = " + seeker.mass, 10, 65);
  text("Max. Force (w/s) = " + seeker.maxForce, 10, 80);
  text("Max. Speed (e/d) = " + seeker.maxSpeed, 10, 95);
  text("Click to move the target", 10, 110);
  popStyle(); // Retrieve previous drawing style
}

/*
 * Input handlers
 */

// Mouse clicked, so move the target
void mouseClicked() {
   seek.target = new PVector(mouseX, mouseY); 
}

// Key pressed
void keyPressed() {
   if (key == ' ') {
     togglePause();
     
   } else if (key == '1' || key == '!') {
     toggleInfo();
     
   } else if (key == '2' || key == '@') {
     seeker.toggleAnnotate();
     
     // Vary the agent's mass
   } else if (key == 'q' || key == 'Q') {
     seeker.incMass();
   } else if (key == 'a' || key == 'A') {
     seeker.decMass();
     
     // Vary the agent's maximum force
   } else if (key == 'w' || key == 'W') {
     seeker.incMaxForce();
   } else if (key == 's' || key == 'S') {
     seeker.decMaxForce();

     // Vary the agent's maximum speed
   } else if (key == 'e' || key == 'E') {
     seeker.incMaxSpeed();
   } else if (key == 'd' || key == 'D') {
     seeker.decMaxSpeed();

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

