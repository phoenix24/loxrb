# frozen_string_literal: true

require_relative "loxrb/version"


require "readline"

class LoxLang
  def repl()
    expression, welcome = "welcome to loxrb repl"
    puts welcome
    until expression == "quit"
      expression = Readline.readline(">> ", true)
      puts "you said #{expression}"
    end
  end

  def script(file)
  end
end




module Loxrb
  class Error < StandardError
  end

  LoxLang.new.repl
end
