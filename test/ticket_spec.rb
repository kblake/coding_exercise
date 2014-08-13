require_relative 'spec_helper'
require 'lockerz/ticket'

describe Lockerz::Ticket do
  let( :lockers ) { Lockerz::Lockers.new }
  describe 'create' do
    let ( :ticket ) { Lockerz::Ticket.new }

    it 'generate confirmation number' do
      ticket.confirmation_number.wont_be_nil
    end

    it 'assign a locker number' do
      ticket.assign_locker(lockers)
      ticket.locker_number.wont_be_nil
    end
  end

  describe 'lookup' do
  end

  describe 'add' do
  end

  describe 'remove' do
  end
end
