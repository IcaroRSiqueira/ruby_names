require 'spec_helper'
require 'net/http'
require 'sqlite3'
require 'byebug'

describe "uf_name" do
  it "success" do
    allow($stdin).to receive(:gets).and_return("3\n", "alta floresta d,oeste\n", "sair\n")
    db = SQLite3::Database.open "db/cities.db"
    allow_any_instance_of(SQLite3).to receive(:new).and_return(db)

    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite 3.
Para sair do programa digite: sair.
Digite o nome da cidade (sem acentuação, exemplo: sao paulo) para saber quais os nomes mais comuns no município.
+-----------+-----------------------------+-------------+
+-----------+-----------------------------+-------------+
| Geral     | Alta floresta d,oeste, (RO) | Porcentagem |
| Nome:     | Ranking:                    | (%):        |
+-----------+-----------------------------+-------------+
| MARIA     | 1                           | 4.9466 %    |
| JOSE      | 2                           | 2.8808 %    |
| JOAO      | 3                           | 1.6256 %    |
| ANA       | 4                           | 1.3075 %    |
| ANTONIO   | 5                           | 1.1767 %    |
| PAULO     | 6                           | 0.7148 %    |
| LUCAS     | 7                           | 0.6581 %    |
| MARCOS    | 8                           | 0.6537 %    |
| CARLOS    | 9                           | 0.6232 %    |
| PEDRO     | 10                          | 0.584 %     |
| LUIZ      | 11                          | 0.5448 %    |
| FRANCISCO | 12                          | 0.4533 %    |
| LEANDRO   | 13                          | 0.3966 %    |
| SEBASTIAO | 14                          | 0.3792 %    |
| GABRIEL   | 15                          | 0.3748 %    |
| RAFAEL    | 16                          | 0.3705 %    |
| DANIEL    | 17                          | 0.353 %     |
| BRUNO     | 18                          | 0.353 %     |
| MATEUS    | 19                          | 0.3399 %    |
| ALINE     | 20                          | 0.3356 %    |
+-----------+-----------------------------+-------------+
+------------------+-----------------------------+-------------+
+------------------+-----------------------------+-------------+
| Nomes masculinos | Alta floresta d,oeste, (RO) | Porcentagem |
| Nome:            | Ranking:                    | (%):        |
+------------------+-----------------------------+-------------+
| JOSE             | 1                           | 2.8634 %    |
| JOAO             | 2                           | 1.6169 %    |
| ANTONIO          | 3                           | 1.1724 %    |
| PAULO            | 4                           | 0.7104 %    |
| LUCAS            | 5                           | 0.6537 %    |
| MARCOS           | 6                           | 0.6407 %    |
| CARLOS           | 7                           | 0.6232 %    |
| PEDRO            | 8                           | 0.5796 %    |
| LUIZ             | 9                           | 0.5448 %    |
| FRANCISCO        | 10                          | 0.4533 %    |
| LEANDRO          | 11                          | 0.3966 %    |
| SEBASTIAO        | 12                          | 0.3792 %    |
| GABRIEL          | 13                          | 0.3748 %    |
| RAFAEL           | 14                          | 0.3705 %    |
| DANIEL           | 15                          | 0.353 %     |
| BRUNO            | 16                          | 0.3443 %    |
| MATEUS           | 17                          | 0.3399 %    |
| FERNANDO         | 18                          | 0.3312 %    |
| EDUARDO          | 19                          | 0.3182 %    |
| MARCELO          | 20                          | 0.3138 %    |
+------------------+-----------------------------+-------------+
+-----------------+-----------------------------+-------------+
+-----------------+-----------------------------+-------------+
| Nomes femininos | Alta floresta d,oeste, (RO) | Porcentagem |
| Nome:           | Ranking:                    | (%):        |
+-----------------+-----------------------------+-------------+
| MARIA           | 1                           | 4.9379 %    |
| ANA             | 2                           | 1.3031 %    |
| ALINE           | 4                           | 0.3356 %    |
| MARCIA          | 3                           | 0.3356 %    |
| PATRICIA        | 5                           | 0.3269 %    |
| VANESSA         | 6                           | 0.2876 %    |
| JULIANA         | 7                           | 0.2789 %    |
| LUCIANA         | 8                           | 0.2702 %    |
| ELIANE          | 9                           | 0.2702 %    |
| SANDRA          | 10                          | 0.2615 %    |
| ADRIANA         | 11                          | 0.2615 %    |
| CAMILA          | 12                          | 0.2528 %    |
| DAIANE          | 14                          | 0.231 %     |
| ANDREIA         | 13                          | 0.231 %     |
| JAQUELINE       | 15                          | 0.2266 %    |
| MARLI           | 17                          | 0.2223 %    |
| AMANDA          | 16                          | 0.2223 %    |
| MARLENE         | 18                          | 0.2179 %    |
| LETICIA         | 19                          | 0.2136 %    |
| ROSELI          | 20                          | 0.2092 %    |
+-----------------+-----------------------------+-------------+
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para pesquisar os nomes mais comuns por UF digite: 2.
Para pesquisar os nomes mais comuns por município digite 3.
Para sair do programa digite: sair.
Saindo do RubyNames, até logo!
").to_stdout
  end
end
