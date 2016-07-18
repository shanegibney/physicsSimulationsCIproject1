//Written by Shane Gibney
PVector pos, vel, v0, acc;
float radius = 10.0;
float y, g;
void setup() {
  size(300, 150);
  smooth();
  frameRate(24);
  pos = new PVector(10.0, height-20);//initial position
  v0 = new PVector(2.75, -4.5);//initial velocity
  vel = new PVector(v0.x, v0.y);//velocity
  g = 0.095;
  acc = new PVector(0.0, g);
}
void draw() {
  background(142,170,148);
  fill(0);
  pos.x += vel.x;
  vel.y += acc.y;
  pos.y += vel.y;
  line(pos.x, pos.y, pos.x + 10*vel.x, pos.y);//horizontal component
  line(pos.x, pos.y, pos.x, pos.y + 10*vel.y);//vertical component
  line(pos.x, pos.y, pos.x + 10*vel.x, pos.y + 10*vel.y);//actual velocity vector
  ellipse(pos.x, pos.y, radius, radius);//black the projectile itself!
  float a = atan2(vel.y, vel.x);//angle between resultant and horizontal

  stroke(#CECAC4);//grey
  for (int x = 0; x < width; x++) {//equation of trajectory y=(-g sec^2(theta)/2v_0^2)x^2+xtan(theta)
    y = g / (2*(pow(v0.x, 2)+pow(v0.y, 2))*pow(cos(atan(v0.y/v0.x)), 2))*pow(x, 2) + x*(v0.y/v0.x);
    point(x+10, height+y-20);
  }

  fill(142,170,148);
  noStroke();
  rect(0, height, width, -40);//blank background rectangle along bottom

  fill(0);
  pushMatrix();
  translate(pos.x + 10*vel.x, pos.y + 10*vel.y);
  rotate(PI/2+a);
  triangle(0, 0, -5, 5, 5, 5);//arrow-head on resultant vector
  popMatrix();

  pushMatrix();
  translate(pos.x + 10*vel.x, pos.y);
  rotate(PI/2);
  triangle(0, 0, -5, 5, 5, 5);//arrow-head horizontal component
  popMatrix();

  pushMatrix();
  translate(pos.x, pos.y + 10*vel.y);
  if (vel.y > 0) {
    rotate(PI);
  }
  triangle(0, 0, -5, 5, 5, 5);//arrow-head vertical component
  popMatrix();

  fill(0, 25);
  noStroke();
  rect(pos.x-35, height, 70, -height);//shaded area
  stroke(1.0);
  pushMatrix();
  translate(pos.x-10, height-35);
  rotate(-PI/10);
  fill(#D0D156);//mustard
  ellipse(0, 0, 12, 20);//body
  popMatrix();
  fill(#D6A345);//head colour
  ellipse(pos.x-13, height-45, 10, 10);//head
  fill(#454A6F);
  rect(pos.x-20, height-30, 40, 20, 5, 5, 15, 15);//cart
  fill(0);
  ellipse(pos.x-10, height-10, 10, 10);
  ellipse(pos.x+10, height-10, 10, 10);
  if (pos.y > height) {
    setup();
  }
}
// Anykey to pause and unpause animation
boolean bStop;
void keyPressed()
{
  bStop = !bStop;
  if (bStop)
    noLoop();
  else
    loop();
}
