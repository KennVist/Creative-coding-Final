import controlP5.*;

int smallPoint = 10;
int largePoint = 40;

PImage img;
ControlP5 cp5;
float point = smallPoint;
float minFrameRate = 60;
float maxFrameRate = 1000000000;
float frameRateValue = minFrameRate;
boolean useSquare = false; 
boolean useTriangle = false; 
boolean useStar = false; 

void setup() {
  size(1920, 1080);
  selectInput("Select an image to load", "imageSelected"); 
  noStroke();
  background(255);
  
  cp5 = new ControlP5(this);
  Slider slider = cp5.addSlider("point")
                     .setPosition(10, 10)
                     .setRange(smallPoint, largePoint)
                     .setValue(smallPoint)
                     .setSize(200, 20);
  slider.setLabel("Size");
  slider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  
  Slider frameRateSlider = cp5.addSlider("frameRateValue")
                              .setPosition(10, 40)
                              .setRange(minFrameRate, maxFrameRate)
                              .setValue(minFrameRate)
                              .setSize(200, 20);
  frameRateSlider.setLabel("Frame Rate");
  frameRateSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  
  cp5.addButton("useSquare")
     .setPosition(10, 70)
     .setSize(80, 20)
     .setLabel("Use Square");
  
  cp5.addButton("useTriangle")
     .setPosition(10, 100)
     .setSize(80, 20)
     .setLabel("Use Triangle");
  
  cp5.addButton("useStar")
     .setPosition(10, 130)
     .setSize(80, 20)
     .setLabel("Use Star");
}

void draw() {
  if (img != null) {
    point = cp5.getController("point").getValue();
    frameRateValue = cp5.getController("frameRateValue").getValue();
    
    float x = random(img.width);
    float y = random(img.height);
    color c = img.get(int(x), int(y));
    fill(c);
    
    if (useSquare) {
      rect(x, y, point, point);
    } else if (useTriangle) {
      triangle(x, y, x + point, y, x + point / 2, y + point);
    } else if (useStar) {
      star(x, y, 5, point / 2, point / 4);
    } else {
      ellipse(x, y, point, point);
    }
  }
  
  frameRate(frameRateValue);
}

void imageSelected(File selection) {
  if (selection != null) {
    img = loadImage(selection.getAbsolutePath());
  }
}

void useSquare() {
  useSquare = !useSquare;
}

void useTriangle() {
  useTriangle = !useTriangle;
}

void useStar() {
  useStar = !useStar;
}

void star(float x, float y, int numPoints, float outerRadius, float innerRadius) {
  float angle = TWO_PI / numPoints;
  float halfAngle = angle / 2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * outerRadius;
    float sy = y + sin(a) * outerRadius;
    vertex(sx, sy);
    sx = x + cos(a + halfAngle) * innerRadius;
    sy = y + sin(a + halfAngle) * innerRadius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    background(255);
  }
}
