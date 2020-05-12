require_relative 'city_name.rb'

class Database
  
  def self.get_total_br_population
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

  def self.get_total_uf_population(sigla_uf)
    csv = CSV.read('db/populacao_2019.csv', :quote_char => "|")
    population = []
    csv.each do |row|
      if row[0] == "\"UF\"" && row[1] == "\"#{sigla_uf}\""
        population << row[3]
      end
    end
    return population[0][/\d+/]
  end

  def self.get_total_city_population(city_id)
    csv = CSV.read('db/populacao_2019.csv', :quote_char => "|")
    population = []
    csv.each do |row|
      if row[0] == "\"MU\"" && row[1] == "\"#{city_id}\""
        population << row[3]
      end
    end
    return population[0][/\d+/]
  end

  def self.create_city_db(db)
    db.execute <<-SQL
      create table if not exists cities (
        id varchar(500),
        nome varchar(500),
        uf varchar(50)
      );
    SQL
  end

  def self.check_city_db(db, cities)
    if db.execute( "select * from cities" ).empty?
      cities.each do |city|
        db.execute("INSERT INTO cities (id, nome, uf)
              VALUES (?, ?, ?)", ["#{city[:id]}",
                                "#{CityName.string_sanitizer(city[:nome].downcase)}",
                                "#{city[:microrregiao][:mesorregiao][:UF][:sigla]}"])
      end
    end
  end

  def self.create_uf_db(db)
    db.execute <<-SQL
      create table if not exists uf (
        id varchar(50),
        sigla varchar(50),
        nome varchar(50)
      );
    SQL
  end

  def self.check_uf_db(db, states)
    if db.execute( "select * from uf" ).empty?
      states.each do |state|
        db.execute("INSERT INTO uf (id, sigla, nome)
              VALUES (?, ?, ?)", ["#{state[:id]}",
                                  "#{state[:sigla]}",
                                  "#{state[:nome]}"])
      end
    end
  end
end
