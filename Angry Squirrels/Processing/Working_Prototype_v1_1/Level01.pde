/*This class is a subclass of Level and performs the same actions however they can
 be modified to create a more complex and diverse level system.
 */

class LevelOne extends Level {  
  //constructs an instance of LevelOne with the same parameters as it parent class
  LevelOne(ArrayList birds_, ArrayList baddies_, ArrayList blocks_) {
    super(birds_, baddies_, blocks_);
    dist=1000;
  }

  //resets the background and over-rides the original method obtained from the Level class
  void resetBackground() {
    background(10, 190, 198);
    stroke(2, 113, 14);
    strokeWeight(10);
    rectMode(CORNER);
    fill(113, 69, 2);
    rect(0, 455, width + 10, 145);
  }

  //checks the horizontal boundaries of the level and over-rides the original method from the Level class
  boolean boundariesHorizontal(float x, float y) {
    if (y >= 452) {
      return true;
    }

    else
      return false;
  }
}

