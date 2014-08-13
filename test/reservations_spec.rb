require_relative 'spec_helper'
require 'lockerz/reservations'

describe Lockerz::Reservations do
  let ( :reservations ) { Lockerz::Reservations.new }

  it 'length' do
    reservations.length.must_equal 0
  end

  it 'add ticket' do
    reservations.add_ticket(Lockerz::Ticket.new('small'))
    reservations.length.must_equal 1
  end

  it 'remove ticket' do
    ticket = Lockerz::Ticket.new('small')
    ticket.assign_available_locker_from(reservations.lockers)
    reservations.add_ticket(ticket)
    reservations.length.must_equal 1
    reservations.remove_ticket(ticket)
    reservations.length.must_equal 0
  end

  it 'create reservation' do
    ticket = Lockerz::Ticket.new('small')
    reservations.create(ticket).wont_be_nil
  end

  it 'lookup by confirmation number' do
    ticket = Lockerz::Ticket.new('small')
    reservations.create(ticket)
    reservations.lookup(ticket.confirmation_number).wont_be_nil
  end
end
