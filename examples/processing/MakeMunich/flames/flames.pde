OPC opc;
PImage im;

void setup()
{
  size(300, 300);

  // Load a sample image
  im = loadImage("flames.jpeg");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map one 64-LED strip to the center of the window
  //opc.ledStrip(0, 30, width/2, height/2, width / 70.0, 0, false);
  opc.ledGrid(0, 30, 30, width * 1/2, height * 1/2, height/30, height/30, 0, true);
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

