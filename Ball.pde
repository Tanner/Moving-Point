
final float RAY_LENGTH = 500;
final float VELOCITY_LINE_LENGTH = 100;

class Ball extends Point {
  Vector velocity;
  Ray ray;
  int radius;
  
  Point nextPoint;
  
  public Ball(float x, float y, int r, PolyLoop loop) {
    super(x, y);
    
    velocity = new Vector(1, 1);
    radius = r;
    
    ray = new Ray(this, RAY_LENGTH);
    ray.setBoundaryDistance(r);
    ray.setPolyLoop(loop);
    ray.setColor(#FFFF00);
    
    updateRay();
  }
  
  void display() {
    ray.display();
    
    fill(#00FF00);
    noStroke();
    ellipse(x,
            y,
            radius * 2,
            radius * 2);
    
    stroke(#00FF00);
    line(x,
         y,
         x + velocity.x * VELOCITY_LINE_LENGTH,
         y + velocity.y * VELOCITY_LINE_LENGTH);
  }
  
  void update() {
    float dist = distance(new Point(x + velocity.x, y + velocity.y));
    
    nextPoint = ray.pointAlongRay(dist);
    
    Ray nextRay = ray.rayAlongRay(dist);
    
    velocity = new Vector(cos(nextRay.angle) * 1, sin(nextRay.angle) * 1);
    
    x = nextPoint.x;
    y = nextPoint.y;
    
    updateRay();
  }
  
  void updateRay() { 
    ray.setOrigin(this);
    ray.setAngle(atan2(velocity.y, velocity.x));
  }
}
