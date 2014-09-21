// Minim library
import ddf.minim.*;

// Sound frequency
import ddf.minim.analysis.*;

/**
 * Class Visualizer
 *
 * Creates particle system sensitive to the
 * amplitude and frequency of the input
 */
public class Visualizer {
  Minim minim;
  AudioInput input;
  FFT fft;
  
  float amplitudeMagnitude = 1000; // Default 
  
  int windowHeight;
  int windowWidth;
  int visualizerWidth;

  public Visualizer(int windowHeight, int windowWidth, int visualizerWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.visualizerWidth = visualizerWidth;

    minim = new Minim(this);
  
    input = minim.getLineIn(Minim.STEREO, 512);
    fft = new FFT(input.bufferSize(), input.sampleRate());
    
  }

  /**
   * Visualization
   */
  public void draw() {
    fft.forward(input.mix);

    noStroke();

    // Config background
    fill(0, 0, 0, 10);
    rect(0, 0, visualizerWidth, height);
    
    for (int i = 0; i < 3; i++) {
      fill(random(0, 255), random(0, 255), random(0, 255));
      
      float amplitude = (input.mix.get(1) * amplitudeMagnitude);
      float frequency = (fft.getBand(1) * 30);

      ellipse(random(i, width), (height / 2) - amplitude, frequency, frequency);
    }
  }

  /**
   * Mouse input
   */
  public void mouseClick() {
    // TODO - check within();
    background(random(0, 255), random(0, 255), random(0, 255));
  }
  
  public void update(float amplitudeMagnitude) {
    this.amplitudeMagnitude = 2000 * amplitudeMagnitude; // Scale by 2000
    System.out.println(this.amplitudeMagnitude);
  }
}
