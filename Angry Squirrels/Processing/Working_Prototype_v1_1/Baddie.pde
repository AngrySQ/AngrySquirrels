/*This class creates the Baddie object 
  This object is displayed, has forces applied to it and recognizes if it is dead
*/

public class Baddie {
  
  //determines baddie's current location
  private PVector location;

  //determines baddie's starting location
  private PVector origin;
  
  //determines the baddie's velocity and acceleration
  private PVector velocity;
  private PVector acceleration;

  //determines the baddie's mass and sets its size to 24
  private final float mass = 1.5;
  private final float size = 24;

  //constructs an instance of Baddie at location (xLocation, yLocation)
  public Baddie(float xLocation, float yLocation) {
    
    //sets the x and y parameters for the location and origin vector
    location = new PVector(xLocation, yLocation);
    origin = new PVector(xLocation, yLocation);
    
    //sest the x and y parameters for the velocity and acceleration to 0
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  //displays the instance as a red ellipse with a black 2 pixel outline
  public void display() {
    stroke(0);
    strokeWeight(2);
    fill(250, 0, 0);
    ellipse(location.x, location.y, size, size);
  }

  //Newton's second law
  //add the vector f determined by dividing the specific force vector by the baddie's mass.
  //to the baddie's acceleration.
  public void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  //Neutralize all forces being applied and stop movement 
  //by mulitplying the velocity and acceleration by 0.
  public void stopForce() {
    velocity.mult(0);
    acceleration.mult(0);
  }

  //Updates the values of the baddie.
  //acceleration is a change in velocity therfore add acceleration to velocity.
  //velocity is a change in location therfore add velocity to location.
  //reset the accleration by multiplying it by 0 - this is done in order to 
  //reset the forces acting on the object at each frame.
  public void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  //resets the object's location to its origin
  public void reset() {
    location = origin.get();
  }

  //checks to see if the baddie is dead. 
  //if the center of Bird b is less than b's size away from this instance, than it is dead and returns true.
  public boolean isDead(Bird b) {
    float d = dist(location.x, location.y, b.location.x, b.location.y);
    if (d < size) 
      return true;
  
  //otherwise it is not dead and returns false.
    else
      return false;
  }
}

