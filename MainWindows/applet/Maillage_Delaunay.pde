void methodeDelaunay(){ 
   
    if(mousePressed){
      x = mouseX;
      y = mouseY;
      points[i][0]=x;
      points[i][1]=y;
      tableauSommetCoordonnees[0][i]=x;  // On sauvegarde les coordonnées de notre sommet
      tableauSommetCoordonnees[1][i]=y;
    }
  
  if(i>0){
   float[][] pointsATracer = new float [i+1][2];
    for(int k=0; k<i+1; k++){
      pointsATracer[k][0] = points[k][0];
      pointsATracer[k][1] = points[k][1];     // copie les "points" dans un nouveau tableau "pointAtracer"
    }

    image(imageImportee, 0,0,500,500); // permet de rafraichir notre image
    myDelaunay = new Delaunay( pointsATracer );
    float[][] myEdges = myDelaunay.getEdges();
    
    for(int k=0; k<myEdges.length; k++)
    {
    	float startX = myEdges[k][0];
    	float startY = myEdges[k][1];
    	float endX = myEdges[k][2];
    	float endY = myEdges[k][3];
    	line( startX, startY, endX, endY );
    }
    
  }
 
} 
