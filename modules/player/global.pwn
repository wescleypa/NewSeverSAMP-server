#include "../modules/player/strtock.pwn"

new logado[MAX_PLAYERS] = 0;

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	TogglePlayerSpectating(playerid, false);
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
	
	GetVehicleParamsEx(vehicleid, motorr[vehicleid], faroll[vehicleid],
	alarmee[vehicleid], portass[vehicleid], capoo[vehicleid],
    portamalass[vehicleid], objetivoo[vehicleid]);

    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, faroll[vehicleid], alarmee[vehicleid],
	portass[vehicleid], capoo[vehicleid], portamalass[vehicleid], objetivoo[vehicleid]);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new name[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	GetPlayerPos(playerid, Player[playerid][dX], Player[playerid][dY], Player[playerid][dZ]);
	GetPlayerFacingAngle(playerid, Player[playerid][dA]);
	Player[playerid][dI] = GetPlayerInterior(playerid);
	
	Salvar(playerid);
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart){
	new Float:pHealth[MAX_PLAYERS];
	GetPlayerHealth(playerid, pHealth[playerid]);
    if(pHealth[playerid] < 4.0){
		SetPlayerHealth(playerid, 4.0);
		TogglePlayerControllable(playerid, 0);
		Send(playerid, 1, "adios boy");
	}
	return 1;
}

stock Spawn(playerid){ //Spawn player login
	SpawnPlayer(playerid);
	SetPlayerPos(playerid, Player[playerid][dX], Player[playerid][dY], Player[playerid][dZ]);
	SetPlayerFacingAngle(playerid, Player[playerid][dA]); 
	SetPlayerInterior(playerid, Player[playerid][dI]);
}

stock Salvar(playerid){
	if(logado[playerid] == 0) return 1;

	new name[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);

	new sql_update[300];
	format(sql_update, sizeof(sql_update), "UPDATE `%s` SET `money`='%d', `level`='%d',\
	`dI`='%d', `dX`=%f, `dY`=%f, `dZ`=%f, `dA`=%f, `admin`=%d WHERE `username`='%s'", SQL_TABLE_PLAYER, Player[playerid][money],\ 
	Player[playerid][level], Player[playerid][dI], Player[playerid][dX], Player[playerid][dY],\
	Player[playerid][dZ], Player[playerid][dA], Player[playerid][admin], name);
	mysql_query(conexao, sql_update, false);
	return 1;
}

stock ToAdmins(msg[]){
	foreach(new i: Player)
    {
		if(Player[i][admin] >= ADMIN_ADMINISTRADOR){
			SendClientMessage(i, -1, msg);
		}
	}
	return 1;
}

stock SalvarContas(){//Salvamento de contas em geral
	foreach(new i: Player){
		if(logado[i] > 0){
			new namesalvar[MAX_PLAYER_NAME+1], sql_update[300];
			GetPlayerName(i, namesalvar, sizeof(namesalvar));

			format(sql_update, sizeof(sql_update), "UPDATE `%s` SET `money`='%d', `level`='%d',\
			`dI`='%d', `dX`=%f, `dY`=%f, `dZ`=%f, `dA`=%f, `admin`=%d WHERE `username`='%s'", SQL_TABLE_PLAYER, Player[i][money],\ 
			Player[i][level], Player[i][dI], Player[i][dX], Player[i][dY],\
			Player[i][dZ], Player[i][dA], Player[i][admin], namesalvar);
			mysql_query(conexao, sql_update, false);
		}
	}
}