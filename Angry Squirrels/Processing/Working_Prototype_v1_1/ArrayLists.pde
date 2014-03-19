/*These functions are used to create and organise the various lists of objects 
 that will be in each level of the game.
 */

//creates an arrayList of Birds with a certain number of birds
//the first bird at location (launcherX, launcherY) and a scale factor of launcherSize
ArrayList<Bird> birdsList(float numberOfBirds, float launcherX, float launcherY, float launcherSize) {

  //declare and initialize the arrayList of Birds
  ArrayList<Bird> birds = new ArrayList<Bird>();

  //declare and initialize a launcher l instance to be used as a reference for the birds
  Launcher l = new Launcher(launcherX, launcherY, launcherSize);

  //loop through the arrayList until we reach the numberOfBirds
  for (int i = 0; i < numberOfBirds; i++) {

    //for the first bird only...
    if (i == 0) {

      //declare and initialize the bird at location (l.location.x, l.location.y) 
      //with a mass of 1.5 and l as a reference
      Bird bird = new Bird(l.location.x, l.location.y, 1.5, l);

      //add the bird to the arrayList
      birds.add(bird);
    }

    //for all other birds...
    else {

      //declare and initialze the bird at location (l.location.x - (i * (l.size * 1.5)),  l.location.y + (l.size * 2.5))
      //a mass of 1.5 and l as a reference.
        //the x formula locates each bird an appropriate distance (according to its size) away from the previous.
        //the y formula locates each bird so it is on the ground and not in the launcher
      Bird bird = new Bird(l.location.x - (i * (l.size * 1.5)), l.location.y + (l.size * 2.5), 1.5, l);

      //add the bird to the arrayList
      birds.add(bird);
    }
  }

  //return the arrayList
  return birds;
}

//creates an arrayList of Baddies used for level 1
ArrayList<Baddie> baddiesLevel1() {

  //declare and initialize the arrayList
  ArrayList<Baddie> baddies = new ArrayList<Baddie>();

  //declare and initialize each baddie at the appropriate location
  Baddie bad1 = new Baddie(1100, 440);
  Baddie bad2 = new Baddie(900, 440);

  //add each baddie to the arrayList
  baddies.add(bad1);
  baddies.add(bad2);

  //return the arrayList
  return baddies;
}

//creates an arrayList of Block used for level 1
ArrayList<Block> blocksLevel1() {
  int x=0;
  int y=0;
  int xPos=950;
  int yPos=360;
  //declare and initialize the arrayList
  ArrayList<Block> blocks = new ArrayList<Block>();

  //declare and initialize each blocks at the appropriate location
  for(int i=0;i<6;i++){
    blocks.add(new Block(x, y, xPos, yPos));    
    y=y+17;
  }
  x=17; y=0;
  for(int i=0;i<4;i++){
    blocks.add(new Block(x, y, xPos, yPos));    
    x=x+17;
  }
  x=85; y=0;
  for(int i=0;i<6;i++){
    blocks.add(new Block(x, y, xPos, yPos));    
    y=y+17;
  }

  x=17; y=85;
  for(int i=0;i<4;i++){
    blocks.add(new Block(x, y, xPos, yPos));    
    x=x+17;
  } 
 
  //return the arrayList
  return blocks;
}

//creates an arrayList of Block used for level 2
ArrayList<Block> blocksLevel2() {
  int x=0;
  int y=0;
  int xPos=800;
  int yPos=300;
  //declare and initialize the arrayList
  ArrayList<Block> blocks = new ArrayList<Block>();

  //declare and initialize each blocks at the appropriate location
  x=17; y=85;
  for(int i=0;i<4;i++){
    blocks.add(new Block(x, y, xPos, yPos));    
    x=x+17;
  }
  
  x=40; y=40;
  for(int i=0;i<5;i++){
    blocks.add(new Block(x, y, xPos, yPos));
    x = x-10;
    y=y+10;
  }
  
  x=40; y=40;
  for(int i=0;i<5;i++){
    blocks.add(new Block(x, y, xPos, yPos));
    x = x+10;
    y=y+10;
  }
  
  //return the arrayList
  return blocks;
}

//creates an arrayList of Block used for level 3
ArrayList<Block> blocksLevel3() {
  int x=0;
  int y=0;
  int xPos=850;
  int yPos=300;
  //declare and initialize the arrayList
  ArrayList<Block> blocks = new ArrayList<Block>();

  //declare and initialize each blocks at the appropriate location
  for(int i=0;i<6;i++){
    blocks.add(new Block(x, y, xPos, yPos));    
    y=y+17;
  }
  x=17; y=0;
  for(int i=0;i<4;i++){
    blocks.add(new Block(x, y, xPos, yPos));    
    x=x+17;
  }
  x=85; y=0;
  for(int i=0;i<6;i++){
    blocks.add(new Block(x, y, xPos, yPos));    
    y=y+17;
  }

//  x=17; y=85;
//  for(int i=0;i<4;i++){
//    blocks.add(new Block(x, y, xPos, yPos));    
//    x=x+17;
//  } 

  //return the arrayList
  return blocks;
}

//creates an arrayList of Baddies used for level 2
ArrayList<Baddie> baddiesLevel2() {

  //declare and initialize the arrayList
  ArrayList<Baddie> baddies = new ArrayList<Baddie>();

  //declare and initialize each baddie at the appropriate location
  Baddie bad1 = new Baddie(785, 440);
  Baddie bad2 = new Baddie(960, 385);
  Baddie bad3 = new Baddie(1100, 385);

  //add each baddie to the arrayList
  baddies.add(bad1);
  baddies.add(bad2);
  baddies.add(bad3);
  
  //return the arrayList
  return baddies;
}

//creates an arrayList of Baddies used for level 3
ArrayList<Baddie> baddiesLevel3() {

  //declare and initialize the arrayList
  ArrayList<Baddie> baddies = new ArrayList<Baddie>();

  //declare and initialize each baddie at the appropriate location
  Baddie bad1 = new Baddie(785, 440);
  Baddie bad2 = new Baddie(900, 385);
  Baddie bad3 = new Baddie(1060, 440);

  //add each baddie to the arrayList
  baddies.add(bad1);
  baddies.add(bad2);
  baddies.add(bad3);
  
  //return the arrayList
  return baddies;
}

