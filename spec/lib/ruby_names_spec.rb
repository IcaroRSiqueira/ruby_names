require 'spec_helper'
require 'ruby_names'

describe "ruby_names" do

  it "displays welcome message and uf selected" do
    allow($stdin).to receive(:gets).and_return("SP\n")

    expect { load "./lib/run.rb" }.to output("Bem vindo ao RubyNames!\nDigite o UF para saber quais são os nomes mais comuns no estado\nO estado escolhido é SP\n").to_stdout

  end
end
