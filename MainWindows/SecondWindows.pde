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
              positionSourisX = mouseX;
              positionSourisY = mouseY;      

        frameRate(100);   // On met un framerate assez elevé pour ne pas avoir de saute de rafraissisement.
        switch (ETAT){
            case 1:
            //On charge l'image

               text("bonjour je m'appelle adrien et ceci est l'etape 1", 40, 40);
              
                positionRectX = 50;
                positionRectY = 50;
               
                rectSizeX = 50;
                rectSizeY =30;
                
               // On repère à chaque frame la potition de la souris pour savoir si on est dans la zone d'upload ou pas

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
            
              //On donne le choix à l'utilisateur du type de transformation:
              
              positionEllX= 50;
              positionEllY= 50;

              fill(0);
              text("Quelle transformation voulez-vous effectuer?", 30, 30);
              text("Type 1 : Selectionner un contour à main levée", positionEllX +13, positionEllY +5);
              text("Type 2 : Selectionner un contour par expansion", positionEllX +13, positionEllY +27);
              
              fill(255);
              ellipse(positionEllX, positionEllY, 14, 14); //diamètre ellipse =14
              
              positionEllX2 = positionEllX;
              positionEllY2 = positionEllY+23;
              
              ellipse(positionEllX2,positionEllY2, 14, 14);

               if(choixTransformation == 1){
                 fill( 0, 121, 184 );
                 ellipse(positionEllX, positionEllY, 6, 6);   
               }
               
               if(choixTransformation == 2){
                 fill( 0, 121, 184 );
                 ellipse(positionEllX2, positionEllY2, 6, 6);
              
               }
              // Dans le cas où l'utilisateur demande une explosion encadré               
             if (positionSourisX >= positionEllX-7 && positionSourisX <= positionEllX+7 && positionSourisY >= positionEllY-7 && positionSourisY <= positionEllY+7) {
                 
                //On ajoute un nouvel élément à la liste chainée                 
                lesAmorces.add(new AMORCE());
                lesAmorces.getLast().nombrePoint = variableEnvironnement.nombrePointBase;
                lesAmorces.getLast().choixTransformation = 1;                   
                ETAT =202;
                
              }
              // Dans le cas où l'utilisateur demande une explosion circulaire
              if (positionSourisX >= positionEllX2-7 && positionSourisX <= positionEllX2+7 && positionSourisY >= positionEllY2-7 && positionSourisY <= positionEllY2+7) {
                
                //On ajoute un nouvel élément à la liste chainée                 
                lesAmorces.add(new AMORCE());
                lesAmorces.getLast().nombrePoint = variableEnvironnement.nombrePointBase;
                lesAmorces.getLast().choixTransformation = 2;            
                ETAT =201;                
            
            break;
            
            case 201:
              fill(0);
              text("Vous allez maintenant devoir cliquer à l'intérieur de la forme que vous voulez éclater", 30, 30);
            
            break;
            
            
            case 202:
              fill(0);
              text("Vous pouvez maintenant tracer un contour autour de la forme que vous voulez éclater", 30, 30);
    
            break;

            case 3:
              fill(0);
              text("Voulez vous ajouter d'autre contour ?", 30, 30);
              positionRectX1 = 50;
              positionRectX2 = 250;    
              positionRectX3 = 150;           
              positionRectY = 50;
              positionRectY3 = 150;
              
              rectSizeX = 120;
              rectSizeY = 30;
              
               // On repère à chaque frame la potition de la souris pour savoir si on est dans la zone d'upload ou pas
              positionSourisX = mouseX;
              positionSourisY = mouseY;
              
              if ( positionSourisX >= positionRectX1 && positionSourisX <= positionRectX1+rectSizeX && positionSourisY >= positionRectY && positionSourisY <= positionRectY+rectSizeY){
                ETAT = 7;
              }
              if ( positionSourisX >= positionRectX2 && positionSourisX <= positionRectX2+rectSizeX && positionSourisY >= positionRectY && positionSourisY <= positionRectY+rectSizeY) {

                tableauDePoint = new float[nombrePoint][3];                
                tabInit();
                choixTransformation = 0;
                nombrePoint = nombrePointBase;
    
                mouseHasBeenReleased = false;       
                collisionEnded=false;
                ETAT = 2;                     

              }  
              if ( positionSourisX >= positionRectX3 && positionSourisX <= positionRectX3+rectSizeX && positionSourisY >= positionRectY3 && positionSourisY <= positionRectY3+rectSizeY){
                ETAT = 7;
              }              
              
//              // Nous sommes dans la zone et nous n'avons pas chargé d'image
//               if(aDejaChargImage == false){
//               buttonOver = true;
//               }
//               
//               // Nous sommes dans la zone et nous avons déjà chargé une image
//               else{
//               buttonOver = false;
//               }
//               
//              }
              
              // Nous ne sommes pas dans la zone notre historique de chargement d'image est remis à zéro
              fill(255,0,0);
              rect(positionRectX1, positionRectY, rectSizeX, rectSizeY);
              fill(0);
              text("Explode that shit!", 60, 70);
    

              fill(0,0,255);
              rect(positionRectX2, positionRectY, rectSizeX, rectSizeY);
              fill(0);
              text("Add another one !", 260, 70); 

              fill(255,0,255);
              rect(positionRectX3, positionRectY3, rectSizeX, rectSizeY);
              fill(0);
              text("Make the previous one again !", 160, 170);                
            break;            
    
        }
    }
    
    
    void mousePressed(){
       
              
    }
}
