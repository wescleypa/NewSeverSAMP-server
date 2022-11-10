//Define locais
enum Locais{
    ls, //Los Santos
    lv, //Las Venturas
    sf  //San Fierro
}

stock ToSpawn(playerid, local){ 
  switch(local){
    case ls:{
      SetPlayerPos(playerid, 1482.1118, -1677.4886, 14.0469);
      SetPlayerFacingAngle(playerid, 176.2255);
      SetPlayerInterior(playerid, 0);
    }    
    case lv:{
      SetPlayerPos(playerid, 1690.5522, 1453.8761, 10.7662);
      SetPlayerFacingAngle(playerid, 269.2406);
      SetPlayerInterior(playerid, 0);
    }
    case sf:{
      SetPlayerPos(playerid, 1417.0,-295.8,14.1);
      SetPlayerInterior(playerid, 0);
    }
  }
  return 1;
}