


void mouseReleased() {
  //drawTempobar();
centerMouse();

}

void mouseDragged() {
  //line(countries[clickCount].point1X,countries[clickCount].point1Y,mouseX,mouseY);
  if(abs(mouseX - tempoSliderXpos)<10 && abs(mouseY - tempoYpos)<10)
    tempoSliderXpos=mouseX;
  if(tempoSliderXpos<tempoLineXpos) tempoSliderXpos=tempoLineXpos;
  if(tempoSliderXpos>tempoLineXpos+tempoLineLength) tempoSliderXpos=tempoLineXpos+tempoLineLength;
  drawTempobar();
  //tempoCalc();
  println(tempo);
  
}
void mouseMoved(){
tempoCalc();
tempoSliderXpos = map(mouseX, 0, wt, tempoLineXpos, tempoLineXpos+tempoLineLength);
 drawTempobar();

}
