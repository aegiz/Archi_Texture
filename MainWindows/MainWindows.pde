// ******************************** VARIABLES ******************************** //

//// PREMIERE fenetre
import megamu.shapetween.*;

PImage imageImportee;
PImage imageContour;

int nombreTriangles;
double imageGet;
int [][] TableauSommet; // initialisé à 150 sommets
int [][] TableauTriangles; // initialisé à 1042triangles
int [] TableauTampon;
int [] tableauDesSommets1;
int [] tableauDesSommets2;
int [] TableauTamponTrie;
int [][] TableauIndices;
float [][][] TableauCoodonneesTrianglesActuelles;
float [][][] TableauCoodonneesExtraites;
boolean tableConverted = false;

int x;
int y;
int i=0; // variable globale servant à definir le nombre de sommets progressivement

// variables pour l'animation d'explosion
Tween ani;
BezierShaper mon_bezier;






// DEUXIEME fenetre


PFrame f;
secondApplet s;
PFont font;

int positionEllX, positionEllY;
int positionEllX2, positionEllY2;

int rectSizeX;
int rectSizeY;
int positionRectX,positionRectX1,positionRectX2, positionRectX3, positionRectY, positionRectY3;

int positionSourisX, positionSourisY;


boolean buttonOver;
boolean aDejaChargImage=false;
int choixTransformation; // 0 = pas encore assigné 1 = delaunay, 2 = polaires

int ETAT =1;

// ******************************** VARIABLES POUR L'EXTRACTION DES CONTOURS ******************************* //
//declaration des classes
class UNPOINT{
  int x;
  int y;
  boolean arrete = false;
}

//declaration des variables
int mousePress = 1;

float tableauDePoint[][] = new float[nombrePoint][3];
int seuil = 20;


//Pour la figure à main levée
UNPOINT pointChemin = new UNPOINT();

int typeSelection = 0;
int tempX, tempY;

// pour le tracé à main levé
ArrayList listeDePoint = new ArrayList();
boolean imageLoaded = false;

UNPOINT un = new UNPOINT();
UNPOINT temp = new UNPOINT();
UNPOINT position = new UNPOINT();
float xCen =0, yCen = 0;


// ******************************** PARAMETRES POUR LA DELAUNAY ******************************** //
 
 
 float [][] pointsATracer = new float [nombrePoint][2];
float [] [] points = new float [350][350];
float [] [] tableauSommetCoordonnees = new float [2][350]; // On considère que le nombre de sommets max est 350

Delaunay myDelaunay;


// ******************************** PARAMETRES POUR L'EXPLOSION ******************************** //


float indiceExplosion = 0;
float vitesseExplosion = 2;
float pesanteur = 0.02;
float aleatoire = 0.2;

int [][] donneesExplosion;

// ******************************** PARAMETRES DE LA FENETRE PRINCIPALE ******************************** //


// ******************************** Variable d'environnement pour l'amorce ***************************** //
public class ENVAMORCE{
  public boolean   mouseHasBeenPressed;
  public   boolean   mouseHasBeenReleased;
  public   boolean   collisionEnded;
  public   boolean   delaunayNotSetted;
  public   int   nombrePointBase;  
  
  public ENVAMORCE(){
    mouseHasBeenPressed = false;
    mouseHasBeenReleased = false;
    collisionEnded = false;
    delaunayNotSetted = true;  
    nombrePointBase = 10; 
  }
  
  public void nouvAmorce(){
    mouseHasBeenPressed = false;
    mouseHasBeenReleased = false;
    collisionEnded = false;
    delaunayNotSetted = true; 
    nombrePointBase = 10;   
  }
}
              
ENVAMORCE variableEnvironnement = new ENVAMORCE();

// ******************************** CLASSE QUI CONTIENT UNE AMORCE D'EXPLOSION***************************** //
// Les amorce d'explosion contiennent tout ce qu'il faut pour démarer une explosion.
public class AMORCE{
  
  float [][] tableauDePoint; 
  int nombrePoint;
  int choixTransformation;
  UNPOINT centreTransformation;
  public AMORCE(){
    choixTransformation = 0;
    nombrePoint = nombrePointBase;
  }
}
// La liste chainée qui contient toutes les amorces.
List lesAmorces= new LinkedList();

void setup(){
  
  size(500, 500, P3D);
  background(255, 255, 255);
  
  imageImportee =loadImage("Presentation1.png");
  image(imageImportee, 0,0,500,500);
  textureMode(IMAGE);
  
  smooth();
  
  font = loadFont("ArabicTypesetting-20.vlw"); // Cette police pixellise moins
  textFont(font);
  
  PFrame f = new PFrame();
 
}



// ******************************** "MAIN" ******************************** //


