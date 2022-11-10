enum PlayerInfo{
    password,       //senha
    money,          //saldo conta
    level,          //score
    Float: dX,      //Desconectou X
    Float: dY,      //Desconectou Y
    Float: dZ,      //Desconectou Z
    Float: dA,      //Desconectou A
    dI,             //Desconectou Interior
    admin,          //Admin
    genre,          //Genero
    trampando,      //Trabalhando
    vip             //Player VIP
}
new Player[MAX_PLAYERS][PlayerInfo];
new CarAdmin[MAX_PLAYERS], //Veículo criado via cmd
    CriouCarAdmin[MAX_PLAYERS], //Verifica se o admin já criou um veículo
    VehicleAdmin[MAX_VEHICLES];

new  veiculo[MAX_PLAYERS], //Variaveis de veículo
       faroll[MAX_PLAYERS],
      alarmee[MAX_PLAYERS],
      portass[MAX_PLAYERS],
        capoo[MAX_PLAYERS],
   portamalass[MAX_PLAYERS],
     objetivoo[MAX_PLAYERS],
        motorr[MAX_PLAYERS];

new AutoRep[MAX_PLAYERS] = 0, //Auto reparo
    TempAutoRep[MAX_PLAYERS];