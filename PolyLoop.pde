
import java.util.*;

class PolyLoop {
  List<Point> points;
  
  PolyLoop() {
    points = new ArrayList<Point>();
  }
  
  private int nextPointIndex(int i) {
    return ((i + 1) % points.size());
  }
  
  private int previousPointIndex(int i) {
    return (i == 0) ? (points.size() - 1) : (i - 1);
  }
  
  void display() {
    for (int i = 0; i < points.size(); i++) {
      line(points.get(i).x,
           points.get(i).y,
           points.get(nextPointIndex(i)).x,
           points.get(nextPointIndex(i)).y);
    }
  }
  
  void addPoint(float x, float y) {
    points.add(new Point(x, y));
  }
  
  void changeLastPoint(float x, float y) {
    points.get(points.size() - 1).setCoords(x, y);
  }
  
  void removeAllPoints() {
    points.clear();
  }
  
  Pair<Point, Vector> intersectionPointAndVectorPair(final Ray ray) {
    if (points.size() == 0) {
      return null;
    }
    
    PriorityQueue<Pair<Point, Vector>> candidates = new PriorityQueue<Pair<Point, Vector>>(points.size(), new Comparator<Pair<Point, Vector>>() {
      public int compare(Pair<Point, Vector> a, Pair<Point, Vector> b) {
        return (int)(ray.getOrigin().distance(a.first) - ray.getOrigin().distance(b.first));
      }
    });
    
    for (int i = 0; i < points.size(); i++) {
      Point a = points.get(i);
      Point b = points.get(nextPointIndex(i));
      Point c = ray.getOrigin().pointByAddingVector(ray.getVector());
      Point d = ray.getOrigin();
    
      Point intersection = intersectionPoint(a, b, c, d);
      
      if (intersection != null) {        
        float rayHeadDistance = ray.pointAlongRay(ray.length).distance(intersection);
        float rayOriginDistance = ray.origin.distance(intersection);
                
        if (rayOriginDistance < 0.001) {
          // Bad ray
          continue;
        }
        
        candidates.add(new Pair<Point, Vector>(intersection, new Vector(a, b)));
      }
    }
    
    if (candidates.size() > 0) {
      return candidates.poll();
    }
    
    return null;
  }
  
  Point intersectionPoint(Point a, Point b, Point c, Point d) {
    Vector cdr = new Vector(c, d).rotated();
    
    float t = (cdr.x * (a.x - c.x) + cdr.y * (a.y - c.y)) / (-cdr.y * (b.y - a.y) - cdr.x * (b.x - a.x));
    
    Point p = a.pointByAddingVector(new Vector(a, b).vectorByMultiplying(t));
        
    if (p.x <= max(c.x, d.x) &&
        p.x >= min(c.x, d.x) &&
        p.y <= max(c.y, d.y) &&
        p.y >= min(c.y, d.y) &&
        p.x <= max(a.x, b.x) &&
        p.x >= min(a.x, b.x) &&
        p.y <= max(a.y, b.y) &&
        p.y >= min(a.y, b.y)) {
      return p;
    }
    
    return null;
  }
}
