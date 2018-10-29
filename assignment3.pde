
Camera cam;

PShape tri1;
PShape hex1;
PShape ngon1;
PShape monster;
int numFaces;

boolean first = false;
float view = 0;

//Circular list
CircularList c = new CircularList();
int indexTarget = 1;
int sizeList = 0;


void setup() {
  size(1600, 1000, P3D);
  perspective(radians(50.0f), width/(float)height, 0.1, 1000);
  background(220, 220, 220);

  tri1 = createShape();
  tri1.beginShape(TRIANGLES);
  //Face1
  tri1.fill(255, 255, 0);
  tri1.vertex(-0.5, 0.5, 0.5);
  tri1.vertex(0.5, 0.5, 0.5);
  tri1.vertex(-0.5, -0.5, 0.5);
  tri1.fill(0, 255, 0);
  tri1.vertex(0.5, 0.5, 0.5);
  tri1.vertex(0.5, -0.5, 0.5);
  tri1.vertex(-0.5, -0.5, 0.5);

  //Face2
  tri1.fill(255, 0, 255);
  tri1.vertex(-0.5, 0.5, -0.5);
  tri1.vertex(0.5, 0.5, -0.5);
  tri1.vertex(-0.5, -0.5, -0.5);
  tri1.fill(0, 255, 255);
  tri1.vertex(0.5, 0.5, -0.5);
  tri1.vertex(0.5, -0.5, -0.5);
  tri1.vertex(-0.5, -0.5, -0.5);

  //Face3
  tri1.fill(120, 255, 120);
  tri1.vertex(-0.5, 0.5, -0.5);
  tri1.vertex(-0.5, 0.5, 0.5);
  tri1.vertex(-0.5, -0.5, -0.5);
  tri1.fill(0, 100, 120);
  tri1.vertex(-0.5, 0.5, 0.5);
  tri1.vertex(-0.5, -0.5, 0.5);
  tri1.vertex(-0.5, -0.5, -0.5);

  //Face4
  tri1.fill(255, 100, 100);
  tri1.vertex(0.5, 0.5, -0.5);
  tri1.vertex(0.5, 0.5, 0.5);
  tri1.vertex(0.5, -0.5, -0.5);
  tri1.fill(200, 50, 0);
  tri1.vertex(0.5, 0.5, 0.5);
  tri1.vertex(0.5, -0.5, 0.5);
  tri1.vertex(0.5, -0.5, -0.5);

  //Face5 (BOTTOM)
  tri1.fill(50, 50, 50);
  tri1.vertex(-0.5, 0.5, 0.5);
  tri1.vertex(-0.5, 0.5, -0.5);
  tri1.vertex(0.5, 0.5, -0.5);
  tri1.fill(200, 50, 0);
  tri1.vertex(0.5, 0.5, -0.5);
  tri1.vertex(0.5, 0.5, 0.5);
  tri1.vertex(-0.5, 0.5, 0.5);

  //Face6 (TOP)
  tri1.fill(200, 100, 250);
  tri1.vertex(-0.5, -0.5, 0.5);
  tri1.vertex(-0.5, -0.5, -0.5);
  tri1.vertex(0.5, -0.5, -0.5);
  tri1.fill(20, 200, 100);
  tri1.vertex(0.5, -0.5, -0.5);
  tri1.vertex(0.5, -0.5, 0.5);
  tri1.vertex(-0.5, -0.5, 0.5);

  tri1.endShape();

  hex1 = createShape();
  hex1.beginShape(TRIANGLE_FAN);

  hex1.fill(255, 0, 0);
  hex1.vertex(2, -sqrt(3), 0);
  hex1.fill(255,20,147);
  hex1.vertex(1, -2*sqrt(3), 0);
  hex1.fill(0, 0, 255);
  hex1.vertex(-1, -2*sqrt(3), 0);
  
  hex1.fill(255, 0, 0);
  hex1.vertex(2, -sqrt(3), 0);
  hex1.fill(0, 0, 255);
  hex1.vertex(-1, -2*sqrt(3), 0);
  hex1.fill(0,191,255);
  hex1.vertex(-2, -sqrt(3), 0);
  
  hex1.fill(255, 0, 0);
  hex1.vertex(2, -sqrt(3), 0);
  hex1.fill(0,191,255);
  hex1.vertex(-2, -sqrt(3), 0);
  hex1.fill(0, 255, 0);
  hex1.vertex(-1, 0, 0);
  
  hex1.fill(255, 0, 0);
  hex1.vertex(2, -sqrt(3), 0);
  hex1.fill(0, 255, 0);
  hex1.vertex(-1, 0, 0);
  hex1.fill(255, 255, 0);
  hex1.vertex(1, 0, 0);
  
  hex1.endShape();
  
  monster = loadShape("monster.obj");
  numFaces = monster.getChildCount();
}

