
int positionEllX, positionEllY;
int positionEllX2, positionEllY2;
int positionEllX3, positionEllY3; 


boolean onEnterFrame = true;

int rectWidth, rectHeight;
int rectWidth2, rectHeight2;
int positionRectX, positionRectY;
int positionRectX2, positionRectY2;
int positionRectX3, positionRectY3;
int rectWidth3, rectHeight3;

int positionSourisX, positionSourisY;



public class PFrame extends Frame {
    public PFrame() {
        setBounds(100,100,400,300);
        s = new secondApplet();
        add(s);
        s.init();
        show();
    }
}


// SECOND APPLET

public class secondApplet extends PApplet {

    public void setup() {
        size(400, 300);
        noLoop();
        smooth();
        background(255, 255, 255);
    }
    
    public void draw() {

        frameRate(100);   // On met un framerate assez elevé pour ne pas avoir de saute de rafraissisement.
        
    /******* Bouton d'exit ******/
    
        fill(215,64,39);
        rect(width-25, 5, 20,20);
        
        fill(255);
        text("X", width-18, 20);
        fill(0);
        
    
        switch (ETAT){
          
          case 1: // image loading

                positionRectX = 50;
                positionRectY = 90;
                rectWidth = 50;
                rectHeight =30;
                
               // On repère à chaque frame la position de la souris pour savoir si on est dans la zone d'upload ou pas
                positionSourisX = mouseX;
                positionSourisY = mouseY;

                text("Bonjour et bienvenue dans le logiciel Archi'texture", 40, 40);
                text("Pour commencer, veuillez selectionner une image", 40, 70);
                text("Note:", 40, 170);
                
                fill(100,100,100);
                text("Pour une question de performance", 50, 170);
                text("veuillez noter que votre image sera ", 75, 190);
                text("resizée au format 500*500 px", 75, 210);
                
                
                if ( positionSourisX >= positionRectX && positionSourisX <= positionRectX+rectWidth && positionSourisY >= positionRectY && positionSourisY <= positionRectY+rectHeight) {
                
                  // Nous sommes dans la zone et nous n'avons pas chargé d'image
                 if(aDejaChargImage == false){
                   buttonOver = true;
                 }
                 
                 // Nous sommes dans la zone et nous avons déjà chargé une image
                 else{
                   buttonOver = false;
                 }
                 
                }
                
                // Nous ne sommes pas dans la zone notre historique de chargement d'image est remis à zéro
                else {
                  buttonOver = false;
                  aDejaChargImage = false;
                  fill( 0, 121, 184 );
                }
                
                rect(positionRectX, positionRectY, rectWidth, rectHeight);
                
                fill(255);
                text("CLICK", 60, 110);
                
            break;
            
         case 2: //On donne le choix à l'utilisateur du type de transformation + nombre de points qu'il veut avoir

              if (onEnterFrame==true){
               
               positionEllX3= 46;
               positionEllY3= 150;
              
              }
              
              onEnterFrame=false;
              
              positionEllX= 50;
              positionEllY= 50;
              positionEllX2 = positionEllX;
              positionEllY2 = positionEllY+23;
              
              positionRectX2 = 45;
              positionRectY2 = 145;
              rectWidth2 =182;
              
              positionSourisX = mouseX;
              positionSourisY = mouseY;

              fill(0);
              text("Quelle transformation voulez-vous effectuer?", 30, 30);
              text("Type 1 : Selectionner un contour à main levée", positionEllX +13, positionEllY +5);
              text("Type 2 : Selectionner un contour par expansion", positionEllX +13, positionEllY +27);

              text("Veuillez choisir un nombre de point pour l'explosion:", 30, 120);
              textFont(font,10);
                text("20", 40, 175);
                text("60", 130, 175);
                text("100", 220, 175);
              textFont(font,12);

              fill(255);
              
              /****** Rectangle des résultats *****/
              
              rect(positionRectX2 + rectWidth2 + 50, positionRectY2-5, 40, rectHeight2 +20);
              
              fill(0);
              int resultat = calculTriangle(positionEllX3);
              text(resultat, positionRectX2 + rectWidth2 + 65, positionRectY2+10);
              nombrePoint = resultat;
              
              /****** Rectangle du "validé" *****/
              
              if ( positionSourisX >= 30 && positionSourisX <= 30+rectWidth + 15 && positionSourisY >= positionRectY2 + 50 && positionSourisY <= positionRectY2 + 50 +rectHeight) {
                fill( 100, 100, 100 ); // si la souris est sur le rectangle...
              }
              else {
                  fill( 0, 121, 184 );
              }
              rect(30, positionRectY2 + 50, rectWidth + 15, rectHeight);
              
              /****** Radio Button du choix d'explosion *****/
              
              fill (255);
              ellipse(positionEllX, positionEllY, 14, 14); 
              ellipse(positionEllX2,positionEllY2, 14, 14);
              
              
             // On remplit les ellipses avec un point bleu
              if(choixTransformation == 1){
                fill( 0, 121, 184 );
                ellipse(positionEllX, positionEllY, 6, 6);   
              }
             
              if(choixTransformation == 2){
                fill( 0, 121, 184 );
                ellipse(positionEllX2, positionEllY2, 6, 6);
              }
             
             
              /****** Slider de selection de points *****/
              fill(255);
              
              rect(positionRectX2, positionRectY2,rectWidth2,rectHeight2+10);
              ellipse(positionEllX3, positionEllY3, 17,17);

              text("VALIDER", 30+8, positionRectY2 + 70);

              
              
        break;
            
        case 201:
              fill(0);
              text("Vous allez maintenant devoir cliquer à", 30, 30);
              text("l'intérieur de la forme que vous voulez éclater", 30, 50);
        break;
            
            
        case 202:
              fill(0);
              text("Vous pouvez maintenant tracer un contour autour", 30, 30);
              text("de la forme que vous voulez éclater", 30, 50);
    
        break;
            
           
           case 8: 
           
              positionRectX3 = 50;
              positionRectY3 = 90;
              rectWidth3 = 50;
              rectHeight3 =30;
              
              fill(0);
              text("Fin de l'animation. Voulez-vous sauvegarder?", 30, 30);
              
              
              // ******************* bug car nous n'avons plus la main dans la fenêtre secondaire
              
              if ( positionSourisX >= positionRectX3 && positionSourisX <= positionRectX3 +rectWidth3 && positionSourisY >= positionRectY3 && positionSourisY <= positionRectY3 + rectHeight3) {
                fill( 100, 100, 100 );
              }
              else {
                  fill( 0, 121, 184 );
              }
              
             
              
             
              
              rect(positionRectX3, positionRectY3, rectWidth3, rectHeight3);
              rect(positionRectX3, positionRectY3 + rectHeight3 +20 , rectWidth3+20, rectHeight3);
              
              fill(0);
              text("SAVE", positionRectX3+8, positionRectY3 + rectHeight3/2);
              text("RESTART", 30+8, positionRectY2 + 70);
              
           break;
        }
    }
    
    
    void mousePressed(){
     
      // Bouton d'exit!
      
      if (positionSourisX >= width-25 && positionSourisX <= width-5 && positionSourisY >= 5 && positionSourisY <= 25) {
        exit();         
      }

      
      switch (ETAT){
            case 2:
      
              // Selection pour le type de transformation
              
             if (positionSourisX >= positionEllX-7 && positionSourisX <= positionEllX+7 && positionSourisY >= positionEllY-7 && positionSourisY <= positionEllY+7) {
               //exit();
               choixTransformation = 1;
                
              }
              
              if (positionSourisX >= positionEllX2-7 && positionSourisX <= positionEllX2+7 && positionSourisY >= positionEllY2-7 && positionSourisY <= positionEllY2+7) {

                choixTransformation = 2;
                
              }
              
             // Selection du bouton valider
             
             if ( positionSourisX >= 30 && positionSourisX <= 30+rectWidth + 15 && positionSourisY >= positionRectY2 + 50 && positionSourisY <= positionRectY2 + 50 +rectHeight) {
               
               if(choixTransformation==1){
                 ETAT =202;
               }
               if(choixTransformation==2){
                 ETAT =201;
               }

             }
            break;
            
            case 8:
            
            
            
            
            
            break;
            
      }
              
    }
    
    void mouseDragged(){
       
      switch (ETAT){
        
            case 2:
              //slider
              if (positionSourisX >= positionRectX2 && positionSourisX <= positionRectX2 + rectWidth2 && positionSourisY >= positionEllY3-10 && positionSourisY <= positionEllY3+10) {
                
                positionEllX3= positionSourisX;
                
              }    
            break;
      }
      
   }
    
    int calculTriangle(int positionEllipse){
      int resultat;
      resultat= positionEllipse*20/45;
      return resultat;
    }
    
}
