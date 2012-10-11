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
        
        fill(215,64,39);
        rect(width-25, 5, 20,20);
        fill(255);
        text("X", width-18, 20);
        fill(100,100,100);
        switch (ETAT){
            case 1:
            //On charge l'image
               

               text("Bonjour et bienvenue dans le logiciel Archi'texture", 40, 40);
               text("Pour commencer, veuillez selectionner une image", 40, 70);
               
                positionRectX = 50;
                positionRectY = 90;
               
                rectWidth = 50;
                rectHeight =30;
                
                
               // On repère à chaque frame la potition de la souris pour savoir si on est dans la zone d'upload ou pas
                positionSourisX = mouseX;
                positionSourisY = mouseY;

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
            
            case 2:
            //On donne le choix à l'utilisateur du type de transformation + nombre de points qu'il veut avoir
            
              positionEllX= 50;
              positionEllY= 50;
              
              positionRectX2 = 45;
              positionRectY2 = 145;
              rectWidth2 =182;
              rectHeight2 = 10;
              
                
              if (onEnterFrame==true){
               
               positionEllX3= 46;
               positionEllY3= 150;
              
              }
              onEnterFrame=false;
              
              
              
              
              
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
              // rectangle des résultats
              rect(positionRectX2 + rectWidth2 + 50, positionRectY2-5, 40, rectHeight2 +10);
              
              // rectangle du validé
              if ( positionSourisX >= 30 && positionSourisX <= 30+rectWidth + 15 && positionSourisY >= positionRectY2 + 50 && positionSourisY <= positionRectY2 + 50 +rectHeight) {
                fill( 100, 100, 100 );
              }
              else {
                  fill( 0, 121, 184 );
              }
              
              rect(30, positionRectY2 + 50, rectWidth + 15, rectHeight);
              fill (255);
              ellipse(positionEllX, positionEllY, 14, 14); //diamètre ellipse = 14
              positionEllX2 = positionEllX;
              
              positionEllY2 = positionEllY+23;
              
              ellipse(positionEllX2,positionEllY2, 14, 14);
              
              rect(positionRectX2, positionRectY2,rectWidth2,rectHeight2);
              ellipse(positionEllX3, positionEllY3, 17,17); //diamètre de notre slider = 16
              
              
             // On remplit les ellipses avec un point bleu
             if(choixTransformation == 1){
               fill( 0, 121, 184 );
               ellipse(positionEllX, positionEllY, 6, 6);   
             }
             
             if(choixTransformation == 2){
               fill( 0, 121, 184 );
               ellipse(positionEllX2, positionEllY2, 6, 6);
  
             }
             fill(255);
             text("VALIDER", 30+8, positionRectY2 + 70);
             
             fill(0);
             int resultat = calculTriangle(positionEllX3);
             text(resultat, positionRectX2 + rectWidth2 + 65, positionRectY2+10);
             nombrePoint = resultat;
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
      }
              
    }
    
    void mouseDragged(){
       
      switch (ETAT){
            case 2:
            
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
