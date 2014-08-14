require_relative 'error'

# @author Karmen Blake
module Lockerz
  class Lockers

    # @!attribute [r] small
    #   @return [Array] collection to keep track of lockers
    # @!attribute [r] medium
    #   @return [Array] collection to keep track of lockers
    # @!attribute [r] large
    #   @return [Array] collection to keep track of lockers
    attr_reader :small, :medium, :large

    # Default size of each locker room
    DEFAULT_SIZE = 1000

    # Locker room types
    TYPES = %w( small medium large )

    # Initialize a lockers object
    # @example
    #   lockers = Lockerz::Lockers.new
    def initialize
      @small = Array.new(DEFAULT_SIZE, false)  
      @medium = Array.new(DEFAULT_SIZE, false)  
      @large = Array.new(DEFAULT_SIZE, false)  
    end

    # Intelligently look for and assign a locker from a specified room. If room
    # is full then it will look at next size up lockers and so on.
    # If all lockers from all rooms are full then an error will notify
    # of that.
    #
    # @param [String] locker_size locker room type (small, medium, large)
    # @return [Array] Locker number and locker room assigned to
    # @example
    #   lockers.assign_from('small')
    #   lockers.assign_from('medium')
    #   lockers.assign_from('large')
    def assign_from(locker_size)
      next_available_locker = send(locker_size).index(false)

      if next_available_locker.nil?
        if locker_size == 'small'
          locker_size = 'medium'
          next_available_locker = send(locker_size).index(false)
        end
      end

      if next_available_locker.nil?
        if locker_size == 'medium'
          locker_size = 'large'
          next_available_locker = send(locker_size).index(false)
        end
      end

      if next_available_locker.nil?
        if locker_size == 'large'
          raise Lockerz::Error::NoLockersAvailable
        end
      end

      send(locker_size)[next_available_locker] = true
      [ next_available_locker, locker_size ]
    end

    # Set locker for a particular ticket to false (unused)
    #
    # @param [Lockerz::Ticket] ticket to unassign locker from
    # @example
    #   lockers.unassign(ticket)
    def unassign(ticket)
      send(ticket.bag_size)[ticket.locker_number] = false
    end

    # Utility method used by admins to simulate locker rooms being full
    #
    # @param [String] locker_size locker room type (small, medium, large)
    # @example
    #   lockers.fill_locker_room_for('small')
    #   lockers.fill_locker_room_for('all')
    def fill_locker_room_for(locker_type)
      if locker_type == 'all'
        @small = Array.new(DEFAULT_SIZE, true)
        @medium = Array.new(DEFAULT_SIZE, true)
        @large = Array.new(DEFAULT_SIZE, true)
      end

      instance_variable_set("@#{locker_type}".to_sym, Array.new(DEFAULT_SIZE, true))
    end
  end
end
