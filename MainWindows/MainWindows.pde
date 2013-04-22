// ******************************** VARIABLES ******************************** //

//// PREMIERE fenetre

//PImage imageImportee;
//PImage imageContour;

//int nombreTriangles;
//double imageGet;
//int [][] TableauSommet; // initialisé à 150 sommets
//int [][] TableauTriangles; // initialisé à 1042triangles
//int [] TableauTampon;
//int [] tableauDesSommets1;
//int [] tableauDesSommets2;
//int [] TableauTamponTrie;
//int [][] TableauIndices;
//float [][][] TableauCoodonneesTrianglesActuelles;
//float [][][] TableauCoodonneesExtraites;
//boolean tableConverted = false;

//int x;
//int y;
//int i=0; // variable globale servant à definir le nombre de sommets progressivement

//// DEUXIEME fenetre
//PFrame f;
//secondApplet s;
//PFont font;

//int positionEllX, positionEllY;
//int positionEllX2, positionEllY2;

//int rectSizeX;
//int rectSizeY;
//int positionRectX, positionRectY;

//int positionSourisX, positionSourisY;


boolean buttonImageChoosen;
//boolean aDejaChargImage=false;
//int choixTransformation; // 0 = pas encore assigné 1 = delaunay, 2 = polaires

//int ETAT =1;

// ******************************** VARIABLES POUR L'EXCTRACTION DES CONTOURS ******************************* //
//declaration des classes
//class unPoint {
//  int x;
//  int y;
//  boolean arrete = false;
//}

//declaration des variables
//int mousePress = 1;

boolean   mouseHasBeenPressed = false;
boolean   mouseHasBeenReleased = false;
boolean   collisionEnded = false;
boolean   delaunayNotSetted = true;

//On cree la liste de point
//List listePointCercle = new LinkedList();
int nombrePoint =10;
float tableauDePoint[][] = new float[nombrePoint][3];
//int seuil = 20;


//Pour la figure à main levée
//unPoint pointChemin = new unPoint();

//int typeSelection = 0;
//int tempX, tempY;

// pour le tracé à main levé
//ArrayList listeDePoint = new ArrayList();
//boolean imageLoaded = false;

//unPoint un = new unPoint();
//unPoint temp = new unPoint();
//unPoint position = new unPoint();
//float xCen =0, yCen = 0;

// ******************************** PARAMETRES POUR LA DELAUNAY ******************************** //


//float [][] pointsATracer = new float [nombrePoint][2];
//float [] [] points = new float [350][350];
//float [] [] tableauSommetCoordonnees = new float [2][350]; // On considère que le nombre de sommets max est 350
//
//Delaunay myDelaunay;
// ******************************** PARAMETRES DE LA FENETRE PRINCIPALE ******************************** //


void setup() {


  size(500, 500, P3D);
  background(255, 255, 255);

  imageImportee =loadImage("Presentation1.png");
  image(imageImportee, 0, 0, 500, 500);
  textureMode(IMAGE);

  smooth();

  font = loadFont("ArabicTypesetting-20.vlw"); // Cette police pixellise moins
  textFont(font);

  PFrame f = new PFrame();
  // Pour mettre eventuellement notre fenêtre en mode undecorated

  // f.dispose();
  //f.setUndecorated(true);
  //f.setVisible(true);
}



// ******************************** "MAIN" ******************************** //


