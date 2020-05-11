require 'spec_helper'
require 'net/http'
require 'sqlite3'
require 'byebug'

describe "uf_name" do
  it "success" do
    allow($stdin).to receive(:gets).and_return("3\n", "sao paulo\n", "sair\n")
    db = SQLite3::Database.open "db/cities.db"
    allow_any_instance_of(SQLite3).to receive(:new).and_return(db)

    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite: 3.
Para sair do programa digite: sair.
Digite o nome da cidade (sem acentuação, exemplo: sao paulo) para saber quais os nomes mais comuns no município.
+-----------+-----------------+-------------+
+-----------+-----------------+-------------+
| Geral     | Sao paulo, (SP) | Porcentagem |
| Nome:     | Ranking:        | (%):        |
+-----------+-----------------+-------------+
| MARIA     | 1               | 4.7409 %    |
| JOSE      | 2               | 2.1994 %    |
| ANA       | 3               | 1.3401 %    |
| JOAO      | 4               | 1.0574 %    |
| ANTONIO   | 5               | 0.9871 %    |
| CARLOS    | 6               | 0.7067 %    |
| PAULO     | 7               | 0.6831 %    |
| LUCAS     | 8               | 0.607 %     |
| GABRIEL   | 9               | 0.5695 %    |
| PEDRO     | 10              | 0.5632 %    |
| MARCOS    | 11              | 0.5535 %    |
| RAFAEL    | 12              | 0.5315 %    |
| LUIZ      | 13              | 0.5291 %    |
| FRANCISCO | 14              | 0.5086 %    |
| MARCELO   | 15              | 0.4777 %    |
| FELIPE    | 16              | 0.4644 %    |
| BRUNO     | 17              | 0.4358 %    |
| EDUARDO   | 18              | 0.4286 %    |
| RODRIGO   | 19              | 0.4225 %    |
| GUILHERME | 20              | 0.403 %     |
+-----------+-----------------+-------------+
+------------------+-----------------+-------------+
+------------------+-----------------+-------------+
| Nomes masculinos | Sao paulo, (SP) | Porcentagem |
| Nome:            | Ranking:        | (%):        |
+------------------+-----------------+-------------+
| JOSE             | 1               | 2.1911 %    |
| JOAO             | 2               | 1.0527 %    |
| ANTONIO          | 3               | 0.984 %     |
| CARLOS           | 4               | 0.7036 %    |
| PAULO            | 5               | 0.68 %      |
| LUCAS            | 6               | 0.6003 %    |
| GABRIEL          | 7               | 0.5625 %    |
| PEDRO            | 8               | 0.5597 %    |
| MARCOS           | 9               | 0.5511 %    |
| LUIZ             | 10              | 0.5266 %    |
| RAFAEL           | 11              | 0.5266 %    |
| FRANCISCO        | 12              | 0.5068 %    |
| MARCELO          | 13              | 0.4756 %    |
| FELIPE           | 14              | 0.4595 %    |
| BRUNO            | 15              | 0.432 %     |
| EDUARDO          | 16              | 0.426 %     |
| RODRIGO          | 17              | 0.4202 %    |
| GUILHERME        | 18              | 0.3997 %    |
| LUIS             | 19              | 0.3983 %    |
| RICARDO          | 20              | 0.3965 %    |
+------------------+-----------------+-------------+
+-----------------+-----------------+-------------+
+-----------------+-----------------+-------------+
| Nomes femininos | Sao paulo, (SP) | Porcentagem |
| Nome:           | Ranking:        | (%):        |
+-----------------+-----------------+-------------+
| MARIA           | 1               | 4.7234 %    |
| ANA             | 2               | 1.3355 %    |
| JULIANA         | 3               | 0.3681 %    |
| FERNANDA        | 4               | 0.3495 %    |
| MARCIA          | 5               | 0.3474 %    |
| ADRIANA         | 6               | 0.3378 %    |
| PATRICIA        | 7               | 0.3334 %    |
| CAMILA          | 8               | 0.317 %     |
| SANDRA          | 9               | 0.3135 %    |
| JULIA           | 10              | 0.3026 %    |
| BEATRIZ         | 11              | 0.3009 %    |
| GABRIELA        | 12              | 0.289 %     |
| ALINE           | 13              | 0.2819 %    |
| BRUNA           | 14              | 0.2762 %    |
| RENATA          | 15              | 0.2655 %    |
| AMANDA          | 16              | 0.2617 %    |
| MARIANA         | 17              | 0.2609 %    |
| LETICIA         | 18              | 0.2584 %    |
| VANESSA         | 19              | 0.2559 %    |
| LUCIANA         | 20              | 0.2555 %    |
+-----------------+-----------------+-------------+
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite: 3.
Para sair do programa digite: sair.
Saindo do RubyNames, até logo!
").to_stdout
  end


  it "try unnaccepted input then success" do
    allow($stdin).to receive(:gets).and_return("3\n", "erro\n", "sao paulo\n", "sair\n")
    db = SQLite3::Database.open "./spec/support/ufs.db"
    allow_any_instance_of(SQLite3).to receive(:new).and_return(db)

    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite: 3.