void draw() { //draw() est appellée à chaque frame

   // print(" Nous somme dans l'état : " + ETAT+ "\n");

   s.background(255, 255, 255); // On met un fond blanc dans l'autre fenêtre en permanence ce qui permet d'avoir un texte propre
   s.fill(100);
   s.redraw();// On raffraichit notre seconde fenetre à chaque frame

  switch (ETAT){
    
    case 1:
    //On charge l'image

       if(s.mousePressed && buttonOver == true){ // Nous faisons cette étape dans la fenêtre maître et non pas dans l'esclave car l'image chargée appartient au maitre

         // Nous avons cliqué et nous sommes dans la zone  
         // La variable aDejaChargImage est alors passé à vraie
         aDejaChargImage = true;
         String address = selectInput(); 

               if (address == null) {  
                 println("No file selected.");
               }
               
               else {
                 imageImportee = loadImage(address);
                 imageContour = loadImage(address);
                 print(" x1 "+ imageImportee.width  +" y1 "+imageImportee.height   +" x2 "+ imageContour.width  +" y2 "+imageContour.height + "\n" );
                 image(imageImportee, 0,0,500,500);
                 textureMode(IMAGE);
                  // Si on a upload une image alors on passe dans l'état 2
                  
                  
                  // Action a effectuer avant l'entrée dans l'étape 2
                 tabInit();
                 imageContour();   
                 imageLoaded = true;
                 ETAT =2; 
                 
                 variableEnvironnement = new ENVAMORCE();
               }

       }

    break;
    
    case 2:
    // On selectionne la méthode de contour
    // On applique nos traitements sur l'image pour faire apparaitre les contours
    


    break;
    
    case 201:
      // méthode polaire    
      image(imageImportee, 0,0,500,500);  
      if (mouseHasBeenReleased){
         //     dessineMoinUnCercle();  // Inutile
         collision();   
      }
      if(collisionEnded) {
        ETAT = 4;
      }
        
    break;
   
    case 202:
    // méthode main levée
      if (mousePressed && !mouseHasBeenReleased){
        tableConverted = false;
        print("trace");
        traceMoiUnCercleMainsLevee();
        dessineMoiUneCercleTraceAMainLevee();
      }    
      if(mouseHasBeenReleased){
        if(!tableConverted){
          nombrePoint = listeDePoint.size()/2;
          //On fait la moyenne des coordonnées pour trouver le point central
          int i;
          for(i=0; i<listeDePoint.size()-1; i+=2)
          {
            tempX =(Integer)listeDePoint.get(i);     
            xCen += tempX;
            tempY =(Integer)listeDePoint.get(i+1);             
            yCen += tempY;
          }
          xCen /= listeDePoint.size();
          yCen /= listeDePoint.size();    
          xCen = floor(xCen)*2;
          yCen = floor(yCen)*2;
    
          // On copie colle toute les points dans le tableau de point en les mettant en coordonnées polaires
          tableauDePoint = new float[nombrePoint][3];
          for(i=0; i<listeDePoint.size()-1; i+=2)
          {
            tempX = (Integer)listeDePoint.get(i);     
            tempY = (Integer)listeDePoint.get(i+1);          
            tableauDePoint[i/2][0] = sqrt(((tempX - xCen)*(tempX - xCen)) + ((tempY - yCen)*(tempY - yCen)));
            tableauDePoint[i/2][1] = 0;
            if ((tempY - yCen) > 0){
              tableauDePoint[i/2][2] = acos((tempX - xCen) / tableauDePoint[i/2][0]) ;  
            }
            else
            {
              tableauDePoint[i/2][2] = -1*acos((tempX - xCen) / tableauDePoint[i/2][0]) ;  
            }
          }   
          tableConverted = true;
        }        
        image(imageImportee, 0,0,500,500);
        collision();
      }
      
      
      if(collisionEnded) {
        print("end \n");
        ETAT = 4;
        print("\n nombre de point de la delaunay :" + nombrePoint);
      }
    break;        

    case 3:
    //On demande si l'utilisateur veut ajouter d'autre contour
    dessineTriangles();
    break;
    
    case 4: 
    mouseHasBeenReleased = false;
    print("Case 4 \n");
    recupereCoordonnees();
    ETAT = 5;
    break;
    
    case 5:
    print("Case 5 \n");
    methodeDelaunay();
    ETAT = 6;
    break;
    
    case 6:
    print("Case 6 \n");
    //Exctraction des triangles
    ExtractionTriangle(myDelaunay);
    ETAT = 3;   
    break;   
    
    case 7:
    // On dessine les triangles avec la texture d'arrière plan
    dessineTriangles();
    preparationExplosion();
    ETAT = 702;

    break;   
    
    case 702:  
    //On explose tout ça de manière dynamique
    dessineTriangles();
    indiceExplosion++;
    eclatementTriangles();
    if(indiceExplosion>100){
      ETAT = 8;
    }
    break;
    
    case 701:
 
    break;
    
    case 8:
    //On récupére le JPEG
    break;

  }
}

void mousePressed()
{

}


void mouseReleased(){ // on a relâché la souris

   if(ETAT==201 || ETAT==202){
     mouseHasBeenReleased = true;     
    tabInit();
     xCen = mouseX;
     yCen = mouseY;
   } 
  
}

void mouseDragged(){ // la souris a été bougé 

 
}


void keyPressed(){
    
  
}
