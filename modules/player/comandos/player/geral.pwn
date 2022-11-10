CMD:motor(playerid){
    if(!IsPlayerInAnyVehicle(playerid)) return ComandoInvalido(playerid);

    new vehicleId = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId],
	alarmee[vehicleId], portass[vehicleId], capoo[vehicleId],
    portamalass[vehicleId], objetivoo[vehicleId]);

    if(motorr[vehicleId]){
        Send(playerid, -1, "{B30404}[!] {FFFFFF}O motor do veículo foi desligado.");
        SetVehicleParamsEx(vehicleId, VEHICLE_PARAMS_OFF, faroll[vehicleId], alarmee[vehicleId],
	    portass[vehicleId], capoo[vehicleId], portamalass[vehicleId], objetivoo[vehicleId]);
    }else{
        Send(playerid, -1, "{B30404}[!] {FFFFFF}O motor do veículo foi ligado.");
        SetVehicleParamsEx(vehicleId, VEHICLE_PARAMS_ON, faroll[vehicleId], alarmee[vehicleId],
	    portass[vehicleId], capoo[vehicleId], portamalass[vehicleId], objetivoo[vehicleId]);
    }
    return 1;
}

CMD:farol(playerid){
    if(!IsPlayerInAnyVehicle(playerid)) return ComandoInvalido(playerid);

    new vehicleId = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId],
	alarmee[vehicleId], portass[vehicleId], capoo[vehicleId],
    portamalass[vehicleId], objetivoo[vehicleId]);

    if(faroll[vehicleId]){
        SetVehicleParamsEx(vehicleId, motorr[vehicleId], VEHICLE_PARAMS_OFF, alarmee[vehicleId],
	    portass[vehicleId], capoo[vehicleId], portamalass[vehicleId], objetivoo[vehicleId]);
    }else{
        SetVehicleParamsEx(vehicleId, motorr[vehicleId], VEHICLE_PARAMS_ON, alarmee[vehicleId],
	    portass[vehicleId], capoo[vehicleId], portamalass[vehicleId], objetivoo[vehicleId]);
    }
    return 1;
}

CMD:portas(playerid){
    if(!IsPlayerInAnyVehicle(playerid)) return ComandoInvalido(playerid);

    new vehicleId = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId],
	alarmee[vehicleId], portass[vehicleId], capoo[vehicleId],
    portamalass[vehicleId], objetivoo[vehicleId]);

    if(portass[vehicleId]){
        SetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId], alarmee[vehicleId],
	    VEHICLE_PARAMS_OFF, capoo[vehicleId], portamalass[vehicleId], objetivoo[vehicleId]);
    }else{
        SetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId], alarmee[vehicleId],
	    VEHICLE_PARAMS_ON, capoo[vehicleId], portamalass[vehicleId], objetivoo[vehicleId]);
    }
    return 1;
}

CMD:portamalas(playerid){
    if(!IsPlayerInAnyVehicle(playerid)) return ComandoInvalido(playerid);

    new vehicleId = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId],
	alarmee[vehicleId], portass[vehicleId], capoo[vehicleId],
    portamalass[vehicleId], objetivoo[vehicleId]);

    if(portamalass[vehicleId]){
        SetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId], alarmee[vehicleId],
	    portamalass[vehicleId], capoo[vehicleId], VEHICLE_PARAMS_OFF, objetivoo[vehicleId]);
    }else{
        SetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId], alarmee[vehicleId],
	    portamalass[vehicleId], capoo[vehicleId], VEHICLE_PARAMS_ON, objetivoo[vehicleId]);
    }
    return 1;
}

CMD:alarme(playerid){
    if(!IsPlayerInAnyVehicle(playerid)) return ComandoInvalido(playerid);

    new vehicleId = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId],
	alarmee[vehicleId], portass[vehicleId], capoo[vehicleId],
    portamalass[vehicleId], objetivoo[vehicleId]);

    if(alarmee[vehicleId]){
        SetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId], VEHICLE_PARAMS_OFF,
	    portamalass[vehicleId], capoo[vehicleId], portass[vehicleId], objetivoo[vehicleId]);
    }else{
        SetVehicleParamsEx(vehicleId, motorr[vehicleId], faroll[vehicleId], VEHICLE_PARAMS_ON,
	    portamalass[vehicleId], capoo[vehicleId], portass[vehicleId], objetivoo[vehicleId]);
    }
    return 1;
}

CMD:desvirar(playerid){
    if(!IsPlayerInAnyVehicle(playerid))
        return Send(playerid, 0xFF0000FF, "[!] Você não está em nenhum veículo");
    new Float:X[MAX_PLAYERS], Float:Y[MAX_PLAYERS], Float:Z[MAX_PLAYERS], Float:angulo[MAX_PLAYERS];
    new str[128];
    veiculo[playerid] = GetPlayerVehicleID(playerid);
    GetVehiclePos(veiculo[playerid], X[playerid], Y[playerid], Z[playerid]);
    GetVehicleZAngle(veiculo[playerid], angulo[playerid]);
    SetVehiclePos(veiculo[playerid], X[playerid], Y[playerid], Z[playerid]);
    SetVehicleZAngle(veiculo[playerid], angulo[playerid]);
    SetCameraBehindPlayer(playerid);
    format(str, sizeof(str), "{%d}[!] {FFFFFF}Veículo desvirado.", Color(0));
    return Send(playerid, -1, str); 
}  
 
CMD:reparar(playerid){
    new RepTime[MAX_PLAYERS], Float:health;

    if(Player[playerid][vip] <= 0  && Player[playerid][admin] <= 0)
       return Send(playerid, 0xFF0000FF, "[!] Você não tem permissão!");

    if(!IsPlayerInAnyVehicle(playerid))
        return Send(playerid, 0xFF0000FF, "[!] Você não está em nenhum veículo");

    if((gettime() - RepTime[playerid]) < 120)
    	return Send(playerid, -1, "[!] Voce reparou um veiculo recentemente");
   
    RepTime[playerid] = gettime();
    veiculo[playerid] = GetPlayerVehicleID(playerid);
    GetVehicleHealth(veiculo[playerid], health);
    RepairVehicle(veiculo[playerid]);
    if(health > 1000){
    	RepairVehicle(veiculo[playerid]);
    	SetVehicleHealth(veiculo[playerid], health);
    }
    new msg[128];
    format(msg, sizeof(msg), "{%d}[!] {FFFFFF}Veiculo reparado", Color(3));
	Send(playerid, -1, msg);
    return 1; 
}   