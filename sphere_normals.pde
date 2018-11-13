// https://forum.processing.org/two/discussion/21702/drawing-points-for-each-vertex-on-a-rotating-3d-sphere
// https://stackoverflow.com/questions/8024898/calculate-the-vertex-normals-of-a-sphere
// https://gamedev.stackexchange.com/questions/150191/opengl-calculate-uv-sphere-vertices
import peasy.*;

PeasyCam cam;

VertSphere vertSphere;

void setup(){
  size(800, 600, P3D);
  cam = new PeasyCam(this, 100);
  vertSphere = new VertSphere(100);
  
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0); 
}
 
void draw(){
  background(127);
    
  vertSphere.draw();
  
  surface.setTitle("" + frameRate);
}
 
