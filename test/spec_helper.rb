require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

module LockersSpecExtensions
  def assign_locker(size, array)
    instance_variable_set("@#{size}".to_sym, array)
  end
end
