// https://forum.processing.org/two/discussion/21702/drawing-points-for-each-vertex-on-a-rotating-3d-sphere
// https://stackoverflow.com/questions/8024898/calculate-the-vertex-normals-of-a-sphere
// https://gamedev.stackexchange.com/questions/150191/opengl-calculate-uv-sphere-vertices

VertSphere vertSphere;

void setup(){
  size(800, 600, P3D);
  frameRate(60);
  smooth();
  vertSphere = new VertSphere();
}
 
void draw(){
  background(127);
  
  pushMatrix();
  translate(width/2, height/2);
  rotateZ(millis() * 0.0001 * TWO_PI);
  rotateY(millis() * 0.0001 * TWO_PI);
  
  vertSphere.draw();
  popMatrix();
  
  surface.setTitle("" + frameRate);
}
 
