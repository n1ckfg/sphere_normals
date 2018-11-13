class Vert {
  
  PVector co;
  PVector uv;
  PVector n;
  color col;
  
  Vert() {
    co = new PVector(0,0,0);
    col = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co) {
    co = _co;
    col = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co, color _col) {
    co = _co;
    col = _col;
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(PVector _co, PVector _uv) {
    co = _co;
    col = color(0);
    n = co.copy().normalize();
    uv = _uv;
  }

  Vert(PVector _co, PVector _uv, color _col) {
    co = _co;
    col = _col;
    n = co.copy().normalize();
    uv = _uv;
  }
  
  Vert(float x, float y, float z) {
    co = new PVector(x, y, z);
    col = color(0);
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(float x, float y, float z, color _col) {
    co = new PVector(x, y, z);
    col = _col;
    n = co.copy().normalize();
    uv = getUv(co);
  }
  
  Vert(float x, float y, float z, float u, float v) {
    co = new PVector(x, y, z);
    col = color(0);
    n = co.copy().normalize();
    uv = new PVector(u, v);
  }

  Vert(float x, float y, float z, float u, float v, color _col) {
    co = new PVector(x, y, z);
    col = _col;
    n = co.copy().normalize();
    uv = new PVector(u, v);
  }
  
  PVector getUv(PVector p) {
    p = new PVector(p.z, 1.0 - p.y, p.x).normalize();
    float u = 0.5 + (atan2(p.x, p.z) / (2 * PI)); 
    float v = 0.5 - (asin(p.y) / PI);

    return new PVector(0.5 - u, v);
  }
  
}
