# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

# Greets the world.
class Greeter
  extend T::Sig

  sig { returns(String) }
  def greet
    # greeting
    'Hello, world'
  end
end

puts Greeter.new.greet
