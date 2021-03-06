
float L = 15;
float I;
float gravity = 0.05;
float spring = 0.15;
float damping = 0.001;
ArrayList blocks;
void setup(){
  size(500,400);
  I = L*L/6;
  stroke(0);
  smooth();
  noFill();
  blocks = new ArrayList();
  for(int i=0;i<10;i++){
    blocks.add(new block());
  }
}
void draw(){
  if(frameCount%60==1);
  background(#FFFFFF);
  for(int i=1;i<blocks.size();i++){
    block blk = (block) blocks.get(i);
    for(int j=0;j<i;j++){
      block blk2 = (block) blocks.get(j);
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
  PVector mouseLocation = new PVector(mouseX,mouseY);
  PVector mouseVelocity = PVector.sub(mouseLocation,
    new PVector(pmouseX,pmouseY));
  for(int i=0;i<blocks.size();i++){
    block blk = (block) blocks.get(i);
    if(mousePressed){
      PVector dx = PVector.sub(blk.location,mouseLocation);
      if(dx.mag()<L*0.75){
        blk.forceSum.add(PVector.mult(PVector.sub(
          mouseVelocity,blk.velocity),0.8));
      }
    }
    blk.testWalls();
    blk.update();
    blk.draw();
  }
}
class block{
  PVector location;
  PVector velocity;
  PVector forceSum;
  float angle;
  float angularSpeed;
  float momentSum;
  PVector ui;
  PVector uj;
  PVector[] pointsToTest;
  float pressure;
  block(){
    location = new PVector(random(L,70-L),random(L,100-L));
    velocity = new PVector();
    forceSum = new PVector();
    ui = new PVector(1,0);
    uj = new PVector(0,1);
    pointsToTest = new PVector[12];
    for(int i=0;i<12;i++){
      float rad = L/2/cos(PI/6);
      if(i%3==0){rad=L/2*pow(2,0.5);}
      float phi = i*PI/6+PI/4;
      pointsToTest[i] = new PVector(
        rad*cos(phi),
        rad*sin(phi));
    }
    pressure = 0;
  }
  void update(){
    velocity.add(forceSum);
//    velocity.mult(0.98);
    forceSum = new PVector(0,gravity);
    location.add(velocity);
    angularSpeed+=momentSum/I;
    angularSpeed = constrain(angularSpeed,-PI/4,PI/4);
    momentSum = 0;
    angle+=angularSpeed;
    angularSpeed*=0.99;
    ui = new PVector(cos(angle),sin(angle));
    uj = new PVector(-ui.y,ui.x);
  }
  void draw(){
    colorMode(HSB,1);
    fill(color(0.67-pressure*0.2,1,1,0.5));
    beginShape();
    for(int i=0;i<12;i+=3){
      PVector testPoint = toWorld(pointsToTest[i]);
      testPoint.add(location);
      vertex(testPoint.x,testPoint.y);
    }
    endShape(CLOSE);
    pressure = 0;
  }
  PVector toOri(PVector w){
    PVector o = new PVector();
    o.x = w.dot(ui);
    o.y = w.dot(uj);
    return o;
  }
  PVector toWorld(PVector o){
    PVector w = new PVector();
    w.x = ui.x * o.x + uj.x * o.y;
    w.y = ui.y * o.x + uj.y * o.y;
    return w;
  }
  PVector feild(PVector atPoint){
    PVector atBlock = toOri(PVector.sub(atPoint,location));
    PVector value = new PVector();
    if(abs(atBlock.x)>abs(atBlock.y)){
      if(abs(atBlock.x)<L/2){
        if(atBlock.x>0){
          value.x = spring*(L/2-abs(atBlock.x));
        }else{
          value.x = -spring*(L/2-abs(atBlock.x));
        }
      }
    }else{
      if(abs(atBlock.y)<L/2){
        if(atBlock.y>0){
          value.y = spring*(L/2-abs(atBlock.y));
        }else{
          value.y = -spring*(L/2-abs(atBlock.y));
        }
      }
    }
    return toWorld(value);
  }
  void testPoints(block otherBlock){
    for(int i=0;i<12;i++){
      PVector testPoint = toWorld(pointsToTest[i]);
      testPoint.add(location);
      PVector force = otherBlock.feild(testPoint);
      PVector dv = PVector.sub(
        otherBlock.velocity(testPoint),
        velocity(testPoint));
      force.add(PVector.mult(dv,damping));
      applyForce(force,testPoint);
      otherBlock.applyForce(PVector.mult(force,-1),testPoint);
    }
  }
  void testWalls(){
    for(int i=0;i<12;i+=3){
      PVector testPoint = toWorld(pointsToTest[i]);
      testPoint.add(location);
      PVector force = wallFeild(testPoint);
      PVector dv = velocity(testPoint);
      force.sub(PVector.mult(dv,damping));
      applyForce(force,testPoint);
    }
  }
  PVector wallFeild(PVector atPoint){
    PVector value = new PVector();
    if(atPoint.x<0){
      value.x = -spring*atPoint.x;
    }
    if(atPoint.x>width){
      value.x = -spring*(atPoint.x-width);
    }
    if(atPoint.y<0){
      value.y = -spring*atPoint.y;
    }
    if(atPoint.y>height){
      value.y = -spring*(atPoint.y-height);
    }
    return value;
  }
  void applyForce(PVector force, PVector atPoint){
    PVector cube = PVector.sub(atPoint,location);
    momentSum += cube.cross(force).z;
    forceSum.add(force);
    pressure += force.mag();
  }
  PVector velocity(PVector atPoint){
    return PVector.add((new PVector(0,0,angularSpeed)).cross(
      PVector.sub(atPoint,location)),velocity);
  }
}
