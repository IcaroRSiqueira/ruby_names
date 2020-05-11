require 'spec_helper'
require 'net/http'
require 'sqlite3'
require 'byebug'

describe "uf_name" do
  it "success" do
    allow($stdin).to receive(:gets).and_return("2\n", "sp\n", "sair\n")
    db = SQLite3::Database.open "db/ufs.db"
    allow_any_instance_of(SQLite3).to receive(:new).and_return(db)

    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite: 3.
Para sair do programa digite: sair.
Digite a sigla da UF (exemplo: SP) para saber quais os nomes mais comuns no estado
+-----------+----------+----------+
+-----------+----------+----------+
| Geral     |          |          |
| Nome:     | Ranking: | (%) SP   |
+-----------+----------+----------+
| MARIA     | 1        | 4.6674 % |
| JOSE      | 2        | 2.4364 % |
| ANA       | 3        | 1.4464 % |
| JOAO      | 4        | 1.3303 % |
| ANTONIO   | 5        | 1.0844 % |
| PAULO     | 6        | 0.7266 % |
| CARLOS    | 7        | 0.7163 % |
| LUCAS     | 8        | 0.616 %  |
| LUIZ      | 9        | 0.5901 % |
| PEDRO     | 10       | 0.5756 % |
| MARCOS    | 11       | 0.5628 % |
| GABRIEL   | 12       | 0.5586 % |
| LUIS      | 13       | 0.537 %  |
| RAFAEL    | 14       | 0.5037 % |
| FRANCISCO | 15       | 0.438 %  |
| MARCELO   | 16       | 0.43 %   |
| BRUNO     | 17       | 0.4095 % |
| FELIPE    | 18       | 0.4059 % |
| GUILHERME | 19       | 0.3834 % |
| RODRIGO   | 20       | 0.3769 % |
+-----------+----------+----------+
+------------------+----------+----------+
+------------------+----------+----------+
| Nomes masculinos |          |          |
| Nome:            | Ranking: | (%) SP   |
+------------------+----------+----------+
| JOSE             | 1        | 2.4283 % |
| JOAO             | 2        | 1.3248 % |
| ANTONIO          | 3        | 1.0813 % |
| PAULO            | 4        | 0.7238 % |
| CARLOS           | 5        | 0.7136 % |
| LUCAS            | 6        | 0.6102 % |
| LUIZ             | 7        | 0.5878 % |
| PEDRO            | 8        | 0.5727 % |
| MARCOS           | 9        | 0.5605 % |
| GABRIEL          | 10       | 0.5526 % |
| LUIS             | 11       | 0.5347 % |
| RAFAEL           | 12       | 0.4994 % |
| FRANCISCO        | 13       | 0.4365 % |
| MARCELO          | 14       | 0.4282 % |
| BRUNO            | 15       | 0.4064 % |
| FELIPE           | 16       | 0.4021 % |
| GUILHERME        | 17       | 0.3804 % |
| RODRIGO          | 18       | 0.3751 % |
| EDUARDO          | 19       | 0.36 %   |
| GUSTAVO          | 20       | 0.3581 % |
+------------------+----------+----------+
+-----------------+----------+----------+
+-----------------+----------+----------+
| Nomes femininos |          |          |
| Nome:           | Ranking: | (%) SP   |
+-----------------+----------+----------+
| MARIA           | 1        | 4.6518 % |
| ANA             | 2        | 1.4417 % |
| JULIANA         | 3        | 0.344 %  |
| MARCIA          | 4        | 0.3313 % |
| ADRIANA         | 5        | 0.3251 % |
| APARECIDA       | 6        | 0.3128 % |
| FERNANDA        | 7        | 0.3056 % |
| PATRICIA        | 8        | 0.3032 % |
| ALINE           | 9        | 0.2872 % |
| CAMILA          | 10       | 0.2858 % |
| SANDRA          | 11       | 0.2853 % |
| BRUNA           | 12       | 0.2819 % |
| JULIA           | 13       | 0.2777 % |
| LETICIA         | 14       | 0.2678 % |
| BEATRIZ         | 15       | 0.2659 % |
| GABRIELA        | 16       | 0.2584 % |
| JESSICA         | 17       | 0.2546 % |
| AMANDA          | 18       | 0.254 %  |
| LUCIANA         | 19       | 0.2454 % |
| VANESSA         | 20       | 0.24 %   |
+-----------------+----------+----------+
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite: 3.
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
Para pesquisar os nomes mais comuns por município digite: 3.
Para sair do programa digite: sair.
Digite a sigla da UF (exemplo: SP) para saber quais os nomes mais comuns no estado
Entrada não aceita.
Digite a sigla da UF (exemplo: SP) para saber quais os nomes mais comuns no estado
+-----------+----------+----------+
+-----------+----------+----------+
| Geral     |          |          |
| Nome:     | Ranking: | (%) SP   |
+-----------+----------+----------+
| MARIA     | 1        | 4.6674 % |
| JOSE      | 2        | 2.4364 % |
| ANA       | 3        | 1.4464 % |
| JOAO      | 4        | 1.3303 % |
| ANTONIO   | 5        | 1.0844 % |
| PAULO     | 6        | 0.7266 % |
| CARLOS    | 7        | 0.7163 % |
| LUCAS     | 8        | 0.616 %  |
| LUIZ      | 9        | 0.5901 % |
| PEDRO     | 10       | 0.5756 % |
| MARCOS    | 11       | 0.5628 % |
| GABRIEL   | 12       | 0.5586 % |
| LUIS      | 13       | 0.537 %  |
| RAFAEL    | 14       | 0.5037 % |
| FRANCISCO | 15       | 0.438 %  |
| MARCELO   | 16       | 0.43 %   |
| BRUNO     | 17       | 0.4095 % |
| FELIPE    | 18       | 0.4059 % |
| GUILHERME | 19       | 0.3834 % |
| RODRIGO   | 20       | 0.3769 % |
+-----------+----------+----------+
+------------------+----------+----------+
+------------------+----------+----------+
| Nomes masculinos |          |          |
| Nome:            | Ranking: | (%) SP   |
+------------------+----------+----------+
| JOSE             | 1        | 2.4283 % |
| JOAO             | 2        | 1.3248 % |
| ANTONIO          | 3        | 1.0813 % |
| PAULO            | 4        | 0.7238 % |
| CARLOS           | 5        | 0.7136 % |
| LUCAS            | 6        | 0.6102 % |
| LUIZ             | 7        | 0.5878 % |
| PEDRO            | 8        | 0.5727 % |
| MARCOS           | 9        | 0.5605 % |
| GABRIEL          | 10       | 0.5526 % |
| LUIS             | 11       | 0.5347 % |
| RAFAEL           | 12       | 0.4994 % |
| FRANCISCO        | 13       | 0.4365 % |
| MARCELO          | 14       | 0.4282 % |
| BRUNO            | 15       | 0.4064 % |
| FELIPE           | 16       | 0.4021 % |
| GUILHERME        | 17       | 0.3804 % |
| RODRIGO          | 18       | 0.3751 % |
| EDUARDO          | 19       | 0.36 %   |
| GUSTAVO          | 20       | 0.3581 % |
+------------------+----------+----------+
+-----------------+----------+----------+
+-----------------+----------+----------+
| Nomes femininos |          |          |
| Nome:           | Ranking: | (%) SP   |
+-----------------+----------+----------+
| MARIA           | 1        | 4.6518 % |
| ANA             | 2        | 1.4417 % |
| JULIANA         | 3        | 0.344 %  |
| MARCIA          | 4        | 0.3313 % |
| ADRIANA         | 5        | 0.3251 % |
| APARECIDA       | 6        | 0.3128 % |
| FERNANDA        | 7        | 0.3056 % |
| PATRICIA        | 8        | 0.3032 % |
| ALINE           | 9        | 0.2872 % |
| CAMILA          | 10       | 0.2858 % |
| SANDRA          | 11       | 0.2853 % |
| BRUNA           | 12       | 0.2819 % |
| JULIA           | 13       | 0.2777 % |
| LETICIA         | 14       | 0.2678 % |
| BEATRIZ         | 15       | 0.2659 % |
| GABRIELA        | 16       | 0.2584 % |
| JESSICA         | 17       | 0.2546 % |
| AMANDA          | 18       | 0.254 %  |
| LUCIANA         | 19       | 0.2454 % |
| VANESSA         | 20       | 0.24 %   |
+-----------------+----------+----------+
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite: 3.
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
