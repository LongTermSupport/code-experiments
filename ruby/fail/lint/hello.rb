# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

# Greets the world.
class Greeter
  extend T::Sig

  sig { returns(String) }
  def greet
    unused = 1
    'Hello, world'
  end
end

puts Greeter.new.greet
