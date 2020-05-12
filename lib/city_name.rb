require 'json'
require 'terminal-table'
require 'net/http'
require "sqlite3"
require_relative 'api_communication.rb'
require_relative 'tables.rb'

class CityName

  def self.user_choose_city
    puts 'Digite o nome da cidade (sem acentuação, exemplo: sao paulo) para saber quais os nomes mais comuns no município.'
    input = $stdin.gets.chomp.downcase
    CityName.select_city(input)
  end

  def self.select_city(input)
    city = CityName.check_city_name(input)
    begin
      url_all = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{city[0]}"
      url_mal = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{city[0]}&sexo=M"
      url_fem = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{city[0]}&sexo=F"
    rescue
      puts 'Entrada não aceita.'
      return CityName.user_choose_city
    end
    responses = [url_all, url_mal, url_fem].map do |url|
      ApiCommunication.get_response(url)
    end
    population = Database.get_total_city_population(city[0])
    puts Tables.city_table_maker(responses[0], 'Geral', city, population)
    puts Tables.city_table_maker(responses[1], 'Nomes masculinos', city, population)
    puts Tables.city_table_maker(responses[2], 'Nomes femininos', city, population)
    welcome
  end

  def self.check_city_name(input)
    db = SQLite3::Database.new "db/cities.db"
    Database.create_city_db(db)
    if db.execute( "select * from cities" ).empty?
      CityName.get_cities(db)
    end
    db.execute( "select * from cities where nome='#{input}'" ) do |row|
      return row
    end
  end

  def self.get_cities(db)
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/municipios"
    cities = ApiCommunication.get_response(url)
    Database.check_db(db, cities)
  end

  def self.string_sanitizer(string)
    string.gsub!(/[ÄÅÁÂÀÃäáâàã]/,'a')
    string.gsub!(/[ÉÊËÈéêëè]/, 'e')
    string.gsub!(/[ÍÎÏÌíîïì]/, 'i')
    string.gsub!(/[ÖÓÔÒÕöóôòõ]/, 'o')
    string.gsub!(/[ÜÚÛüúûù]/, 'u')
    string.gsub!(/[Çç]/, 'c')
    string.gsub!(/[''`]/, ',')
    string
  end
end
