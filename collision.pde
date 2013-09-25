
PolyLoop loop = new PolyLoop();
Ray ray = null;
EditMode editMode = EditMode.POLYLOOP;
final float LENGTH = 100;

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
    
    stroke(#00AA00);
    ray.display();
        
    Point intersection = loop.intersectionPoint(ray);
    stroke(#000000);
    
    if (intersection != null) {
      intersection.display();
    }
  }
}

void mousePressed() {
  switch (editMode) {
    case POLYLOOP:
      loop.addPoint(mouseX, mouseY);
      break;
    case RAY:
      ray = new Ray(mouseX, mouseY, LENGTH);
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
      break;
    }
  }
}

void keyPressed() {
  switch (Character.toLowerCase(key)) {
    case 'c': {
      if (editMode == EditMode.POLYLOOP) {
        loop.removeAllPoints();
      } else {
        ray = null;
      }
      break;
    }
    case 'p': setEditMode(EditMode.POLYLOOP); break;
    case 'r': setEditMode(EditMode.RAY); break;
  }
}

void setEditMode(EditMode mode) {
  editMode = mode;
}
