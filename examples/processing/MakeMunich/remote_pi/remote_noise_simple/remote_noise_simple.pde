// A simple example of using Processing's noise() function to draw LED clouds

OPC opc;

PImage clouds;

//int w = 9;
//int h = 6;
int w = 30;
int h = 30;
int pW = 16;
int pH = 8;

void setup()
{
  size(w*10, h*10);
  
  colorMode(HSB, 100);
  noiseDetail(5, 0.4);
  loadPixels();

  // Render the noise to a smaller image, it's faster than updating the entire window.
  clouds = createImage(128, 128, RGB);

  opc = new OPC(this, "192.168.42.1", 7890);
  /* each panel (1 to 8) has 16x8 pixel
     connected from 1 to 8 in chain
  .---------+---------.
  |    1    |    2    |
  +---------+---------+
  |    3    |    4    |
  +---------+---------+
  |    5    |    6    |
  +---------+---------+
  |    7    |    8    |
  `---------+---------´
  */
  /*
  opc.ledGrid(0 * 128, pW, pH, width * 1/4, height * 1/pH, width/w, height/h, 0, true);
  opc.ledGrid(1 * 128, pW, pH, width * 3/4, height * 1/pH, width/w, height/h, 0, true);
  opc.ledGrid(2 * 128, pW, pH, width * 1/4, height * 3/pH, width/w, height/h, 0, true);
  opc.ledGrid(3 * 128, pW, pH, width * 3/4, height * 3/pH, width/w, height/h, 0, true);
  opc.ledGrid(4 * 128, pW, pH, width * 1/4, height * 5/pH, width/w, height/h, 0, true);
  opc.ledGrid(5 * 128, pW, pH, width * 3/4, height * 5/pH, width/w, height/h, 0, true);
  opc.ledGrid(6 * 128, pW, pH, width * 1/4, height * 7/pH, width/w, height/h, 0, true);
  opc.ledGrid(7 * 128, pW, pH, width * 3/4, height * 7/pH, width/w, height/h, 0, true);
  */
  
  opc.ledGrid(0, w, h, width * 1/2, height * 1/2, width/w, height/h, 0, true);
  
  opc.setStatusLed(false);
}

void draw()
{
  float hue = (noise(millis() * 0.0001) * 200) % 100;
  float z = millis() * 0.001;
  float dx = millis() * 0.001;

  for (int x=0; x < clouds.width; x++) {
    for (int y=0; y < clouds.height; y++) {
      float n = 320 * (noise(dx + x * 0.01, y * 0.01, z) - 0.4);
      color c = color(hue, 80 - n, n);
      clouds.pixels[x + clouds.width*y] = c;
    }
  }
  clouds.updatePixels();

  image(clouds, 0, 0, width, height);
}