void draw() {
  background(220, 220, 220);

  //Set grid
  for (int i = (width/2)-100; i <= (width/2)+100; i = i + 10) {
    if (i == width/2) {
      stroke(0, 0, 255);
    } else {
      stroke(255);
    }

    line(i, height/2, -100, i, height/2, 100);
  }

  for (int i = -100; i <= 100; i = i + 10) {

    if (i == 0) {
      stroke(255, 0, 0);
    } else {
      stroke(255);
    }

    line((width/2)-100, height/2, i, (width/2)+100, height/2, i);
  }
  
  
  //REGULAR MONSTER (half scale)
  pushMatrix();
  translate((width/2), height/2, 0);
  scale(0.5);
  rotate(PI);
  monster.setFill(color(107,142,35));
  shape(monster);
  popMatrix();
  
  //WIRE MONSTER
  pushMatrix();
  translate((width/2)+75, height/2, 0);
  rotate(PI);
  drawWire();
  popMatrix();
  
  //HEXAGON
  pushMatrix();
  translate((width/2)-(40-sqrt(3)), height/2-sqrt(3), 0);
  scale(3, 3, 3);
  shape(hex1);
  popMatrix();
  
  //NGON
  pushMatrix();
  translate((width/2)-(60), height/2-7, 0);
  ngon(20);
  popMatrix();
  
  //CUBES
  translate((width/2)-100, height/2, 0);
  pushMatrix();
  scale(5, 5, 5);
  shape(tri1);
  popMatrix();

  pushMatrix();
  translate(-10, 0, 0);
  shape(tri1);
  popMatrix();

  pushMatrix();
  translate(10, 0, 0);
  scale(10, 20, 10);
  shape(tri1);
  popMatrix();




  if (!first) {
    cam = new Camera((float)(width/2), (height/2)-200, width/2, width/2, height/2, 0.0);

    PVector p = new PVector (width/2+75, height/2, 0);
    cam.addLookTarget(p);
    
    p.x = width/2;
    p.y = height/2;
    p.z = 0;
    cam.addLookTarget(p);
    
    p.x = width/2-50;
    p.y = height/2;
    p.z = 0;
    cam.addLookTarget(p);
  
    p.x = width/2-100;
    p.y = height/2;
    p.z = 0;
    cam.addLookTarget(p);
    
    first = true;
  }


  cam.update(mouseX, mouseY);
}



void keyPressed() {
  if (key == ' ') {
    println("SPACE PRESSED");
    cam.cycleTarget();
  }
}



void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  //println(e);
  cam.zoom(e);
}


void drawWire(){
  beginShape(TRIANGLES);
  for(int i = 0; i < numFaces; i++){
    PShape child = monster.getChild(i);
    int verticesOfFace = child.getVertexCount();
    for(int j = 0; j < verticesOfFace; j++){
      stroke(0);
      fill(150, 0);
      vertex(child.getVertexX(j), child.getVertexY(j), child.getVertexZ(j));
    }
  }
  endShape();
}

void ngon(int n){
  int radius = 7;
  
  beginShape(TRIANGLE_FAN);
    for(int i = 0; i < n; i++){
      if(i == 0){
        fill(255, 0, 0);
      }
      if(i == n/3){
        fill(0, 255, 0);
      }
      if(i == (n/3)*2){
        fill(0, 0, 255);
      }
      vertex(radius * cos(2*PI*i/n), radius * sin(2*PI*i/n), 0);
    }
  endShape();
  
}
