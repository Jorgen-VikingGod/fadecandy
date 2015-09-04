import ddf.minim.analysis.*;
import ddf.minim.*;
OPC opc;
PImage dot1, dot2;

Minim minim;
AudioInput in;
FFT fft;
float[] fftFilter;
float decay = 0.98;

void setup()
{
  size(300, 300);
  frameRate(20);
  
    minim = new Minim(this); 

  // Small buffer size!
  in = minim.getLineIn();

  fft = new FFT(in.bufferSize(), in.sampleRate());
  fftFilter = new float[fft.specSize()];

  dot1 = loadImage("greenDot.png");
  dot2 = loadImage("purpleDot.png");

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.ledGrid(0, 30, 30, width * 1/2, height * 1/2, height/30, height/30, 0, true);
  // Map an 8x8 grid of LEDs to the center of the window, scaled to take up most of the space
  //float spacing = height / 14.0;
  //opc.ledGrid8x8(0, width/2, height/2, spacing, HALF_PI, false);
  // Make the status LED quiet
  opc.setStatusLed(false);
}

float px, py;

void draw()
{
  background(0);
  blendMode(ADD);
  
  fft.forward(in.mix);
  for (int i = 0; i < fftFilter.length; i++) {
    fftFilter[i] = max(fftFilter[i] * decay, log(1 + fft.getBand(i)));
  }
  
  for (int i = 0; i < fftFilter.length; i += 3) {
      
  // Smooth out the mouse location
    //px += (fftFilter[i] - px);// * 0.1;
    //py += (fftFilter[i] - py);// * 0.1;
    px = fftFilter[i] * 50;
    py = fftFilter[i] * 50;

    float a = fftFilter[i] * 2;
    float r = py * 0.4;
    float dotSize = r * 2;  

    float dx = width/2 + cos(a) * r;
    float dy = height/2 + sin(a) * r;
  
    // Draw it centered at the mouse location
    image(dot1, dx - dotSize/2, dy - dotSize/2, dotSize, dotSize);

    // Another dot, mirrored around the center
    image(dot2, width - dx - dotSize/2, height - dy - dotSize/2, dotSize, dotSize);
  }
}

