require 'json'
require 'terminal-table'
require 'net/http'
require "sqlite3"
class CityName
  def self.choose_city
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
      return CityName.choose_city
    end
    general = CityName.names_getter(url_all)
    male = CityName.names_getter(url_mal)
    female = CityName.names_getter(url_fem)
    CityName.table_maker(general, 'Geral', city)
    CityName.table_maker(male, 'Nomes masculinos', city)
    CityName.table_maker(female, 'Nomes femininos', city)
    welcome
  end

  def self.check_city_name(input)
    db = SQLite3::Database.new "db/cities.db"
    CityName.create_table(db)
    if db.execute( "select * from cities" ).empty?
      CityName.get_cities(db)
    end
    db.execute( "select * from cities where nome='#{input}'" ) do |row|
      return row
    end
  end

  def self.get_cities(db)
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/municipios"
    uri = URI.parse(URI.escape(url))
    response = Net::HTTP.get_response(URI.parse(URI.escape(url)))
    cities = JSON.parse(response.body, symbolize_names: true)
    CityName.check_db(db, cities)
  end

  def self.create_table(db)
    db.execute <<-SQL
      create table if not exists cities (
        id varchar(500),
        nome varchar(500),
        uf varchar(50)
      );
    SQL
  end

  def self.check_db(db, cities)
    if db.execute( "select * from cities" ).empty?
      cities.each do |city|
        db.execute("INSERT INTO cities (id, nome, uf)
              VALUES (?, ?, ?)", ["#{city[:id]}",
                                "#{CityName.string_sanitizer(city[:nome].downcase)}",
                                "#{city[:microrregiao][:mesorregiao][:UF][:sigla]}"])
      end
    end
  end

  def self.check_status(code)
    unless code.to_i == 200
      raise "Sem conexão com o servidor no momento."
    end
  end

  def self.names_getter(url)
    uri = URI.parse(URI.escape(url))
    response = Net::HTTP.get_response(URI.parse(URI.escape(url)))
    CityName.check_status(response.code)
    names = JSON.parse(response.body, symbolize_names: true)
    names
  end

  def self.table_maker(names, title, city)
    population = CityName.get_total_population(city[0])
    rows = []
    rows << :separator
    rows << ["#{title}",
              "#{city[1].capitalize}, (#{city[2]})",
              "Porcentagem"]
    rows << ["Nome:", "Ranking:", "(%):"]
    rows << :separator
    names[0][:res].each do |i|
      rows << ["#{i[:nome]}".tr('[', ''),
                "#{i[:ranking]}",
                "#{(i[:frequencia]/population.to_f * 100).round(4)} %"]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end

  def self.get_total_population(city_id)
    csv = CSV.read('db/populacao_2019.csv', :quote_char => "|")
    population = []
    csv.each do |row|
      if row[0] == "\"MU\"" && row[1] == "\"#{city_id}\""
        population << row[3]
      end
    end
    return population[0][/\d+/]
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
