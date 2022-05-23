import processing.video.*; //importa, carrega la llibreria de video de Processing 
import processing.opengl.*;
import JMyron.*; 	
import hypermedia.video.*;
JMyron m;
OpenCV opencv;

int currentPeli=0;
float pelitime = 0;
Movie[] pelis = new Movie[3];

color trackColor;
int w=320;
int currentColor;
int h=240;
int[] imgOCV;
int i=0;




void setup()
{
  
  
  size(w,2*(h+10)); 
  m = new JMyron(); 
   
   m.start(w,h); 
  
  opencv = new OpenCV(this); 
  opencv.allocate( w, h ); 
  trackColor = color(255,0,0);
   
   
   pelis[0] = new Movie(this,"station.mov"); 
   pelis[1] = new Movie(this,"station2.mov");
   pelis[2] = new Movie(this,"station3.mov");
   pelis[currentPeli].play();
   pelis[currentPeli].loop();
   pelis[1].stop();
   pelis[1].loop();
   pelis[2].stop();
   pelis[2].loop();
   
}

void draw()
{
  m.update(); 
  
  int[] img = m.image();
   
  opencv.copy(img,w,0,0,w,h,0,0,w,h);
  image(opencv.image(),10,10,w-20,h-10);
  image(pelis[currentPeli],10,20+h,w-20,h-10); //a veces al renderizar da errores y otras no. Dice que nos encontramos
 // fuera de los limites del array aunque el video esta dentro de los limites del sketch
  imgOCV = opencv.pixels();
  pelis[currentPeli].read(); // Read the new frame from the camera
  pelis[currentPeli].loadPixels();
  
  float worldRecord = 500; 

  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < w; x ++ ) {
    for (int y = 0; y < h; y ++ ) {
      
        int loc = x+y*width;
      
       //loadPixels();
       
       currentColor = imgOCV[loc];
       
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
  
   colorInterection(); //funcion que controla la interaccion segun el volor trackeado 
   if(pelis[currentPeli].time()==pelis[currentPeli].duration())
     nextPeli(); 
}

void mousePressed() {
  int loc = mouseX + mouseY*w;
  trackColor = color(imgOCV[loc]);
  i++;//controla los clicks del raton realizados
}


void colorInterection(){ //segun cual es la componente que predomina más en el color que trackeamos se realizara una interacción u otra
  if(i>0){ //no queremos que entre en las condiciones de interraciçon hasta que no se haya trackeado por primera vez y lo controlamos con la variable i
    if ((green(trackColor)>red(trackColor)) && (green(trackColor)>blue(trackColor))){ //si la componente predominante es el verde
        currentPeli=1; //indicamos que clip que sera reproducido
        pelis[currentPeli].jump(random( pelis[currentPeli].duration())); //saltamos de un fotograma a otro del clip
    
    }
  
   if ((red(trackColor)>green(trackColor)) && (red(trackColor)>blue(trackColor))){ //si la componente predominante es el rojo
           currentPeli=2; //indicamos que clip que sera reproducido
            pelis[currentPeli].speed(0.5); //disminuimos la velocidad del clip que se esta reproduciendo
    
    }
  
    if ((blue(trackColor)>red(trackColor)) && (blue(trackColor)>green(trackColor))){ //si la componente predominante es el azul
          currentPeli=0; //indicamos que clip que sera reproducido
          pelis[currentPeli].speed(4.0);  //augmentamos la velocidad del clip que se esta reproduciendo
      }  
  }
}

void nextPeli(){
  pelis[currentPeli].stop();
      if(currentPeli<2)
      {
        currentPeli++;
      }
      else
      {
        currentPeli=0;
      }
   pelis[currentPeli].jump(0);
   pelis[currentPeli].play();
}
  
