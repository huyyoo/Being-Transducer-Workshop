PShape plant;
PImage txtr;
float theta;

void setup() {
  size(800, 800, P3D);
  txtr = loadImage("textures/textured_0_v2.jpg");
  plant = loadShape("3Ddata.obj");
  plant.setTexture(txtr);
  theta = 0;
  plant.scale(500);
}

void draw() {
  background(0);
  lights();
  
  pushMatrix();
  translate(width/2+100, height/2+200);
  rotateX(PI);
  rotateY(theta/2);
  shape(plant); 
  popMatrix();
  theta += 0.01;
}
