import com.onformative.screencapturer.*;
OPC opc;
float dx, dy;

ScreenCapturer capturer;

int w = 32;
int h = 32;


void setup()
{
  size(w*10, h*10);
  capturer = new ScreenCapturer(width, height, 30);
  
  // Connect to the local instance of fcserver
  opc = new OPC(this, "192.168.0.106", 7890);
  opc.ledGrid(0, w, h, width * 1/2, height * 1/2, height/w, height/h, 0, true);
  
  // Make the status LED quiet
  opc.setStatusLed(false);  
}

void draw() {
  image(capturer.getImage(), 0, 0);
}
