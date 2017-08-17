/** Jake falling! : Hackaton procedural Liquid Squad 2017

Tematica: Libro La torre oscura (Stephen King)

Escena de la caida de Jake.

Apoyos:

- Teoria del caos: Atractores extraños - Roessler - Basado en https://www.openprocessing.org/sketch/47994#
- Saul Bass (diseñador) en su trabajo para Vertigo.
- El tiempo se mueve: Acceso a un servidor de NTP para adquirir el delay del paquete udp (RUIDO)
- Mundos en dimensiones paralelas

**/

PFont font;
PImage jake;
PImage roland;
PShape boxShape;

nucelar ruidoNucelar;

int fase = 1;
boolean perspectivaOn = false;

logisticMap myLogistic;
henonMap myHenon;
roesslerAttractor myRoessler;
float[][] henonPoints;
float[][] logisticPoints;
float[][] roesslerPoints;
int numX=10,numY=10;

float b=0;
float rotX=0,rotY=0;
void setup(){

  size(800,600,P3D);
 
  hint(ENABLE_DEPTH_SORT);
 
  font = createFont("Vertigon", 48);
  textFont(font);
  textAlign(CENTER, CENTER);
  
  jake = loadImage("jake4.png");
  roland = loadImage("roland.png");
  boxShape = createShape(BOX, width/30);
  boxShape.setTexture(jake);
  boxShape.setStroke(#FF0000);
  
  nucelar ruidoNucelar = new nucelar();
  //ruidoNucelar.hazRuido();
  b= ruidoNucelar.getRuido();
  
  myLogistic=new logisticMap(0.1);
  myHenon=new henonMap(1.5,0.3);
  myRoessler=new roesslerAttractor(0.2,0.2,5.7);
  logisticPoints=new float[numX][1];
  henonPoints=new float[numX*numY][2];
  roesslerPoints=new float[numX*numY*numX][3];
  for(int i=0;i<numX;i++){
    for(int j=0;j<numY;j++){
      for(int k=0;k<numX;k++){
        float lambdaX=(float) i/(float) (numX-1);
        float lambdaY=(float) j/(float) (numY-1);
        float lambdaZ=(float) k/(float) (numX-1);
        float x=(-1)*(1-lambdaX)+(1)*lambdaX;
        float y=(-1)*(1-lambdaY)+(1)*lambdaY;
        float z=(-1)*(1-lambdaZ)+(1)*lambdaZ;
        roesslerPoints[i+numX*j+numX*numY*k]=new float[]{x,y,z};
      }
    }
  }
 
  for(int i=0;i<numX;i++){
    float x=(float) i/(float) (numX-1);
    logisticPoints[i]=new float[]{x};
  }
  
  for(int i=0;i<numX;i++){
    for(int j=0;j<numY;j++){
      float lambdaX=(float) i/(float) (numX-1);
      float lambdaY=(float) j/(float) (numY-1);
      float x=(1-lambdaX)*(-1)+lambdaX*1;
      float y=(1-lambdaY)*(-1)+lambdaY*1;
      henonPoints[i+j*numX]=new float[]{x,y};
     }
   }
 }

void mouseDragged(){
  perspectivaOn = true;
  rotX=(float) mouseX/(float) width;
  rotY=(float) mouseY/(float) height;
}

void keyPressed(){
  
  if (fase < 4) {
    fase++;
  } else {
    fase = 1;
  }
  
  
}

void particulas() {

  translate(width/2,height/2,0);
  rotateX(TWO_PI*rotY);
  rotateY(-TWO_PI*rotX);
  
  stroke(255);
  noFill();
  
  //shape(boxShape);
  
  myRoessler.setParameters(new float[]{0.1,0.4,b});
  for(int i=0;i<numX*numY*numX;i++){
    //float[] p=roesslerPoints[i];
    float[][] orb=myRoessler.orbit(roesslerPoints[i],150);
    for(int j=0;j<orb.length;j++){
       float[] oPoint=orb[j];
     
       
       if (round(random(10000/2)) == 1) {
         
         pushMatrix();
         translate(0, 0,oPoint[2]*(width/6));
         if (perspectivaOn) {
           rotateY(b);
           rotateZ(b/2);
         }
         image(jake, oPoint[0]*(width/6),oPoint[1]*(width/6), jake.width/b, jake.height/b);
         popMatrix();
       } 
       
       point(oPoint[0]*(width/6),oPoint[1]*(width/6),oPoint[2]*(width/6)); 
    }
  }
    //boxShape.rotateX(b);
    //boxShape.rotateY(b);
    //boxShape.rotateZ(b);
    
    b+=0.1;
    
    if(b>14)
      b=0;
  
}

void intro(){
  image(jake, width*3/4, height/2);
  image(roland, width/20, height/4);
  textSize(48);
}

void intro2(){
  textSize(24);
  text("Has olvidado el rostro de tu padre.", width/2+50, height/3);
  textSize(48);
}

void intro3(){
  textSize(32);
  text("Vete, pues, hay otros mundos aparte de este...", width/4, height/2-50, width/2, 200);
  textSize(48);
}


void draw(){
  background(#FF0000);
  text("Jake falling!", width/4, height/12);
  textFont(font, 36);
  text("HACKATHON PROCEDURAL", width/2, height*11/12);
  
   switch(fase) {
    case 1: 
      intro();
      break;
    case 2:
      intro();
      intro2();
      break;
    case 3:
      intro();
      intro2();
      intro3();
      break;
    case 4:
      particulas();
      break;
  }    
}