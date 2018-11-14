class VertSphere {
  
  PImage tex_rgb;
  PImage tex_depth;
  float normLineLength = 20;
  int detail = 10;
  ArrayList<Vert> verts;
  boolean drawEndLines = false;
 
  float _Displacement = 500;
  float _BaselineLength = 180;
  float _SphericalAngle = 3.142;
  float _Maximum = 1000;
  
  VertSphere(PImage _rgb, PImage _depth) {
    init(_rgb, _depth);
  }
  
  VertSphere(PImage _rgb, PImage _depth, int _detail) {
    detail = _detail;
    init(_rgb, _depth);
  }
  
  void init(PImage _rgb, PImage _depth) {
    tex_rgb = _rgb;
    tex_depth = _depth;
    tex_rgb.loadPixels();
    tex_depth.loadPixels();
    verts = initVerts(detail);
  }
  
  ArrayList<Vert> initVerts(int detail) {
    ArrayList<Vert> returns = new ArrayList<Vert>();
    for (int m = 0; m < detail; m++) {
      for (int n = 0; n < detail; n++) {
        float x = sin(PI * m/detail) * cos(2 * PI * n/detail);
        float z = sin(PI * m/detail) * sin(2 * PI * n/detail);
        float y = cos(PI * m/detail); // up
          
        Vert v = new Vert(new PVector(x, y, z));
        v.col = getPixelFromUv(tex_rgb, v.uv);
        v.depth = getPixelFromUv(tex_depth, v.uv);
        v.co = reprojectEqr(v);
        returns.add(v);
      }
    }

    return returns;
  }
  
  void draw() {
    stroke(255);
    strokeWeight(2);
    draw_points();
  }

  void draw_points() {
    for (int i = 0; i < verts.size(); i++) {
      Vert v = verts.get(i);
      
      stroke(v.col);
      strokeWeight(10);
      point(v.co.x + v.n.x, v.co.y + v.n.y, v.co.z + v.n.z);
      
      if (drawEndLines) {
        PVector end = v.co.copy().add(v.n.copy().mult(normLineLength));
        strokeWeight(2);
        line(v.co.x, v.co.y, v.co.z, end.x, end.y, end.z);
      }
    }
  }

  color getPixelFromUv(PImage img, PVector uv) {   
    int x = int(uv.x * img.width);
    int y = int(uv.y * img.height);
    int loc = x + y * img.width;
    loc = constrain(loc, 0, img.pixels.length - 1);
    return img.pixels[loc];
  }
  
  float getDepthSpherical(float d) {
      return asin(_BaselineLength * sin(_SphericalAngle)) / asin(d);
  }
          
  PVector reprojectEqr(Vert v) {
    PVector returns = v.n.copy().mult(constrain(getDepthSpherical(red(v.depth)/255.0), -_Maximum, 0) * _Displacement);
    return new PVector(returns.x, returns.y, returns.z);
  }

}


class Vert {
  
  PVector co;
  PVector uv;
  PVector n;
  color col;
  color depth;
  
  Vert() {
    co = new PVector(0,0,0);
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co) {
    co = _co;
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co, color _col) {
    co = _co;
    col = _col;
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co, PVector _uv) {
    co = _co;
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = _uv;
  }

  Vert(PVector _co, PVector _uv, color _col) {
    co = _co;
    col = _col;
    depth = color(0);
    n = co.copy().normalize();
    uv = _uv;
  }
  
  Vert(float x, float y, float z) {
    co = new PVector(x, y, z);
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(float x, float y, float z, color _col) {
    co = new PVector(x, y, z);
    col = _col;
    depth = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(float x, float y, float z, float u, float v) {
    co = new PVector(x, y, z);
    col = color(0);
    depth = color(0);
    n = co.copy().normalize();
    uv = new PVector(u, v);
  }

  Vert(float x, float y, float z, float u, float v, color _col) {
    co = new PVector(x, y, z);
    col = _col;
    depth = color(0);
    n = co.copy().normalize();
    uv = new PVector(u, v);
  }
  
  PVector getUv(PVector p) {
    p = new PVector(p.x, p.y, p.z).normalize();
    float u = 0.5 + (atan2(p.x, p.z) / (2 * PI)); 
    float v = 0.5 - (asin(p.y) / PI);
    return new PVector(1.0 - u, v);
  }
  
  PVector getUvPShape(PVector p) {
    p = new PVector(p.z, 1.0 - p.y, p.x).normalize();
    float u = 0.5 + (atan2(p.x, p.z) / (2 * PI)); 
    float v = 0.5 - (asin(p.y) / PI);
    return new PVector(0.5 + u, v);
  }
  
  PVector getXyz(float u, float v) {
    float theta = u * 2.0 * PI;
    float phi = (v - 0.5) * PI;
    float c = cos(phi);
    return new PVector(c * cos(theta), sin(phi), c * sin(theta));
  }
  
}
