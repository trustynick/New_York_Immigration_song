

//variables setup


#define numOutputs 32
#define firstPin 22 //what's the first pin
int lowNote = 36; //what's the firs note?
int numOuts = numOutputs; //how many outputs

byte incomingByte;
byte note;
byte velocity;

//set midi channel
int chan = 1;


int statusLed = 13;   // select the pin for the LED

int action=2; //0 =note off ; 1=note on ; 2= nada

long noteStart[numOutputs+firstPin];
int timeout = 3000;
boolean noteOn[numOutputs+firstPin];

//setup: declaring iputs and outputs and begin serial
void setup() {
  pinMode(statusLed,OUTPUT);   // declare the LED's pin as output

//assign output 
  for(int i=firstPin; i<firstPin+numOuts; i++){
  pinMode(i, OUTPUT);
  digitalWrite(i, LOW);
  }

  
  //start serial with midi baudrate 31250 or 38400 for debugging
  Serial.begin(38400);        
  //digitalWrite(statusLed,HIGH);  
}

//loop: wait for serial data, and interpret the message
void loop () {
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.read();

    // wait for as status-byte, channel 1, note on or off
    if (incomingByte== 143+chan){ // note on message starting starting
      action=1;
    }else if (incomingByte== 127+chan){ // note off message starting
      action=0;
    }else if (incomingByte== 207+chan){ // aftertouch message starting
       //not implemented yet
    }else if (incomingByte== 159+chan){ // polypressure message starting
       //not implemented yet
    }else if ( (action==0)&&(note==0) ){ // if we received a "note off", we wait for which note (databyte)
      note=incomingByte;
      playNote(note, 0);
      note=0;
      velocity=0;
      action=2;
    }else if ( (action==1)&&(note==0) ){ // if we received a "note on", we wait for the note (databyte)
      note=incomingByte;
    }else if ( (action==1)&&(note!=0) ){ // ...and then the velocity
      velocity=incomingByte;
      playNote(note, velocity);
      note=0;
      velocity=0;
      action=0;
    }else{
      //nada
    }
  }
  //check for timeout
   notesTimeout();
  
  
}

void blink(){
  digitalWrite(statusLed, HIGH);
  delay(100);
  digitalWrite(statusLed, LOW);
  delay(100);
}


void playNote(byte note, byte velocity){
  int value=LOW;
  if (velocity >10){
      value=HIGH;
  }else{
   value=LOW;
  }

 //since we don't want to "play" all notes we wait for a note in range

 if(note>=lowNote && note<lowNote+numOuts){
   byte myPin=note-(lowNote-firstPin); // to get a pinnumber within note range
   digitalWrite(myPin, value);
   
   if(value==HIGH){
   noteStart[myPin] = millis();
   noteOn[myPin] = true;
   }
   if(value==LOW){
   noteOn[myPin] = false;
   }
   
 }
}


void notesTimeout(){

  for(int i; i<numOutputs+firstPin; i++){
  if(millis() - noteStart[i]>timeout &&  noteOn[i] == true){
  digitalWrite(i, LOW);
  noteOn[i] == false;
  }

}
}
