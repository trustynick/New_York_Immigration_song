import processing.serial.*;
float xPos = 0;             // horizontal position of the graph

Serial myPort; //the serial port

void setup(){
size(800,600);

//list all serial ports
println(Serial.list());

String portName = Serial.list()[0];  
myPort = new Serial(this, portName, 38400);

background(56,76,56);

}

void draw(){
//nothing to look at here

for(int i=53; i<57; i++){

noteOn(144, i, 127);
delay(1000);
noteOn(128, i, 0);
delay(1000);
println(i);
}





for(int i=35; i<54; i++){

noteOn(144, i, 127);
delay(1000);
noteOn(128, i, 0);
delay(1000);
println(i);
}

}

void noteOn(int cmd, int data1, int  data2) {
    myPort.write(cmd);
    myPort.write(data1);
    myPort.write(data2);
 }

