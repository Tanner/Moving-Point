
PolyLoop loop = new PolyLoop();
Ray ray = null;
Ball ball = null;
EditMode editMode = EditMode.POLYLOOP;
final float LENGTH = 500;

void setup() {
  size(600, 600);
  smooth();
}

void draw() {
  background(#FFFFFF);
  stroke(#000000);
  fill(#000000);
  strokeWeight(3);
  
  loop.display();
  
  if (ray != null) {
    ray.setPolyLoop(loop);
    
    ray.display();
  }
  
  if (ball != null) {
    ball.update();
    
    ball.display();
  }
}

void mousePressed() {
  switch (editMode) {
    case POLYLOOP:
      loop.addPoint(mouseX, mouseY);
      break;
    case RAY:
      ray = new Ray(mouseX, mouseY, LENGTH);
      ray.setColor(#00AA00);
      break;
    case BALL:
      ball = new Ball(mouseX, mouseY, 10, loop);
      break;
  }
}

void mouseDragged() {
  switch (editMode) {
    case POLYLOOP: {
      loop.changeLastPoint(mouseX, mouseY);
      break;
    }
    case RAY: { 
      ray.setAngle(ray.getOrigin().angle(mouseX, mouseY));
//      ray.propogateReflection();
      
//      if (ray.child != null)
//        ray.child.propogateReflection();
      break;
    }
  }
}

void keyPressed() {
  switch (Character.toLowerCase(key)) {
    case 'c': {
      if (editMode == EditMode.POLYLOOP) {
        loop.removeAllPoints();
      } else if (editMode == EditMode.BALL) {
        ball = null;
      } else {
        ray = null;
      }
      break;
    }
    case 'p': setEditMode(EditMode.POLYLOOP); break;
    case 'r': setEditMode(EditMode.RAY); break;
    case 'b': setEditMode(EditMode.BALL); break;
  }
}

void setEditMode(EditMode mode) {
  editMode = mode;
}
