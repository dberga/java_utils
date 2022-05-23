/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Camera Features:
 * <ul>
 * <li>Interface for built-in camera</li>
 * <li></li>
 * </ul>
 * <p>Updated: 2012-03-10 Daniel Sauter/j.duran</p>
 */

import ketai.camera.*;
import saito.objloader.*;

KetaiCamera cam;
OBJModel model ;

void setup() {
  orientation(LANDSCAPE);
  imageMode(CENTER);
  
  size(displayWidth,displayHeight,P3D);
  colorMode(RGB, 100);
  cam = new KetaiCamera(this, 320, 240, 24);
  
  model = new OBJModel(this, "dma.obj", "absolute", POLYGON);
  //model.scale(2); // MODELS OFTEN NEED TO BE SCALED
  model.translateToCenter();
}

void draw() {
  image(cam, width/2, height/2);
  
  lights();
  fill(0,100,100);
   translate(0,0,40);
    //box(40);
    rotateX(radians(-90));
    model.draw();
  
  
}

void onPause()
{
  super.onPause();
  //Make sure to releae the camera when we go
  //  to sleep otherwise it stays locked
  if (cam != null && cam.isStarted())
    cam.stop();
}

void onCameraPreviewEvent()
{
  cam.read();
}

void exit() {
  cam.stop();
}

// start/stop camera preview by tapping the screen
void mousePressed()
{
  if (cam.isStarted())
  {
    cam.stop();
  }
  else
    cam.start();
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == MENU) {
      if (cam.isFlashEnabled())
        cam.disableFlash();
      else
        cam.enableFlash();
    }
  }
}

