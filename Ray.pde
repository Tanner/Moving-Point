
class Ray {  
  Point origin;
  float angle;
  PolyLoop loop;
  Ray child;
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
          
    if (child != null) {
      Point intersection = child.getOrigin();
      intersection.display();
    
      Random r = new Random((int)length);
      stroke(color(255 - r.nextInt(255), r.nextInt(255), r.nextInt(255)));
      child.display();
    }
  }
  
  void propogateReflection() {    
    if (loop == null || length <= 0) {
      return;
    }
    
    Pair<Point, Vector> pair = loop.intersectionPointAndVectorPair(this);
    
    if (pair != null) {      
      Point p = pair.first;
      Vector v = pair.second;
    
      float remainingLength = length - getOrigin().distance(p);
      
      if (remainingLength <= 0) {
        return;
      }
      
      Vector incident = getVector().vectorByNormalizing();
      Vector normal = v.rotated().vectorByNormalizing();
      Vector reflection = incident.vectorBySubtracting(normal.vectorByMultiplying(incident.dot(normal) * 2));
      float angle = new Vector(1, 0).angle(reflection);
      Ray child = new Ray(p, remainingLength);
      
      this.length = length - remainingLength;
      this.child = child;
      
      child.setPolyLoop(loop);
      child.setAngle(angle);
    }
  }
  
  void setAngle(float angle) {
    this.angle = angle;
    this.length = totalLength;
    this.child = null;
    
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
