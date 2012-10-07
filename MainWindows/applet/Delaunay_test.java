import processing.core.*; 
import processing.xml.*; 

import quickhull3d.*; 
import megamu.mesh.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Delaunay_test extends PApplet {

// ******************************** VARIABLES ******************************** //

PImage imageImportee;

double imageGet;
int [][] TableauSommet; // initialis\u00e9 \u00e0 150 sommets
int [][] TableauTriangles; // initialis\u00e9 \u00e0 1042triangles
int [] TableauTampon;
int [] tableauDesSommets1;
int [] tableauDesSommets2;
int []TableauTamponTrie;
int [][] TableauFINAL;

int x;
int y;
int i=0; // variable globale servant \u00e0 definir le nombre de sommets progressivement

float [] [] points = new float [80][80];
float [] [] tableauSommetCoordonnees = new float [2][150]; // On consid\u00e8re que le nombre de sommets max est 150

Delaunay myDelaunay;

// ******************************** PARAMETRES DE LA FENETRE ******************************** //

public void setup() {
  size(500, 500, P3D);
  smooth();
  background(255,255,255);

 
  String address = selectInput(); 
        if (address == null) {
          // If a file was not selected
          println("No file selected.");
        } 
  else {
          // If a file was selected, print path to file
          println(address);
           imageImportee = loadImage(address);
          }
  
  


  image(imageImportee, 0,0,500,500);
  textureMode(IMAGE);
  
}



// ******************************** "MAIN" ******************************** //


public void draw() { // On est oblig\u00e9 de mettre draw dans le code processing (en g\u00e9n\u00e9ral sert \u00e0 faire des actions \u00e0 une fr\u00e9quence donn\u00e9e)
}

public void mousePressed(){ // la souris a \u00e9t\u00e9 pr\u00e9ss\u00e9e
  methodeDelaunay();
}

public void mouseReleased(){ // on a rel\u00e2ch\u00e9 la souris
  i=i+1;
}

public void mouseDragged(){ // la souris a \u00e9t\u00e9 boug\u00e9 
  methodeDelaunay(); // normalement on devrait aussi mettre un if(mouse pressed)
}


public void keyPressed(){
    
/*  switch(keyCode) {
      
    case UP:
      println("up");
      break;
    case DOWN:
      println("down");
      break;
    case RIGHT:
      println("right");
      break;
    case LEFT:
      println("left");
      break;
    
    case ENTER:
      println("enter");
      break;  
      
    }*/
    
  switch(key) {
    
    case '1':
    if(i>0){
      //frameRate(1);
      ExtractionTriangle(myDelaunay);  //On a pass\u00e9 en variable globale Mydelaunay
      print("\n happy end"); // Pour rappel il faudra placer le point zero \u00e0 un endroit "peu d\u00e9favorable"
    //  creationTriangle();
    }
    break;
    
    case '2':
    if(i>0){
      //frameRate(1);
      creationTriangle();  //On a pass\u00e9 en variable globale Mydelaunay
      print("\n happy end 2"); // Pour rappel il faudra placer le point zero \u00e0 un endroit "peu d\u00e9favorable"
    }
    break;
    
    case '3':
        
    String savePath = selectOutput();  // Opens file chooser
    if (savePath == null) {
      // If a file was not selected
      println("No output file was selected...");
    } else {
      // If a file was selected, print path to folder
      println(savePath);
    }

    save(savePath);
    
    break;
    

    
  }


}
public void ExtractionTriangle(Delaunay myDelaunay){

  TableauSommet = new int [i][150]; //on prend un tableau statique assez grand le mieux aurait \u00e9t\u00e9 de le faire en dynamique avec une arraylist
  // en abcisse on a le nombre de sommet ->i et en ordonn\u00e9 les liens avec ces m\u00eame sommets
  
  /* Cr\u00e9ation et initialisation du Tableau tampon de sommets! */
  
  //print("\n\n");
  
  for(int sommet=0; sommet<i; sommet++){ //Pour chaque sommet...
  
    // Mise en tableau tampon
    TableauTampon = myDelaunay.getLinked(sommet); // ...on parcours tous les sommets li\u00e9s et on les met dans un tableau tampon

    // Premi\u00e8re partie du nettoyage du Tableau Tampon: on enl\u00e8ve les 0 en trop et on leur colle la valeure 1042
    
    for(int j=0;j<TableauTampon.length-1; j++){ 
     
      if (TableauTampon[j]==0 && TableauTampon[j+1]== 0){ // si on a deux zeros ou plus cons\u00e9cutifs cela signifie que ce sont des bugs -> on leur met la valeure 1042
         for(j=j; j<TableauTampon.length; j++){
            TableauTampon[j]=1042;
         }
      }
      
    }

    // Tri \u00e0 bulles :
    
    int changement=1;
    int x; // variable tampon
      
    while(changement>0){ //tant qu'il ya des valeurs \u00e0 \u00e9changer
    
      changement=0; // on r\u00e9initialise changement quand la boucle repart

      for(int j=0;j<TableauTampon.length-1; j++){ 
   
        if(TableauTampon[j+1]<TableauTampon[j]){ //on compare chaque \u00e9l\u00e9ment \u00e0 son voisin
          x=TableauTampon[j];
          TableauTampon[j]=TableauTampon[j+1];
          TableauTampon[j+1]=x;
          changement++; //on signale qu'il ya eu un changement
        }

      }
    } // fin du while
    
    // Deuxi\u00e8me partie du netttoyage: Suppression des potentiels deux z\u00e9ros cons\u00e9cutifs en d\u00e9but de tableau
    
    if (TableauTampon[0]==0 && TableauTampon[1]==0){ // On passe l'une des deux valeurs \u00e0 1042 ...
      TableauTampon[0]=1042;
    }
    
    if (sommet==0 && TableauTampon[0]==0){ // Si l'on est dans le sommet on ne peut pas \u00eatre reli\u00e9 \u00e0 0
      TableauTampon[0]=1042;
    }
    
    int changement2=1;
    int x2;
      
    while(changement2>0){ //... et on retrie ensuite
    
      changement2=0; 

      for(int j=0;j<TableauTampon.length-1; j++){ 
   
        if(TableauTampon[j+1]<TableauTampon[j]){
          x2=TableauTampon[j];
          TableauTampon[j]=TableauTampon[j+1];
          TableauTampon[j+1]=x2;
          changement2++;
        }

      }
    }  

  // Repla\u00e7age dans le tableau global en pla\u00e7ant la valeur 1042 en bout:
  
   for(int j=0;j<TableauTampon.length; j++){          
        TableauSommet[sommet][j] = 1042;
   }
   
   for(int j=0;j<TableauSommet.length; j++){          // Pour \u00e9liminer les derniers 0
        TableauSommet[sommet][j] = 1042;
   }
   
   for(int j=0;j<TableauTampon.length; j++){
      TableauSommet[sommet][j] = TableauTampon[j];
   }
    
 
  } // fin du for
    
    
  
      
  /* Afichage des sommets */
  
 /* for(int t=0; t<i; t++){  
    print("\n\n ");
    print("\n sommet n\u00b0 "+t);
    
    for(int j=0; j<TableauSommet.length; j++){  
      
      print("\n "+ TableauSommet[t][j]);
      
    }
  }  */
     
  /*Extraction des triangles*/
  
  int Sommet1Triangle = 0; 
  int Sommet2Triangle = 0;
  int Sommet3Triangle = 0;
  int indiceTableauTriangles=0;
  
  TableauTriangles = new int [3][1000];
  //TableauTrianglesTrie = new int [3][];
  
 /* print("\n\n nombre de sommets = "+i);
  print("\n TableauSommet.length = "+TableauSommet.length);
  */
  for(int sommet=0; sommet<i; sommet++){  
    
    for(int j=0; j<TableauSommet.length; j++){  
      
      Sommet1Triangle=sommet; // 0
      Sommet2Triangle= TableauSommet[sommet][j]; // 1
     
    if (Sommet2Triangle != 1042){  // on ne prend pas en compte les valeurs ou il y a 1042
     
      for(int z=j; z<TableauSommet.length; z++){ // Pour le doublet {Sommet1Triangle, Sommet2Triangle} concern\u00e9 on v\u00e9rifie le Sommet3Triangle
       
        Sommet3Triangle= TableauSommet[sommet][z+1]; //3-4-5...
        int valeurTest1=0;
        int valeurTest2=0;
        
        
        if (Sommet3Triangle != 1042 && Sommet1Triangle != Sommet3Triangle && Sommet2Triangle != Sommet3Triangle){  // on ne prend pas en compte les valeurs ou il y a 1042 ni les doublets de 0
         // print("\n Triplet test\u00e9:" +Sommet1Triangle+ "-"+Sommet2Triangle+ "-"+Sommet3Triangle);
          
          for (int t=0; t<TableauSommet.length; t++){ // On est dans notre troisi\u00e8me sommet
  
              if (TableauSommet[Sommet3Triangle][t]==Sommet1Triangle){  // le Sommet1Triangle est dans le tableau du Sommet3Triangle
                 valeurTest1=1;
              }
              if (TableauSommet[Sommet3Triangle][t]==Sommet2Triangle){ // le Sommet2Triangle est dans le tableau du Sommet3Triangle
                 valeurTest2=1;
              }
  
          }
          
           if (valeurTest1==1 && valeurTest2==1){ // le triplet test\u00e9 est bon -> on a bien triangle

            //  print("\nTriangle detecte!!\n");
              TableauTriangles[0][indiceTableauTriangles]=Sommet1Triangle;
              TableauTriangles[1][indiceTableauTriangles]=Sommet2Triangle;
              TableauTriangles[2][indiceTableauTriangles]=Sommet3Triangle;
              
              indiceTableauTriangles++;
           }
           
           else {
          //   print("\nPas de triangle...\n");
           }
    
       
        }// fin du if 
      }
    }    
    
    
        //fin des deux for
       }
    }

/* Trie du tableau de triangles */
  
  TableauTamponTrie = new int [indiceTableauTriangles];
    
  for (int t=0; t<indiceTableauTriangles; t++){
    int vartest=1;
  
    while(vartest>0){  
      
      vartest=0;
      
      for (int j=0; j<2; j++){

          if (TableauTriangles[j+1][t]< TableauTriangles[j][t]){ // si la premi\u00e8re case est inf\u00e9rieure \u00e0 la suivante
              TableauTamponTrie[0] = TableauTriangles[j][t];
              TableauTriangles[j][t] = TableauTriangles[j+1][t];
              TableauTriangles[j+1][t] = TableauTamponTrie[0];
              vartest++;
          }
 
      }
      
    }

  }

 
/* Suppression des doublons: on met 666 \u00e0 la place d'un doublon */

int var1=0;
int var2=0;
int var3=0;

  for (int t=0; t<indiceTableauTriangles; t++){
    
    var1= TableauTriangles[0][t];  // On r\u00e9cup\u00e8re les valeurs de la ligne courante
    var2= TableauTriangles[1][t];
    var3= TableauTriangles[2][t];
    
    for (int r=t+1 ; r<indiceTableauTriangles; r++){           // On v\u00e9rifie que sur les lignes suivantes que les trois valeurs ne s'y trouvent pas d\u00e9j\u00e0
      
      
      if (TableauTriangles[0][r]==var1 && TableauTriangles[1][r]==var2 && TableauTriangles[2][r]==var3){
        
        TableauTriangles[0][r]=666;
        TableauTriangles[1][r]=666;
        TableauTriangles[2][r]=666;
      }
      
    }
    
  }   
 
  
/* Cr\u00e9ation d'un dernier tableau avec les triangles sans doublons */  

TableauFINAL = new int [3][300];
  
  int p=0;
  
    for (int t=0; t<indiceTableauTriangles; t++){
      
      if (TableauTriangles[0][t]!= 666 && TableauTriangles[1][t]!=666 && TableauTriangles[2][t]!=666){
        
        TableauFINAL[0][p]= TableauTriangles[0][t];
        TableauFINAL[1][p]= TableauTriangles[1][t];
        TableauFINAL[2][p]= TableauTriangles[2][t];
        p++;
        
      
    }
  }
  

 
 /* Affichage des triangles "for" */
 

 for (int u=0; u<20;u++){
   print("\n"+TableauFINAL[0][u]+"-"+TableauFINAL[1][u]+"-"+TableauFINAL[2][u]);
   //print("\n taille"+TableauFINAL[0].length);
 }
 
}
public void methodeDelaunay(){ 
   
    if(mousePressed){
      x = mouseX;
      y = mouseY;
      points[i][0]=x;
      points[i][1]=y;
      tableauSommetCoordonnees[0][i]=x;  // On sauvegarde les coordonn\u00e9es de notre sommet
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


/* Creation DES TRIANGLES */


// TableauFINAL: Tableau \u00e0 3dimension repr\u00e9sentant chacun un sommet
// TableauSommetCoordonnees: tableau des coordonn\u00e9es x et y 
     
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
public void creationTriangle(){

int sommet1, sommet2, sommet3;
float coordonnee_x_sommet1, coordonnee_x_sommet2, coordonnee_x_sommet3, coordonnee_y_sommet1, coordonnee_y_sommet2, coordonnee_y_sommet3;

  for(int t=0; t<TableauFINAL[0].length; t++){ //Pour chaque triangle ...
   
    if(TableauFINAL[0][t]!=0 || TableauFINAL[1][t]!=0 || TableauFINAL[2][t]!=0){ // Pour \u00e9viter le cas o\u00f9 l'on a la combinaison 0-0-0
   

   
      sommet1= TableauFINAL[0][t];  // ex 1-2-7
      sommet2= TableauFINAL[1][t];
      sommet3= TableauFINAL[2][t];
      
      coordonnee_x_sommet1= tableauSommetCoordonnees[0][sommet1];
      coordonnee_x_sommet2= tableauSommetCoordonnees[0][sommet2];
      coordonnee_x_sommet3 =tableauSommetCoordonnees[0][sommet3];

      coordonnee_y_sommet1= tableauSommetCoordonnees[1][sommet1];
      coordonnee_y_sommet2= tableauSommetCoordonnees[1][sommet2];
      coordonnee_y_sommet3= tableauSommetCoordonnees[1][sommet3];
     
     
     // tableauSommetCoordonnees[0][sommet1], tableauSommetCoordonnees[1][sommet1] -> coordonn\u00e9e en x du point 1, coordonn\u00e9e en y du point 1 

     triangle(coordonnee_x_sommet1, coordonnee_y_sommet1 , coordonnee_x_sommet2 , coordonnee_y_sommet2 , coordonnee_x_sommet3 ,coordonnee_y_sommet3 ); 
     fill(255,123);
     
     translate(50,70);
     rotate(40);
     

    
      
      beginShape();
      texture(imageImportee);
      
      // vertex(coordonn\u00e9 x triangle, coord y triangle, coordonn\u00e9 x texture, coordonn\u00e9 y texture) ici les m\u00eame
      
      vertex(coordonnee_x_sommet1, coordonnee_y_sommet1, coordonnee_x_sommet1, coordonnee_y_sommet1); 
      vertex(coordonnee_x_sommet2, coordonnee_y_sommet2, coordonnee_x_sommet2, coordonnee_y_sommet2);
      vertex(coordonnee_x_sommet3, coordonnee_y_sommet3, coordonnee_x_sommet3, coordonnee_y_sommet3);

      endShape();


    }
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "Delaunay_test" });
  }
}
