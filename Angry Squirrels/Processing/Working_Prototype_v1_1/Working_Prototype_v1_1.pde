/**
 * Title: Angry Birds Physics PROTOTYPE
 * Name: Julian Glass-Pilon & Yanna-Torry Aspraki
 * Date: February 25, 2014
 * Description: This program will be a video game based on the idea of Angry Birds
 * What makes this game different is the use of multiple physics engines and eventually the 
 * use of the Kinect to control the game.
 */

//create an arrayList of all the levels 
ArrayList<Level> levels;

//declare each level instance
LevelOne level1;
LevelTwo level2;
LevelThree level3;

//declare the instance for the menu
PauseMenu menu;

//flags if the user is in the menu.
boolean inPauseMenu = false; 

//keeps track of what level is active
int levelCount = 0;

void setup() {
  //set canvas size to 500 by 500 pixels.
  size(1300, 500);

  //initialize the menu to its starting location of (-170, 0) with a width of 200 and height of the canvas
  menu = new PauseMenu();

  //initialize the arrayList of levels
  levels = new ArrayList<Level>();

  //initialize all the levels with the following parameters:
  //the first argument passes the function birdsList which creates an arrayList of birds with the following arguments:
    //the first argument determines the amount of birds
    //the second and third argument determine the location of the first bird in the list
    //the fourth argument determines the genreal scale (not size exactly)
  //the second argument passes the function baddiesLevel__ which creates an arrayList of baddies  
  level1 = new LevelOne(birdsList(2, 210, 380, 20), baddiesLevel1(), blocksLevel1());
  level2 = new LevelTwo(birdsList(2, 210, 380, 20), baddiesLevel2(), blocksLevel2());
  level3 = new LevelThree(birdsList(3, 210, 380, 20), baddiesLevel3(), blocksLevel3());

  //adds all the levels to the levels arrayList
  levels.add(level1);
  levels.add(level2);
  levels.add(level3);
  
}

void draw() {
  //goes through the arrayList levels...
  for (int i = 0; i < levels.size(); i++) {

    //if the loop index i is equal to the levelCount...
    if (i == levelCount) {

      //run that particular level
      levels.get(i).run();
    }
  }

  //display the menu
  menu.display();
}

//if the mouse is pressed...
void mousePressed() {

  //as long as the user is not in the menu
  if (!inPauseMenu) {

    //go through the arrayList levels...
    for (int i = 0; i < levels.size(); i++) {

      //if the loop index i is equal to the levelCount...
      if (i == levelCount) {

        //perform the mouse clicked actions
        levels.get(i).clicked();
      }
    }
  }

  //if the mouse is over the pause tag...
  if (menu.mouseOverTag()) {

    //and the user is not in the menu...
    if (!inPauseMenu) {

      //pop the pause menu out to be fully visible and flag inPauseMenu true.
      menu.show();
      inPauseMenu = true;
    }  

    //otherwise the user is already in the pause menu...
    else {

      //pop the menu back out of the screen and flag inPauseMenu false.
      menu.hide();
      inPauseMenu = false;
    }
  }

  //if the user is in the pause menu...
  if (inPauseMenu) {

    //if the mouse is over the replay button
    if (menu.mouseOverReplay()) {

      //loop through the arrayList levels...
      for (int i = 0; i < levels.size(); i++) {

        //reset all levels
        levels.get(i).resetLevel();
      }

      //hide the menu and flag inPauseMenu false.
      menu.hide();
      inPauseMenu = false;
    }
  }
}


//if the mouse is released...
void mouseReleased() {

  //if the user is not in the menu...
  if (!inPauseMenu) {
    
    //loop through the arrayList levels...
    for (int i = 0; i < levels.size(); i++) {
      
      //if the loop index i is equal to the levelCount...
      if (i == levelCount) {
        
        //perform the mouse released actions.
        levels.get(i).release();
      }
    }
  }
}

//**********************************************************************//
//***for testing purposes only***//

//if a key is pressed...
void keyPressed() {

  if (key == 110) {
    if (levelCount < (levels.size()-1)) 
      levelCount ++;

    else
      levelCount = 0;
  }
}

