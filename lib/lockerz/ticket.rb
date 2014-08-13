require 'securerandom'

module Lockerz
  class Ticket
    attr_reader   :confirmation_number
    attr_accessor :locker_number
    attr_accessor :bag_size

    def initialize(bag_size)
      unless Lockerz::Lockers::TYPES.include? bag_size
        raise Lockerz::Error::InvalidLockerType
      end

      @confirmation_number = SecureRandom.hex
      @bag_size = bag_size
    end

    # locker number
    # bag size returned because it may have changed
    def assign_available_locker_from(lockers)
      @locker_number, @bag_size = lockers.assign_from(@bag_size)
    end
  end
end