Para sair do programa digite: sair.
Digite o nome da cidade (sem acentuação, exemplo: sao paulo) para saber quais os nomes mais comuns no município.
Entrada não aceita.
Digite o nome da cidade (sem acentuação, exemplo: sao paulo) para saber quais os nomes mais comuns no município.
+-----------+-----------------+-------------+
+-----------+-----------------+-------------+
| Geral     | Sao paulo, (SP) | Porcentagem |
| Nome:     | Ranking:        | (%):        |
+-----------+-----------------+-------------+
| MARIA     | 1               | 4.7409 %    |
| JOSE      | 2               | 2.1994 %    |
| ANA       | 3               | 1.3401 %    |
| JOAO      | 4               | 1.0574 %    |
| ANTONIO   | 5               | 0.9871 %    |
| CARLOS    | 6               | 0.7067 %    |
| PAULO     | 7               | 0.6831 %    |
| LUCAS     | 8               | 0.607 %     |
| GABRIEL   | 9               | 0.5695 %    |
| PEDRO     | 10              | 0.5632 %    |
| MARCOS    | 11              | 0.5535 %    |
| RAFAEL    | 12              | 0.5315 %    |
| LUIZ      | 13              | 0.5291 %    |
| FRANCISCO | 14              | 0.5086 %    |
| MARCELO   | 15              | 0.4777 %    |
| FELIPE    | 16              | 0.4644 %    |
| BRUNO     | 17              | 0.4358 %    |
| EDUARDO   | 18              | 0.4286 %    |
| RODRIGO   | 19              | 0.4225 %    |
| GUILHERME | 20              | 0.403 %     |
+-----------+-----------------+-------------+
+------------------+-----------------+-------------+
+------------------+-----------------+-------------+
| Nomes masculinos | Sao paulo, (SP) | Porcentagem |
| Nome:            | Ranking:        | (%):        |
+------------------+-----------------+-------------+
| JOSE             | 1               | 2.1911 %    |
| JOAO             | 2               | 1.0527 %    |
| ANTONIO          | 3               | 0.984 %     |
| CARLOS           | 4               | 0.7036 %    |
| PAULO            | 5               | 0.68 %      |
| LUCAS            | 6               | 0.6003 %    |
| GABRIEL          | 7               | 0.5625 %    |
| PEDRO            | 8               | 0.5597 %    |
| MARCOS           | 9               | 0.5511 %    |
| LUIZ             | 10              | 0.5266 %    |
| RAFAEL           | 11              | 0.5266 %    |
| FRANCISCO        | 12              | 0.5068 %    |
| MARCELO          | 13              | 0.4756 %    |
| FELIPE           | 14              | 0.4595 %    |
| BRUNO            | 15              | 0.432 %     |
| EDUARDO          | 16              | 0.426 %     |
| RODRIGO          | 17              | 0.4202 %    |
| GUILHERME        | 18              | 0.3997 %    |
| LUIS             | 19              | 0.3983 %    |
| RICARDO          | 20              | 0.3965 %    |
+------------------+-----------------+-------------+
+-----------------+-----------------+-------------+
+-----------------+-----------------+-------------+
| Nomes femininos | Sao paulo, (SP) | Porcentagem |
| Nome:           | Ranking:        | (%):        |
+-----------------+-----------------+-------------+
| MARIA           | 1               | 4.7234 %    |
| ANA             | 2               | 1.3355 %    |
| JULIANA         | 3               | 0.3681 %    |
| FERNANDA        | 4               | 0.3495 %    |
| MARCIA          | 5               | 0.3474 %    |
| ADRIANA         | 6               | 0.3378 %    |
| PATRICIA        | 7               | 0.3334 %    |
| CAMILA          | 8               | 0.317 %     |
| SANDRA          | 9               | 0.3135 %    |
| JULIA           | 10              | 0.3026 %    |
| BEATRIZ         | 11              | 0.3009 %    |
| GABRIELA        | 12              | 0.289 %     |
| ALINE           | 13              | 0.2819 %    |
| BRUNA           | 14              | 0.2762 %    |
| RENATA          | 15              | 0.2655 %    |
| AMANDA          | 16              | 0.2617 %    |
| MARIANA         | 17              | 0.2609 %    |
| LETICIA         | 18              | 0.2584 %    |
| VANESSA         | 19              | 0.2559 %    |
| LUCIANA         | 20              | 0.2555 %    |
+-----------------+-----------------+-------------+
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite: 3.
Para sair do programa digite: sair.
Saindo do RubyNames, até logo!
").to_stdout
  end

  it "status not 200" do
    allow($stdin).to receive(:gets).and_return("3\n", "sao paulo\n")
    json = File.read('./spec/support/empty.json')
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=3550308"
    uri = URI.parse(URI.escape(url))
    object = double
    allow(Net::HTTP).to receive(:get_response).with(uri).and_return(object)
    allow(object).to receive(:body).and_return(json)
    allow(object).to receive(:code).and_return(400)
    allow($stdout).to receive(:puts) # esta linha limpa a saida durante o teste

    expect { load "./lib/execute.rb" }.to raise_error('Sem conexão com o servidor no momento.')
  end
end
