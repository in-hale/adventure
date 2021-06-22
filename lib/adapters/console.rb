# frozen_string_literal: true

module Adapters
  class Console

    def println(string = '')
      Kernel.puts(string) unless string.nil?
    end

    def readline(prompt = '')
      Readline.readline(prompt, true)
    end

    def clear
      system 'clear'
    end

  end
end
