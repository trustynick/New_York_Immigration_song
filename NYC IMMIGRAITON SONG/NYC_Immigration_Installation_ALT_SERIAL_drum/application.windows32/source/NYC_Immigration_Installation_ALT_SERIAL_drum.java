import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import processing.serial.*; 
import java.awt.AWTException; 
import java.awt.Robot; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class NYC_Immigration_Installation_ALT_SERIAL_drum extends PApplet {

boolean debug = false;
boolean drum =true;



Serial myPort; //the serial port



 
Robot robot;

int drumNote=66;

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
float tempoMax=1500;
float tempoMin=300;

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

int numYears=17;
int numCols=numYears+2;
int numEntries;
int numCountries=42;
int numRows=numCountries;

String[] allData;

//names fo countries
String[] origin= new String[numCountries];
int[] midiNotes= new int[numCountries];
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

int fadeAlpha=PApplet.parseInt(map(yearAlpha, timeMark-millis(),tempo*numCountries,255,-150));


public void setup(){
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
public void draw() {  
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
public void createCountries() {
  for(int i=0;i<numCountries;i++) {
    countries[i] = new country();
    countries[i].midiNote=midiNotes[i];
    //countries[i].midiNote=int(random(50))+36;
    
  }
}



public void advanceCountryCounter() {
  if(countryCounter<numCountries-1) {
    countryCounter++;
    countries[countryCounter-1].noteOff();
  }
  else
  
  countryCounter=1;
  countries[numCountries-1].noteOff();
  }


public void advanceYearCounter() { 
  timeMark=millis();
  if(counter<cYear.length -1 ) {
    counter++;
    }
  else {counter=0;
   playing =false;
  }
}


public void playNotes() {
 // if(int(population[counter][countryCounter])!=0) {
   // countries[countryCounter].playNote(float(masterGrid[counter+5][countryCounter]));
    countries[countryCounter].noteOn(PApplet.parseFloat(population[counter][countryCounter]));
 // }
 


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



public void drawTempobar(){
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

public void tempoCalc() {
 
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

public void drawYear(){
   //fill(0,fadeAlpha);
  textFont(yearFont, 100);
  //textFont(yearFont, 100);
  text(cYear[counter], 150, (height-100));
   fadeAlpha=PApplet.parseInt(map(millis()-timeMark, 0,yearLength[counter],255,50));
}


public void centerMouse(){
//move "mouse" to center position for speed callibration

  try { 
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
  }
  robot.mouseMove(displayWidth/2, displayHeight/2);

}

 public void externalMidi(){
// SoundCipher.getMidiDeviceInfo();
//cipher.getMidiDeviceInfo();
//cipher.setMidiDeviceOutput(2);
 
 }
 

public void countryDisplay(){
 for (int i=1; i<numCountries; i++){
 int x=0;
 int y=0;
 if(i<=numCountries/3){
   x=10;
   y=i*36;
 
 }
   if(i>numCountries/3 && i<= numCountries/3*2){
   x=310;
 y=(i-PApplet.parseInt(numCountries/3))*36;
 }
   if(i > numCountries/3*2){
   x=610;
 y=(i-PApplet.parseInt(numCountries/3*2))*36;
 }

if(countries[i].highlight==true) {
fill(255);
}
else if(countries[i].noData==true){
fill(255,0,0);
}
else fill(155);
 textFont(countryFont,36);
 text(origin[i], x,y);
 
 }
}

class country {

  
long noteMark;
int order=0;
int midiNote=0;


// int midiNote=int(random(50);
 
 
 float scaledNoteLength=0;
float noteLength=tempo;

boolean highlight=false;
boolean noData = false;

  country() {
  }
  

 
 public void noteOn(float pop) {
   scaledNoteLength = PApplet.parseInt(map(pop,0,50000,tempo/tempoRatio,tempo));    
 //make sure it isn't under minimum
  if(scaledNoteLength<300){
  scaledNoteLength=300;
  }
  
   if(pop!=0 && playing == true){
    myPort.write(144);
    myPort.write(midiNote);
    myPort.write(127);

   highlight=true;
   noData = false;
   noteMark=millis();
  }
  
  if(pop==0 && drum ==true){
    
 scaledNoteLength = tempo/tempoRatio;   
    
 //play drum
  myPort.write(144);  //128 = note off for channel 1
    myPort.write(drumNote);
    myPort.write(127);
    //drumMark
     noteMark=millis();
     noData = true;
 }
  
  
 }
 
 
 public void noteOff(){
 myPort.write(128);  //128 = note off for channel 1
    myPort.write(midiNote);
    myPort.write(0);
    
    myPort.write(128);  //128 = note off for channel 1
    myPort.write(drumNote);
    myPort.write(0);
   
   highlight=false;
   noData = false;
 
 
 }
 
 /*
 void getLineNote() {
     lineLength=dist(point1X,point1Y,point2X,point2Y);
    lineNote=map(lineLength,600/scaleAmount,1*scaleAmount,60,100);
  }
  
*/

public void alphaUpdate(){

}

 

}



public void getCSVdata() {

  String CSVdata[] = loadStrings("NYC_Imm_multi.txt");                           
  String everything= join(CSVdata,"");
  allData= split(everything,",");
  numEntries=allData.length;
  println(allData.length);
  //for(int i=0; i<allData.length; i++){
  //println(allData[i]);
  //}

  //populate countries;
  for(int j=0; j<numRows; j++) {
    origin[j]=allData[(j*numCols)];
    midiNotes[j]=PApplet.parseInt(allData[(j*numCols+1)])+36;
  }
  //populate MasterGrid
  for(int i=0; i<numCols;i++) {
    for(int j=0; j<numRows; j++) {
      masterGrid[i][j]=allData[i+j*numCols];
      //println(i+","+j);
     // println(masterGrid[i][j]);
    }
    }
    
    //populate Years
    for(int i=2; i<numCols; i++){
    cYear[i-2]=masterGrid[i][0];
    
    }
    
 //population population
for(int i = 2; i< numYears+2; i++){
for(int j = 1; j< numCountries; j++){
population[i-2][j] = PApplet.parseInt(masterGrid[i][j]);

}
}

for(int i=0; i<numYears; i++){
  for(int j=0; j<numCountries; j++){
println(cYear[i]);
println(origin[j]);
println(population[i][j]);
  }
}

//populate yearPop
 
for(int i = 0; i< numYears; i++){
  yearPop[i]=0;
for(int j = 1; j< numCountries; j++){
  yearPop[i]+= population[i][j];
  }
println(cYear[i] + ":" + yearPop[i]);
}


//print years
  for(int i=0; i<cYear.length; i++) {
    println(i+" "+cYear[i]);
  }

  for(int i=0; i<numCols; i++) {
    for(int j=0; j<numRows; j++) {
   
      //println(masterGrid[i][j]);
    }
    }  
    for(int j=0; j<numRows; j++) {
    
      // println(origin[j]+","+latitude[j]+","+longitude[j]+","+masterGrid[5][j]+","+masterGrid[6][j]+","+masterGrid[7][j]+","+masterGrid[8][j]+","+masterGrid[9][j]);
      
     
      
    }  
    



  }





public void mouseReleased() {
  //drawTempobar();
centerMouse();

if(playing == false){
playing = true;
}

}

public void mouseDragged() {
  //line(countries[clickCount].point1X,countries[clickCount].point1Y,mouseX,mouseY);
  if(abs(mouseX - tempoSliderXpos)<10 && abs(mouseY - tempoYpos)<10)
    tempoSliderXpos=mouseX;
  if(tempoSliderXpos<tempoLineXpos) tempoSliderXpos=tempoLineXpos;
  if(tempoSliderXpos>tempoLineXpos+tempoLineLength) tempoSliderXpos=tempoLineXpos+tempoLineLength;
  drawTempobar();
  //tempoCalc();
  println(tempo);
  
}
public void mouseMoved(){
tempoCalc();
tempoSliderXpos = map(mouseX, 0, wt, tempoLineXpos, tempoLineXpos+tempoLineLength);
 drawTempobar();

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "NYC_Immigration_Installation_ALT_SERIAL_drum" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
