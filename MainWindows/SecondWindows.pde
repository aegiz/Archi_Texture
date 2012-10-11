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
    }
    
    public void draw() {

        frameRate(100);   // On met un framerate assez elevé pour ne pas avoir de saute de rafraissisement.
        switch (ETAT){
            case 1:
            //On charge l'image

               text("Bonjour et bienvenue dans le logiciel Archi'texture", 40, 40);
              
                positionRectX = 50;
                positionRectY = 50;
               
                rectSizeX = 50;
                rectSizeY =30;
                
               // On repère à chaque frame la potition de la souris pour savoir si on est dans la zone d'upload ou pas
                positionSourisX = mouseX;
                positionSourisY = mouseY;

                if ( positionSourisX >= positionRectX && positionSourisX <= positionRectX+rectSizeX && positionSourisY >= positionRectY && positionSourisY <= positionRectY+rectSizeY) {
                
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

                rect(positionRectX, positionRectY, rectSizeX, rectSizeY);
                
                fill(255);
                text("CLICK", 60, 70);
            break;
            
            case 2:
            //On donne le choix à l'utilisateur du type de transformation + nombre de points qu'il veut avoir
            
            
              positionEllX= 50;
              positionEllY= 50;
              
              positionEllX3= 50;
              positionEllY3= 230;
              
              positionSourisX = mouseX;
              positionSourisY = mouseY;
              
              fill(0);
              text("Quelle transformation voulez-vous effectuer?", 30, 30);
              text("Type 1 : Selectionner un contour à main levée", positionEllX +13, positionEllY +5);
              text("Type 2 : Selectionner un contour par expansion", positionEllX +13, positionEllY +27);
              
              text("Veuillez choisir un nombre de point pour l'explosion ", 30, 180);
              
              fill(255);
              ellipse(positionEllX, positionEllY, 14, 14); //diamètre ellipse = 14
              ellipse(positionEllX3, positionEllY3, 17,17); //diamètre de notre slider = 16
              
              positionEllX2 = positionEllX;
              positionEllY2 = positionEllY+23;
              
              ellipse(positionEllX2,positionEllY2, 14, 14);
              
             // On remplit les ellipse avec un point bleu
             if(choixTransformation == 1){
               fill( 0, 121, 184 );
               ellipse(positionEllX, positionEllY, 6, 6);   
             }
             
             if(choixTransformation == 2){
               fill( 0, 121, 184 );
               ellipse(positionEllX2, positionEllY2, 6, 6);
  
             }
            
            break;
            
            case 201:
              fill(0);
              text("Vous allez maintenant devoir cliquer à l'intérieur de la forme que vous voulez éclater", 30, 30);
            
            break;
            
            
            case 202:
              fill(0);
              text("Vous pouvez maintenant tracer un contour autour de la forme que vous voulez éclater", 30, 30);
    
            break;
            
        
    
        }
    }
    
    
    void mousePressed(){
              
              // Selection pour le type de transformation
              
             if (positionSourisX >= positionEllX-7 && positionSourisX <= positionEllX+7 && positionSourisY >= positionEllY-7 && positionSourisY <= positionEllY+7) {
                
                println("Main levée");
                
               choixTransformation = 1;
                ETAT =202;
              }
              
              if (positionSourisX >= positionEllX2-7 && positionSourisX <= positionEllX2+7 && positionSourisY >= positionEllY2-7 && positionSourisY <= positionEllY2+7) {
                
                println("Circulaire");
                
                choixTransformation = 2;
                ETAT =201;
              }
              
              
    }



}
