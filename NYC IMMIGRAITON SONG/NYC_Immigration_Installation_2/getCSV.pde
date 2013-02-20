void getCSVdata() {

  String CSVdata[] = loadStrings("NYC_Imm_3.txt");                           
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
  }
  //populate MasterGrid
  for(int i=0; i<numCols;i++) {
    for(int j=0; j<numRows; j++) {
      masterGrid[i][j]=allData[i+j*numCols];
    }
    }
    
    //populate Years
    for(int i=5; i<numCols; i++){
    cYear[i-5]=masterGrid[i][0];
    
    }
    
    //populate Lat and Long
      for(int j=0; j<numRows; j++) {
//      latitude[j] = float(masterGrid[3][j]);
  //    longitude[j] = float(masterGrid[4][j]);
          
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