void draw() { //draw() est appellée à chaque frame
  //print("\n \n Etat : " + ETAT);
  // print(" Nous somme dans l'état : " + ETAT+ "\n");

  s.background(255, 255, 255); // On met un fond blanc dans l'autre fenêtre en permanence ce qui permet d'avoir un texte propre
  s.fill(100);
  s.redraw();// On raffraichit notre seconde fenetre à chaque frame


  switch (ETAT) {

  case 1:
    if (selectedFile != null) {
      imageImportee = loadImage(selectedFile.getAbsolutePath());
      imageContour = loadImage(selectedFile.getAbsolutePath());
      print(" x1 "+ imageImportee.width  +" y1 "+imageImportee.height   +" x2 "+ imageContour.width  +" y2 "+imageContour.height + "\n" );
      image(imageImportee, 0, 0, 500, 500);
      textureMode(IMAGE);
      // Si on a upload une image alors on passe dans l'état 2
      // Action a effectuer avant l'entrée dans l'étape 2
      tabInit();
      imageContour();   
      imageLoaded = true;
      ETAT =2;
    }
    break;

  case 2:
    // On selectionne la méthode de contour
    // On applique nos traitements sur l'image pour faire apparaitre les contours

    if (typeSelection == 2) ETAT = 202;
    if (typeSelection == 1) ETAT = 201;

    break;

  case 201:
    // méthode polaire    
    image(imageImportee, 0, 0, 500, 500);  
    //On lance l'expansion si la souris a été relaché
    if (variableEnvironnement.mouseHasBeenReleased) {
      collision();
    }

    if (variableEnvironnement.collisionEnded) {
      lesAmorces.getLast().centreTransformation.x = (int)xCen;
      lesAmorces.getLast().centreTransformation.y = (int)yCen;         
      ETAT = 4;
    }
    break;

  case 202:
    // méthode main levée

    //Tant que la souris n'a pas été relaché, on continue à enregistrer des points.
    if (mousePressed && !variableEnvironnement.mouseHasBeenReleased) {
      lesAmorces.getLast().tableConverted = false;
      traceMoiUnCercleMainsLevee();
      dessineMoiUneCercleTraceAMainLevee();
    }    

    //Quand la souris est relaché, on lance la conversion.
    if (variableEnvironnement.mouseHasBeenReleased) {
      if (!lesAmorces.getLast().tableConverted) {

        //Comme on mets les Y à la suite des X dans la liste chainée, nombrePoint = size/2.
        lesAmorces.getLast().nombrePoint = listeDePoint.size()/2;

        //On fait la moyenne des coordonnées pour trouver le point central
        for (int i=0; i<listeDePoint.size()-1; i+=2)
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

        // On stocke le point central dans l'instance
        lesAmorces.getLast().centreTransformation.x = (int)xCen;
        lesAmorces.getLast().centreTransformation.y = (int)yCen;          

        // On copie colle toute les points dans le tableau de point en les mettant en coordonnées polaires
        lesAmorces.getLast().tableauDePoint = new float[lesAmorces.getLast().nombrePoint][3];
        for (i=0; i<listeDePoint.size()-1; i+=2)
        {
          tempX = (Integer)listeDePoint.get(i);     
          tempY = (Integer)listeDePoint.get(i+1);          
          lesAmorces.getLast().tableauDePoint[i/2][0] = sqrt(((tempX - xCen)*(tempX - xCen)) + ((tempY - yCen)*(tempY - yCen)));
          lesAmorces.getLast().tableauDePoint[i/2][1] = 0;
          if ((tempY - yCen) > 0) {
            lesAmorces.getLast().tableauDePoint[i/2][2] = acos((tempX - xCen) / lesAmorces.getLast().tableauDePoint[i/2][0]) ;
          }
          else
          {
            lesAmorces.getLast().tableauDePoint[i/2][2] = -1*acos((tempX - xCen) / lesAmorces.getLast().tableauDePoint[i/2][0]) ;
          }
        }   
        lesAmorces.getLast().tableConverted = true;
      }        
      image(imageImportee, 0, 0, 500, 500);
      collision();
    }


    if (lesAmorces.getLast().collisionEnded) {
      print("end \n");
      ETAT = 4;
    }
    break;        

  case 3:
    //On demande si l'utilisateur veut ajouter d'autre contour
    dessineTriangles();
    break;

  case 4: 
    variableEnvironnement.mouseHasBeenReleased = false;
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
    if (indiceExplosion>100) {
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


void mouseReleased() { // on a relâché la souris

  if (ETAT==201 || ETAT==202) {
    variableEnvironnement.mouseHasBeenReleased = true;     
    tabInit();
    lesAmorces.getLast().centreTransformation.x = mouseX;
    lesAmorces.getLast().centreTransformation.y = mouseY;
  }
}

void mouseDragged() { // la souris a été bougé
}


void keyPressed() {
}

