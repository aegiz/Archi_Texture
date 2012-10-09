void recupereCoordonnees(){
    //On recupere les coordonnées des points à tracer
    pointsATracer = new float [2 * nombrePoint][2];
    for(int k=0; k<nombrePoint; k++){
      pointsATracer[k][0] = floor(cos(tableauDePoint[ k ][2])*tableauDePoint[ k ][0] + xCen); 
      pointsATracer[k][1] = floor(sin(tableauDePoint[ k ][2])*tableauDePoint[ k ][0] + yCen);    // copie les "points" dans un nouveau tableau "pointAtracer"
      
      //On ajoute des points à l'intérieur de la forme qui sont entre un point k et le centre de la forme.
      pointsATracer[k+nombrePoint][0] = floor(xCen + random(0.05,0.8)*( (pointsATracer[k][0] - xCen)));
      pointsATracer[k+nombrePoint][1] = floor(yCen + random(0.05,0.8)*( (pointsATracer[k][1] - yCen)));
    }
    nombrePoint*=2;    
}
void methodeDelaunay(){ 
    image(imageImportee, 0,0,500,500); // permet de rafraichir notre image
    myDelaunay = new Delaunay( pointsATracer );
    float[][] myEdges = myDelaunay.getEdges();
    
    for(int k=0; k<myEdges.length; k++)
    {
      float startX;
      float startY;
      float endX;
      float endY;
      startX = myEdges[k][0];
      startY = myEdges[k][1];
      endX = myEdges[k][2];
      endY = myEdges[k][3];
      line( startX, startY, endX, endY );
    }
    delaunayNotSetted = false;
} 
