
PolyLoop loop = new PolyLoop();
Ray ray = null;
EditMode editMode = EditMode.POLYLOOP;

void setup() {
  size(600, 600);
  smooth();
}

void draw() {
  background(#FFFFFF);
  stroke(#000000);
  fill(#000000);
  strokeWeight(2);
  
  loop.display();
  
  if (ray != null) {
    ray.display();
  }
}

void mousePressed() {
  switch (editMode) {
    case POLYLOOP:
      loop.addPoint(mouseX, mouseY);
      break;
    case RAY:
      ray = new Ray(mouseX, mouseY);
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
      ray.setAngle(ray.getOrigin().angleTo(mouseX, mouseY));
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
