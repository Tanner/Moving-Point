
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
  
  Point intersectionPoint(final Ray ray) {
    if (points.size() == 0) {
      return null;
    }
    
    PriorityQueue<Point> candidates = new PriorityQueue<Point>(points.size(), new Comparator<Point>() {
      public int compare(Point a, Point b) {
        return (int)(ray.getOrigin().distance(a) - ray.getOrigin().distance(b));
      }
    });
    
    for (int i = 0; i < points.size(); i++) {
      Point a = points.get(i);
      Point b = points.get(nextPointIndex(i));
      Point c = ray.getOrigin().pointByAddingVector(ray.getVector());
      Point d = ray.getOrigin();
    
      Point intersection = intersectionPoint(a, b, c, d);
      
      if (intersection != null) {
        candidates.add(intersection);
      }
    }
    
    if (candidates.size() > 0) {
      return candidates.poll();
    }
    
    return null;
  }
  
  Vector intersectionVector(final Ray ray) {
    if (points.size() == 0) {
      return null;
    }
    
    PriorityQueue<Point> candidates = new PriorityQueue<Point>(points.size(), new Comparator<Point>() {
      public int compare(Point a, Point b) {
        return (int)(ray.getOrigin().distance(a) - ray.getOrigin().distance(b));
      }
    });
    
    for (int i = 0; i < points.size(); i++) {
      Point a = points.get(i);
      Point b = points.get(nextPointIndex(i));
      Point c = ray.getOrigin().pointByAddingVector(ray.getVector());
      Point d = ray.getOrigin();
            
      if (intersectionPoint(a, b, c, d) != null) {
        return new Vector(a, b);
      }
    }
    
    return null;
  }
  
  Point intersectionPoint(Point a, Point b, Point c, Point d) {         
    float det1 = new Vector(a, b).det(new Vector(a, c));
    float det2 = new Vector(a, b).det(new Vector(a, d));
  
    if ((det1 < 0 && det2 > 0) ||
        (det1 > 0 && det2 < 0)) {
      float m1 = d.slope(c);
      float m2 = a.slope(b);
                              
      float x = (m2 * a.x - a.y - m1 * d.x + d.y) / (m2 - m1);
      float y = m1 * (x - d.x) + d.y;
      
      if (x <= max(a.x, b.x) &&
          x >= min(a.x, b.x) &&
          y <= max(a.y, b.y) &&
          y >= min(a.y, b.y)) {
            return new Point(x, y);
      }
    }
    
    return null;
  }
}
