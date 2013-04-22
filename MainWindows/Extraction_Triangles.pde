void ExtractionTriangle(Delaunay myDelaunay){

  TableauSommet = new int [nombrePoint][5500]; // end un tableau statique assez grand le mieux aurait été de le faire en dynamique avec une arraylist
  // en abcisse on a le nombre de sommet ->i et en ordonné les liens avec ces même sommets
  
  /* Création et initialisation du Tableau tampon de sommets! */
  
  //print("\n\n");
  
  for(int sommet=0; sommet<nombrePoint; sommet++){ //Pour chaque sommet...
  
    // Mise en tableau tampon
    TableauTampon = myDelaunay.getLinked(sommet); // ...on parcours tous les sommets liés et on les met dans un tableau tampon

    // Première partie du nettoyage du Tableau Tampon: on enlève les 0 en trop et on leur colle la valeure 1042
    
    for(int j=0;j<TableauTampon.length-1; j++){ 
     
      if (TableauTampon[j]==0 && TableauTampon[j+1]== 0){ // si on a deux zeros ou plus consécutifs cela signifie que ce sont des bugs -> on leur met la valeure 1042
         for(j=j; j<TableauTampon.length; j++){
            TableauTampon[j]=1042;
         }
      }
      
    }

    // Tri à bulles :
    
    int changement=1;
    int x; // variable tampon
      
    while(changement>0){ //tant qu'il ya des valeurs à échanger
    
      changement=0; // on réinitialise changement quand la boucle repart

      for(int j=0;j<TableauTampon.length-1; j++){ 
   
        if(TableauTampon[j+1]<TableauTampon[j]){ //on compare chaque élément à son voisin
          x=TableauTampon[j];
          TableauTampon[j]=TableauTampon[j+1];
          TableauTampon[j+1]=x;
          changement++; //on signale qu'il ya eu un changement
        }

      }
    } // fin du while
    
    // Deuxième partie du netttoyage: Suppression des potentiels deux zéros consécutifs en début de tableau
    // BUG à modifier
    /*try {
      
      if (TableauTampon[0]==0 && TableauTampon[1]==0){ // On passe l'une des deux valeurs à 1042 ...
        TableauTampon[0]=1042;
      }
    
    }finally{}
    */
    
    if (sommet==0 && TableauTampon[0]==0){ // Si l'on est dans le sommet on ne peut pas être relié à 0
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

  // Replaçage dans le tableau global en plaçant la valeur 1042 en bout:
  
   for(int j=0;j<TableauTampon.length; j++){          
        TableauSommet[sommet][j] = 1042;
   }
   
   for(int j=0;j<TableauSommet.length; j++){          // Pour éliminer les derniers 0
        TableauSommet[sommet][j] = 1042;
   }
   
   for(int j=0;j<TableauTampon.length; j++){
      TableauSommet[sommet][j] = TableauTampon[j];
   }
    
 
  } // fin du for
    
    
  
      
  /* Afichage des sommets */
  
 /* for(int t=0; t<i; t++){  
    print("\n\n ");
    print("\n sommet n° "+t);
    
    for(int j=0; j<TableauSommet.length; j++){  
      
      print("\n "+ TableauSommet[t][j]);
      
    }
  }  */
     
  /*Extraction des triangles*/
  
  int Sommet1Triangle = 0; 
  int Sommet2Triangle = 0;
  int Sommet3Triangle = 0;
  int indiceTableauTriangles=0;
  
  TableauTriangles = new int [3][5000];
  //TableauTrianglesTrie = new int [3][];
  
 /* print("\n\n nombre de sommets = "+i);
  print("\n TableauSommet.length = "+TableauSommet.length);
  */
  for(int sommet=0; sommet<nombrePoint; sommet++){  
    
    for(int j=0; j<TableauSommet.length; j++){  
      
      Sommet1Triangle=sommet; // 0
      Sommet2Triangle= TableauSommet[sommet][j]; // 1
     
    if (Sommet2Triangle != 1042){  // on ne prend pas en compte les valeurs ou il y a 1042
     
      for(int z=j; z<TableauSommet.length; z++){ // Pour le doublet {Sommet1Triangle, Sommet2Triangle} concerné on vérifie le Sommet3Triangle
       
        Sommet3Triangle= TableauSommet[sommet][z+1]; //3-4-5...
        int valeurTest1=0;
        int valeurTest2=0;
        
        
        if (Sommet3Triangle != 1042 && Sommet1Triangle != Sommet3Triangle && Sommet2Triangle != Sommet3Triangle){  // on ne prend pas en compte les valeurs ou il y a 1042 ni les doublets de 0
          print("\n Triplet testé:" +Sommet1Triangle+ "-"+Sommet2Triangle+ "-"+Sommet3Triangle);
          
          for (int t=0; t<TableauSommet.length; t++){ // On est dans notre troisième sommet
          
              if (TableauSommet[Sommet3Triangle][t]==Sommet1Triangle){  // le Sommet1Triangle est dans le tableau du Sommet3Triangle
                 valeurTest1=1;
              }
              if (TableauSommet[Sommet3Triangle][t]==Sommet2Triangle){ // le Sommet2Triangle est dans le tableau du Sommet3Triangle
                 valeurTest2=1;
              }
  
          }
          
           if (valeurTest1==1 && valeurTest2==1){ // le triplet testé est bon -> on a bien triangle

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

          if (TableauTriangles[j+1][t]< TableauTriangles[j][t]){ // si la première case est inférieure à la suivante
              TableauTamponTrie[0] = TableauTriangles[j][t];
              TableauTriangles[j][t] = TableauTriangles[j+1][t];
              TableauTriangles[j+1][t] = TableauTamponTrie[0];
              vartest++;
          }
 
      }
      
    }

  }

 
/* Suppression des doublons: on met 666 à la place d'un doublon */

int var1=0;
int var2=0;
int var3=0;

  for (int t=0; t<indiceTableauTriangles; t++){
    
    var1= TableauTriangles[0][t];  // On récupère les valeurs de la ligne courante
    var2= TableauTriangles[1][t];
    var3= TableauTriangles[2][t];
    
    for (int r=t+1 ; r<indiceTableauTriangles; r++){           // On vérifie que sur les lignes suivantes que les trois valeurs ne s'y trouvent pas déjà
      
      
      if (TableauTriangles[0][r]==var1 && TableauTriangles[1][r]==var2 && TableauTriangles[2][r]==var3){
        
        TableauTriangles[0][r]=666;
        TableauTriangles[1][r]=666;
        TableauTriangles[2][r]=666;
      }
      
    }
    
  }   
 
  
/* Création d'un dernier tableau avec les triangles sans doublons */  

TableauIndices = new int [6][3500];
   
  nombreTriangles=0;
  
    for (int t=0; t<indiceTableauTriangles; t++){
   print("\n"+TableauTriangles[0][t]+"-"+TableauTriangles[1][t]+"-"+TableauTriangles[2][t] + " utututut");
      if (TableauTriangles[0][t]!= 666 && TableauTriangles[1][t]!=666 && TableauTriangles[2][t]!=666){
        
        TableauIndices[0][nombreTriangles]= TableauTriangles[0][t];
        TableauIndices[1][nombreTriangles]= TableauTriangles[1][t];
        TableauIndices[2][nombreTriangles]= TableauTriangles[2][t];
        nombreTriangles++;
    }
  }
  
  TableauCoodonneesExtraites = new float [nombreTriangles][3][2]; // On crée le tableau final qui contiendra les coordonnées des 3 sommets des p triangles
  float [][] myEdges = myDelaunay.getEdges();
  int [] localLinks;
  //On transforme les indices de sommets en coordonnées
  int sommet1, sommet2, sommet3;
  float coordonnee_x_sommet1, coordonnee_x_sommet2, coordonnee_x_sommet3, coordonnee_y_sommet1, coordonnee_y_sommet2, coordonnee_y_sommet3;
  
  for(int t=0; t<nombreTriangles; t++){ //Pour chaque triangle ...
   
    if(TableauIndices[0][t]!=0 || TableauIndices[1][t]!=0 || TableauIndices[2][t]!=0){ // Pour éviter le cas où l'on a la combinaison 0-0-0



      TableauCoodonneesExtraites[t][0][0] = pointsATracer[TableauIndices[0][t]][0];
      TableauCoodonneesExtraites[t][1][0] = pointsATracer[TableauIndices[1][t]][0];
      TableauCoodonneesExtraites[t][2][0] = pointsATracer[TableauIndices[2][t]][0];
//      
      TableauCoodonneesExtraites[t][0][1] = pointsATracer[TableauIndices[0][t]][1];
      TableauCoodonneesExtraites[t][1][1] = pointsATracer[TableauIndices[1][t]][1];
      TableauCoodonneesExtraites[t][2][1] = pointsATracer[TableauIndices[2][t]][1];
    }
  }

}
