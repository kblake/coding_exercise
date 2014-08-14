require 'securerandom'

# @author Karmen Blake
module Lockerz
  class Ticket
    # @!attribute [r] confirmation_number
    #   @return [String] confirmation number used to associate with a guest's reservation 
    attr_reader   :confirmation_number

    # @!attribute locker_number
    #   @return [Integer] locker number assigned
    attr_accessor :locker_number

    # @!attribute bag_size
    #   @return [String] locker room type assigned
    attr_accessor :bag_size

    # Initialize a ticket object. Generates a confirmation number for ticket.
    # @param [String] bag_size used to set the desired locker room
    # @example
    #   ticket = Lockerz::Ticket.new('small')
    def initialize(bag_size)
      unless Lockerz::Lockers::TYPES.include? bag_size
        raise Lockerz::Error::InvalidLockerType
      end

      @confirmation_number = SecureRandom.hex
      @bag_size = bag_size
    end

    # Assign an available locker number and locker room to this ticket
    # @param [Lockerz::Lockers] lockers needed to intelligently get locker from proper room
    # @example
    #   ticket.assign_available_locker_from(lockers) 
    def assign_available_locker_from(lockers)
      @locker_number, @bag_size = lockers.assign_from(@bag_size)
    end

    def to_s
      "Confirmation #: #{@confirmation_number}, In the #{@bag_size.capitalize} locker room at locker #{@locker_number}"
    end
  end
end
