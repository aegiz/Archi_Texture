// ******************************** VARIABLES ******************************** //

PImage imageImportee;

double imageGet;
int [][] TableauSommet; // initialisé à 150 sommets
int [][] TableauTriangles; // initialisé à 1042triangles
int [] TableauTampon;
int [] tableauDesSommets1;
int [] tableauDesSommets2;
int []TableauTamponTrie;
int [][] TableauFINAL;

int x;
int y;
int i=0; // variable globale servant à definir le nombre de sommets progressivement

float [] [] points = new float [80][80];
float [] [] tableauSommetCoordonnees = new float [2][150]; // On considère que le nombre de sommets max est 150

Delaunay myDelaunay;

// ******************************** PARAMETRES DE LA FENETRE ******************************** //

void setup() {
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


void draw() { // On est obligé de mettre draw dans le code processing (en général sert à faire des actions à une fréquence donnée)
}

void mousePressed(){ // la souris a été préssée
  methodeDelaunay();
}

void mouseReleased(){ // on a relâché la souris
  i=i+1;
}

void mouseDragged(){ // la souris a été bougé 
  methodeDelaunay(); // normalement on devrait aussi mettre un if(mouse pressed)
}


void keyPressed(){
    
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
      ExtractionTriangle(myDelaunay);  //On a passé en variable globale Mydelaunay
      print("\n happy end"); // Pour rappel il faudra placer le point zero à un endroit "peu défavorable"
    //  creationTriangle();
    }
    break;
    
    case '2':
    if(i>0){
      //frameRate(1);
      creationTriangle();  //On a passé en variable globale Mydelaunay
      print("\n happy end 2"); // Pour rappel il faudra placer le point zero à un endroit "peu défavorable"
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
