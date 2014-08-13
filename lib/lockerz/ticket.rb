require 'securerandom'

module Lockerz
  class Ticket
    attr_reader :confirmation_number
    attr_reader :locker_number

    def initialize
      @confirmation_number = SecureRandom.hex
    end

    def assign_locker(lockers)
      @locker_number = lockers.assign_from(:small)
    end

  end
end
