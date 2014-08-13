require 'securerandom'

module Lockerz
  class Ticket
    attr_reader :confirmation_number
    attr_reader :locker_number
    attr_reader :bag_capacity

    def initialize(bag_capacity)
      unless Lockerz::Lockers::TYPES.include? bag_capacity
        raise Lockerz::Error::InvalidLockerType
      end

      @confirmation_number = SecureRandom.hex
      @bag_capacity = bag_capacity
    end

    def assign_locker(lockers)
      @locker_number = lockers.assign_from(@bag_capacity)
    end

  end
end
