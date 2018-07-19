require 'set'

class MinilangRuntimeError < RuntimeError; end
class BadTokenError < MinilangRuntimeError; end
class EmptyStackError < MinilangRuntimeError; end

class Minilang
  INSTRUCTIONS = Array.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
  
  def initialize(program)
    @program = program.split
    @stack = []
    @register = 0
  end

  def eval
    @program.each { |token| eval_token(token) }
  rescue MinilangRuntimeError => error
    puts error.message
  end

  def eval_token(token)
    if INSTRUCTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack << @register
  end
  
  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end
  
  def print
    puts @register
  end
  
  def add
    @register += @stack.pop
  end
  
  def sub
    @register -= @stack.pop
  end
  
  def mult
    @register *= @stack.pop
  end

  def div
    @register /= @stack.pop
  end

  def mod
    @register %= @stack.pop
  end

end

Minilang.new('5 PRINT').eval
Minilang.new('5 PUSH 3 MULT PRINT').eval
Minilang.new('-3 PUSH 5 XSUB PRINT').eval
Minilang.new('5 PUSH POP POP PRINT').eval