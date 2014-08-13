module Lockerz
  class Reservations
    def initialize
      @reservations = {}
    end

    def length
      @reservations.length
    end

    def create(lockers, ticket)
      ticket.assign_available_locker_from(lockers)
      add_ticket(ticket)
    end

    def add_ticket(ticket)
      @reservations[ticket.confirmation_number] = ticket
    end

    def remove_ticket(lockers, ticket)
      lockers.unassign(ticket) 
      @reservations.delete(ticket.confirmation_number)
    end
  end
end
