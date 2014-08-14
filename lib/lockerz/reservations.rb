# @author karmen Blake

module Lockerz
  class Reservations
    # !@attribute [r]
    #   @return [Lockerz::Lockers] lockers object referencing rooms and lockers
    attr_reader :lockers

    # Initialize reservations object
    # Holds growing and shrinking list of ticket reservations
    # @example
    #   reservations = Lockerz::Reservations.new
    def initialize
      @reservations = {}
      @lockers = Lockerz::Lockers.new
    end

    # Conviencience proxy method to internal hash's length
    # @return [Integer] Length of current list of reservations
    def length
      @reservations.length
    end

    # Assign a ticket to a locker and then add it to the reservation list
    # @param [Lockerz::Ticket] ticket ticket to create
    # @example
    #   reservations.create(ticket)
    def create(ticket)
      ticket.assign_available_locker_from(@lockers)
      add_ticket(ticket)
    end

    # Convenience method used by the 'create' method to add a ticket to the reservations list
    # @param [Lockerz::Ticket] ticket ticket to add
    def add_ticket(ticket)
      @reservations[ticket.confirmation_number] = ticket
    end

    # Remote a ticket from the the reservation list and free up the locker it used
    # @param [Lockerz::Ticket] ticket ticket to be removed
    def remove_ticket(ticket)
      @lockers.unassign(ticket) 
      @reservations.delete(ticket.confirmation_number)
    end

    # Find the ticket using its confirmation number
    # @param [String] confirmation_number
    def lookup(confirmation_number = nil)
      @reservations[confirmation_number]
    end

    # Proxy method over to the lockers object to simulate locker rooms being fully occupied
    # @param [String] locker_type which room to occupy
    def fill_locker_room_for(locker_type)
      lockers.fill_locker_room_for(locker_type)
    end

    def to_s
      if @reservations.length > 0
        @reservations.values.join("\n")
      else
        "No reservations yet"
      end
    end
  end
end
