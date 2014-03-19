class Block{
  float L = 15;
  float I = L*L/6;
  float gravity = 0.05;
  float spring = 0.15;
  float damping = 0.001;
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
  Block(int x, int y, int xPos, int yPos){
    location = new PVector(x, y);
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
        rad*cos(phi)+xPos,
        rad*sin(phi)+yPos);
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
  void display(){
    fill(color(204, 153, 0));
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
  void testPoints(Block otherBlock){
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
  
  boolean isHit(Bird b, int dist)
  {
    float d = dist(location.x, location.y, b.location.x, b.location.y);
    println(d);
    if (d > dist) 
      return true;  
    //otherwise it is not dead and returns false.
    else
      return false;
  }
}
