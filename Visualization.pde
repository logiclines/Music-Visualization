import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
//import processing.video.*;

String artist = "Karnivool";
String track = "Goliath";
int numparticles =10000;
particle[] particles;
boolean flag = true;
FFT fftLog1;
Minim minim;
AudioPlayer song;
PFont f;

void setup()
{
  //size(600,400);
  f = createFont("Arial",24,true);
  size(displayWidth, displayHeight,P3D);

  background(255);
  noStroke();
  smooth();
  rectMode(CENTER);
  minim = new Minim(this);
  song = minim.loadFile("123.mp3");
  song.play();
  particles = new particle[numparticles];
  for(int i=0; i<numparticles; i++)
  {
    particles[i] = new particle(random(50, width-20), random(50, height-20), 1, 1, 1, 0.9,
                             color(random(0,255), random(0,255), random(0,255), 255));
  }
  fftLog1 = new FFT(song.bufferSize(),song.sampleRate()); 
}
 
void draw()
{
  background(0);
  fftLog1.forward(song.mix);
  for(int i=0; i<fftLog1.specSize(); i++)
  {
    particles[i].collide();
    particles[i].move();
    particles[i].render();
    particles[i].xspeed*=(particles[i].dampfactor);
    particles[i].yspeed*=(particles[i].dampfactor);
    float band = fftLog1.getBand(i);
    float vo = width - band * 512;
    ellipse(displayWidth/2, displayHeight/2, vo/32, vo/32);
    ellipse(displayWidth/2, displayHeight/2, band/32, band/32);
    stroke(random(0,55), random(0,55), random(0,55), 50);
  }
  
  fill(127);
  textFont(f,14); 
  textMode(SHAPE);
  textMode(MODEL);
  textAlign(CENTER);
  
  textFont(f,32); 
  fill(127,123,50);
  text(artist,width/2,height/4);
  text(track,width/2,3*height/4);
  //saveFrame("line-######.png");
}

boolean sketchFullScreen() {
  return true;
}
