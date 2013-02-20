
import java.awt.AWTException;
import java.awt.Robot;
 
Robot robot;

import arb.soundcipher.*;
SoundCipher cipher;

//fullres
int wt=1440;
int ht=900;
int instr=1;


//tempo variables
float tempoLineXpos=150;
float tempoLineLength =250;
float tempoSliderXpos=tempoLineXpos+tempoLineLength/2;
float tempoYpos=(ht-50);
//min & max speeds
float tempoMax=400;
float tempoMin=100;


//float tempo=map(tempoSliderXpos,tempoLineXpos,tempoLineXpos+tempoLineLength,tempoMax,tempoMin);

float tempo=tempoMax/2;

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
String[] cYear=new String[numYears];
String[][] masterGrid = new String[numCols+21][numRows+21];

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


noCursor();
centerMouse();  
cipher= new SoundCipher();

cipher.setMidiDeviceOutput(2);
 
 yearFont=loadFont("LetterGothicStd-BoldSlanted-100.vlw");
 countryFont=loadFont("Didot-12.vlw");
 countryFont_2=loadFont("Didot-36.vlw");
 titleFont=loadFont("OratorStd-24.vlw");


  background(50);
  fill(90);

  getCSVdata();
  createCountries();
}

//ooooooooooooooooooooooooooooooooooooooooooooooooooVOID_DRAW!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
void draw() {  
  background(20);
  noStroke();
  fill(70);

  rectMode(CENTER);
  rect(width/2,height/2, width*.8+10, height*.8+10);
  
drawYear();
drawTempobar();
tempoCalc();
countryDisplay();


//counter activities
  if(millis()-countries[countryCounter].noteMark>countries[countryCounter].scaledNoteLength) {
    advanceCountryCounter();  
    if(countryCounter==1) {
      advanceYearCounter();
    }
    playNotes();
  } 
}


//___________________________________________
void createCountries() {
  for(int i=0;i<numCountries;i++) {
    countries[i] = new country();
    countries[i].midiNote=i+30;
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
  else counter=0;
  }


void playNotes() {
  if(int(masterGrid[counter+5][countryCounter])!=0) {
    countries[countryCounter].playNote(float(masterGrid[counter+5][countryCounter]));
    
    
  }
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
  
  //println(mouseX+","+tempo);
  }

void drawYear(){
   fill(0,fadeAlpha);
  textFont(yearFont, 100);
  //textFont(yearFont, 100);
  text(cYear[counter], 150, (height-100));
   fadeAlpha=int(map(yearAlpha, timeMark-millis(),tempo*numCountries,255,-150));
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
