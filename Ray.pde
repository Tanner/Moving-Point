
class Ray {
  private final float LENGTH = width * height;
  
  Point origin;
  float angle;
  
  public Ray(Point origin) {
    this.origin = origin;
  }
  
  public Ray(float x, float y) {
    this(new Point(x, y));
  }
  
  void display() {
    line(origin.x,
          origin.y,
          origin.x + cos(angle) * LENGTH,
          origin.y + sin(angle) * LENGTH);
  }
  
  void setAngle(float angle) {
    this.angle = angle;
  }
  
  Point getOrigin() {
    return origin;
  }
}
