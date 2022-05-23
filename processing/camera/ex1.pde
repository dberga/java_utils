import JMyron.*;  //Importa les llibreries de processament de JMyron
import hypermedia.video.*; //Importa les llibreries de processament de OpenCV

JMyron m;//Declara l'objecte principal per als processos de JMyron d'us de camara
OpenCV opencv; //Declara l'objecte principal per als processos de OpenCV de processament de visió
void setup()
{
  size(320,240); //Defineix el tamany de la finestra en píxels. Amplada i altura en anglès width i height
  m = new JMyron(); //Crea un nou objecte per usar els processos JMyron per la càmara
  m.start(width,height); //start a capture en 320x240
  opencv = new OpenCV(this); //Usa per crear un nou objecte principal OpenCV per als els processos de visió
  opencv.allocate( width, height ); //Reserva el buffer necessari per la dimensio que hem especificat
}
void draw()
{
  m.update(); //Es crida un cop per fotograma per tal d'executar el processament de la visio i actualitzacio de la camara
  int[] img = m.image(); //Forma un array de enters amb la informacio dels pixels dels fotogrames que rep la camara
  //loadPixels(); //Es un metode de processing que carrega la informacio de pixels al array de pixels de la finestra 
  opencv.copy(img,width,0,0,width,height,0,0,width,height); //Copia el fotograma en el buffer i especifiquem les dimensions de la copia, en aquest cas sera de tamany igual a la del setup
  //updatePixels(); //Actualitza el que hi ha a la finestra amb la informacio de l'array de pixels
  opencv.ROI( 0, 0, width/2, height ); //Isolem un espai concret de la imatge, en aquest cas partim la imatge en 2 parts
  opencv.invert(); //Invertim els colors de la imatge
  image(opencv.image(),0,0); //Mostra la imatge que hi ha en el buffer, que es el que veiem per la camara
}
