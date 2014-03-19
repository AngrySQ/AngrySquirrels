/*This class is a subclass of Level and performs the same actions however they can
 be modified to create a more complex and diverse level system.
 */

class LevelTwo extends Level {  
  //constructs an instance of LevelOne with the same parameters as it parent class
  LevelTwo(ArrayList birds_, ArrayList baddies_, ArrayList blocks_) {
    super(birds_, baddies_, blocks_);
    dist=820;
  } 

  //resets the background and over-rides the original method obtained from the Level class
  void resetBackground() {
    background(57, 66, 224);
    stroke(208, 221, 237);
    strokeWeight(10);
    rectMode(CORNER);
    fill(113, 69, 2);
    rect(0, 455, width + 10, 145);
    rect(800, 400, 510, 210);
    noStroke();
    rect(790, 461, 20, 145);
  }

  //checks the horizontal boundaries of the level and over-rides the original method from the Level class
  boolean boundariesHorizontal(float x, float y) {
    if (y > 452 || (x > 801 && y > 397)) {
      return true;
    }

    else
      return false;
  }

  //checks the vertical boundaries of the level and over-rides the original method from the Level class
  boolean boundariesVertical(float x, float y) {
    if (x > 800 && y > 405) {
      return true;
    }
    //&& y < 452 && y > 397
    else
      return false;
  }
}

