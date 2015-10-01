OPC opc;
PImage im;

int w = 30;
int h = 30;

void setup()
{
  size(w*10, h*10);

  // Load a sample image
  im = loadImage("flames.jpeg");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "192.168.42.1", 7890);
  opc.ledGrid(0, w, h, width * 1/2, height * 1/2, width/w, height/h, 0, true);
  // Make the status LED quiet
  opc.setStatusLed(false);
}

void draw()
{
  // Scale the image so that it matches the width of the window
  int imHeight = im.height * width / im.width;

  // Scroll down slowly, and wrap around
  float speed = 0.1;
  float y = (millis() * -speed) % imHeight;
  
  // Use two copies of the image, so it seems to repeat infinitely  
  image(im, 0, y, width, imHeight);
  image(im, 0, y + imHeight, width, imHeight);
}

