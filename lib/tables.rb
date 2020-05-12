class Tables

  def self.decade_table_gen(list, rows, population)
    list.each do |i|
      rows << ["#{i[:periodo]}".tr('[', ''),
                "#{i[:frequencia]}",
                "#{(i[:frequencia]/population.to_f * 100).round(4)} %"]
    end
  end

  def self.location_table_gen(list, rows, population)
    list.each do |i|
      rows << ["#{i[:nome]}".tr('[', ''),
                "#{i[:ranking]}",
                "#{(i[:frequencia]/population.to_f * 100).round(4)} %"]
    end
  end

  def self.decade_table_single_name(rows, decades, population)
    rows << :separator
    rows << ["#{decades[:nome]}", "", ""]
    rows << ["Período:", "Registros:", "(%) Brasil:"]
    rows << :separator
    Tables.decade_table_gen(decades[:res], rows, population)
  end

  def self.decade_table_multiple_names(rows, decades, population)
    decades.each do |i|
      Tables.decade_table_single_name(rows, i, population)
    end
  end

  def self.uf_table_maker(names, title, uf, population)
    rows = []
    rows << :separator
    rows << ["#{title}", " ", " "]
    rows << ["Nome:", "Ranking:", "(%) #{uf[1]}"]
    rows << :separator
    Tables.location_table_gen(names[0][:res], rows, population)
    Terminal::Table.new :rows => rows
  end

  def self.city_table_maker(names, title, city, population)
    rows = []
    rows << :separator
    rows << ["#{title}",
              "#{city[1].capitalize}, (#{city[2]})",
              "Porcentagem"]
    rows << ["Nome:", "Ranking:", "(%):"]
    rows << :separator
    Tables.location_table_gen(names[0][:res], rows, population)
    Terminal::Table.new :rows => rows
  end

  def self.decade_table_maker(decades, population)
    rows = []
    if decades.length == 1
      Tables.decade_table_single_name(rows, decades[0], population)
    elsif decades.length > 1
      Tables.decade_table_multiple_names(rows, decades, population)
    end
    Terminal::Table.new :rows => rows
  end
end
