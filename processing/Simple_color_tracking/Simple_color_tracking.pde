import JMyron.*; 	
import hypermedia.video.*;
JMyron m;
OpenCV opencv;

color trackColor;
int w=320;
int currentColor;
int h=240;
int[] imgOCV;
 
void setup()
{
  
  size(320,240);//your code here: create the canvas
  
  m = new JMyron(); //your code here: start jMyron camara capture
  m.start(width,height); //start a capture en 320x240
  opencv = new OpenCV(this);//your code here: create an empty mage buffer in opencv
  opencv.allocate( width, height ); 
  trackColor = color(255,0,0);
}

void draw()
{
  m.update();//your code here: take the jMyron data and pass it to opencv
  int[] img = m.image();
  opencv.copy(img,width,0,0,width,height,0,0,width,height);
  image(opencv.image(),0,0);  //your code here: draw the image data with openCV 
  imgOCV = opencv.pixels(); //your code here: copy data from OpenCV to intArray
  
  
  float worldRecord = 500; 

  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < w; x ++ ) {
    for (int y = 0; y < h; y ++ ) {
      int loc = x+y*width;// your code here: get the current pixel location
        //loadPixels();
      currentColor = imgOCV[loc]; // your code here: get the color at the current pixel location 
      
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = dist(r1,g1,b1,r2,g2,b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestX = x;
        closestY = y;
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (worldRecord < 10) { 
    // Draw a circle at the tracked pixel
    fill(trackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(closestX,closestY,16,16);
  }
  

}

void mousePressed() {
  int loc = mouseX + mouseY*w;
  trackColor = color(imgOCV[loc]);// your code here: save color where the mouse is clicked in trackColor variable
}
