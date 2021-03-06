// Some real-time FFT! This visualizes music in the frequency domain using a
// polar-coordinate particle system. Particle size and radial distance are modulated
// using a filtered FFT. Color is sampled from an image.
// demo song of the progressive violin metal band "Ally the Fiddle"

import ddf.minim.analysis.*;
import ddf.minim.*;

OPC opc;
PImage dot;
PImage colors;
Minim minim;
AudioPlayer sound;
FFT fft;
float[] fftFilter;

String filename = "AllyTheFiddle-Lost_at_the_Gates.mp3";//"song.mp3";//AllyTheFiddle-Lost_at_the_Gates.mp3";

float spin = 0.001;
float radiansPerBucket = radians(20);
float decay = 0.90;
float opacity = 75;
float minSize = 0.1;
float sizeScale = 0.6;

void setup()
{
  size(300, 300, P3D);
  minim = new Minim(this); 

  // Small buffer size!
  sound = minim.loadFile(filename, 512);
  sound.loop();
  fft = new FFT(sound.bufferSize(), sound.sampleRate());
  fftFilter = new float[fft.specSize()];

  dot = loadImage("dot.png");
  colors = loadImage("colors.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.ledGrid(0, 30, 30, width * 1/2, height * 1/2, height/30, height/30, 0, true);
  // Make the status LED quiet
  opc.setStatusLed(false);
}

void draw()
{
  background(0);

  fft.forward(sound.mix);
  for (int i = 0; i < fftFilter.length; i++) {
    fftFilter[i] = max(fftFilter[i] * decay, log(1 + fft.getBand(i)));
  }
  
  for (int i = 0; i < fftFilter.length; i += 3) {   
    color rgb = colors.get(int(map(i, 0, fftFilter.length-1, 0, colors.width-1)), colors.height/2);
    tint(rgb, fftFilter[i] * opacity);
    blendMode(ADD);
    //float spin = 0.005* log(fftFilter[i]);
    float size = height * (minSize + sizeScale * fftFilter[i]);
    PVector center = new PVector(width * (fftFilter[i] * 0.35), 0);
    center.rotate(millis() * spin + i * radiansPerBucket);
    center.add(new PVector(width * 0.5, height * 0.5));
    image(dot, center.x - size/2, center.y - size/2, size, size);
  }
}

