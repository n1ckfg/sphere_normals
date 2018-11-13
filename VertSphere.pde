class VertSphere {
  
  PShape ps;
  PImage tex_rgb;
  PImage tex_depth;
  float normLineLength = 20;
  int detail = 15;
  int radius = 200;
  ArrayList<Vert> verts;
  color tintCol = color(255);
 
  VertSphere() {
    init();
  }
  
  VertSphere(int _detail) {
    detail = _detail;
    init();
  }
  
  void init() {
    sphereDetail(detail);
    tex_rgb = loadImage("eqr-rgb-small.jpg");
    tex_depth = loadImage("eqr-depth-small.jpg");
    tex_rgb.loadPixels();
    tex_depth.loadPixels();
    ps = createShape(SPHERE, radius);
    ps.setTexture(tex_rgb);  
    verts = initVerts(ps);
  }
  
  ArrayList<Vert> initVerts(PShape shape) {
    ArrayList<Vert> returns = new ArrayList<Vert>();
    for (int i = 0 ; i < shape.getVertexCount(); i ++) {
      Vert v = new Vert(shape.getVertex(i));
      v.col = getPixelFromUv(tex_rgb, v.uv);
      v.depth = getPixelFromUv(tex_depth, v.uv);
      v.co = reprojectEqr(v);
      returns.add(v);
    }
    return returns;
  }
  
  void draw() {
    //fill(tintCol);
    //stroke(0);
    //strokeWeight(4);
    //shape(ps);
    stroke(255);
    strokeWeight(2);
    draw_points();
  }

  void draw_points() {
    for (int i = 0; i < verts.size(); i++) {
      Vert v = verts.get(i);
      
      stroke(v.col);
      strokeWeight(8);
      point(v.co.x + v.n.x, v.co.y + v.n.y, v.co.z + v.n.z);
      
      PVector end = v.co.copy().add(v.n.copy().mult(normLineLength));
      strokeWeight(2);
      line(v.co.x, v.co.y, v.co.z, end.x, end.y, end.z);
    }
  }

  color getPixelFromUv(PImage img, PVector uv) {   
    int x = int(uv.x * img.width);
    int y = int(uv.y * img.height);
    int loc = x + y * img.width;
    loc = constrain(loc, 0, img.pixels.length - 1);
    return img.pixels[loc];
  }

  float _Displacement = 620;
  float _BaselineLength = 1800;
  float _SphericalAngle = 3.142;
  float _Maximum = 3003.65;
  
  float getDepthSpherical(float d) {
      return asin(_BaselineLength * sin(_SphericalAngle)) / asin(d);
  }
          
  PVector reprojectEqr(Vert v) {
    PVector returns = v.n.copy().mult(constrain(getDepthSpherical(red(v.depth)/255.0), -_Maximum, 0) * _Displacement);
    return new PVector(returns.x, -returns.y, returns.z);
  }

}
