// Some real-time FFT! This visualizes music in the frequency domain using a
// polar-coordinate particle system. Particle size and radial distance are modulated
// using a filtered FFT. Color is sampled from an image.

import ddf.minim.analysis.*;
import ddf.minim.*;

OPC opc;
PImage dot;
PImage colors;
Minim minim;
AudioInput in;
FFT fft;
float[] fftFilter;

float spin = 0.001;
float radiansPerBucket = radians(1);
float decay = 0.90;
float opacity = 10;
float minSize = 0.1;
float sizeScale = 0.6;

void setup()
{
  size(300, 300, P3D);

  minim = new Minim(this); 

  // Small buffer size!
  in = minim.getLineIn();

  fft = new FFT(in.bufferSize(), in.sampleRate());
  fftFilter = new float[fft.specSize()];

  dot = loadImage("dot.png");
  colors = loadImage("colors3.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.ledGrid(0, 30, 30, width * 1/2, height * 1/2, height/30, height/30, 0, true);
  // Make the status LED quiet
  opc.setStatusLed(false);
}

void draw()
{
  background(0);

  fft.forward(in.mix);
  for (int i = 0; i < fftFilter.length; i++) {
    fftFilter[i] = max(fftFilter[i] * decay, log(1 + fft.getBand(i)));
  }
 
  for (int i = 0; i < fftFilter.length; i += 3) {   
    color rgb = colors.get(int(map(i, 0, fftFilter.length-1, 0, colors.width-1)), colors.height/2);
    tint(rgb, fftFilter[i] * opacity);
    blendMode(ADD);
 
    float size = height * (minSize + sizeScale * fftFilter[i]);
    PVector center = new PVector(width * (fftFilter[i] * 0.2), 0);
    center.rotate(millis() * spin + i * radiansPerBucket);
    center.add(new PVector(width * 0.5, height * 0.5));
 
    image(dot, center.x - size/2, center.y - size/2, size, size);
  }
}
/*
void clearPattern(){}
void pausePattern() { if (pauseTime == 0){pauseTime = millis();}else{pauseTime = 0;} }


void keyPressed()
{
  if (keyCode == DELETE) clearPattern();
  if (key == ' ') pausePattern();
}
*/
