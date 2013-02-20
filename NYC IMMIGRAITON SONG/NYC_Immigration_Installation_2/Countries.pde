
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
  
void playNote(float pop) { 
  scaledNoteLength = int(map(pop,0,32000,tempo,tempo/500));
    
    
   // if(tempo>70){
   
 //   cipher.repeat(map(pop,0,32000,0,tempo));
   // cipher.repeat(map(pop,0,32000,0,32));
 
 if(pop!=0){
 cipher.playNote(midiNote,127,noteLength);

 //lineDraw=true;
 highlight=true;
 noteMark=millis();
  }

// }
 
 /*
 else
 cipher.playNote(midiNote,127,map(pop,0,32000,0,.5));
// lineDraw=true;
 highlight=true;
 */
    
  }
 
 void noteOff(){
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
