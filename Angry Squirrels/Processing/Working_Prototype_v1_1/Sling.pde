/*This class creates the sling object
This object can be displayed and its end point can be updated.
*/

class Sling {
  
  //determines the location of the start of the sling
  PVector start;
  
  //determines the location of the end of the sling
  PVector end;
  
  //determines the length of the sling
  float magnitude;

  //construct an instance of Sling at location (x, y)
  Sling(float x, float y) {
    
    //set the start of the sling at (x, y)
    start = new PVector(x, y);
  }

  //updates the end of the sling
  void update(PVector end_) {
    end = end_;
  }

  //display the string as a 2 pixel thich dark grey line located from start to end
  void display() {
    strokeWeight(2);
    stroke(50);
    line(start.x, start.y, end.x, end.y);
  }
}

