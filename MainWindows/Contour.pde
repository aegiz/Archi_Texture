
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
  for(int i =0; i!= lesAmorces.getLast().nombrePoint-1; i++){
    x1 = floor(cos(lesAmorces.getLast().tableauDePoint[ i ][2])*lesAmorces.getLast().tableauDePoint[ i ][0] + lesAmorces.getLast().centreTransformation.x);
    y1 = floor(sin(lesAmorces.getLast().tableauDePoint[ i ][2])*lesAmorces.getLast().tableauDePoint[ i ][0] + lesAmorces.getLast().centreTransformation.y);
    x2 = floor(cos(lesAmorces.getLast().tableauDePoint[i+1][2])*lesAmorces.getLast().tableauDePoint[i+1][0] + lesAmorces.getLast().centreTransformation.x);
    y2 = floor(sin(lesAmorces.getLast().tableauDePoint[i+1][2])*lesAmorces.getLast().tableauDePoint[i+1][0] + lesAmorces.getLast().centreTransformation.y);
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
  
  for(int i =0; i!= lesAmorces.getLast().nombrePoint; i++){
    x1 = floor( cos(lesAmorces.getLast().tableauDePoint[i][2])*lesAmorces.getLast().tableauDePoint[i][0] + lesAmorces.getLast().centreTransformation.x);
    y1 = floor( sin(lesAmorces.getLast().tableauDePoint[i][2])*lesAmorces.getLast().tableauDePoint[i][0] + lesAmorces.getLast().centreTransformation.y);
    location = y1 * imageContour.width + x1;
    fill(0,255,255);
    if (abs(brightness(imageContour.pixels[abs(location)]))> seuil || lesAmorces.getLast().tableauDePoint[i][1] == 1){ // bug ici Arrayoutofbounds
      lesAmorces.getLast().tableauDePoint[i][1] = 1;
      fill(0,0,255);
      if (lesAmorces.getLast().tableauDePoint[i][1] == 1)
      {
        compteur++;
      }
    }
    else if(ETAT == 201)
    {
      lesAmorces.getLast().tableauDePoint[i][0] ++;
    }
    else if(ETAT ==202 && lesAmorces.getLast().tableauDePoint[i][0] < 0 )
    {
     lesAmorces.getLast().tableauDePoint[i][1] = 1;
    }
    
    else
    {
      lesAmorces.getLast().tableauDePoint[i][0] --;
    }
        rect(x1, y1, 5, 5);
  }
   if (compteur > lesAmorces.getLast().nombrePoint / 1.2)
    {
     variableEnvironnement.collisionEnded = true;
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

void tabInit(){
  for(int i =0; i!= lesAmorces.getLast().nombrePoint; i++){
     lesAmorces.getLast().tableauDePoint[i][0] = 10;
     lesAmorces.getLast().tableauDePoint[i][1] = 0;
     lesAmorces.getLast().tableauDePoint[i][2] = 2*PI*(float(i+1 )/lesAmorces.getLast().nombrePoint) ;    
  }
}
