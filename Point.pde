
class Point {
  float x, y;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void setCoords(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  float angleTo(Point p) {
    if (p.x < this.x) {
      return PI + atan((p.y - this.y) / (p.x - this.x));
    }
    
    return atan((p.y - this.y) / (p.x - this.x));
  }
  
  float angleTo(float x, float y) {
    return angleTo(new Point(x, y));
  }
}
