new MYSQL[20] = "true";
new SQL_HOST[50] = "localhost";
new SQL_USER[20] = "root";
new SQL_PASS[50] = "";
new SQL_DB[20] = "samp";
new SERVER_NAME[50] = "";
new MSG_COMMAND_INVALID[200] = "teste";
new DEFAULT_MONEY = 0;
new DEFAULT_LEVEL = 0;
new Float:SpawnX = 0.0;
new Float:SpawnY = 0.0;
new Float:SpawnZ = 0.0;
new Float:SpawnA = 0.0;
new SpawnI = 0;
#pragma warning disable 213
#pragma disablerecursion

stock LoadConfig();
public LoadConfig(){
    new loadConfig[200], config[300];
    format(loadConfig, sizeof(loadConfig), "config.ini");
    format(config, sizeof(config), "config.ini");
    if(!DOF2_FileExists(loadConfig)){
      DOF2_CreateFile(loadConfig);

      //Setting default config
      DOF2_SetString(config, "MySQL", "true");
      DOF2_SetString(config, "MySQL_Host", "localhost");
      DOF2_SetString(config, "MySQL_User", "root");
      DOF2_SetString(config, "MySQL_Pass", "pass");
      DOF2_SetString(config, "MySQL_DB", "samp");
      DOF2_SetString(config, "Server_Name", "Wescley RP");
      DOF2_SetString(config, "Msg_Command_Invalid", "{B30404}[!] {FFFFFF}O comando digitado é invalido, se precisar de ajude use /ajuda");
      DOF2_SetInt(config, "Minimo_GMX", 15);
      DOF2_SetInt(config, "Default_Money", 0);
      DOF2_SetInt(config, "Default_Level", 0);
      DOF2_SetFloat(config, "Default_Spawn_X", 0.0);
      DOF2_SetFloat(config, "Default_Spawn_Y", 0.0);
      DOF2_SetFloat(config, "Default_Spawn_Z", 0.0);
      DOF2_SetFloat(config, "Default_Spawn_A", 0.0);
      DOF2_SetInt(config, "Default_Spawn_Interior", 0);
      DOF2_SaveFile();
      DOF2_Exit();
    }else{
      format(MYSQL, sizeof(MYSQL), DOF2_GetString(config, "MySQL"));
      format(SQL_HOST, sizeof(SQL_HOST), DOF2_GetString(config, "MySQL_Host"));
      format(SQL_USER, sizeof(SQL_USER), DOF2_GetString(config, "MySQL_User"));
      format(SQL_PASS, sizeof(SQL_PASS), DOF2_GetString(config, "MySQL_Pass"));
      format(SQL_DB, sizeof(SQL_DB), DOF2_GetString(config, "MySQL_DB"));
      format(SERVER_NAME, sizeof(SERVER_NAME), DOF2_GetString(config, "Sever_Name"));
      format(MSG_COMMAND_INVALID, sizeof(MSG_COMMAND_INVALID), DOF2_GetString(config, "Msg_Command_Invalid"));
      DEFAULT_LEVEL = DOF2_GetInt(config, "Default_Level");
      DEFAULT_MONEY = DOF2_GetInt(config, "Default_Money");
      SpawnX = DOF2_GetFloat(config, "Default_Spawn_X");
      SpawnY = DOF2_GetFloat(config, "Default_Spawn_Y");
      SpawnZ = DOF2_GetFloat(config, "Default_Spawn_Z");
      SpawnA = DOF2_GetFloat(config, "Default_Spawn_A");
      SpawnI = DOF2_GetInt(config, "Default_Spawn_Interior");
    }
}

/*#define MYSQL true
#define SQL_HOST "localhost"
#define SQL_USER "root"
#define SQL_PASS ""
#define SQL_DB "samp"
#define SERVER_NAME ""
#define MSG_COMMAND_INVALID "teste"
#define DEFAULT_MONEY 0
#define DEFAULT_LEVEL 0
#define SpawnX 0.0
#define SpawnY 0.0
#define SpawnZ 0.0
#define SpawnA 0.0
#define SpawnI 7*/

stock ComandoInvalido(playerid){
    new cmdinvalid[120];
    format(cmdinvalid, sizeof(cmdinvalid), MSG_COMMAND_INVALID);
    SendClientMessage(playerid, -1, cmdinvalid);
    return 1;
}

//Cargos Admin
#define ADMIN_TRAINER 1
#define ADMIN_AJUDANTE 2
#define ADMIN_MODERADOR 3
#define ADMIN_ADMINISTRADOR 4
#define ADMIN_SUPERVISOR 5
#define ADMIN_DIRETOR 6
#define ADMIN_OWNER 7

//Defines levels admin
stock RankAdmin(genero, level){
  new rank[20];
  if(genero == 1){
    switch(level)
    {
      case 1: rank = "Trainer";
      case 2: rank = "Ajudante";
      case 3: rank = "Moderador";
      case 4: rank = "Administrador";
      case 5: rank = "Supervisor";
      case 6: rank = "Diretor";
      case 7: rank = "Owner";
    }
  }else{
    switch(level)
    {
      case 1: rank = "Trainer";
      case 2: rank = "Ajudante";
      case 3: rank = "Moderadora";
      case 4: rank = "Administradora";
      case 5: rank = "Supervisora";
      case 6: rank = "Diretora";
      case 7: rank = "Owner";
    }
  }
  return rank;
}
//Defines Colors admin
ColorAdmin(level)
{
  new CORADM[7];
  switch(level)
  {
    case 1: CORADM = "e0e094";
    case 2: CORADM = "ffff00";
    case 3: CORADM = "da7617";
    case 4: CORADM = "0d8ab9";
    case 5: CORADM = "a200ff";
    case 6: CORADM = "ff2424";
    case 7: CORADM = "ff4c0f";
   default: CORADM = "FFFFFF";
  }
  return CORADM;
}

//Define colors server
Color(type){
  new COLOR[7];
  switch(type){
    case 0: COLOR = "045FB4"; //COLOR_WARN [!]
    case 1: COLOR = "015EB5"; //COLOR_CENTRAL [Centrral]
    case 2: COLOR = "5DFF00"; //COLOR_ADMIN [Admin]
  }
  return COLOR;
}

//Não mexa
// dest[22];
//NetStats_GetIp(playerid, dest, sizeof(dest));

