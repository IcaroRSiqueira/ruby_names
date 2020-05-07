require 'spec_helper'
require 'ruby_names'

describe "ruby_names" do

  it "displays welcome message and uf selected" do
    allow($stdin).to receive(:gets).and_return("Joao\n")
    json = File.read('./spec/support/joao_test.json')
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/joao"
    allow(Faraday).to receive(:get).with(url).and_return(json)

    expect { load "./lib/run.rb" }.to output("Bem vindo ao RubyNames!
Digite o nome para saber qual a frequencia do mesmo durante as décadas
Exibindo resultados para o nome joao
+--------------------+-------------------+
| Período: 1930      | Registros: 60155  |
| Período: 1930,1940 | Registros: 141772 |
| Período: 1940,1950 | Registros: 256001 |
| Período: 1950,1960 | Registros: 396438 |
| Período: 1960,1970 | Registros: 429148 |
| Período: 1970,1980 | Registros: 279975 |
| Período: 1980,1990 | Registros: 273960 |
| Período: 1990,2000 | Registros: 352552 |
| Período: 2000,2010 | Registros: 794118 |
+--------------------+-------------------+
").to_stdout
  end
end
