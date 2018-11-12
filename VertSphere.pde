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
    sphereDetail(detail);
    tex_rgb = loadImage("uv.jpg");
    tex_rgb.loadPixels();
    ps = createShape(SPHERE, radius);
    ps.setTexture(tex_rgb);  
    verts = initVerts(ps);
  }
  
  ArrayList<Vert> initVerts(PShape shape) {
    ArrayList<Vert> returns = new ArrayList<Vert>();
      for (int i = 0 ; i < shape.getVertexCount(); i++) {
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
      
      stroke(tex_rgb.pixels[xyToUv(tex_rgb, v.co.x, v.co.y, 360/detail, 360/detail)]);
      strokeWeight(8);
      point(v.co.x + v.n.x, v.co.y + v.n.y, v.co.z + v.n.z);
      
      PVector end = v.co.copy().add(v.n.copy().mult(normLineLength));
      strokeWeight(2);
      line(v.co.x, v.co.y, v.co.z, end.x, end.y, end.z);
    }
  }

  int xyToUv(PImage img, float _x, float _y, float numLatitudeLines, float numLongitudeLines) {
    float latitudeSpacing = 1.0f / (numLatitudeLines + 1.0f);
    float longitudeSpacing = 1.0f / (numLongitudeLines);
    _x = _x * longitudeSpacing;
    _y = 1.0f - (_y + 1) * latitudeSpacing; 
    
    float theta = _x * 2.0 * PI;
    float phi = (_y - 0.5) * PI;
    float c = cos(phi);
    PVector v = new PVector(c * cos(theta), sin(phi), c * sin(theta));
    int x = abs(int(v.x * img.width));
    int y = abs(int(v.y * img.height));
    return x + y * img.width;
  }

}
