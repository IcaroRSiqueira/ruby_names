require 'json'
require 'terminal-table'
require 'net/http'
require 'csv'
require_relative 'api_communication.rb'
require_relative 'tables.rb'

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
    ApiCommunication.check_status(response.code)
    decades = JSON.parse(response.body, symbolize_names: true)
    return welcome if DecadeName.name_valid?(decades, input) == false
    population = DecadeName.get_total_population
    puts "Exibindo resultados para o(s) nome(s) #{input}:"
    puts Tables.decade_table_maker(decades, population)
    welcome
  end

  def self.name_valid?(decades, input)
    if decades.empty?
      puts "Não existem registros para o(s) nome(s) #{input}."
      false
    end
  end

  def self.get_total_population
    csv = CSV.read('db/populacao_2019.csv', :quote_char => "|")
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
