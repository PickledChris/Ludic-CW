/*
 * A Steering Behaviour
 */
abstract class Steering {
  
  // The steered agent
  Agent agent;
  // Relative weight in sum of all steering forces
  float weight;
  // Is the behaviour switched on?
  boolean active;
  
  // Initialisation
  Steering(Agent a) {
   agent = a;
   weight = 1;
   active = true;
  }
  
  // Get the current steering force for this behaviour
  PVector getForce() {
    if (active) {
       // Actual force is calculated in subclass
       PVector f = calculateRawForce();
       //PVector wallForce = getWallForce();
       //PVector collisionForce = getCollisionForce();
       //f.add(wallForce);
       f.mult(weight); // Weight the result
       return f;
    } else {
       // No force if this behaviour is not active
       return new PVector(0,0); 
    }
  }

  PVector getWallForce() {
    
    float width = 1000;
    float height = 600;
    float error = 0.001;
    
    PVector force = new PVector(0, 0);
    float distToXWall = (width/2) - agent.position.x;
    float distToYWall = (height/2) - agent.position.y;
    
    
    
    
    force.x = pow(distToXWall/200, 3);
    force.y = pow(distToYWall/200, 3);
    
    return force;
    
    /*
    float xDist = 50;
    float yDist = 50;
    float xWidth = 1000;
    float yHeight = 600;
    
    // x boundary = 20, 980
    // y boundary = 20, 580
    PVector force = new PVector(0, 0);
    float x = agent.position.x;
    float y = agent.position.y;
    if (x < xDist) {
      force.x = xDist-x;
    } else if (x > (xWidth - xDist)) {
      force.x = -1 * (xDist - (xWidth - x));
    }
    force.x = pow (force.x, 5);
    force.x = force.x / 20;
    
    if (y < yDist) {
     
      force.y = yDist-y;
    } else if (y > (yHeight - yDist)) {
      force.y = -1 * (yDist - (yHeight - y));
    }
    force.y = pow (force.y, 5);
    force.y = force.y / 20;
    
    return force;
    */
  }
  
  
  
  PVector getCollisionForce() {
     
    return new PVector(0, 0);
  }

  // The actual force calculation
  abstract PVector calculateRawForce();
  
  // Draw any associated objects
  abstract void draw();
  
  // whether the steering is a pursue type or a flee type
  abstract boolean isPursueForce();
}
