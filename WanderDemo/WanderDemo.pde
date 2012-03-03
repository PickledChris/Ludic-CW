/*
 *
 * The WanderDemo sketch
 *
 */

// A single agent
Agent wanderer;

// It's steering behaviour
Wander wander;
// Are we paused?
boolean pause;
// Is this information panel being displayed?
boolean showInfo;

 PVector startPos;

// Initialisation
void setup() {
  size(1000,600); // Large display window
  pause = false;
  showInfo = true;
  
  // Create the agent
  PVector r1 = randomPoint();
  startPos =  new PVector(100, 100);
  wanderer = new Agent(0.1, 10, new PVector(100, 100));
  
  wander = new Wander(wanderer, new PVector(500, 500), 10, randomPoint());
  
  wanderer.behaviours.add(wander);

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
    wanderer.update();
  }
  
  // Draw the agent
  wanderer.draw();
  
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
  text("Mass of Seek (q/a) = " + wanderer.mass, 10, 65);
  text("Max. Force Seek (w/s) = " + wanderer.maxForce, 10, 80);
  text("Max. Speed Seek (e/d) = " + wanderer.maxSpeed, 10, 95);
  text("Jitter (r/f) = " + wanderer.jitter, 10, 110);
  text("Circle radius (t/g) = " + wanderer.wanderCircleRadius, 10, 125);
  text("Wander distance (y/h) = " + wanderer.wanderDistance, 10, 140);
  text("circle = " + wanderer.velocity, 10, 155);
  text("circle rad = " + wanderer.wanderCircleRadius, 10, 170);
   
   
  PVector cent = wander.centreOfWanderCircle();
  //ellipse(cent.x, cent.y, 5, 5);
  float r = wanderer.wanderCircleRadius;
  noFill();
  ellipse(cent.x, cent.y, 2 * r, 2 * r);
  PVector tar = wander.targetPosNoRand();
  ellipse(tar.x, tar.y, 5, 5);
  
  popStyle(); // Retrieve previous drawing style
}

/*
 * Input handlers
 */

// Mouse clicked, so move the target
void mouseClicked() {
   wander.target = new PVector(mouseX, mouseY);  
}

// Key pressed
void keyPressed() {
   if (key == ' ') {
     togglePause();
     
   } else if (key == '1' || key == '!') {
     toggleInfo();
     
   } else if (key == '2' || key == '@') {
     wanderer.toggleAnnotate();
     
     // Vary the agent's mass
   } else if (key == 'q' || key == 'Q') {
     wanderer.incMass();
   } else if (key == 'a' || key == 'A') {
     wanderer.decMass();
     
     // Vary the agent's maximum force
   } else if (key == 'w' || key == 'W') {
     wanderer.incMaxForce();
   } else if (key == 's' || key == 'S') {
     wanderer.decMaxForce();
  
     // Vary the agent's maximum speed
   } else if (key == 'e' || key == 'E') {
     wanderer.incMaxSpeed();
   } else if (key == 'd' || key == 'D') {
     wanderer.decMaxSpeed();
   
    //Jitter
   } else if (key == 'r' || key == 'R') {
     wanderer.incJitter();
   } else if (key == 'f' || key == 'F') {
     wanderer.decJitter();
     
     //Radius
   } else if (key == 't' || key == 'T') {
     wanderer.incRadius();
   } else if (key == 'g' || key == 'G') {
     wanderer.decRadius();

    //Distance
   } else if (key == 'Y' || key == 'y') {
     wanderer.incDistance();
   } else if (key == 'h' || key == 'H') {
     wanderer.decDistance();
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

