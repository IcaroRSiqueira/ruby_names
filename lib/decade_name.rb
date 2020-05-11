require 'json'
require 'terminal-table'
require 'net/http'
require 'csv'
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
    population = DecadeName.get_total_population
    puts "Exibindo resultados para o(s) nome(s) #{input}:"
    puts DecadeName.table_maker(decades, population)
    welcome
  end

  def self.table_maker(decades, population)
    rows = []
    if decades.length == 1
      DecadeName.single_name(rows, decades, population)
    elsif decades.length > 1
      DecadeName.multiple_names(rows, decades, population)
    end
    Terminal::Table.new :rows => rows
  end

  def self.single_name(rows, decades, population)
    rows << :separator
    rows << ["#{decades[0][:nome]}", "", ""]
    rows << ["Período:", "Registros:", "(%) Brasil:"]
    rows << :separator
    decades[0][:res].each do |i|
      rows << ["#{i[:periodo]}".tr('[', ''),
                "#{i[:frequencia]}",
                "#{(i[:frequencia]/population.to_f * 100).round(4)} %"]
    end
  end

  def self.multiple_names(rows, decades, population)
    decades.each do |i|
      rows << :separator
      rows << ["#{i[:nome]}", "", ""]
      rows << ["Período:", "Registros:", "(%) Brasil:"]
      rows << :separator
      i[:res].each do |i|
        rows << ["#{i[:periodo]}".tr('[', ''),
                  "#{i[:frequencia]}",
                  "#{(i[:frequencia]/population.to_f * 100).round(4)} %"]
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

  def self.get_total_population
    csv = CSV.read('populacao_2019.csv', :quote_char => "|")
    total = []
    csv.each do |row|
      if row[0] == "\"UF\""
        total << row[3]
      end
    end
    numbers = total.map {|x| x[/\d+/]}
    return numbers.map(&:to_i).sum
  end
end
