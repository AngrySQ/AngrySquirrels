/*This class creates the Level object.
 It runs all the appropriate methods that run each level and allows its methods to be over-ridden
 to enable diversity between levels while still maintaining its basic functions
 */

public class Level {

  //creates the list of birds that will act as ammuniation in the level
  private ArrayList<Bird> birds;

  //creates a reference of the birds list so as to be able to properly reset
  private ArrayList<Bird> referenceBirds;

  //creates the list of baddies that will act as targets in the level
  private ArrayList<Baddie> baddies;

  //creates a reference of the baddies list so as to be able to properly reset
  private ArrayList<Baddie> referenceBaddies;
  
  //creates a reference of the Blocks which would be used to create a statues
  private ArrayList<Block> referenceBlocks;
  
  //creates a reference of the Blocks which would be used to create a statues
  private ArrayList<Block> blocks;
    
  //creates an instance of the sling and launcher
  private Sling sling;
  private Launcher launchPad;

  //flags whether the bird has been thrown.
  private boolean thrown = false;
  
  protected int dist;

  //constructs an instance of Level with the appropriate arrayLists as reference (both birds and baddies)
  public Level(ArrayList birds_, ArrayList baddies_, ArrayList blocks_) {

    //creates the birds arrayList and passes birds_ to the referenceBirds arrayList 
    birds = new ArrayList<Bird>();   
    referenceBirds = birds_;

    //loops through the arrayList of referenceBirds and passes its elements to the birds ArrayList
    for (int i = 0; i < referenceBirds.size(); i++) {
      birds.add(referenceBirds.get(i));
    }

    //creates the baddies arrayList and passes baddies_ to the referenceBaddies arrayList 
    baddies = new ArrayList<Baddie>();
    referenceBaddies = baddies_;

    //loops through the arrayList of referenceBaddies and passes its elements to the baddies ArrayList
    for (int i = 0; i < referenceBaddies.size(); i++) {
      baddies.add(referenceBaddies.get(i));
    }
    
    blocks = new ArrayList<Block>();
    referenceBlocks = blocks_;

    //loops through the arrayList of referenceBaddies and passes its elements to the baddies ArrayList
    for (int i = 0; i < referenceBlocks.size(); i++) {
      blocks.add(referenceBlocks.get(i));
    }

    //initialze the sling at the location of the first bird in the array
    sling = new Sling(birds.get(0).location.x, birds.get(0).location.y);

    //initialize the launcher at the proper location (210, 380) and sets its size to 20
    launchPad = new Launcher(210, 380, 20);
  }

  //run the level (should not be over-ridden by sub-classes)
  void run() {

    //reset the background at each frame
    resetBackground();

    //check to see if the bird is at boundary.
    birds.get(0).collisionEnvironment(this);

    //as long as the user is not in the pause menu...
    if (!inPauseMenu) {

      //if the bird has not been thrown
      if (!thrown) {

        //update and display the sling
        sling.update(birds.get(0).location);
        sling.display();

        //allow the bird to be dragged and recognize if the mouse is hovering over it.
        birds.get(0).drag(launchPad);
        birds.get(0).hover(mouseX, mouseY);
      }

      //otherwise the bird is thrown...
      else {

        //as long as the user is not in the pause menu
        if (!inPauseMenu) {

          //update the posititon of the active bird
          birds.get(0).update();
        }

        //apply the physics engine to the active bird in the level
        applyPhysicsEngineToBird();

        //remove any dead baddie
        removeDeadBaddies();
        blocksAreHit();

        //if the level has been beaten...
        if (isLevelBeaten()) {

          //goes to next level
          toNextLevel();
        }

        //if the active bird is dead...
        if (birds.get(0).isDead()) {

          //as long as there is more than one bird in the birds arrayList...
          if (birds.size() > 1) {

            //remove the dead bird, update the arrayList so the next bird is active and flag thrown to false
            removeDeadBird();
            updateBirdArray();
            thrown = false;
          }
        }
      }
    }

    //display all objects on screen
    displayObjects();
  }

