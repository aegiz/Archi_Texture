

/* Creation DES TRIANGLES */


// TableauFINAL: Tableau à 3dimension représentant chacun un sommet
// TableauSommetCoordonnees: tableau des coordonnées x et y 
     
/*noStroke();
PImage a = loadImage("arch.jpg");
textureMode(IMAGE);
beginShape();
texture(a);
vertex(10, 20, 0, 0);
vertex(80, 5, 100, 0);
vertex(95, 90, 100, 100);
vertex(40, 95, 0, 100);
endShape();*/

/* for...
 translate(thisTriangleTranslation);
      rotate(thisTriangleRotation);
      beginShape();
      texture(original_image);
      vertex(d1.x, d1.y, d1.x, d1.y);
      vertex(d2.x, d2.y, d2.x, d2.y);

      vertex(d3.x, d3.y, d3.x, d3.y);

      endShape()
*/     
void creationTriangle(){

int sommet1, sommet2, sommet3;
float coordonnee_x_sommet1, coordonnee_x_sommet2, coordonnee_x_sommet3, coordonnee_y_sommet1, coordonnee_y_sommet2, coordonnee_y_sommet3;

  for(int t=0; t<TableauFINAL[0].length; t++){ //Pour chaque triangle ...
   
    if(TableauFINAL[0][t]!=0 || TableauFINAL[1][t]!=0 || TableauFINAL[2][t]!=0){ // Pour éviter le cas où l'on a la combinaison 0-0-0
   

   
      sommet1= TableauFINAL[0][t];  // ex 1-2-7
      sommet2= TableauFINAL[1][t];
      sommet3= TableauFINAL[2][t];
      
      coordonnee_x_sommet1= tableauSommetCoordonnees[0][sommet1];
      coordonnee_x_sommet2= tableauSommetCoordonnees[0][sommet2];
      coordonnee_x_sommet3 =tableauSommetCoordonnees[0][sommet3];

      coordonnee_y_sommet1= tableauSommetCoordonnees[1][sommet1];
      coordonnee_y_sommet2= tableauSommetCoordonnees[1][sommet2];
      coordonnee_y_sommet3= tableauSommetCoordonnees[1][sommet3];
     
     
     // tableauSommetCoordonnees[0][sommet1], tableauSommetCoordonnees[1][sommet1] -> coordonnée en x du point 1, coordonnée en y du point 1 

     triangle(coordonnee_x_sommet1, coordonnee_y_sommet1 , coordonnee_x_sommet2 , coordonnee_y_sommet2 , coordonnee_x_sommet3 ,coordonnee_y_sommet3 ); 
     fill(255,123);
     
     translate(50,70);
     rotate(40);
     

    
      
      beginShape();
      texture(imageImportee);
      
      // vertex(coordonné x triangle, coord y triangle, coordonné x texture, coordonné y texture) ici les même
      
      vertex(coordonnee_x_sommet1, coordonnee_y_sommet1, coordonnee_x_sommet1, coordonnee_y_sommet1); 
      vertex(coordonnee_x_sommet2, coordonnee_y_sommet2, coordonnee_x_sommet2, coordonnee_y_sommet2);
      vertex(coordonnee_x_sommet3, coordonnee_y_sommet3, coordonnee_x_sommet3, coordonnee_y_sommet3);

      endShape();


    }
  }
}
