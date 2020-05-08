require 'json'
require 'terminal-table'
require 'net/http'
class RubyNames
  def self.choose_decade
    puts 'Digite o nome para saber qual a frequencia do mesmo durante as décadas'
    input = $stdin.gets.chomp.downcase
    RubyNames.get_decades(input)
  end

  def self.get_decades(input)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{input.to_s.gsub(",","|")}"
    uri = URI.parse(URI.escape(url))
    response = Net::HTTP.get_response(uri)
    unless response.code == 200
      abort "Sem conexão com o servidor no momento."
    end
    decades = JSON.parse(response.body, symbolize_names: true)
    rows = []
    return puts "Não existem resultados para #{input}." if decades.empty?
    puts "Exibindo resultados para o(s) nome(s) #{input}:"
    if decades.length == 1
      rows << :separator
      rows << ["#{decades[0][:nome]}", " "]
      rows << ["Período:", "Registros:"]
      rows << :separator
      decades[0][:res].each do |i|
        rows << ["#{i[:periodo]}".tr('[', ''),
                  "#{i[:frequencia]}"]
      end
    elsif decades.length > 1
      decades.each do |i|
        rows << :separator
        rows << ["#{i[:nome]}", " "]
        rows << ["Período:", "Registros:"]
        rows << :separator
        i[:res].each do |decade|
          rows << ["#{decade[:periodo]}".tr('[', ''),
                    "#{decade[:frequencia]}"]
        end
      end
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end
