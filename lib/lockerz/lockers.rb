require 'lockerz/error'

module Lockerz
  class Lockers
    attr_reader :small, :medium, :large

    DEFAULT_SIZE = 1000
    TYPES = %w( small medium large )

    def initialize
      @small = Array.new(DEFAULT_SIZE, false)  
      @medium = Array.new(DEFAULT_SIZE, false)  
      @large = Array.new(DEFAULT_SIZE, false)  
    end

    def assign_from(locker_size)
      next_available_locker = send(locker_size).index(false)

      unless next_available_locker
        if locker_size == 'small'.to_sym
          locker_size = :medium
          next_available_locker = send(locker_size).index(false)
        end
      end

      unless next_available_locker
        if locker_size == 'medium'.to_sym
          locker_size = :large
          next_available_locker = send(locker_size).index(false)
        end
      end

      unless next_available_locker
        if locker_size == 'large'.to_sym
          raise Lockerz::Error::NoLockersAvailable
        end
      end

      send(locker_size)[next_available_locker] = true
      [ next_available_locker, locker_size ]
    end
  end
end
