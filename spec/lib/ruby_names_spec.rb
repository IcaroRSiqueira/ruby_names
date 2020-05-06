require 'spec_helper'
require 'ruby_names'

describe "ruby_names" do
  it "displays welcome message" do
    printed = capture_stdout do
      load "./lib/ruby_names.rb"
    end

    expect(printed).to eq("Bem vindo ao RubyNames!\n")
  end
end
