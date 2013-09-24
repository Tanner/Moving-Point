
class Vector {
  float x, y;
  
  public Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public Vector(Point a, Point b) {
    this.x = b.x - a.x;
    this.y = b.y - a.y;
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
  
  float magnitude() {
    return new Point(x, y).distance(0, 0);
  }
}
