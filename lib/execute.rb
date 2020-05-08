require_relative 'decade_name.rb'

def decide(input)
  if input.to_i == 1
    DecadeName.choose_name
  elsif input == "sair"
    abort "Saindo do RubyNames, até logo!"
  else
    puts 'Opção não aceita, insira uma entrada válida'
  end
end

def welcome
  puts 'Para pesquisar a frequência de nomes ao longo das décadas digite: 1.'
  puts 'Para sair do programa digite: sair.'
  input = $stdin.gets.chomp
  decide(input)
end

puts 'Bem vindo ao RubyNames!'
welcome
