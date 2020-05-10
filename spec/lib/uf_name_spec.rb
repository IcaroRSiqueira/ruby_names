require 'spec_helper'
require 'net/http'
require 'sqlite3'
require 'byebug'

describe "uf_name" do
  it "success" do
    allow($stdin).to receive(:gets).and_return("2\n", "sp\n", "sair\n")
    db = SQLite3::Database.open "./spec/support/ufs.db"
    allow_any_instance_of(SQLite3).to receive(:new).and_return(db)

    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para sair do programa digite: sair.
Digite a sigla da UF (exemplo: SP) para saber quais os nomes mais comuns no estado
+-----------+----------+
+-----------+----------+
| Geral     |          |
| Nome:     | Ranking: |
+-----------+----------+
| MARIA     | 1        |
| JOSE      | 2        |
| ANA       | 3        |
| JOAO      | 4        |
| ANTONIO   | 5        |
| PAULO     | 6        |
| CARLOS    | 7        |
| LUCAS     | 8        |
| LUIZ      | 9        |
| PEDRO     | 10       |
| MARCOS    | 11       |
| GABRIEL   | 12       |
| LUIS      | 13       |
| RAFAEL    | 14       |
| FRANCISCO | 15       |
| MARCELO   | 16       |
| BRUNO     | 17       |
| FELIPE    | 18       |
| GUILHERME | 19       |
| RODRIGO   | 20       |
+-----------+----------+
+------------------+----------+
+------------------+----------+
| Nomes masculinos |          |
| Nome:            | Ranking: |
+------------------+----------+
| JOSE             | 1        |
| JOAO             | 2        |
| ANTONIO          | 3        |
| PAULO            | 4        |
| CARLOS           | 5        |
| LUCAS            | 6        |
| LUIZ             | 7        |
| PEDRO            | 8        |
| MARCOS           | 9        |
| GABRIEL          | 10       |
| LUIS             | 11       |
| RAFAEL           | 12       |
| FRANCISCO        | 13       |
| MARCELO          | 14       |
| BRUNO            | 15       |
| FELIPE           | 16       |
| GUILHERME        | 17       |
| RODRIGO          | 18       |
| EDUARDO          | 19       |
| GUSTAVO          | 20       |
+------------------+----------+
+-----------------+----------+
+-----------------+----------+
| Nomes femininos |          |
| Nome:           | Ranking: |
+-----------------+----------+
| MARIA           | 1        |
| ANA             | 2        |
| JULIANA         | 3        |
| MARCIA          | 4        |
| ADRIANA         | 5        |
| APARECIDA       | 6        |
| FERNANDA        | 7        |
| PATRICIA        | 8        |
| ALINE           | 9        |
| CAMILA          | 10       |
| SANDRA          | 11       |
| BRUNA           | 12       |
| JULIA           | 13       |
| LETICIA         | 14       |
| BEATRIZ         | 15       |
| GABRIELA        | 16       |
| JESSICA         | 17       |
| AMANDA          | 18       |
| LUCIANA         | 19       |
| VANESSA         | 20       |
+-----------------+----------+
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para sair do programa digite: sair.
Saindo do RubyNames, até logo!
").to_stdout
  end

  it "try unnaccepted input then success" do
    allow($stdin).to receive(:gets).and_return("2\n", "erro\n", "sp\n", "sair\n")
    db = SQLite3::Database.open "./spec/support/ufs.db"
    allow_any_instance_of(SQLite3).to receive(:new).and_return(db)

    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para sair do programa digite: sair.
Digite a sigla da UF (exemplo: SP) para saber quais os nomes mais comuns no estado
Entrada não aceita.
Digite a sigla da UF (exemplo: SP) para saber quais os nomes mais comuns no estado
+-----------+----------+
+-----------+----------+
| Geral     |          |
| Nome:     | Ranking: |
+-----------+----------+
| MARIA     | 1        |
| JOSE      | 2        |
| ANA       | 3        |
| JOAO      | 4        |
| ANTONIO   | 5        |
| PAULO     | 6        |
| CARLOS    | 7        |
| LUCAS     | 8        |
| LUIZ      | 9        |
| PEDRO     | 10       |
| MARCOS    | 11       |
| GABRIEL   | 12       |
| LUIS      | 13       |
| RAFAEL    | 14       |
| FRANCISCO | 15       |
| MARCELO   | 16       |
| BRUNO     | 17       |
| FELIPE    | 18       |
| GUILHERME | 19       |
| RODRIGO   | 20       |
+-----------+----------+
+------------------+----------+
+------------------+----------+
| Nomes masculinos |          |
| Nome:            | Ranking: |
+------------------+----------+
| JOSE             | 1        |
| JOAO             | 2        |
| ANTONIO          | 3        |
| PAULO            | 4        |
| CARLOS           | 5        |
| LUCAS            | 6        |
| LUIZ             | 7        |
| PEDRO            | 8        |
| MARCOS           | 9        |
| GABRIEL          | 10       |
| LUIS             | 11       |
| RAFAEL           | 12       |
| FRANCISCO        | 13       |
| MARCELO          | 14       |
| BRUNO            | 15       |
| FELIPE           | 16       |
| GUILHERME        | 17       |
| RODRIGO          | 18       |
| EDUARDO          | 19       |
| GUSTAVO          | 20       |
+------------------+----------+
+-----------------+----------+
+-----------------+----------+
| Nomes femininos |          |
| Nome:           | Ranking: |
+-----------------+----------+
| MARIA           | 1        |
| ANA             | 2        |
| JULIANA         | 3        |
| MARCIA          | 4        |
| ADRIANA         | 5        |
| APARECIDA       | 6        |
| FERNANDA        | 7        |
| PATRICIA        | 8        |
| ALINE           | 9        |
| CAMILA          | 10       |
| SANDRA          | 11       |
| BRUNA           | 12       |
| JULIA           | 13       |
| LETICIA         | 14       |
| BEATRIZ         | 15       |
| GABRIELA        | 16       |
| JESSICA         | 17       |
| AMANDA          | 18       |
| LUCIANA         | 19       |
| VANESSA         | 20       |
+-----------------+----------+
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para sair do programa digite: sair.
Saindo do RubyNames, até logo!
").to_stdout
  end

  it "status not 200" do
    allow($stdin).to receive(:gets).and_return("2\n", "sp\n")
    json = File.read('./spec/support/empty.json')
    url_geral = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=35"
    uri_geral = URI.parse(URI.escape(url_geral))
    object = double
    allow(Net::HTTP).to receive(:get_response).with(uri_geral).and_return(object)
    allow(object).to receive(:body).and_return(json)
    allow(object).to receive(:code).and_return(400)
    allow($stdout).to receive(:puts) # esta linha limpa a saida durante o teste

    expect { load "./lib/execute.rb" }.to raise_error('Sem conexão com o servidor no momento.')
  end
end
