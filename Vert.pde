class Vert {
  
  PVector co;
  PVector uv;
  color col;
  
  Vert() {
    co = new PVector(0,0,0);
    uv = new PVector(0,0);
    col = color(0);
  }
  
  Vert(PVector _co) {
    co = _co;
    uv = new PVector(0,0);
    col = color(0);
  }
  
  Vert(PVector _co, color _col) {
    co = _co;
    uv = new PVector(0,0);
    col = _col;
  }
  
  Vert(PVector _co, PVector _uv) {
    co = _co;
    uv = _uv;
    col = color(0);
  }

  Vert(PVector _co, PVector _uv, color _col) {
    co = _co;
    uv = _uv;
    col = _col;
  }
  
  Vert(float x, float y, float z) {
    co = new PVector(x, y, z);
    uv = new PVector(0,0);
    col = color(0);
  }
  
  Vert(float x, float y, float z, color _col) {
    co = new PVector(x, y, z);
    uv = new PVector(0,0);
    col = _col;
  }
  
  Vert(float x, float y, float z, float u, float v) {
    co = new PVector(x, y, z);
    uv = new PVector (u, v);
    col = color(0);
  }

  Vert(float x, float y, float z, float u, float v, color _col) {
    co = new PVector(x, y, z);
    uv = new PVector (u, v);
    col = _col;
  }
  
}
