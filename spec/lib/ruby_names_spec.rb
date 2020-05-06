require 'spec_helper'
require 'ruby_names'

describe "ruby_names" do

  it "displays welcome message and uf selected" do
    printed = capture_stdout do
      RubyNames.welcome
    end

    expect($stdout).to include("Bem vindo ao RubyNames!\n")
    expect(printed).to include("Digite o UF para saber quais são os nomes mais comuns no estado\n")
    allow($stdin).to receive(:gets).and_return("SP\n")
    expect(printed).to include("O estado escolhido é SP\n")
  end
end
