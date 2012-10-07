void dessineTriangles(){
  
  for(int t=nombreTriangles-1; t!=-1; t--){ //Pour chaque triangle ...
      fill(225,126,0);
     triangle(TableauCoodonneesExtraites[t][0][0], TableauCoodonneesExtraites[t][0][1] , TableauCoodonneesExtraites[t][1][0], TableauCoodonneesExtraites[t][1][1], TableauCoodonneesExtraites[t][2][0],TableauCoodonneesExtraites[t][2][1] ); 
  }     
}



