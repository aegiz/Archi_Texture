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
    

    // Prototype lerp: start stop, position au cours du temp
    
    float xPY = lerp( x1, x1b, ani.time() ); // sur les X on veut que la forme suive le défilement des frames 
    float xPX = lerp( y1, y1b, ani.position() );   // sur les Y on veut que la vitesse soit plus forte au début qu'à la fin


  
    beginShape();
    texture(imageImportee);
    vertex( xPX, xPY, xPX, xPY );
    vertex( xPX+100, xPY, xPX+100, xPY );
    vertex( xPX, xPY+100, xPX, xPY+100);
    endShape();
    
     /*fill(0, 100, 180);
     ellipse( xPX, xPY, 30, 30 );*/
     
  
}
