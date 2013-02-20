
class country {

  
long noteMark;
int order=0;
int midiNote=0;


// int midiNote=int(random(50);
 
 
 float scaledNoteLength=0;
float noteLength=tempo;

boolean highlight=false;

  country() {
  }
  

 
 void noteOn(float pop) {
   scaledNoteLength = int(map(pop,0,50000,tempo/tempoRatio,tempo));    
  
  
   if(pop!=0 && playing == true){
    myPort.write(144);
    myPort.write(midiNote);
    myPort.write(127);

   highlight=true;
   noteMark=millis();
  }
  
  if(pop==0 && drum ==true){
    
 scaledNoteLength = tempo/tempoRatio;   
    
 //play drum
  myPort.write(128);  //128 = note off for channel 1
    myPort.write(drumNote);
    myPort.write(127);
    //drumMark
     noteMark=millis();
 }
  
  
 }
 
 
 void noteOff(){
 myPort.write(128);  //128 = note off for channel 1
    myPort.write(midiNote);
    myPort.write(0);
   
   highlight=false;
 
 
 }
 
 /*
 void getLineNote() {
     lineLength=dist(point1X,point1Y,point2X,point2Y);
    lineNote=map(lineLength,600/scaleAmount,1*scaleAmount,60,100);
  }
  
*/

void alphaUpdate(){

}

 

}



