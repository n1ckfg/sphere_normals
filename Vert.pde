class Vert {
  
  PVector co;
  PVector uv;
  PVector n;
  color col;
  
  Vert() {
    co = new PVector(0,0,0);
    uv = getUv(co);
    col = color(0);
    n = co.copy().normalize();
  }
  
  Vert(PVector _co) {
    co = _co;
    uv = getUv(co);
    col = color(0);
    n = co.copy().normalize();
  }
  
  Vert(PVector _co, color _col) {
    co = _co;
    uv = getUv(co);
    col = _col;
    n = co.copy().normalize();
  }
  
  Vert(PVector _co, PVector _uv) {
    co = _co;
    uv = _uv;
    col = color(0);
    n = co.copy().normalize();
  }

  Vert(PVector _co, PVector _uv, color _col) {
    co = _co;
    uv = _uv;
    col = _col;
    n = co.copy().normalize();
  }
  
  Vert(float x, float y, float z) {
    co = new PVector(x, y, z);
    uv = getUv(co);
    col = color(0);
    n = co.copy().normalize();
  }
  
  Vert(float x, float y, float z, color _col) {
    co = new PVector(x, y, z);
    uv = getUv(co);
    col = _col;
    n = co.copy().normalize();
  }
  
  Vert(float x, float y, float z, float u, float v) {
    co = new PVector(x, y, z);
    uv = new PVector(u, v);
    col = color(0);
    n = co.copy().normalize();
  }

  Vert(float x, float y, float z, float u, float v, color _col) {
    co = new PVector(x, y, z);
    uv = new PVector(u, v);
    col = _col;
    n = co.copy().normalize();
  }
  
  PVector getUv(PVector v) {
    float theta = v.x * 2.0 * PI;
    float phi = (v.y - 0.5) * PI;
    float c = cos(phi);
    PVector returns = new PVector(c * cos(theta), sin(phi), c * sin(theta));  
    return new PVector(returns.x, returns.y);
  }
  
}
