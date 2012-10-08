void dessineTriangles(){
  println("\n Hello");
  for(int t=nombreTriangles-1; t!=-1; t--){ //Pour chaque triangle on lui donne la texture qui est dessous
     
    beginShape(); // on trace une shape avec 3 sommets donc un triangle
    texture(imageImportee);
    vertex(TableauCoodonneesExtraites[t][0][0],TableauCoodonneesExtraites[t][0][1] ,TableauCoodonneesExtraites[t][0][0],TableauCoodonneesExtraites[t][0][1] );
    vertex(TableauCoodonneesExtraites[t][1][0], TableauCoodonneesExtraites[t][1][1],TableauCoodonneesExtraites[t][1][0], TableauCoodonneesExtraites[t][1][1]);
    vertex(TableauCoodonneesExtraites[t][2][0] , TableauCoodonneesExtraites[t][2][1] ,TableauCoodonneesExtraites[t][2][0] ,TableauCoodonneesExtraites[t][2][1] );
    
    endShape();

  }     
}

void preparationExplosion(){
  
  //Initialisation du tableau qui contiendra toute les infos sur les jets.
  donneesExplosion =  new int [nombreTriangles][3];
  
  for(int t=0; t!=nombreTriangles-1; t++){ //Pour chaque triangle on lui donne la texture qui est dessous
  
  //On détermine le vecteur vitesse de départ des triangles
  
    //On fait la moyenne des coordonnées des trois points :
    int moyX = floor((TableauCoodonneesExtraites[t][0][0] + TableauCoodonneesExtraites[t][1][0] + TableauCoodonneesExtraites[t][2][0])/3);
    int moyY = floor((TableauCoodonneesExtraites[t][0][1] + TableauCoodonneesExtraites[t][1][1] + TableauCoodonneesExtraites[t][2][1])/3); 

    //On calcul le vecteur vitesse de départ à partir du centre de l'image    
    int vectX = floor((moyX - xCen));
    int vectY = floor((moyY - yCen));     


    //On normalise le vecteur pour qu'il n'y ait pas de différence entre images (on les rajoutera après ;) ). 
    donneesExplosion[t][0] = floor((vectX / (sqrt(float(vectX*vectX + vectY*vectY))))* vitesseExplosion);
    donneesExplosion[t][1] = floor((vectY / (sqrt(float(vectX*vectX + vectY*vectY))))* vitesseExplosion);
  }  
  
}


void eclatementTriangles(){
  float x1 = 0;
  float y1 = 0;
  float x1b = width;
  float y1b = height;  
  smooth();
  noStroke();

  // On est obligé de repréciser le background car sinon le triangle laisse une trainée derrière lui
  image(imageImportee, 0,0,500,500);
  
  for(int t=0; t!=nombreTriangles-1; t++){ //Pour chaque triangle on lui donne la texture qui est dessous
   
    //On applique un coef au vecteur qui change au cours du temp pour la vitesse de déplacement.
    int vectX = floor(donneesExplosion[t][0]  * indiceExplosion);
    int vectY = floor(donneesExplosion[t][1]  * indiceExplosion) + floor(pesanteur * indiceExplosion * indiceExplosion);      
    
    beginShape(); // on trace une shape avec 3 sommets donc un triangle
    texture(imageImportee);
    vertex(TableauCoodonneesExtraites[t][0][0]+ vectX, TableauCoodonneesExtraites[t][0][1]+ vectY, TableauCoodonneesExtraites[t][0][0], TableauCoodonneesExtraites[t][0][1] );
    vertex(TableauCoodonneesExtraites[t][1][0]+ vectX, TableauCoodonneesExtraites[t][1][1]+ vectY, TableauCoodonneesExtraites[t][1][0], TableauCoodonneesExtraites[t][1][1] );
    vertex(TableauCoodonneesExtraites[t][2][0]+ vectX, TableauCoodonneesExtraites[t][2][1]+ vectY, TableauCoodonneesExtraites[t][2][0], TableauCoodonneesExtraites[t][2][1] );

    endShape();
 
  }
}
