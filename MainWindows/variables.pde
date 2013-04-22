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
File selectedFile;

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

//float tableauDePoint[][] = new float[nombrePoint][3];
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
 
 
float [][] pointsATracer;
float [] [] points = new float [350][350];
float [] [] tableauSommetCoordonnees = new float [2][350]; // On considère que le nombre de sommets max est 350

Delaunay myDelaunay;


// ******************************** PARAMETRES POUR L'EXPLOSION ******************************** //


float indiceExplosion = 0;
float vitesseExplosion = 2;
float pesanteur = 0.02;
float aleatoire = 0.2;

int [][] donneesExplosion;

// ******************************** Variable d'environnement pour l'amorce ***************************** //
public class ENVAMORCE{
  public   boolean   mouseHasBeenPressed;
  public   boolean   mouseHasBeenReleased;
  public   boolean   collisionEnded;
  public   boolean   delaunayNotSetted;
  public   int   nombrePointBase;  
  public   int amorceNB;
  
  public ENVAMORCE(){
    this.mouseHasBeenPressed = false;
    this.mouseHasBeenReleased = false;
    this.nombrePointBase = 10; 
    this.amorceNB = 0;
  }
  
  public void nouvAmorce(){
    this.mouseHasBeenPressed = false;
    this.mouseHasBeenReleased = false;
    this.delaunayNotSetted = true; 
    this.nombrePointBase = 10; 
    this.amorceNB++;
  }
}
              
  ENVAMORCE variableEnvironnement = new ENVAMORCE();

// ******************************** CLASSE QUI CONTIENT UNE AMORCE D'EXPLOSION***************************** //
// Les amorce d'explosion contiennent tout ce qu'il faut pour démarer une explosion.
public class AMORCE{
  
  float [][] tableauDePoint; 
  int nombrePoint;
  int choixTransformation;
  public boolean delaunayNotSetted = true;    
  public UNPOINT centreTransformation; 
  public boolean tableConverted;
  public boolean collisionEnded;
  public AMORCE(){
    this.delaunayNotSetted = true;     
    this.collisionEnded = false;
    this.tableConverted = false;
    this.choixTransformation = 0;
    this.nombrePoint = variableEnvironnement.nombrePointBase;
    this.centreTransformation.x=0;
    this.centreTransformation.y=0;    
  }
  
  public UNPOINT getCenter(){
    return centreTransformation;
  }

}

LinkedList<AMORCE> lesAmorces = new LinkedList<AMORCE>();
