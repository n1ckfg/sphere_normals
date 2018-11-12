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
    init(detail);
  }
  
  VertSphere(int _detail) {
    detail = _detail;
    init(detail);
  }
  
  void init(int _detail) {
    sphereDetail(detail);
    tex_rgb = loadImage("uv.jpg");
    tex_rgb.loadPixels();
    ps = createShape(SPHERE, radius);
    ps.setTexture(tex_rgb);  
    verts = initVerts(ps);
  }
  
  ArrayList<Vert> initVerts(PShape shape) {
    ArrayList<Vert> returns = new ArrayList<Vert>();
      for (int i = 0 ; i < shape.getVertexCount(); i ++) {
        returns.add(new Vert(shape.getVertex(i)));
      }
    return returns;
  }
  
  void draw() {
    fill(tintCol);
    stroke(0);
    strokeWeight(4);
    shape(ps);
    stroke(255);
    strokeWeight(2);
    draw_points();
  }

  void draw_points() {
    for (int i = 0 ; i < verts.size(); i++) {
      Vert v = verts.get(i);
      
      stroke(getPixelFromUv(tex_rgb, v.uv));
      strokeWeight(8);
      point(v.co.x + v.n.x, v.co.y + v.n.y, v.co.z + v.n.z);
      
      PVector end = v.co.copy().add(v.n.copy().mult(normLineLength));
      strokeWeight(2);
      line(v.co.x, v.co.y, v.co.z, end.x, end.y, end.z);
    }
  }

  color getPixelFromUv(PImage img, PVector uv) {   
    int x = abs(int(uv.x * img.width));
    int y = abs(int(uv.y * img.height));
    int loc = x + y * img.width;
    loc = constrain(loc, 0, img.pixels.length - 1);
    return img.pixels[loc];
  }

}
