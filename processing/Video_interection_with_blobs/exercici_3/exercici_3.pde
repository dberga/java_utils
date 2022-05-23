import hypermedia.video.*;
import java.awt.*;
import JMyron.*;  
import processing.video.*;

JMyron m;
OpenCV opencv;
Movie myMovie;

int w = 320;
int h = 240;
int threshold = 80;
int movieStatus = 0;

boolean find=true;

PFont font;

void setup() {

    size( w*2+30,h*3+40 );

    m = new JMyron();
    m.start(w,h); 
    opencv = new OpenCV( this );
    opencv.allocate(w,h);
    
    font = loadFont( "AndaleMono.vlw" );
    textFont( font );

    println( "Drag mouse inside sketch window to change threshold" );
   println( "Press space bar to record background image" );
   
   
  myMovie = new Movie(this,"station.mov"); 
  myMovie.frameRate(25); 
  myMovie.loop(); 
  myMovie.play(); 
}



void draw() {

    int[]cleanPx= new int[w*h];
    opencv.copy(cleanPx,w,0,0,w,h,0,0,w,h);
 
    m.update();
    int[] img = m.image(); 
    opencv.copy(img,w,0,0,w,h,0,0,w,h);
  
    image( opencv.image(), 10, 10 );	            // RGB image
    image( opencv.image(OpenCV.GRAY), 20+w, 10 );   // GRAY image
    image( opencv.image(OpenCV.MEMORY), 10, 20+h ); // image in memory

    opencv.absDiff(); 
    opencv.threshold(threshold);
    image( opencv.image(OpenCV.GRAY), 20+w, 20+h ); // absolute difference image
    image(myMovie,10, 2*(h+15), 2*(w+3),3*(h/3));//a veces al renderizar da errores y otras no. Dice que nos encontramos
    // fuera de los limites del array aunque el video esta dentro de los limites del sketch

    // working with blobs
    Blob[] blobs = opencv.blobs( 100, w*h/3, 20, true );
    reproducir(blobs); //interaccion con blobs
    noFill();

    pushMatrix();
    translate(20+w,20+h);
    
    for( int i=0; i<blobs.length; i++ ) {

        Rectangle bounding_rect	= blobs[i].rectangle;
        float area = blobs[i].area;
        float circumference = blobs[i].length;
        Point centroid = blobs[i].centroid;
        Point[] points = blobs[i].points;

        // rectangle
        noFill();
        stroke( blobs[i].isHole ? 128 : 64 );
        rect( bounding_rect.x, bounding_rect.y, bounding_rect.width, bounding_rect.height );


        // centroid
        stroke(0,0,255);
        line( centroid.x-5, centroid.y, centroid.x+5, centroid.y );
        line( centroid.x, centroid.y-5, centroid.x, centroid.y+5 );
        noStroke();
        fill(0,0,255);
        text( area,centroid.x+5, centroid.y+5 );


        fill(255,0,255,64);
        stroke(255,0,255);
        if ( points.length>0 ) {
            beginShape();
            for( int j=0; j<points.length; j++ ) {
                vertex( points[j].x, points[j].y );
            }
            endShape(CLOSE);
        }

        noStroke();
        fill(255,0,255);
        text( circumference, centroid.x+5, centroid.y+15 );

    }
    popMatrix();

}

void keyPressed() { //En aquesta funció guardem la imatge a memoria quan apretem la barra espaiadora
    if ( key==' ' ){
    m.update(); //actualitzem la imatge del objecte m
    int[] img = m.image(); //carreguem la imatge (pixels) a un vector
    opencv.copy(img,w,0,0,w,h,0,0,w,h);
    image( opencv.image(OpenCV.MEMORY), 20+w, 20+h );//imatge a memoria      
    opencv.remember(1); //Apretant la barra espaiadora, fem la captura de la imatge a memoria (pantalla 3)
    
    } 
}

void mouseDragged() {
    threshold = int( map(mouseX,0,width,0,255) );
}

public void stop() {
    opencv.stop();
    super.stop();
}

void reproducir(Blob[] blobs){ //esta funcion controla la interaccion con los blobs

if ((blobs.length>0)) { //si hay blobs en la camara se reproduce el video
            myMovie.play();
        }
else if((blobs.length==0)){ //si no hay blobs en la camara se para el video
     myMovie.pause();
}
}
