require 'spec_helper'
require 'net/http'
require 'sqlite3'
require 'byebug'

describe "uf_name" do
  it "success" do
    allow($stdin).to receive(:gets).and_return("3\n", "alta floresta d,oeste\n", "sair\n")
    db = SQLite3::Database.open "./spec/support/cities.db"
    allow_any_instance_of(SQLite3).to receive(:new).and_return(db)

    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite 3.
Para sair do programa digite: sair.
Digite o nome da cidade (sem acentuação, exemplo: sao paulo) para saber quais os nomes mais comuns no município.
+-----------+-----------------------------+
+-----------+-----------------------------+
| Geral     | Alta floresta d,oeste, (RO) |
| Nome:     | Ranking:                    |
+-----------+-----------------------------+
| MARIA     | 1                           |
| JOSE      | 2                           |
| JOAO      | 3                           |
| ANA       | 4                           |
| ANTONIO   | 5                           |
| PAULO     | 6                           |
| LUCAS     | 7                           |
| MARCOS    | 8                           |
| CARLOS    | 9                           |
| PEDRO     | 10                          |
| LUIZ      | 11                          |
| FRANCISCO | 12                          |
| LEANDRO   | 13                          |
| SEBASTIAO | 14                          |
| GABRIEL   | 15                          |
| RAFAEL    | 16                          |
| DANIEL    | 17                          |
| BRUNO     | 18                          |
| MATEUS    | 19                          |
| ALINE     | 20                          |
+-----------+-----------------------------+
+------------------+-----------------------------+
+------------------+-----------------------------+
| Nomes masculinos | Alta floresta d,oeste, (RO) |
| Nome:            | Ranking:                    |
+------------------+-----------------------------+
| JOSE             | 1                           |
| JOAO             | 2                           |
| ANTONIO          | 3                           |
| PAULO            | 4                           |
| LUCAS            | 5                           |
| MARCOS           | 6                           |
| CARLOS           | 7                           |
| PEDRO            | 8                           |
| LUIZ             | 9                           |
| FRANCISCO        | 10                          |
| LEANDRO          | 11                          |
| SEBASTIAO        | 12                          |
| GABRIEL          | 13                          |
| RAFAEL           | 14                          |
| DANIEL           | 15                          |
| BRUNO            | 16                          |
| MATEUS           | 17                          |
| FERNANDO         | 18                          |
| EDUARDO          | 19                          |
| MARCELO          | 20                          |
+------------------+-----------------------------+
+-----------------+-----------------------------+
+-----------------+-----------------------------+
| Nomes femininos | Alta floresta d,oeste, (RO) |
| Nome:           | Ranking:                    |
+-----------------+-----------------------------+
| MARIA           | 1                           |
| ANA             | 2                           |
| ALINE           | 4                           |
| MARCIA          | 3                           |
| PATRICIA        | 5                           |
| VANESSA         | 6                           |
| JULIANA         | 7                           |
| LUCIANA         | 8                           |
| ELIANE          | 9                           |
| SANDRA          | 10                          |
| ADRIANA         | 11                          |
| CAMILA          | 12                          |
| DAIANE          | 14                          |
| ANDREIA         | 13                          |
| JAQUELINE       | 15                          |
| MARLI           | 17                          |
| AMANDA          | 16                          |
| MARLENE         | 18                          |
| LETICIA         | 19                          |
| ROSELI          | 20                          |
+-----------------+-----------------------------+
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite 3.
Para sair do programa digite: sair.
Saindo do RubyNames, até logo!
").to_stdout
  end
end
