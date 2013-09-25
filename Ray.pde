
class Ray {  
  Point origin;
  float angle;
  PolyLoop loop;
  Ray child;
  float length;
  float totalLength;
  color c;
  float boundaryDistance;
  
  public Ray(Point origin, float totalLength) {
    this.origin = origin;
    this.totalLength = totalLength;
    this.length = totalLength;
  }
  
  public Ray(float x, float y, float totalLength) {
    this(new Point(x, y), totalLength);
  }
  
  void display() {
    stroke(c);
    line(origin.x,
         origin.y,
         origin.x + cos(angle) * length,
         origin.y + sin(angle) * length);
          
    if (child != null) {
      Point intersection = child.getOrigin();
      intersection.display();
    
      child.display();
    }
  }
  
  void propogateReflection() {    
    if (loop == null || length <= 0) {
      return;
    }
    
    Pair<Point, Vector> pair = loop.intersectionPointAndVectorPair(this, boundaryDistance);
    
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
      child.setBoundaryDistance(boundaryDistance);
      
      this.length = length - remainingLength;
      this.child = child;
      
      colorMode(HSB, 100);
      child.setColor(color(hue(c), saturation(c), brightness(c) - 5));
      child.setPolyLoop(loop);
      child.setAngle(angle);
    }
  }
  
  void setOrigin(Point origin) {
    this.origin = origin;
    
    resetAndRecalculate();
  }
  
  void setAngle(float angle) {
    this.angle = angle;
    
    resetAndRecalculate();
  }
  
  void setColor(color c) {
    this.c = c;
  }
  
  void resetAndRecalculate() {
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
  
  void setBoundaryDistance(float d) {
    this.boundaryDistance = d;
  }
  
  Point pointAlongRay(float distance) {
    if (distance > length) {
      if (child != null) {
        return child.pointAlongRay(distance - length);
      } else {
        return null;
      }
    }
    
    return new Point(origin.x + cos(angle) * distance, origin.y + sin(angle) * distance);
  }
  
  Ray rayAlongRay(float distance) {    
    if (distance > length) {
      if (child != null) {
        return child.rayAlongRay(distance - length);
      } else {
        return null;
      }
    }
    
    return this;
  }
}
