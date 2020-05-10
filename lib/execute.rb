require_relative 'decade_name.rb'
require_relative 'uf_name.rb'

def decide(input)
  case input.downcase
  when "1"
    DecadeName.choose_name
  when "2"
    UfName.choose_uf
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
  puts 'Para sair do programa digite: sair.'
  input = $stdin.gets.chomp
  decide(input)
end

puts 'Bem vindo ao RubyNames!'
welcome
