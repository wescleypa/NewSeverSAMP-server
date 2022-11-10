#include "../include/global.inc" //Includes gerais
//
#pragma tabsize 0

main() return print("\n[!] Gamemode iniciada em 10/09/2022 por Wescley Andrade +55 (19) 99187-5201\n\
	e Micael SaydeN\n");

public OnGameModeInit(){
	LoadConfig();
	Conecta();
	
    return 1;
}


public OnGameModeExit()
{
	SalvarContas();
	return 1;
}