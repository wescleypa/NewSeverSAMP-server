#define SQL_TABLE_PLAYER "contas"
new MySQL:conexao;

//Conexão MySQL
forward Conecta();
public Conecta()
{
	conexao = mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DB);
    if(mysql_errno(conexao) == 0) printf("\n[MySQL] Banco de dados conectado com sucesso.\n");
      else printf("\n[MySQL] Erro ao conectar com Banco de dados.\n");
	return 1;
}