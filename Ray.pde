
class Ray {  
  Point origin;
  float angle;
  PolyLoop loop;
  Ray reflection;
  float length;
  float totalLength;
  
  public Ray(Point origin, float totalLength) {
    this.origin = origin;
    this.totalLength = totalLength;
    this.length = totalLength;
  }
  
  public Ray(float x, float y, float totalLength) {
    this(new Point(x, y), totalLength);
  }
  
  void display() {
    line(origin.x,
         origin.y,
         origin.x + cos(angle) * length,
         origin.y + sin(angle) * length);
          
    if (reflection != null) {
      reflection.display();
    }
  }
  
  void propogateReflection() {
    if (loop == null || length <= 0) {
      return;
    }
    
    Point p = loop.intersectionPoint(this);
    Vector v = loop.intersectionVector(this);
    
    if (p != null) {
      float remainingLength = length - getOrigin().distance(p);
      
      if (remainingLength <= 0) {
        return;
      }
      
//      float angle = new Vector(1, 0).angle(v) + PI - getVector().angle(v);
//      System.out.println(angle * 180 / PI);
      Vector incident = getVector().vectorByNormalizing();
      Vector normal = v.rotated().vectorByNormalizing();
      Vector reflection = incident.vectorBySubtracting(normal.vectorByMultiplying(incident.dot(normal) * 2));
      float angle = new Vector(1, 0).angle(reflection);
      Ray child = new Ray(p, remainingLength);
      
      child.setAngle(angle);
      child.setPolyLoop(loop);
      
      this.length = length - remainingLength;
      this.reflection = child;
    }
    
    if (reflection != null) {
//      reflection.propogateReflection();
    }
  }
  
  void setAngle(float angle) {
    this.angle = angle;
    this.length = totalLength;
    this.reflection = null;
    
    propogateReflection();
  }
  
  Point getOrigin() {
    return origin;
  }
  
  Vector getVector() {
    return new Vector(cos(angle) * length, sin(angle) * length);
  }
  
  void setPolyLoop(PolyLoop loop) {
    this.loop = loop;
  }
}
