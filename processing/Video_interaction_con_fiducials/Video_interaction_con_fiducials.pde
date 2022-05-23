

// we need to import the TUIO library
// and declare a TuioProcessing client variable
import TUIO.*;
TuioProcessing tuioClient;
import processing.video.*; 
import processing.opengl.*; 
// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;
float angleActua;
float angleAnter=0;
float a=1;
int id;
int currentPeli=0;
float pelitime = 0;
Movie[] pelis = new Movie[3];
//al final tornar a canviar 640/480
int w=400;
int h=300;

void setup()
{
  //size(screen.width,screen.height);
  size(w,2*h, OPENGL);
  noStroke();
  fill(0);
  
  loop();
  frameRate(30);
  //noLoop();
  
  hint(ENABLE_NATIVE_FONTS);
  font = createFont("Arial", 18);
  scale_factor = height/table_size;
  
  // we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods (see below)
  tuioClient  = new TuioProcessing(this);
 
  
  pelis[0] = new Movie(this,"station.mov"); 
   pelis[1] = new Movie(this,"station2.mov");
   pelis[2] = new Movie(this,"sixties.mov");
   pelis[currentPeli].play();
   pelis[currentPeli].loop();
   pelis[1].stop();
   pelis[1].loop();
   pelis[2].stop();
   pelis[2].loop();
   
  
}

// within the draw method we retrieve a Vector (List) of TuioObject and TuioCursor (polling)
// from the TuioProcessing client and then loop over both lists to draw the graphical feedback.
void draw()
{
  background(255);
  image(pelis[currentPeli],10,20+h,w-20,h-10); 
  
  textFont(font,18*scale_factor);
  float obj_size = object_size*scale_factor; 
  float cur_size = cursor_size*scale_factor; 
  
  Vector tuioObjectList = tuioClient.getTuioObjects();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);
     stroke(0);
     fill(0);
     pushMatrix();
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     id=tobj.getSymbolID();
     
     //Ejecutamos nuestras funciones
     jumpastronauta(id, i);
     normalitat(i);
     angleActua=tobj.getAngle();
     slowfast(angleAnter, angleActua, id, i);
     playstop(id ,tobj, i);
     angleAnter=angleActua;
     
     
     if(pelis[currentPeli].time()==pelis[currentPeli].duration())
     nextPeli();
     rect(-obj_size/2,-obj_size/2,obj_size,obj_size);
     popMatrix();
     fill(255);
     text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
     
   }
   
   Vector tuioCursorList = tuioClient.getTuioCursors();
   for (int i=0;i<tuioCursorList.size();i++) {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      Vector pointList = tcur.getPath();
      
      if (pointList.size()>0) {
        stroke(0,0,255);
        TuioPoint start_point = (TuioPoint)pointList.firstElement();;
        for (int j=0;j<pointList.size();j++) {
           TuioPoint end_point = (TuioPoint)pointList.elementAt(j);
           line(start_point.getScreenX(width),start_point.getScreenY(height),end_point.getScreenX(width),end_point.getScreenY(height));
           start_point = end_point;
        }
        
        stroke(192,192,192);
        fill(192,192,192);
        ellipse( tcur.getScreenX(width), tcur.getScreenY(height),cur_size,cur_size);
        fill(0);
        text(""+ tcur.getCursorID(),  tcur.getScreenX(width)-5,  tcur.getScreenY(height)+5);
        
        
      }
   }
   
    
}

// these callback methods are called whenever a TUIO event occurs

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}

/*La funcion slowfast hace incrementar/disminuir la velocidad del video
captando el fiducial con id puesta (hemos escogido el 9) girando el fiducial */
void slowfast(float angleAnter, float angleActua, int id,int numero){
  if (numero==0){
  if(id==9){

  if(angleAnter > angleActua){
    pelis[currentPeli].play();
    a=a+0.3;
  pelis[currentPeli].speed(a);
    
  }
  else if(angleAnter < angleActua){
    pelis[currentPeli].play();
    a=a-0.3;
   pelis[currentPeli].speed(a); 
   
   if(pelitime == 0){
    pelis[currentPeli].speed(0.1);
  }
 
  
  }
}
}
}

/*La funcion playstop hace parar el video captando el fiducial con id puesta (hemos escogido el 2)
colocandolo en la parte superior de la pantalla de interaccion y continuar el video colocandolo en la parte inferior */
void playstop(int id ,TuioObject tobj, int numero){
  
 if (numero==0){
  if((id==2)&&(tobj.getY()<=0.500)){
   pelis[currentPeli].play();
  
    }
    else if((id==2)&&(tobj.getY()>=0.500)){
      pelis[currentPeli].stop();
}
}
}

/*La funcion jumpastronauta hace un jump hacia donde hay un video que aparece un astronauta cuando capta
el fiducial con la id puesta (hemos escogido el 0) */
void jumpastronauta(int id, int numero){
if (numero==0){
  if(id==0){
   pelis[currentPeli].jump(5);
}
}

}

/*La funcion normalitat lo que hace es poner el speed a condiciones normales y hacer play al video en caso que este parado
eso lo hace cuando hay 3 fiducials captados con la camara a la vez */
void normalitat(int numero){
if(numero==2){
  pelis[currentPeli].speed(1);
  pelis[currentPeli].play();
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
