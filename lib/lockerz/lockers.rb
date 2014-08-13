require_relative 'error'

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

      if next_available_locker.nil?
        if locker_size == :small
          locker_size = :medium
          next_available_locker = send(locker_size).index(false)
        end
      end

      if next_available_locker.nil?
        if locker_size == :medium
          locker_size = :large
          next_available_locker = send(locker_size).index(false)
        end
      end

      if next_available_locker.nil?
        if locker_size == :large
          raise Lockerz::Error::NoLockersAvailable
        end
      end

      send(locker_size)[next_available_locker] = true
      [ next_available_locker, locker_size ]
    end

    def unassign(ticket)
      send(ticket.bag_size)[ticket.locker_number] = false
    end
  end
end
