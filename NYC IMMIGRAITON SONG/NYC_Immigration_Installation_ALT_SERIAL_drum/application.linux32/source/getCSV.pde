void getCSVdata() {

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
    midiNotes[j]=int(allData[(j*numCols+1)])+36;
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
population[i-2][j] = int(masterGrid[i][j]);

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


