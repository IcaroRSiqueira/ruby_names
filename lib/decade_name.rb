require 'json'
require 'terminal-table'
require 'net/http'
class DecadeName
  def self.choose_name
    puts 'Digite o nome para saber qual a frequencia do mesmo durante as décadas'
    input = $stdin.gets.chomp.downcase
    DecadeName.get_decades(input)
  end

  def self.get_decades(input)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{input.to_s.gsub(",","|")}"
    uri = URI.parse(URI.escape(url))
    response = Net::HTTP.get_response(URI.parse(URI.escape(url)))
    DecadeName.check_status(response.code)
    decades = JSON.parse(response.body, symbolize_names: true)
    return welcome if DecadeName.name_valid?(decades, input) == false
    puts "Exibindo resultados para o(s) nome(s) #{input}:"
    puts DecadeName.table_maker(decades)
    welcome
  end

  def self.table_maker(decades)
    rows = []
    if decades.length == 1
      DecadeName.single_name(rows, decades)
    elsif decades.length > 1
      DecadeName.multiple_names(rows, decades)
    end
    Terminal::Table.new :rows => rows
  end

  def self.single_name(rows, decades)
    rows << :separator
    rows << ["#{decades[0][:nome]}", " "]
    rows << ["Período:", "Registros:"]
    rows << :separator
    decades[0][:res].each do |i|
      rows << ["#{i[:periodo]}".tr('[', ''),
                "#{i[:frequencia]}"]
    end
  end

  def self.multiple_names(rows, decades)
    decades.each do |i|
      rows << :separator
      rows << ["#{i[:nome]}", " "]
      rows << ["Período:", "Registros:"]
      rows << :separator
      i[:res].each do |i|
        rows << ["#{i[:periodo]}".tr('[', ''),
                  "#{i[:frequencia]}"]
      end
    end
  end

  def self.check_status(code)
    unless code.to_i == 200
      raise "Sem conexão com o servidor no momento."
    end
  end

  def self.name_valid?(decades, input)
    if decades.empty?
      puts "Não existem registros para o(s) nome(s) #{input}."
      false
    end
  end
end
