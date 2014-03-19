/*this class create the Launcher object
  this object can be display (multiple parts at different times to allow for some overlap of other objects i.e birds)
  this object is mainly used as a reference for the starting point of the bird
*/

public class Launcher {
  
  //determines the launcher location and size
  private PVector location;
  final private float size;

  //constructs an instance of the launcher at location (xLocation, yLocation) and sets its size
  Launcher(float xLocation, float yLocation, float size_) {
    location = new PVector(xLocation, yLocation);
    size = size_;
  }

  //display the back of the launcher
  void displayBack() {
    stroke(100, 47, 3);
    strokeWeight(size / 5);
    noFill();
    strokeCap(ROUND);
    arc(location.x, location.y, size, (size * 3), radians(90), radians(180));
    strokeCap(SQUARE);
    line(location.x, location.y + (size * 1.5), location.x, location.y + (size * 3.5));
  }

  //display the front of the launcher
  void displayFront() {
    stroke(100, 47, 3);
    strokeWeight(size / 5);
    noFill();
    strokeCap(ROUND);
    arc(location.x, location.y, size, (size * 3), radians(0), radians(90));
  }
  
  //return the size of the launcher
  float getSize() {
   return size; 
  }
}

