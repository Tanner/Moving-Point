
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
}
