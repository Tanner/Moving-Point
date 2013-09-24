
class Vector {
  float x, y;
  
  public Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  float dot(Vector p) {
    return this.x * p.x + this.y * p.y;
  }
  
  float det(Vector p) {
    return this.rotated().dot(p);
  }
  
  Vector rotated() {
    return new Vector(-this.y, this.x);
  }
}
