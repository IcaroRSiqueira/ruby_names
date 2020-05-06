class RubyNames
  def self.welcome
    puts 'Bem vindo ao RubyNames!'
    puts 'Digite o UF para saber quais são os nomes mais comuns no estado'
    input = $stdin.gets.chomp
    puts "O estado escolhido é #{input}"
  end
end
