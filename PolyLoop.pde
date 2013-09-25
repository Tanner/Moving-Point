
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
        candidates.add(new Pair<Point, Vector>(intersection, new Vector(a, b)));
      }
    }
    
    if (candidates.size() > 0) {
      return candidates.poll();
    }
    
    return null;
  }
  
  Point intersectionPoint(Point a, Point b, Point c, Point d) {         
    float det1 = new Vector(a, b).det(new Vector(a, c));
    float det2 = new Vector(a, b).det(new Vector(a, d));
    
    System.out.println(det1 + " " + det2);
  
    if ((det1 <= 0 && det2 >= 0) ||
        (det1 >= 0 && det2 <= 0)) {
      
      // HACK
      if (d.x == c.x) {
        d = new Point(d.x + 0.1, d.y);
      }
          
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
