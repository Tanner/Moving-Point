
final float RAY_LENGTH = 500;
final float VELOCITY_LINE_LENGTH = 100;

class Ball extends Point {
  Vector velocity;
  Ray ray;
  
  public Ball(float x, float y, PolyLoop loop) {
    super(x, y);
    
    velocity = new Vector(1, 1);
    ray = new Ray(this, RAY_LENGTH);
    ray.setPolyLoop(loop);
    
    updateRay();
  }
  
  void display() {
    stroke(#FFFF00);
    ray.display();
    
    stroke(#00FF00); 
    ellipse(x,
            y,
            g.strokeWeight * 2,
            g.strokeWeight * 2);
    
    stroke(#00FF00);
    line(x,
         y,
         x + velocity.x * VELOCITY_LINE_LENGTH,
         y + velocity.y * VELOCITY_LINE_LENGTH);
  }
  
  void update() {
    x += velocity.x;
    y += velocity.y;
    
    updateRay();
  }
  
  void updateRay() { 
    ray.setOrigin(this);
    ray.setAngle(atan2(velocity.y, velocity.x));
  }
}