  //resets the level to its starting positions (should not be over-ridden by sub-classes)
  public void resetLevel() {

    //stop throwing the bird and stop all forces acting upon it.
    thrown = false;
    birds.get(0).stopForce();

    //clear the birds arrayList and loop through the referenceBirds arrayList and fill birds with its elements
    birds.clear();
    for (int i = 0; i < referenceBirds.size(); i++) {
      birds.add(referenceBirds.get(i));
    }

    //clear the baddies arrayList and loop through the referenceBaddies arrayList and fill baddies with its elements
    baddies.clear();
    for (int i = 0; i < referenceBaddies.size(); i++) {
      baddies.add(referenceBaddies.get(i));
    }
    
    //clear the blocks arrayList and loop through the referenceBlocks arrayList and fill baddies with its elements
    blocks.clear();
    for (int i = 0; i < referenceBlocks.size(); i++) {
      blocks.add(referenceBlocks.get(i));
    }

    //update the bird array so each bird is in its proper location
    updateBirdArray();
  }

  //method that displays all objects on screen (can be over-ridden by sub-classes)
  public void displayObjects() {

    //display the front part of the slingshot.
    launchPad.displayBack();

    //dispaly the baddies
    displayBaddies();

    //display the birds
    displayBirds();
    
    //display the blocks
    displayBlocks();

    //display the back part of the slingshot.
    launchPad.displayFront();
  }

  //resets the background (can be over-ridden by sub-classes)
  public void resetBackground() {
    background(0);
  }

  //creates and applies the forces to the objects on screen (can be over-ridden by sub-classes)
  public void applyPhysicsEngineToBird() {

    //create a vector named gravity that has a vertical force of 0.3.
    PVector gravity = new PVector(0, 0.2);

    //multiply the gravity force by the bird's mass.
    gravity.mult(birds.get(0).mass);

    //apply the gravity force to the bird's motion.
    birds.get(0).applyForce(gravity);
    
    //create a vector named drag that has the same direction of the bird's velocity
    //by normailzing the value of the bird's velocity.
    PVector drag = birds.get(0).velocity.get();
    drag.normalize();

    //create a variable named speed that is the magnitude of the bird's velocity.
    //multiply the drag vector by a constant and the speed squared. 
    float speed = birds.get(0).velocity.mag();
    drag.mult(-0.003 * speed * speed);

    //apply the drag force to the bird's motion.
    birds.get(0).applyForce(drag);
    
    for(int i=0; i<blocks.size(); i++)
    {
      blocks.get(i).applyForce(gravity, birds.get(0).location);
      PVector drag1 = blocks.get(i).velocity.get();
      drag1.normalize();
  
      //create a variable named speed that is the magnitude of the bird's velocity.
      //multiply the drag vector by a constant and the speed squared. 
      float speed1 = blocks.get(i).velocity.mag();
      drag1.mult(-0.003 * speed1 * speed1);
  
      //apply the drag force to the bird's motion.
      blocks.get(i).applyForce(drag1, birds.get(0).location);      
    }
    
  }

  //loops through the birds arrayList and displays all of its elements (should not be over-ridden)
  public void displayBirds() {
    for (int i = 0; i < birds.size(); i++) {
      Bird b = birds.get(i);
      b.display();
    }
  }

  //loops through the baddies arrayList and displays all of its elements (should not be over-ridden)
  void displayBaddies() {
    for (int i = 0; i < baddies.size(); i++) {
      Baddie b = baddies.get(i);
      b.display();
    }
  }
  
  //loops through the baddies arrayList and displays all of its elements (should not be over-ridden)
  void displayBlocks() {    
    for (int i = 0; i < blocks.size(); i++) {
      Block b = blocks.get(i);
      b.display();
    }
  }

