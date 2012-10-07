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

void eclatementTriangles(){
  float x1 = 0;
  float y1 = 0;
  float x1b = width;
  float y1b = height;  
  smooth();
  noStroke();
  

  
  
  // On est obligé de repréciser le background car sinon le triangle laisse une trainée derrière lui
  image(imageImportee, 0,0,500,500);
  
  for(int t=nombreTriangles-1; t!=-1; t--){ //Pour chaque triangle on lui donne la texture qui est dessous
  
  
    //On détermine la trajectoire du triangles
    int vectX = floor((TableauCoodonneesExtraites[t][0][0] - xCen)*2);
    int vectY = floor((TableauCoodonneesExtraites[t][0][1] - yCen)*2);    
    
    beginShape(); // on trace une shape avec 3 sommets donc un triangle
    texture(imageImportee);
    vertex(TableauCoodonneesExtraites[t][0][0]+vectX,TableauCoodonneesExtraites[t][0][1]+vectY ,TableauCoodonneesExtraites[t][0][0],TableauCoodonneesExtraites[t][0][1] );
    vertex(TableauCoodonneesExtraites[t][1][0]+vectX, TableauCoodonneesExtraites[t][1][1]+vectY,TableauCoodonneesExtraites[t][1][0], TableauCoodonneesExtraites[t][1][1]);
    vertex(TableauCoodonneesExtraites[t][2][0]+vectX, TableauCoodonneesExtraites[t][2][1]+vectY ,TableauCoodonneesExtraites[t][2][0] ,TableauCoodonneesExtraites[t][2][1] );

    endShape();
 
  }
}
