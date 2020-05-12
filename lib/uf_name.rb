require 'json'
require 'terminal-table'
require 'net/http'
require "sqlite3"
require 'byebug'
require_relative 'api_communication.rb'
require_relative 'tables.rb'

class UfName

  def self.user_choose_uf
    puts 'Digite a sigla da UF (exemplo: SP) para saber quais os nomes mais comuns no estado'
    input = $stdin.gets.chomp.upcase
    UfName.select_uf(input)
  end

  def self.select_uf(input)
    uf = UfName.check_uf_initials(input)
    begin
      url_all = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{uf[0]}"
      url_mal = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{uf[0]}&sexo=M"
      url_fem = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{uf[0]}&sexo=F"
    rescue
      puts 'Entrada não aceita.'
      return UfName.user_choose_uf
    end
    responses = [url_all, url_mal, url_fem].map do |url|
      ApiCommunication.get_response(url)
    end
    population = Database.get_total_uf_population(uf[0])
    puts Tables.uf_table_maker(responses[0], 'Geral', uf, population)
    puts Tables.uf_table_maker(responses[1], 'Nomes masculinos', uf, population)
    puts Tables.uf_table_maker(responses[2], 'Nomes femininos', uf, population)
    welcome
  end

  def self.check_uf_initials(input)
    db = SQLite3::Database.new "db/ufs.db"
    Database.create_uf_db(db)
    if db.execute( "select * from uf" ).empty?
      UfName.get_states(db)
    end
    db.execute( "select * from uf where sigla='#{input}'" ) do |row|
      return row
    end
  end

  def self.get_states(db)
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    states = ApiCommunication.get_response(url)
    Database.check_uf_db(db, states)
  end
end
