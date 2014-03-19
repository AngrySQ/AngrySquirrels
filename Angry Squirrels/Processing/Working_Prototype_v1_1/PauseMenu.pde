/*This class creates the PauseMenu object
 This object can be displayed, poped in or out of the screen and recognizes if the 
 mouse is over specific objects
 */

class PauseMenu {

  //determines the menu's location
  private PVector location;

  //determines the menu's width and height
  private final float MENU_WIDTH;
  private final float MENU_HEIGHT;

  //determines the tag's location
  private PVector tagCenter;

  //determines the tag's size
  private final float TAG_SIZE;

  //determines the tag's fill color
  private color tagValue;

  //constructs an instance of the PauseMenu 
  PauseMenu() {
    
    //sets the location of the menu at (-170, 0)
    location = new PVector(-170, 0);
    
    //sets the width to 200 and the height to the heoght of the screen
    MENU_WIDTH = 200;
    MENU_HEIGHT = height;
    
    //sets the location for the center of the tag
    tagCenter = new PVector(location.x + 200, location.y + MENU_HEIGHT/4);
    
    //sets the tag size to 50 and its color to red
    TAG_SIZE = 50;
    tagValue = color(250, 0, 0);
  }

  //displays the pause menu
  void display() {
    
    //if the user is in the pause menu...
    if (inPauseMenu) {
      
      //display a dark semi-transparent rectangle over the full screen
      fill(0, 150);
      noStroke();
      rectMode(CORNER);
      rect(0, 0, width, height);
    }

    //draw the pause menu
    fill(250, 0, 0);
    stroke(0);
    strokeWeight(10);
    rectMode(CORNER);
    rect(location.x, location.y, MENU_WIDTH, MENU_HEIGHT);

    //display the tag
    displayTag();
    
    //display the first button that acts as the replay with its replay symbol
    displayButton(location.x + MENU_WIDTH/2, location.y + MENU_HEIGHT/6, 100, 50);
    displayReplaySymbol(location.x + MENU_WIDTH/2, location.y + MENU_HEIGHT/6, 30);
    
    //dusplay the second button that acts as the home button with its home symbol
    displayButton(location.x + MENU_WIDTH/2, location.y + MENU_HEIGHT/3, 100, 50);
    displayHomeSymbol(location.x + MENU_WIDTH/2, location.y + MENU_HEIGHT/3, 30);
  }

  //displays the replay symbol
  void displayReplaySymbol(float xCenter, float yCenter, float size) {
    noFill();
    strokeWeight(size/8);
    arc(xCenter, yCenter, size, size, radians(180), radians(450));

    strokeWeight(1);
    fill(0);
    triangle(xCenter - (size/5 * 2), yCenter, xCenter - (size/5 * 3), yCenter, xCenter - size/2, yCenter + size/5);
  }

  //display the home symbol
  void displayHomeSymbol(float xCenter, float yCenter, float size) {
    rectMode(CENTER);
    fill(0);
    noStroke();
    rect(xCenter, yCenter + size/5, size, (size/5 * 3));
    triangle(xCenter, yCenter - (size/5 * 3), xCenter - (size/5 * 3), yCenter - size/10, xCenter + (size/5 * 3), yCenter - size/10);
  }

  //display the tag
  void displayTag() {
    
    //determines the loaction of the mouse
    PVector mouse = new PVector(mouseX, mouseY);
    
    //determines the distance from the mouse to the tag
    float d = dist(mouse.x, mouse.y, tagCenter.x, tagCenter.y);

    //if the distance between the mouse and tag is less than half the tag size...
    if (d <= TAG_SIZE/2) {
      
      //set the tag color to a dark red
      tagValue = color(100, 0, 0);
    }

    //otherwise...
    else {
      
      //set the tag color to red
      tagValue = color(250, 0, 0);
    }

    //display the tag
    strokeWeight(5);
    fill(tagValue);
    ellipse(tagCenter.x, tagCenter.y, TAG_SIZE, TAG_SIZE);
    fill(255);
    strokeWeight(2);

    //if the menu is at x-position -170...
    if (location.x == -170) {
      
      //display the pause symbol
      rectMode(CENTER);
      rect(tagCenter.x - TAG_SIZE/6, tagCenter.y, TAG_SIZE/5, TAG_SIZE/2);
      rect(tagCenter.x + TAG_SIZE/6, tagCenter.y, TAG_SIZE/5, TAG_SIZE/2);
    }

    //otherwise...
    else {
      
      //display the play symbol
      triangle(tagCenter.x + TAG_SIZE/3, tagCenter.y, tagCenter.x - TAG_SIZE/4.5, 
      tagCenter.y + TAG_SIZE/3.5, tagCenter.x -TAG_SIZE/4.5, tagCenter.y - TAG_SIZE/3.5);
    }
  }

  //displays the buttons in the menu at position (x, y) with a width of w and height of h
  void displayButton(float x, float y, float w, float h) {
    
    //if the mouse is hovering over the button...
    if (mouseX <= (x + w/2) && mouseX >= (x - w/2) && mouseY <= (y + h/2) && mouseY >= (y - h/2)) {
      
      //set the fill to grey
      fill(150);
    }
    
    //otherwise...
    else {
      
      //set the fill to white
      fill(255);
    }
    
    //display the button
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  //pops the menu into the screen by moving its x-location as well as the tag's x-center 160 to the right
  void show() {
    location.x += 160;
    tagCenter.x += 160;
  }

  //pops the menu out of the screen by moving its x-location as well as the tag's x-center 160 to the left
  void hide() {
    location.x -= 160;
    tagCenter.x -= 160;
  }

  //checks to see if the mouse is over the tag
  boolean mouseOverTag() {
    
    //determines the location of the mouse
    PVector mouse = new PVector(mouseX, mouseY);
    
    //determines the distance between the mouse and the tag center
    float d = dist(mouse.x, mouse.y, tagCenter.x, tagCenter.y);

    //if the mouse is over the tag return true
    if (d <= TAG_SIZE/2) {
      return true;
    }

    //otherwise return false
    else {
      return false;
    }
  }

  //checks to see if the mouse is over the replay button
  boolean mouseOverReplay() {
    
    //if the mouse is over the replay button return true
    if (mouseX <= (location.x + MENU_WIDTH/2 + 50) && mouseX >= (location.x + MENU_WIDTH/2 - 50) 
      && mouseY <= (location.y + MENU_HEIGHT/6 + 25) && mouseY >= (location.y + MENU_HEIGHT/6 - 25)) 
      return true;

    //otherwise return false
    else 
      return false;
  }

//  //returns the x-location of the menu
//  float getLocationX() {
//    return location.x;
//  }
//
//  //returns the y-location of the menu
//  float getLocationY() {
//    return location.y;
//  }
//
//  //returns the width of the menu
//  float getWidth() {
//    return MENU_WIDTH;
//  }
//
//  //returns the height of the menu
//  float getHeight() {
//    return MENU_HEIGHT;
//  }
}

