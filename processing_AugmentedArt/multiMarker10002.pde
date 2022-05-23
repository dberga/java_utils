

import jp.nyatla.nyar4psg.*;
import ketai.camera.*;
import saito.objloader.*;
import processing.opengl.*;
//import ketai.sensors.*;

OBJModel model ;
OBJModel model2 ;

PImage boton1;
PImage exit;

PImage logo;
//PImage img;
boolean portada;
int capturado;
int capturado2;
KetaiCamera cam;
MultiMarker nya;
float rota;
float rotX;
float rotY;
//KetaiSensor sensor;
boolean loaded1;
boolean loaded2;
boolean esperar;
float seconds;
String s[]=new String[100];


void setup() {
    orientation(LANDSCAPE);
      imageMode(CENTER);
      
  size(displayWidth,displayHeight,P3D);
  frameRate(60);
 // sensor = new KetaiSensor(this);
  //sensor.start();
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);  
  cam = new KetaiCamera(this, width, height, 60);
  
  nya=new MultiMarker(this,displayWidth,displayHeight,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro",80);//id=0
  nya.addARMarker("patt.kanji",80);//id=1
 
  
  

  loaded1 = false;
  loaded2 = false;
  boton1= loadImage("Camera.png");
  boton1.resize(80,80);
  exit = loadImage("exit.png");
  exit.resize(80,80);

  logo= loadImage("logo.png");

 

    stroke(255);
    noStroke();
  
 
  
  
  
 
  rota=0;
  capturado = 0;
  capturado2 = 0;
  rotX = 0;
  rotY = 0;
  //model.disableTexture();
  
  background(0,0,240);
  image(logo,width/2,height/2);
  
  
  textSize(40);
  fill(0, 240, 0);
  rotate(-1.57);
  text("Augmented Art", -(width*0.63), 100);
  textSize(30);
  fill(0, 0, 0);
  //rotate(1.57);
  text("Touch the screen \n to start capturing", -(width*0.62), 380);
  esperar = false;
  portada=true;
}



void draw()
{


  if(!esperar){
      
      image( cam, width/2, height/2);
      if(capturado==0 && capturado2==0){
        
         nya.detect(cam);
         if((nya.isExistMarker(0))){
           textSize(32);
            fill(0, 240, 0);
            rotate(-1.57);
            text("loading model1",-(width*0.62),380);
           cam.stop();
           capturado=1;
         }else if((nya.isExistMarker(1))){
           textSize(32);
            fill(0, 240, 0);
            rotate(-1.57);
            text("loading model2",-(width*0.62),380);
           cam.stop();
           capturado2=1;
         }else{
         }
      }else if(capturado == 1 && capturado2 == 0){
       
         render1();
         texto1();
      }else if(capturado== 0 && capturado2 == 1){
         
        render2();
         texto2();
      }else{
       //nada 
      }
  }else{
       
  
  }


  
}  


void loadModel1(){

   model = new OBJModel(this, "map_ground_path_s.obj", "relative", QUADS);
  model.enableDebug();
  
 model.scale(100);
    model.translateToCenter();
  
    loaded1=true;
}

void loadModel2(){

   model2 = new OBJModel(this, "pyramid.obj", "absolute", TRIANGLES); //scale a 0.75,  rotateX(-1.57); rotateZ(-0.5); rotateY(rotY); roty+=0.1; translate z(40)
  model2.enableDebug();
  
 model2.scale(0.75);
    model2.translateToCenter();
  
    loaded2=true;
    
}

void render1(){
     if(!loaded1) loadModel1();
      lights();
      pushMatrix();
      
      translate(120, height/2+20, 40);
      rotateX(-1.57);
      rotateZ(-0.5);
      rotateX(rotX);
      rotateY(rotY);
      //model.texture(img);
     
      model.draw();
      popMatrix();
      
      //rotX+=0.1;
      //rotY+=0.1;
      
       fill(0, 240, 0);
      image(boton1,40,40);
      image(exit,width-40,height-40);
}

void render2(){
      if(!loaded2) loadModel2();
      lights();
      pushMatrix();
      
      translate(120, height/2+20, 40);
      rotateX(-1.57);
      rotateZ(-0.5);
      rotateX(rotX);
      rotateY(rotY);
      //model.texture(img);
     
      model2.draw();
      popMatrix();
      
      //rotX+=0.1;
      //rotY+=0.1;
      
       fill(0, 240, 0);
      image(boton1,40,40);
      image(exit,width-40,height-40);
}

void texto1(){
  
 s[0]="Ubicación: Chile";
  s[1]="Nombre: Casa de la abuela";
  s[2]="Año Creación: 9999 a.C";
  s[3]="Medidas: 2 metros de ancho";
  s[4]="          x 2 metros de alto";
  fill(0,0,0);
  rect(width*0.5, 2,120,height,30);
  fill(0,240,0);
  
  seconds=millis()/(float)1000;
  textSize(18);
  rotate(-1.57);
   for(int i=0;i<4;++i){

     if(seconds > i+30){
       text(s[i], -(width*0.64), 260+(i*15));
     }
     
       
   }
  
}

void texto2(){
  
 s[0]="Ubicación: Mexico";
  s[1]="Nombre: Chichén Itzá";
  s[2]="Año Creación: 525 d.C";
  s[3]="Medidas: 55.5 metros de ancho";
  s[4]="          x 24 metros de alto";
  fill(0,0,0);
  rect(width*0.5, 2,120,height,30);
  fill(0,240,0);
  
  seconds=millis()/(float)1000;
  textSize(18);
  rotate(-1.57);
   for(int i=0;i<4;++i){

     if(seconds > i+30){
       text(s[i], -(width*0.64), 260+(i*15));
     }
     
       
   }
   
  

  
}

void onCameraPreviewEvent()
{
  if(capturado==0 && capturado2==0){
    cam.read();
    
  }
}

/*
void onPause()
{

  super.onPause();
  //Make sure to releae the camera when we go
  //  to sleep otherwise it stays locked
  if (cam != null && cam.isStarted()){
    
    cam.stop();
  }
}
*/

void exit() {
  cam.stop();
  capturado = 0;
  capturado2 = 0;
  loaded1 = false;
  loaded2 = false;
  esperar = false;
  portada = true;
  
}

// start/stop camera preview by tapping the screen
void mousePressed()
{
  if(!portada){
    if(buttonrange(40,40,100,100)){
      if (cam.isStarted())
      {
    
      }
      else{
        
        esperar = true;
         capturado = 0;
        capturado2 = 0;
        if(loaded1) model.reset();
        if(loaded2) model2.reset();
        loaded1 = false;
        loaded2= false;
        setup();
        cam.start();
       esperar = false;
        
        
        
       
        
        
    
      }
    }else if(buttonrange(width-40,height-40,100,100)){
      exit();
      finish();
    }
  }else{
    portada = false;
    cam.start();
  }
}

boolean buttonrange(int butx, int buty, int butwidth, int butheight){
  if((mouseX <= butx+butwidth && mouseX >= butx)&&(mouseY <= buty+butheight && mouseY >= buty)){
    
    return true;
  }else
  return false;
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

void mouseDragged()
{
    rotX += (mouseX - pmouseX) * 0.01;
    rotY -= (mouseY - pmouseY) * 0.01;
}



