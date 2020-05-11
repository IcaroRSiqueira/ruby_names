# Ruby Names

o Ruby Names é um aplicativo criado para fins educacionais. Sua utilização se dá através do envio de comandos pelo terminal que retornam tabelas preenchidas por informações como a frequência de nomes por década e ranking de nomes mais comuns em estado ou cidade, estes dados são adquiridos através da `API` pública do IBGE.
Os nomes e identificadores das cidades e UFs, como são informações que mudam com pouca frequência, são adquiridos uma vez através da API pública do IBGE de localidades e são armazenados no banco de dados, nas requisições seguintes a verificação e seleção da cidade ou UF será feita através do banco de dados, otimizando a sua utilização.


## Configurações:

* O Ruby Names foi desenvolvido em Ruby, versão 2.6.3

## Como iniciar o aplicativo:

* O Ruby Names necessita de conexão com a internet.

* Seu computador deve ter preferencialmente macOS ou O.S Linux, com o Ruby 2.6 instalado.

* Após a clonagem ou download do repositório, mude para o diretório do aplicativo e instale as dependencias necessárias defidas no arquivo `GemFile`, inserindo o comando `bundle install`.

* Após a realização da configuração anterior, o aplicativo pode ser iniciado através do comando `ruby lib/execute.rb`, em seguida siga as instruções demonstradas no console.
{
  * Os nomes inseridos após a opção 1 devem ser inseridos(no caso de mais de um) sem acento ou pontuação, separados apenas por  `,`, por exemplo João e Maria: `joao,maria`.

  * O nome de cidade na opção 3 deve ser sem acento ou pontuação, no caso de apóstrofo o mesmo deve ser substituído por `,`, por exemplo, para pesquisar sobre a cidade Alta Floresta D'Oeste(RO) deve se inserir `alta floresta d,oeste`.
}

* Para parar imediatamente a execução da aplicação digite `control + c`.

## Testes:

  O aplicativo possui testes através do `rspec`. Para executar os testes, insira o comando `rspec`.

## Gems utilizadas:

* Para a formatação das tabelas foi utilizada a gem `terminal-table`.

* Para utilização de banco de dados foi utilizada a gem `sqlite3`.
