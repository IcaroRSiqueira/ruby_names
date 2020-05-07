require 'faraday'
require 'json'
require 'terminal-table'
class RubyNames


  def self.choose_decade
    puts 'Digite o nome para saber qual a frequencia do mesmo durante as décadas'
    input = $stdin.gets.chomp.downcase
    puts "Exibindo resultados para o nome #{input}"
    RubyNames.get_decades(input)
  end

  def self.get_decades(input)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{input.to_s}"
    response = Faraday.get(url)
    decades = JSON.parse(response, symbolize_names: true)
    rows = []
    decades[0][:res].each do |i|
      rows << ["Período: #{i[:periodo]}".tr('[', ''),
                "Registros: #{i[:frequencia]}"]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end
