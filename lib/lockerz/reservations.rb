module Lockerz
  class Reservations
    attr_reader :lockers

    def initialize
      @reservations = {}
      @lockers = Lockerz::Lockers.new
    end

    def length
      @reservations.length
    end

    def create(ticket)
      ticket.assign_available_locker_from(@lockers)
      add_ticket(ticket)
    end

    def add_ticket(ticket)
      @reservations[ticket.confirmation_number] = ticket
    end

    def remove_ticket(ticket)
      @lockers.unassign(ticket) 
      @reservations.delete(ticket.confirmation_number)
    end

    def lookup(confirmation_number = nil)
      @reservations[confirmation_number]
    end

    def to_s
      if @reservations.length > 0
        #output = ""
        #@reservations.values.each do |ticket|
          #output << ticket.to_s
        #end
        #output

        @reservations.values.join("\n")
      else
        "No reservations yet"
      end
    end
  end
end
