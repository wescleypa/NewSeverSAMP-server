forward Reiniciar(time);
public Reiniciar(time){
  if(gmxagora == true){
    SetTimerEx("Reiniciar", 1000, false, "i", time);
    gmxagora = false;
  }else {
    if(time > 1){
      if(time < 30){
        new avisoT[128];
        format(avisoT, sizeof(avisoT), "~r~ATENCAO~n~ ~w~O servidor sera reiniciado em ~r~%d ~w~segundos", time);
        GameTextForAll(avisoT, 1000, 3 );
        time -= 1;
        timegmx = SetTimerEx("Reiniciar", 1000, false, "i", time);
      }else{
        if(time == 60){
          new avisoT[128];
          format(avisoT, sizeof(avisoT), "~r~ATENCAO~n~ ~w~O servidor sera reiniciado em ~r~%d ~w~segundos", time);
          GameTextForAll(avisoT, 5000, 3);
          time -= 1;
          timegmx = SetTimerEx("Reiniciar", 1000, false, "i", time);
        }else{
          time -= 1;
          timegmx = SetTimerEx("Reiniciar", 1000, false, "i", time);
        }
      }
    }else{
        KillTimer(timegmx);
        new aviso[128];
        format(aviso, sizeof(aviso), "{B30404}[ATENÇÃO] {FFFFFF}O servidor está sendo reiniciado...");
        SendClientMessageToAll(-1, aviso);
        SalvarContas();
        SendRconCommand("gmx");
    }
  }
}

stock fcreate(filename[])
{
  if (fexist(filename)){return false;}
  new File:fhandle = fopen(filename,io_write);
  fclose(fhandle);
  return true;
}

stock LogAdmin(playerid, type[], content[], extra[]){
  new name[MAX_PLAYER_NAME+1],
  hour, minute, second,
  day, month, year;
  gettime(hour, minute, second);
  getdate(day, month, year);
  GetPlayerName(playerid, name, sizeof(name));
  new log[200], dof[200];
  format(dof, sizeof(dof), "logs/admins/%s.ini", name);
  if(!fexist(dof)) fcreate(dof);
  new fileLog = fopen(dof, io_append);
  new date[120], tp[50], extr[50];
  format(date, sizeof(date), "\n[%02d/%02d/%d] ", day, month, year);

  if(strlen(extra) <= 0)
    sscanf(type, "s", tp);
  else {
    sscanf(type, "s", tp);
    sscanf(extra, "s", extr);
  }

  if(strcmp(type, "cmd", true) == 0  && strlen(extra) <= 0)
    format(log, sizeof(log), "%s [CMD] %s usou o comando /%s às %02d:%02d:%02d", date, name, content, hour, minute, second);

  else if(strcmp(type, "cmd", true) == 0  && strlen(extra) >= 0)
    format(log, sizeof(log), "%s [CMD] %s usou o comando /%s às %02d:%02d:%02d em: %s", date, name, content, hour, minute, second, extr);
   
  fwrite(fileLog, log);
  fclose(fileLog);
}

