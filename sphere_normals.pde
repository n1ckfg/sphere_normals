// https://forum.processing.org/two/discussion/21702/drawing-points-for-each-vertex-on-a-rotating-3d-sphere
// https://stackoverflow.com/questions/8024898/calculate-the-vertex-normals-of-a-sphere
// https://gamedev.stackexchange.com/questions/150191/opengl-calculate-uv-sphere-vertices

PShape ps;
float normLineLength = 20;
PImage tex;

void setup(){
  size(800, 600, P3D);
  frameRate(60);
  smooth();
  sphereDetail(80);
  fill(255);
  tex = loadImage("sky1.jpg");
  tex.loadPixels();
  ps = createShape(SPHERE, 200);
  ps.setTexture(tex);
}
 
void draw(){
  background(127);
  
  pushMatrix();
  translate(width/2, height/2);
  rotateZ(millis() * 0.0001 * TWO_PI);
  rotateY(millis() * 0.0001 * TWO_PI);
  stroke(0);
  shape(ps);
  stroke(255);
  strokeWeight(2);
  draw_points(ps);
  popMatrix();
  
  surface.setTitle("" + frameRate);
}
 
void draw_points(PShape shape) {
  for (int i = 0 ; i < shape.getVertexCount(); i++) {
    PVector v = shape.getVertex(i);
    PVector vn = v.copy().normalize();
    
    stroke(tex.pixels[xyToUv(tex, v.x, v.y)]);
    strokeWeight(8);
    point(v.x + vn.x, v.y + vn.y, v.z + vn.z);
    
    vn.mult(normLineLength);
    strokeWeight(2);
    line(v.x, v.y, v.z, v.x + vn.x, v.y + vn.y, v.z + vn.z);
  }
}

int xyToUv(PImage img, float _x, float _y) {
  _y = abs(1.0 - _y);
  float theta = _x * 2.0 * PI;
  float phi = (_y - 0.5) * PI;
  float c = cos(phi);
  PVector v = new PVector(c * cos(theta), sin(phi), c * sin(theta));
  int x = abs(int(v.z * img.width));
  int y = abs(int(v.y * img.height));
  return (x + y * img.width) - 1;
}
