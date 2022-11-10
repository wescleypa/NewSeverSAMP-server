new tentativas[MAX_PLAYERS] = 1;

public OnPlayerConnect(playerid)
{
	SetSpawnInfo(playerid, 0, 0, Player[playerid][dX],\
	Player[playerid][dY], Player[playerid][dZ], Player[playerid][dA], 0, 0, 0, 0, 0, 0); //Não mexa
	
	//Verificando dados
	new sql_acess[100], name[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, name, sizeof(name));
	
	format(sql_acess, sizeof(sql_acess), "SELECT `username`, `password` FROM `%s` WHERE username='%s'", SQL_TABLE_PLAYER, name);
	mysql_query(conexao, sql_acess);

	if(cache_num_rows() > 0){
		cache_get_value_name(0, "password", Player[playerid][password], 24); //Pega senha do usuário
		new bvindas[50], msgwelcome[200];
		format(bvindas, sizeof(bvindas), "Boas vindas ao %s", SERVER_NAME);
		format(msgwelcome, sizeof(msgwelcome), "\
		{298A08}Notamos que você já possuí visto em nosso País,\n\
		{FFFFFF}portanto, Faça Login digitando sua senha abaixo.");

		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, bvindas, msgwelcome, "Entrar", "Cancelar");
	}else{
		new bvindas[50];
		format(bvindas, sizeof(bvindas), "Boas vindas ao %s", SERVER_NAME);
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, bvindas, "\
		{8A0808}Notamos que você não possuí visto em nosso País,\n\
		{FFFFFF}portanto, Registre-se digitando uma senha abaixo.", "Registrar", "Cancelar");
	}
	Player[playerid][trampando] = 0;
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
  new name[MAX_PLAYER_NAME + 1];
  GetPlayerName(playerid, name, sizeof(name));

  if (dialogid == DIALOG_LOGIN)
  {
  	if(strlen(inputtext) != 0)
    {
       if(!strcmp(Player[playerid][password], inputtext, true, 24)) //Compara a senha do usuário com a digitada
       {
		//Buscando dados do usuário
			ColetaDados(playerid);
		//
	   }else{
		  if(tentativas[playerid] >= 5){
			Kick(playerid);
		  }else{
			new msgerror[300];
			tentativas[playerid] += 1;
			format(msgerror, sizeof(msgerror), "\
			{DF0101}A senha digitada não confere.\n\
			{FFFFFF}Você tem mais {DF0101}%d{FFFFFF} tentativas,\n\
			caso exceda todas tentativas, terá seu acesso bloqueado por segurança.\n\n\
			{0489B1}Deseja tentar novamente ?", (6-tentativas[playerid]));
			ShowPlayerDialog(playerid, DIALOG_LOGIN_ERROR, DIALOG_STYLE_MSGBOX, "ERRO - Dados inválidos", msgerror, "Sim", "Cancelar");
		  }
	   }
    }else{
       
    }
    return 1;
  }
  //Dialog após erro de Login
  else if(dialogid == DIALOG_LOGIN_ERROR){
	if (response)
    {
      new bvindas[50], msgerror[300];
	  format(msgerror, sizeof(msgerror), "\
	  {298A08}Notamos que você já possuí visto em nosso País,\n\
	  {FFFFFF}portanto, Faça Login digitando sua senha abaixo.\n\n\
	  Obs: Note que essa é sua {DF0101}%d°{FFFFFF} tentativa de Login,\n\
	  caso exceda {DF0101}5{FFFFFF}, terá seu acesso bloqueado por segurança.", tentativas[playerid]);

	  format(bvindas, sizeof(bvindas), "%d° Tentativa de Login", tentativas[playerid]);
	  ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, bvindas, msgerror, "Entrar", "Cancelar");
    }
    else 
    {
	  SendClientMessage(playerid, -1, "Você foi desconectado porque recusou realizar Login");
      Kick(playerid);
    }
	return 1;
  }  

  //Dialog Register
  else if(dialogid == DIALOG_REGISTER){
	if(strlen(inputtext) != 0)
    {
      if(strlen(inputtext) > 24){
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Senha muito longa", "\
		{8A0808}A senha digita é muito longa!,\n\
		{FFFFFF}A senha escolhida é muito longa, sua senha deve ser menor de 24 caracteres.", "Registrar", "Cancelar");
	  }else{
		new sql_insert[300];
		format(sql_insert, sizeof(sql_insert), "\
		INSERT INTO `contas`(`username`, `password`,\
		`money`, `level`, `dX`, `dY`, `dZ`, `dA`, `dI`, `admin`, `genre`) VALUES (\
		'%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%d', '0', '1')", name, inputtext, DEFAULT_MONEY, DEFAULT_LEVEL,
		SpawnX, SpawnY, SpawnZ, SpawnA, SpawnI);
		mysql_query(conexao, sql_insert, false);
		//Fazendo Login
		cache_get_value_name(0, "password", Player[playerid][password]); //Pega senha do usuário
		new bvindas[50];
		format(bvindas, sizeof(bvindas), "Boas vindas ao %s", SERVER_NAME);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, bvindas, "\
		{298A08}Notamos que você já possuí visto em nosso País,\n\
		{FFFFFF}portanto, Faça Login digitando sua senha abaixo.", "Entrar", "Cancelar");
		//
		logado[playerid] = 0;
	  }
	}else{

	}
  }   
  return 0;
}

ColetaDados(playerid){

	new sql_acess[300], name[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, name, sizeof(name));

	format(sql_acess, sizeof(sql_acess), "SELECT *\
    FROM `%s` WHERE username='%s'", SQL_TABLE_PLAYER, name);
	mysql_query(conexao, sql_acess);

	//Coletando dados do usuário
	cache_get_value_int(0, "money", Player[playerid][money]); //Pega dinheiro do usuário
	cache_get_value_int(0, "level", Player[playerid][level]); //Pega dinheiro do usuário
	cache_get_value_float(0, "dX", Player[playerid][dX]); //Pega a posição X que o usuário desconectou
	cache_get_value_float(0, "dY", Player[playerid][dY]); //Pega a posição Y que o usuário desconectou
	cache_get_value_float(0, "dZ", Player[playerid][dZ]); //Pega a posição Z que o usuário desconectou
	cache_get_value_float(0, "dA", Player[playerid][dA]); //Pega a posição A que o usuário desconectou
	cache_get_value_int(0, "dI", Player[playerid][dI]); //Pega o interior que o usuário desconectou
	cache_get_value_int(0, "admin", Player[playerid][admin]); //Pega o nível de admin do usuário
	cache_get_value_int(0, "genre", Player[playerid][genre]); //Pega o nível de admin do usuário
	//
	//Seta dados do usuário
	SetaDados(playerid);
}

SetaDados(playerid){
	GivePlayerMoney(playerid, Player[playerid][money]);
	SetPlayerScore(playerid, Player[playerid][level]);

	Spawn(playerid);
	logado[playerid] = 1;
}



//if(dest != "127.0.0.1") return exit();