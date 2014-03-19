/*This class creates the Bird object 
 This object is displayed, has forces applied to it and recognizes if it is dead
 It also interacts with the mouse. 
 */

public class Bird {
  //determines the Bird's current location
  private PVector location;

  //determines the Bird's starting location
  private PVector origin;

  //determines the Bird's velocity and acceleration
  private PVector velocity; 
  private PVector acceleration;
  
  //sets a maximum velocity
  private final float MAX_VELOCITY;

  //represents the mass and size of the bird instance.
  private final float mass;
  private final float size;

  //determines the angle the bird has been pulled from its original location
  private float angle = 0;

  //determines the amount that the bird has been pulled from its original location and this maximum amount
  private float slingLength = 0;
  private final float MAX_SLING_LENGTH;

  //flags if the object is being dragged.
  private boolean dragging = false;

  //flags if the mouse is over the object.
  private boolean rollOver = false;

  //constructs an instance of Bird at location (xLocation, yLocation), sets its mass and references 
  //to the launcher
  public Bird(float xLocation, float yLocation, float mass_, Launcher launchPad) {

    //make the size of the bird proportional to the launcher.
    size = launchPad.getSize() + (launchPad.getSize() / 5);

    //determines the max that the bird can be pulled from the sling center.
    MAX_SLING_LENGTH = size * 2;
    
    //set the maximum velocity to the size of the bird (so as to not interfere with boundary enty conflicts)
    MAX_VELOCITY = size;

    //locates the position of the bird.
    location =  new PVector(xLocation, yLocation + size/3);

    //locates the starting position of the bird
    origin = location.get();

    //determines the initial speed of the bird.
    velocity = new PVector(0, 0);

    //determines the change in speed of the bird.
    acceleration = new PVector(0, 0);

    //passes mass_ to mass.
    mass = mass_;
  }

  //Newton's second law
  //add the vector f determined by dividing the specific force vector by the bird's mass.
  //to the bird's acceleration.
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

  //Updates the values of the bird.
  //acceleration is a change in velocity therfore add acceleration to velocity.
  //velocity is a change in location therfore add velocity to location.
  //reset the accleration by multiplying it by 0 - this is done in order to 
  //reset the forces acting on the object at each frame.
  public void update() { 
    velocity.add(acceleration);
    
    if(velocity.x > MAX_VELOCITY)
    velocity.x = MAX_VELOCITY;
    
    if(velocity.y > MAX_VELOCITY)
    velocity.y = MAX_VELOCITY;
    
    location.add(velocity);
    acceleration.mult(0);
  }

  //draws the bird on the screen.
  public void display() {

    //if the user is dragging the bird fill it dark grey.
    if (dragging) {
      fill(100);
    }

    //otherwise if the mouse is simply hovering over the bird fill it light grey. 
    else if (rollOver) {
      fill(175);
    }

    //otherwise fill the bird white.
    else {
      fill(255);
    }

    //draw an elipse at (location.x, location.y) the values of the location vector 
    //with a diameter of size and a black 2 pixel outline.
    strokeWeight(2);
    stroke(0);
    ellipse(location.x, location.y, size, size);
  }

  //dtermines if the mouse is hovering over the bird
  public boolean hover(int xUser, int yUser) {

    //calculate the distance between the mouse and the bird and if it is
    //less than half the size (radius) then rollover is true and return true.
    float d = dist(xUser, yUser, location.x, location.y);
    if (d <= size/2) {
      rollOver = true;
      return true;
    }

    //otherwise rollover is false
    //and return false
    else {
      rollOver = false;
      return false;
    }
  }

  //determines if the bird is being held by the user
  public void clicked(int xUser, int yUser) {

    //calculate the distance between the mouse and the bird and if it is
    //less than half the size (radius) then dragging is true.
    float d = dist(xUser, yUser, location.x, location.y);
    if (d <= size/2) {
      dragging = true;
    }
  }

  //releases the bird from the mouse's grip by making dragging false.
  void stopDragging() {
    dragging = false;
  }

  //drag the bird to a new location at the location of the mouse.
  public void drag(Launcher pad) {
    if (dragging) { 

      //calculates the distance between the mouse and the launcher
      float d = dist(mouseX, mouseY, pad.location.x, pad.location.y + size/3);

      //orients the angle between the launcher and the mouse and passes it to angle
      angle = atan2(mouseY - pad.location.y, mouseX - pad.location.x);

      //if the mouse less than its max distance away from the launcher
      if (d <=MAX_SLING_LENGTH) {

        //set the bird to the mouse position
        location.x = mouseX;
        location.y = mouseY;

        //set the slingLength as the distance from the mouse the the launcher 
        slingLength = dist(pad.location.x, pad.location.y, mouseX, mouseY);
      }

      //otherwise the mouse has passed the max pull distance
      else {

        //set the bird's location at the max length of the sling but at the appropriate angle of the mouse
        location.x = (cos(angle) * MAX_SLING_LENGTH) + pad.location.x;
        location.y = (sin(angle) * MAX_SLING_LENGTH) + pad.location.y;

        //set the slingLength to its maximum
        slingLength = MAX_SLING_LENGTH;
      }
    }
  }

  //creates the force of the throw in the direction of the pull angle.
  public void throwForce() {
    acceleration = new PVector(-cos(angle) * slingLength, -sin(angle) * slingLength);
  }

  //checks to see if the bird is dead
  public boolean isDead() {

    //as long as the bird is not at complete reset...
    if (velocity.x != 0 && velocity.y != 0) {

      //if the bird is slower than 0.01 horizontally and less than 0.11 vertically then return true
      if (velocity.x < 0.01 && velocity.x > -0.01 && velocity.y < 0.11 && velocity.y > -0.11) {
        return true;
      }

      //otherwise return false
      else
        return false;
    } 

    //otherwise return false
    else
      return false;
  }

  //returns the size of the bird
  public float getSize() {
    return size;
  }

  //returns the x velocity of the bird
  public float getVelocityX() {
    return velocity.x;
  }

  //returns the y velocity of the bird
  public float getVelocityY() {
    return velocity.y;
  }

  //returns the state of dragging
  public boolean isDragging() {
    return dragging;
  }

  //allows modification of the location of the bird
  public void setLocation(PVector location_) {
    location = location_.get();
  }

  //recognizes the boundaries set by each level and makes the bird react accordingly
  //so as to bounce off the edges and not cross through obstacles
  public void collisionEnvironment(Level l) {

    //if the edge of the bird hits a horizontal boundary 
    if (l.boundariesHorizontal(location.x + size/2, location.y + size/2)) {

      //if the bird's y velocity is less than 0.134...
      if (velocity.y > 0.165) {
        
        //move the bird away from the boundary by its velocity
        location.y -= velocity.y;
      }

      //otherwise the velocity is insignificant
      else {
        
        //move the bird 0.134 away from the boundary
        location.y -= 0.165;
      }
      
      //reduce the x and y velocity accordingly
      velocity.x *= 0.95;
      velocity.y *= 0.25;

      //change the y velocity to the other direction
      velocity.y *= -1;
    }

    //if the edge of the bird hits a vertical boundary
    if (l.boundariesVertical(location.x + size/2, location.y + size/2)) {

      //move the bird one pixel away from the boundary
      //change the x velocity to the other direction and reduce it appropriately
      location.x -= 1;
      velocity.x *= -0.35;
    }
  }
}

