require 'json'
require 'terminal-table'
require 'net/http'
require "sqlite3"
require 'byebug'
require_relative 'api_communication.rb'
require_relative 'tables.rb'

class UfName

  def self.choose_uf
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
      return UfName.choose_uf
    end
    general = UfName.names_getter(url_all)
    male = UfName.names_getter(url_mal)
    female = UfName.names_getter(url_fem)
    population = UfName.get_total_population(uf[0])

    puts Tables.uf_table_maker(general, 'Geral', uf, population)
    puts Tables.uf_table_maker(male, 'Nomes masculinos', uf, population)
    puts Tables.uf_table_maker(female, 'Nomes femininos', uf, population)
    welcome
  end

  def self.check_uf_initials(input)
    db = SQLite3::Database.new "db/ufs.db"
    UfName.create_table(db)
    if db.execute( "select * from uf" ).empty?
      UfName.get_states(db)
    end
    db.execute( "select * from uf where sigla='#{input}'" ) do |row|
      return row
    end
  end

  def self.get_states(db)
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    uri = URI.parse(URI.escape(url))
    response = Net::HTTP.get_response(URI.parse(URI.escape(url)))
    states = JSON.parse(response.body, symbolize_names: true)
    UfName.check_db(db, states)
  end

  def self.create_table(db)
    db.execute <<-SQL
      create table if not exists uf (
        id varchar(50),
        sigla varchar(50),
        nome varchar(50)
      );
    SQL
  end

  def self.check_db(db, states)
    if db.execute( "select * from uf" ).empty?
      states.each do |state|
        db.execute("INSERT INTO uf (id, sigla, nome)
              VALUES (?, ?, ?)", ["#{state[:id]}", "#{state[:sigla]}", "#{state[:nome]}"])
      end
    end
  end

  def self.names_getter(url)
    uri = URI.parse(URI.escape(url))
    response = Net::HTTP.get_response(URI.parse(URI.escape(url)))
    ApiCommunication.check_status(response.code)
    names = JSON.parse(response.body, symbolize_names: true)
    names
  end

  def self.get_total_population(sigla_uf)
    csv = CSV.read('db/populacao_2019.csv', :quote_char => "|")
    population = []
    csv.each do |row|
      if row[0] == "\"UF\"" && row[1] == "\"#{sigla_uf}\""
        population << row[3]
      end
    end
    return population[0][/\d+/]
  end
end
