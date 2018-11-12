// https://forum.processing.org/two/discussion/21702/drawing-points-for-each-vertex-on-a-rotating-3d-sphere
// https://stackoverflow.com/questions/8024898/calculate-the-vertex-normals-of-a-sphere

PShape ps;
float normLineLength = 20;

void setup(){
  size(800, 600, P3D);
  frameRate(60);
  smooth();
  sphereDetail(20);
  fill(255,127,0);
  ps = createShape(SPHERE, 200);
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
    
    strokeWeight(8);
    point(v.x + vn.x, v.y + vn.y, v.z + vn.z);
    
    vn.mult(normLineLength);
    strokeWeight(2);
    line(v.x, v.y, v.z, v.x + vn.x, v.y + vn.y, v.z + vn.z);
  }
}
