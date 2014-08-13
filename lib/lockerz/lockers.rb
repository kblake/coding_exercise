require 'lockerz/error'

module Lockerz
  class Lockers
    attr_reader :small, :medium, :large

    DEFAULT_SIZE = 1000

    def initialize
      @small = Array.new(DEFAULT_SIZE, false)  
      @medium = Array.new(DEFAULT_SIZE, false)  
      @large = Array.new(DEFAULT_SIZE, false)  
    end

    def assign_from(locker_size)
      next_available_locker = send(locker_size).index(false)
      raise Lockerz::Error::NoLockersAvailable unless next_available_locker

      send(locker_size)[next_available_locker] = true
      next_available_locker
    end
  end
end
