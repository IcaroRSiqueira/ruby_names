require 'spec_helper'
require 'net/http'

describe "ruby_names" do

  it "displays frequency of the names during ages correctly" do
    allow($stdin).to receive(:gets).and_return("1\n", "joao\n")
    json = File.read('./spec/support/joao_test.json')
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/joao"
    uri = URI.parse(URI.escape(url))
    object = double
    allow(Net::HTTP).to receive(:get_response).with(uri).and_return(object)
    allow(object).to receive(:body).and_return(json)
    allow(object).to receive(:code).and_return(200)


    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para sair do programa digite: sair.
Digite o nome para saber qual a frequencia do mesmo durante as décadas
Exibindo resultados para o(s) nome(s) joao:
+-----------+------------+
+-----------+------------+
| JOAO      |            |
| Período:  | Registros: |
+-----------+------------+
| 1930      | 60155      |
| 1930,1940 | 141772     |
| 1940,1950 | 256001     |
| 1950,1960 | 396438     |
| 1960,1970 | 429148     |
| 1970,1980 | 279975     |
| 1980,1990 | 273960     |
| 1990,2000 | 352552     |
| 2000,2010 | 794118     |
+-----------+------------+
").to_stdout
  end

  it "should display more than one name" do
    allow($stdin).to receive(:gets).and_return("1\n", "Joao,Maria\n")
    json = File.read('./spec/support/joao_maria_test.json')
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/joao|maria"
    uri = URI.parse(URI.escape(url))
    object = double
    allow(Net::HTTP).to receive(:get_response).with(uri).and_return(object)
    allow(object).to receive(:body).and_return(json)
    allow(object).to receive(:code).and_return(200)

    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para sair do programa digite: sair.
Digite o nome para saber qual a frequencia do mesmo durante as décadas
Exibindo resultados para o(s) nome(s) joao,maria:
+-----------+------------+
+-----------+------------+
| JOAO      |            |
| Período:  | Registros: |
+-----------+------------+
| 1930      | 60155      |
| 1930,1940 | 141772     |
| 1940,1950 | 256001     |
| 1950,1960 | 396438     |
| 1960,1970 | 429148     |
| 1970,1980 | 279975     |
| 1980,1990 | 273960     |
| 1990,2000 | 352552     |
| 2000,2010 | 794118     |
+-----------+------------+
| MARIA     |            |
| Período:  | Registros: |
+-----------+------------+
| 1930      | 336477     |
| 1930,1940 | 749053     |
| 1940,1950 | 1487042    |
| 1950,1960 | 2476482    |
| 1960,1970 | 2495491    |
| 1970,1980 | 1616019    |
| 1980,1990 | 917968     |
| 1990,2000 | 544296     |
| 2000,2010 | 1111301    |
+-----------+------------+
").to_stdout
  end

  it "should show some error when name provided dont exists" do
    allow($stdin).to receive(:gets).and_return("1\n", "nomequenaoexiste\n")
    json = File.read('./spec/support/empty.json')
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/nomequenaoexiste"
    uri = URI.parse(URI.escape(url))
    object = double
    allow(Net::HTTP).to receive(:get_response).with(uri).and_return(object)
    allow(object).to receive(:body).and_return(json)
    allow(object).to receive(:code).and_return(200)


    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para sair do programa digite: sair.
Digite o nome para saber qual a frequencia do mesmo durante as décadas
Não existem registros para o(s) nome(s) nomequenaoexiste.
").to_stdout
  end

  it "should display error message when picking non existent optio" do
    allow($stdin).to receive(:gets).and_return("123131\n")



    expect { load "./lib/execute.rb" }.to output("Bem vindo ao RubyNames!
Para pesquisar a frequência de nomes ao longo das décadas digite: 1.
Para sair do programa digite: sair.
Opção não aceita, insira uma entrada válida
").to_stdout
  end

  it "should display error if status code not 200" do
    allow($stdin).to receive(:gets).and_return("1\n", "joao\n")
    json = File.read('./spec/support/empty.json')
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/joao"
    uri = URI.parse(URI.escape(url))
    object = double
    allow(Net::HTTP).to receive(:get_response).with(uri).and_return(object)
    allow(object).to receive(:body).and_return(json)
    allow(object).to receive(:code).and_return(400)
    allow($stdout).to receive(:puts) # esta linha limpa a saida durante o teste


    expect { load "./lib/execute.rb" }.to raise_error('Sem conexão com o servidor no momento.')


  end
end
