
void traceMoiUnCercleMainsLevee(){
  position.x = mouseX;
  position.y = mouseY;
  listeDePoint.add(position.x); 
  listeDePoint.add(position.y);   
}

void dessineMoiUneCercleTraceAMainLevee(){
  int i;
  for(i=0; i<listeDePoint.size()-1; i+=2)
  {
     tempX =(Integer)listeDePoint.get(i);        
     tempY =(Integer)listeDePoint.get(i+1);         
     fill(255,255,255);
     rect(tempX, tempY, 2, 2);
  }
}

void dessineMoinUnCercle(){
  int x1, x2, y1, y2;
  image(imageImportee, 0, 0,500,500);
  for(int i =0; i!= nombrePoint-1; i++){
    x1 = floor(cos(tableauDePoint[ i ][2])*tableauDePoint[ i ][0] + xCen);
    y1 = floor(sin(tableauDePoint[ i ][2])*tableauDePoint[ i ][0] + yCen);
    x2 = floor(cos(tableauDePoint[i+1][2])*tableauDePoint[i+1][0] + xCen);
    y2 = floor(sin(tableauDePoint[i+1][2])*tableauDePoint[i+1][0] + yCen);
    fill(0,255,255);
    rect(x1, y1, 2, 2);
  }     
}

void collision(){  
  int x1;
  int y1;
  
  //On compte le nombre de point qui ont terminé leur course pour savoir si on a finit le parcour;
  int compteur = 0;
  
  imageContour.loadPixels();
  int location=0;
  for(int i =0; i!= nombrePoint; i++){
    x1 = floor( cos(tableauDePoint[i][2])*tableauDePoint[i][0] + xCen);
    y1 = floor( sin(tableauDePoint[i][2])*tableauDePoint[i][0] + yCen);
    location = y1 * imageContour.width + x1;
    fill(0,255,255);
    if (abs(brightness(imageContour.pixels[abs(location)]))> seuil || tableauDePoint[i][1] == 1){ // bug ici Arrayoutofbounds
      tableauDePoint[i][1] = 1;
      fill(0,0,255);
      if (tableauDePoint[i][1] == 1)
      {
        compteur++;
      }
    }
    else if(ETAT == 201)
    {
      tableauDePoint[i][0] ++;
    }
    else if(ETAT ==202 && tableauDePoint[i][0] < 0 )
    {
     tableauDePoint[i][1] = 1;
    }
    
    else
    {
      tableauDePoint[i][0] --;
    }
        rect(x1, y1, 5, 5);
  }
   if (compteur > nombrePoint / 1.2)
    {
     collisionEnded = true;
    }

}

void imageContour(){
  imageContour.loadPixels();
    for(int x = 0; x <imageContour.width; x++){
      for(int y = 0; y <imageContour.height-1; y++){
  
        int location = y * imageContour.width + x;
        int locationBas = (y + 1)* imageContour.width + x;
        int locationDroite = y* imageContour.width + x + 1;
        
        color pix = imageContour.pixels[location];
        color pixBas = imageContour.pixels[locationBas];
        color pixDroite = imageContour.pixels[locationDroite];  
        float diff = abs(brightness(pix) - brightness(pixBas)) + abs(brightness(pix) - brightness(pixDroite));
        if (diff < seuil )
        {
          diff = 0;
        }
        else
        {
          diff = 255;
        }
        imageContour.pixels[location]= color(diff);
      }
  }
}

//
//void mousePressed(){ // la souris a été préssée
////  mouseHasBeenPressed = true;
////  listeDePoint = new ArrayList();
////  tabInit();
////  mousePress = 1;
////  un.x = mouseX;
////  un.y = mouseY;
//}
//
//void mouseReleased(){ // on a relâché la souris
////  mouseHasBeenPressed = false;
////  mouseHasBeenReleased = true;
////  
////  if (ETAT == 202) //On doit transformer en coordonnées polaires
////    {
////      nombrePoint = listeDePoint.size()/2;
////      //On fait la moyenne des coordonnées pour trouver le point central
////      int i;
////      for(i=0; i<listeDePoint.size()-1; i+=2)
////      {
////        tempX =(Integer)listeDePoint.get(i);     
////        xCen += tempX;
////        tempY =(Integer)listeDePoint.get(i+1);             
////        yCen += tempY;
////      }
////      xCen /= listeDePoint.size();
////      yCen /= listeDePoint.size();    
////      xCen = floor(xCen)*2;
////      yCen = floor(yCen)*2;
////
////      // On copie colle toute les points dans le tableau de point en les mettant en coordonnées polaires
////      tableauDePoint = new float[nombrePoint][3];
////      for(i=0; i<listeDePoint.size()-1; i+=2)
////      {
////        tempX = (Integer)listeDePoint.get(i);     
////        tempY = (Integer)listeDePoint.get(i+1);          
////        tableauDePoint[i/2][0] = sqrt(((tempX - xCen)*(tempX - xCen)) + ((tempY - yCen)*(tempY - yCen)));
////        tableauDePoint[i/2][1] = 0;
////        if ((tempY - yCen) > 0){
////          tableauDePoint[i/2][2] = acos((tempX - xCen) / tableauDePoint[i/2][0]) ;  
////        }
////        else
////        {
////          tableauDePoint[i/2][2] = -1*acos((tempX - xCen) / tableauDePoint[i/2][0]) ;  
////        }
////      }            
////    }
//}
//
//void mouseDragged(){ // la souris a été bougé
//}

void tabInit(){
  print("\n nombrePoint: " + nombrePoint + " \n ");
  for(int i =0; i!= nombrePoint; i++){
    print("coucou");
     tableauDePoint[i][0] = 10;
     tableauDePoint[i][1] = 0;
    // tableauDePoint[i][2] = 2*PI*(float(i+1 )/nombrePoint) ;    
  }
}
