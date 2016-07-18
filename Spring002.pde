//Written by Shane Gibney
float x, y, x1, y1;
int w = 50, h = 30;
float velX = 0.0;
float accX, displ;
float k = 0.008;
float angle = 0.0;
int n = 50;
float space;
int max = 0;
void setup() {
  size(300, 200);
  background(255);
  x = width/2 - w/2;
  y = height/2 - h + 75;
  max = 0;
}
void draw() {
  background(142,170,148);
  line(width/2, height/2 + 10 + 150, width/2, height/2 - 50 + 150);
  line(width/2, 10, width/2, height/2 - 70 + 150);
  line(50, height/2 + 151, width - 50, height/2 + 151);
  line(max, height/2 + 70, width - max, height/2 + 70);
  for (int i = width/2 - max; i < max - width/2; i++) {
    x1 = i + width/2;
    y1 = -i*i*0.01 + height/2 + 70;
    point(x1, y1);
  }
  ellipse(x + w/2, -(x - width/2 + w/2)*(x - width/2 + w/2)*0.01 + height/2 + 70, 5, 5);
  stroke(200, 0, 0);
  line(x + w/2, -(x - width/2 + w/2)*(x - width/2 + w/2)*0.01 + height/2 + 70, x + w/2, height/2 + 70);
  stroke(0, 0, 200);
  line(x + w/2, -(x - width/2 + w/2)*(x - width/2 + w/2)*0.01 + height/2 + 70, x + w/2, -(max - width/2)*(max - width/2)*0.01 + height/2 + 70);
  stroke(#0DCE00);
  line(max, -(max - width/2)*(max - width/2)*0.01 + height/2 + 70, width - max, -(max - width/2)*(max - width/2)*0.01 + height/2 + 70);
  stroke(0);
  displ = x - width/2 + w/2;
  accX = displ/10 * k;
  velX -= accX;
  x += velX;
  spring();
  fill((#FAFA81));
  if ((mouseX > x) && (mouseX < x + w) && (mouseY > y) && (mouseY < y + h)) {
    fill(#FFF700);
    if (mousePressed) {
      if ((mouseX > 50) && (mouseX < width - 50)) {
        x = mouseX - w/2;
        accX = 0.0;
        velX = 0.0;
      }
    }
  }
  rect(x, y, w, h);
}
void spring() {
  space = (x - 20 )/n;
  noFill();
  strokeWeight(3);
  beginShape();
  curveVertex(20, y + h/2);
  for (int i = 0; i < n + 1; i++) {
    if (i == 0) {
      angle = 0.0;
    }
    curveVertex(20 + i*space, 10 * sin(angle) + y + h/2);
    angle += PI/2;
  }
  curveVertex(20 + n*space, y + h/2);
  endShape();
  strokeWeight(1.0);
}
void mouseReleased() {
  if ((mouseX > x) && (mouseX < x + w) && (mouseY > y) && (mouseY < y + h)) {
    max = mouseX;
  }
}
boolean bStop;
void keyPressed()
{
  bStop = !bStop;
  if (bStop)
    noLoop();
  else
    loop();
}
