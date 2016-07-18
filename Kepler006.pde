//Written by Shane Gibney
PVector pos, vel, v0, acc, CM, r;
float m, Const = 1000, radius = 5.0;
int num = 30;
float[] xpos = new float[num];
float[] ypos = new float[num];
int x = 20, y = 10, w = 80, h = 20;
boolean sweep = true;
boolean path = false;
boolean pause = false;
void setup() {
  size(310, 200);
  smooth();
  textSize(13);
  pos = new PVector(140.0, 130.0);//initial position
  v0 = new PVector(1.8, -0.5);//initial velocity near perfect ellipse
  vel = new PVector(v0.x, v0.y);//velocity
  acc = new PVector(0, 0);
  CM = new PVector(310 + 30, 200);
  r = new PVector(0, 0);
  for (int i = 0; i < xpos.length; i ++ ) {
    xpos[i] = pos.x;
    ypos[i] = pos.y;
  }
}
void draw() {
  //background(199,173,87);//not seen
  buttons();
  //background(199,183,87);//visible but no buttons
  for (int i = 0; i < xpos.length-1; i ++ ) {
    xpos[i] = xpos[i+1];
    ypos[i] = ypos[i+1];
  }
  stroke(5);
  fill(200);
  PVector r = PVector.sub(pos, CM);
  m = r.mag();
  acc.x =(Const*cos(r.heading()))/(m*m);// 1 < cos(r.heading()) < -1
  acc.y =(Const*sin(r.heading()))/(m*m);
  vel.x -= acc.x;
  pos.x += vel.x;
  vel.y -= acc.y;
  pos.y += vel.y;
  xpos[xpos.length-1] = pos.x;
  ypos[ypos.length-1] = pos.y;
  if (sweep) {
    fill(#A7DAFF);
    noStroke();
    beginShape();
    for (int i = 0; i < xpos.length -1; i++) {
      vertex(xpos[i]/2, ypos[i]/2);
      vertex(xpos[i+1]/2, ypos[i+1]/2);
      vertex(CM.x/2, CM.y/2);
    }
    endShape();
  }
  stroke(0);
  fill(#0006F7);//blue
  ellipse(xpos[num-1]/2, ypos[num-1]/2, radius, radius);//the particle itself!
  stroke(#FFFBB2);//yellow
  fill(#FEFF00);//yellow
  ellipse(CM.x/2, CM.y/2, 25, 25);
  /*println("pos.x = ", pos.x);
   println("pos.y = ", pos.y);
   println("vel.x = ", vel.x);
   println("vel.y = ", vel.y);
   println("acc.x = ", acc.x);
   println("acc.y = ", acc.y);
   println("pos.heading() = ", degrees(pos.heading()));
   println("m = ", m);*/
}
void buttons() {
  stroke(#999999);
  if (!path) {//hold down mouse to see path
    background(199, 183, 87);
  }
  if (path) {
    //sweep = false;
    //background(199, 183, 87);
    fill(142, 170, 148);//on
    rect(20, y, w + 10, h);//path
    fill(255);
    text("Remove path", 20 + 3, y + 15);
    fill(#FFFFFF);
  } else {
    fill(#FFFFFF);//off
    rect(20, y, w - 5, h);//path
    fill(0, 0, 255);
    text("Show path", 20 + 3, y + 15);
    fill(#FFFFFF);
  }
  if (sweep) {
    //path = false;
    fill(142, 170, 148);//on
    rect(120, y, w + 5, h);//path
    fill(255);
    text("Remove area", 120 + 3, y + 15);
    fill(#FFFFFF);
  } else {
    fill(#FFFFFF);//off
    rect(120, y, w - 5, h);//path
    fill(0, 0, 255);
    text("Show area", 120 + 3, y + 15);
    fill(#FFFFFF);
  }
  fill(#FFFFFF);//off
  rect(220, y, w, h);//path
  fill(0, 0, 255);
  text("Pause", 220 + 3, y + 15);
  fill(#FFFFFF);
}
void mousePressed() {
  if (mouseX > 20 && mouseX < 20 + w && mouseY > y && mouseY < y + h) {
    background(199, 183, 87);
    path = !path;
    if (sweep) {
      sweep = false;
    }
  }
  if (mouseX > 120 && mouseX < 120 + w && mouseY > y && mouseY < y + h) {
    background(199, 183, 87);
    sweep = !sweep;
    if (path) {
      path = false;
    }
  }
  if (mouseX > 220 && mouseX < 220 + w && mouseY > y && mouseY < y + h) {
    if (!pause) {
      stroke(#999999);
      fill(142, 170, 148);//on
      rect(220, y, w, h);//path
      fill(#FFFFFF);
      text("Run", 220 + 3, y + 15);
      fill(#FFFFFF);
    }
    pause = !pause;
    if (pause)
      noLoop();
    else
      loop();
  }
}
