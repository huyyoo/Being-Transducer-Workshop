import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PShape plant;
PImage txtr;
float theta;

ArrayList<Particle> particles = new ArrayList<Particle>();
boolean touched = false;

void setup() {
  size(800, 800, P3D);
  txtr = loadImage("textures/textured_0_v2.jpg");
  plant = loadShape("3Ddata.obj");
  plant.setTexture(txtr);
  theta = 0;
  plant.scale(500);
  
  //Sample model vertex
  int children = plant.getChildCount();
  for (int i = 0; i < children; i+=5) {
    PShape child = plant.getChild(i);
    int total = child.getVertexCount();
    for (int j = 0; j < total; j++) {
      PVector v = child.getVertex(j);
      float sample_x = v.x * 500;
      float sample_y = v.y * 500;
      float sample_z = v.z * 500;
      Particle p = new Particle(sample_x , sample_y, sample_z);
      particles.add(p);
    }
   }
   
   
   oscP5 = new OscP5(this,9999);
    myRemoteLocation = new NetAddress("127.0.0.1",12000);
}

void draw() {
  background(0);
  lights();
  
  pushMatrix();
  translate(width/2+100, height/2+200);
  rotateX(PI);
  rotateY(theta/2);
  shape(plant); 
  for(int i = 0; i < particles.size(); i++){
    Particle p = particles.get(i);
    
    if(!touched){
       p.target = p.original_pos;
    }else if(touched){
       p.target = new PVector(p.pos.x + random(-1000,1000), p.pos.y + random(-1000,1000), p.pos.z + random(-1000,1000));
    }
    
    p.behaviors();
    p.update();
    p.show();
  } 
  popMatrix();
  theta += 0.01;
}

void keyPressed(){
  touched = !touched;
}

void oscEvent(OscMessage theOscMessage) {
  int state = theOscMessage.get(0).intValue();
  if(state == 0) touched = false;
  else if(state == 1) touched = true;
}
