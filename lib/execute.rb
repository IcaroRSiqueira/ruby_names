require_relative 'decade_name.rb'
require_relative 'uf_name.rb'
require_relative 'city_name.rb'

def decide(input)
  case input.downcase
  when "1"
    DecadeName.user_choose_name
  when "2"
    UfName.user_choose_uf
  when "3"
    CityName.user_choose_city
  when "sair"
    puts "Saindo do RubyNames, até logo!"
  else
    puts 'Opção não aceita, insira uma entrada válida'
    welcome
  end
end

def welcome
  puts 'Para pesquisar a frequência de nomes ao longo das décadas digite: 1.'
  puts 'Para pesquisar os nomes mais comuns por UF digite: 2.'
  puts 'Para pesquisar os nomes mais comuns por município digite: 3.'
  puts 'Para sair do programa digite: sair.'
  input = $stdin.gets.chomp
  decide(input)
end

puts 'Bem vindo ao RubyNames!'
welcome
