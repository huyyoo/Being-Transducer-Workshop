class Particle{
  PVector pos;
  PVector original_pos;
  PVector target;
  PVector vel;
  PVector acc;
  float maxspeed;
  float maxforce;
  
  Particle(float x, float y, float z){
    this.pos = new PVector(x, y, z);
    this.original_pos = new PVector(x, y, z);
    this.target = new PVector(x, y, z);
    this.vel = PVector.random3D();
    this.acc = new PVector();
    this.maxspeed = 5;
    this.maxforce = 1;
  }
  
  void behaviors(){
    PVector arrive = this.arrive(this.target);    
    this.applyForce(arrive);
  }
  void applyForce(PVector f){
    this.acc.add(f);
  }
  void update(){
    this.pos.add(this.vel);
    this.vel.add(this.acc);
    this.acc.mult(0);
  }
  void show(){
    stroke(255);
    point(this.pos.x, this.pos.y, this.pos.z);
  }
 
  PVector arrive(PVector target){
    PVector desired = PVector.sub(target,this.pos);
    float d = desired.mag();
    float speed = this.maxspeed;
    if(d < 100){
      speed = map(d,0,100,0,this.maxspeed);
    }
    desired.setMag(speed);
    PVector steer = PVector.sub(desired, this.vel);
    steer.limit(this.maxforce);
    return steer;
  }
}
