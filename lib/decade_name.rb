require 'json'
require 'terminal-table'
require 'net/http'
require 'csv'
require_relative 'api_communication.rb'
require_relative 'tables.rb'
require_relative 'database.rb'


class DecadeName

  def self.user_choose_name
    puts 'Digite o nome para saber qual a frequencia do mesmo durante as décadas'
    input = $stdin.gets.chomp.downcase
    DecadeName.get_decades(input)
  end

  def self.get_decades(input)
    url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{input.to_s.gsub(",","|")}"
    decades = ApiCommunication.get_response(url)
    return welcome if DecadeName.name_valid?(decades, input) == false
    population = Database.get_total_br_population
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
end
