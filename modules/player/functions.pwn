stock Send(playerid, color, msg[]);
public Send(playerid, color, msg[]){
    new str[200];
    format(str, sizeof(str), "%s", msg);
    SendClientMessage(playerid, color, str);
    return 1;
}
forward AutoReparar(playerid);
public AutoReparar(playerid){
	RepairVehicle(GetPlayerVehicleID(playerid));
	return 1;
}

stock LabelAdmin(playerid);
public LabelAdmin(playerid){
    new tdText[MAX_PLAYERS], cargo[MAX_PLAYERS], str[128];
    cargo = RankAdmin(Player[playerid][genre], Player[playerid][admin]);
    format(str, sizeof(str), "%s", cargo);
    new coloruse[24];
    format(coloruse, sizeof(coloruse), "0x00%d", ColorAdmin(Player[playerid][admin]));

    if(Player[playerid][admin] > 0){
        tdText[playerid] = Create3DTextLabel("Administrador", 0x00010101, 0.0, -30.0, 0.0, 50.0, 0, 1);
        Attach3DTextLabelToPlayer(tdText[playerid], playerid, 0.0, 0.0, 0.7);
    }   
    return 1;
}