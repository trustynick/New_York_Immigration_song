void sortCountries(){
for(int i=1; i<numCountries+1; i++){
  for(int j=1; j<i; j++){
    if(int(masterGrid[counter+5][i])<int(masterGrid[counter+5][j])){
    countries[i].order++;
    }
    
  }
}
  println(cYear[counter]);
  for(int i=0; i<numCountries; i++){
    println(i+": "+countries[i].order+" , "+(masterGrid[counter+5][i]));
    
  }
  }
