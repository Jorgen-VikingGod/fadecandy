import com.onformative.screencapturer.*;
OPC opc;
float dx, dy;

ScreenCapturer capturer;
void setup()
{
  //size(320, 160, P3D);

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  size(300,300);
  capturer = new ScreenCapturer(width, height, 30);
 
  opc.ledGrid(0, 30, 30, width * 1/2, height * 1/2, height/30, height/30, 0, true);
  // Make the status LED quiet
  opc.setStatusLed(false);  
}

void draw() {
  image(capturer.getImage(), 0, 0);
}
