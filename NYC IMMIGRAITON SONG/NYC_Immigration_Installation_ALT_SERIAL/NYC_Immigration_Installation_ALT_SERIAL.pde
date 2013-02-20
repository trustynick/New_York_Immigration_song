boolean debug = false;
boolean drum =false;


import processing.serial.*;

Serial myPort; //the serial port

import java.awt.AWTException;
import java.awt.Robot;

 
Robot robot;

/*
import arb.soundcipher.*;
SoundCipher cipher;
*/


//playback
boolean playing =false;

//fullres
int wt=1024; 
int ht=768;
int instr=1;


//tempo variables
float tempoLineXpos=150;
float tempoLineLength =250;
float tempoSliderXpos=tempoLineXpos+tempoLineLength/2;
float tempoYpos=(ht-50);
//min & max speeds
float tempoMax=1000;
float tempoMin=100;

int tempoRatio = 16; //  how we scale population to note length;


//float tempo=map(tempoSliderXpos,tempoLineXpos,tempoLineXpos+tempoLineLength,tempoMax,tempoMin);

float tempo=tempoMax/2;
float pTempo=tempo;

int counter=0;
int countryCounter=1;
long countryTimeMark=0;

long timeMark=0;
float transTempo=10;
long transMark=0;

int numYears=16;
int numCols=numYears+5;
int numEntries;
int numCountries=42;
int numRows=numCountries;

String[] allData;

//names fo countries
String[] origin= new String[numCountries];
int[][] population= new int[numYears][numCountries];
String[] cYear=new String[numYears];
String[][] masterGrid = new String[numCols+21][numRows+21];

//year lengths
int[] yearLength = new int[numYears];
int[] yearPop = new int[numYears];


int numLines=8;
int numSwell=5;
int bgCol=0;

//int clickCount;

//create country array
country[] countries = new country[numCountries];


//create fonts
PFont yearFont;
PFont countryFont;
PFont titleFont;
PFont countryFont_2;

float yearAlpha;

//image variables
PImage worldMap;

int fadeAlpha=int(map(yearAlpha, timeMark-millis(),tempo*numCountries,255,-150));


void setup(){
 // frameRate(10);
  size (wt,ht);


println(Serial.list());

String portName = Serial.list()[0];  
myPort = new Serial(this, portName, 38400);


noCursor();
centerMouse();  
//cipher= new SoundCipher();

//cipher.setMidiDeviceOutput(2);
 
 yearFont=loadFont("LetterGothicStd-BoldSlanted-100.vlw");
// countryFont=loadFont("Didot-12.vlw");
 countryFont=loadFont("HelveticaNeue-48.vlw");
// countryFont_2=loadFont("Didot-36.vlw");
 countryFont_2=loadFont("HelveticaNeue-48.vlw");
 
 titleFont=loadFont("OratorStd-24.vlw");


  background(50);
  fill(90);

  getCSVdata();
  createCountries();
  
  //TEST 
  
  //countries[6].noteOn(1000);
  delay(1000);
 // countries[6].noteOff();
    delay(1000);
  
}

//ooooooooooooooooooooooooooooooooooooooooooooooooooVOID_DRAW!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
void draw() {  
  background(40);
  noStroke();
  
drawYear();
drawTempobar();
tempoCalc();
countryDisplay();

if(playing == true){

//counter activities
  if(millis()-countries[countryCounter].noteMark>countries[countryCounter].scaledNoteLength) {
    advanceCountryCounter();  
    if(countryCounter==1) {
      advanceYearCounter();
    }
    playNotes();
  } 
}
}

//___________________________________________
void createCountries() {
  for(int i=0;i<numCountries;i++) {
    countries[i] = new country();
    countries[i].midiNote=i+33;
    //countries[i].midiNote=int(random(50))+36;
    
  }
}



void advanceCountryCounter() {
  if(countryCounter<numCountries-1) {
    countryCounter++;
    countries[countryCounter-1].noteOff();
  }
  else
  
  countryCounter=1;
  countries[numCountries-1].noteOff();
  }


void advanceYearCounter() { 
  timeMark=millis();
  if(counter<cYear.length -1 ) {
    counter++;
    }
  else {counter=0;
   playing =false;
  }
}


void playNotes() {
  if(int(population[counter][countryCounter])!=0) {
   // countries[countryCounter].playNote(float(masterGrid[counter+5][countryCounter]));
    countries[countryCounter].noteOn(float(population[counter][countryCounter]));
  }
 


//
println("tempo :"+ tempo);
println("year counter: "+counter);
println("year : "+cYear[counter]);
println("name: "+origin[countryCounter]);
println ("country: "+countryCounter);
println("midiNote: "+countries[countryCounter].midiNote);
println("noteLength: "+countries[countryCounter].scaledNoteLength);
println("population: "+population[counter][countryCounter]);
//    
    
  }



void drawTempobar(){
//tempo slider
constrain(tempoSliderXpos,tempoLineXpos,tempoLineXpos+tempoLineLength);
strokeWeight(2);
stroke(100,100,100,100);
line(tempoLineXpos,tempoYpos,tempoLineXpos+tempoLineLength,tempoYpos);
noStroke();
fill(200,20,20,100);
ellipse(tempoSliderXpos,tempoYpos,5,10);

fill(255,200);
textFont(countryFont, 12);
text("Tempo", tempoLineXpos+tempoLineLength+10, tempoYpos+5);

}

void tempoCalc() {
 
tempo=map(mouseX,0,wt,tempoMax,tempoMin);

if(tempo!=pTempo){  
  
/* 
for(int i = 0; i< numYears; i++){
  yearLength[i]=0;
for(int j = 1; j< numCountries; j++){
  yearLength[i]+= int(map(population[i][j],0,50000,tempo/tempoRatio,tempo));
  
  }
println(cYear[i] + ":" + yearLength[i]);
}
*/
pTempo=tempo;
}  

}

void drawYear(){
   //fill(0,fadeAlpha);
  textFont(yearFont, 100);
  //textFont(yearFont, 100);
  text(cYear[counter], 150, (height-100));
   fadeAlpha=int(map(millis()-timeMark, 0,yearLength[counter],255,50));
}


void centerMouse(){
//move "mouse" to center position for speed callibration

  try { 
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
  }
  robot.mouseMove(displayWidth/2, displayHeight/2);

}

 void externalMidi(){
// SoundCipher.getMidiDeviceInfo();
//cipher.getMidiDeviceInfo();
//cipher.setMidiDeviceOutput(2);
 
 }
 

void countryDisplay(){
 for (int i=1; i<numCountries; i++){
 int x=0;
 int y=0;
 if(i<=numCountries/3){
   x=10;
   y=i*36;
 
 }
   if(i>numCountries/3 && i<= numCountries/3*2){
   x=310;
 y=(i-int(numCountries/3))*36;
 }
   if(i > numCountries/3*2){
   x=610;
 y=(i-int(numCountries/3*2))*36;
 }

if(countries[i].highlight==true) {
fill(255);
}
else fill(155);
 textFont(countryFont,36);
 text(origin[i], x,y);
 
 }
}