  //checks to see if the level is beaten (should not be over-ridden)
  boolean isLevelBeaten() {

    //if the active bird is dead...
    if (birds.get(0).isDead()) {

      //if there are no ,onger and baddies in the baddies arrayList (in other words they are all dead)
      if (baddies.size() == 0) {

        //return true
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

  //goes to next level (should not be over-ridden)
  void toNextLevel() { 

    //if the levelCount is less than the size of the levels arrayList - 1
    if (levelCount < (levels.size()-1)) 

      //increase the levelCount by 1
      levelCount++;

    //otherwise
    else {

      //reset the levelCount to 0
      levelCount = 0;
    }

    //reset the level
    resetLevel();
  }

  //performs the click functions when the mouse is clicked (should not be over-ridden)
  public void clicked() {

    //if the bird is not thrown...
    if (!thrown) {

      //recognize that the bird is being clicked.
      birds.get(0).clicked(mouseX, mouseY);
    }
  }

  //performs the release functions when the mouse is released (should not be over-ridden)
  void release() {

    //if the bird is being dragged...
    if (birds.get(0).isDragging()) {

      //if the bird has not been thrown...
      if (!thrown) {

        //give the bird an instant launch velocity related to the angle of release.
        birds.get(0).throwForce();
        thrown = true;

        //stop dragging the bird and throw the bird.
        birds.get(0).stopDragging();
      }
    }
  }

  //updates the birds' positions relative to their position in the arrayList
  void updateBirdArray() {

    //goes through the arrayList birds
    for (int i = 0; i < birds.size(); i++) {

      //creates a reference of bird at position i in the arrayList and copies it to b
      Bird b = birds.get(i);

      //if i is equal to 0 (therefore is in the first position of the array and is the active bird)...
      if (i == 0) {

        //create a vector for the new location at the launcher position
        PVector newLocation = new PVector(launchPad.location.x, launchPad.location.y + b.getSize()/3);

        //set the bird's position to the new location
        b.setLocation(newLocation);
      }

      //otherwise...
      else {

        //create a vector for the new location at the appropraite postion (in single file)
        PVector newLocation = new PVector(launchPad.location.x - (i * (launchPad.size * 1.5)), 
        launchPad.location.y + birds.get(i).getSize()/3 + (launchPad.size * 2.5));

        //set the bird's position to the new location
        b.setLocation(newLocation);
      }
    }
  }

  //removes any dead bird
  void removeDeadBird() {

    //if the bird is dead...
    if (birds.get(0).isDead()) {

      //remove the bird from the arrayList
      birds.remove(0);
    }
  }

  //removes any dead baddie
  void removeDeadBaddies() {

    //go through the baddies arrayList
    for (int i = 0; i < baddies.size(); i++) {

      //if any baddie is dead (hit by bird)
      if (baddies.get(i).isDead(birds.get(0))) {

        //remove it from the arrayList
        baddies.remove(i);
      }
    }
  }
  
  //block are hit by tthe bird
  void blocksAreHit() {   
    //go through the baddies arrayList
    float L = 15;
    float I;
    float gravity = 0.05;
    float spring = 0.15;
    float damping = 0.001;
    
    for(int i=1;i<blocks.size();i++){
      Block blk = (Block) blocks.get(i);
      for(int j=0;j<i;j++){
        Block blk2 = (Block) blocks.get(j);
        PVector dx = PVector.sub(blk2.location,blk.location);
        if((abs(dx.x)<L*1.5)&&(abs(dx.y)<L*1.5)){
          if(dx.mag()<L*0.8){
            float restore = 3*spring*(L-dx.mag());
            dx.normalize();
            dx.mult(restore);
            blk2.forceSum.add(dx);
            blk.forceSum.sub(dx);
            blk2.pressure += dx.mag();
            blk.pressure += dx.mag();
          }else if(dx.mag()<L*1.5){
            blk.testPoints(blk2);
            blk2.testPoints(blk);
          }
        }
      }      
    } 

   for(int k=0;k<blocks.size();k++){
      Block blk1 = (Block) blocks.get(k);          
      if(blk1.isHit(birds.get(0), this.dist)){
        blk1.testWalls();
        blk1.update();
        blk1.display();
      }
    } 
      
  }
  

  //check is an object's center (bird, baddie, or other) is hitting a horizontal boundary
  boolean boundariesHorizontal(float x, float y) {

    //if object is outside the allowed range (in other words is in contact with the boundary)...
    if (x == 999999 && y == 999999) {
      return true;
    }

    else
      return false;
  }

  //check is an object's center (bird, baddie, or other) is hitting a vertical boundary
  boolean boundariesVertical(float x, float y) {

    //if object is outside the allowed range (in other words is in contact with the boundary)...
    if (x == 999999 && y == 999999) {
      return true;
    }

    else
      return false;
  }
}

