require_relative 'spec_helper'
require 'lockerz/lockers'

describe Lockerz::Lockers do
  let( :lockers ) do
    ls = Lockerz::Lockers.new
    ls.extend(LockersSpecExtensions)
    ls
  end
  
  describe 'lockers exist' do
    it 'small lockers' do
      lockers.wont_be_nil
      lockers.small.length.must_equal Lockerz::Lockers::DEFAULT_SIZE
    end

    it 'medium lockers' do
      lockers.medium.wont_be_nil  
      lockers.medium.length.must_equal Lockerz::Lockers::DEFAULT_SIZE
    end

    it 'large lockers' do
      lockers.large.wont_be_nil  
      lockers.large.length.must_equal Lockerz::Lockers::DEFAULT_SIZE
    end
  end

  describe 'manage lockers' do
    it 'assign locker' do
      lockers.assign_from(:small).must_equal [ 0, :small ]
      lockers.assign_from(:small).must_equal [ 1, :small ]
    end

    it 'unassign a ticket from locker' do
      ticket = Lockerz::Ticket.new('small')
      ticket.assign_available_locker_from(lockers)
      lockers.small[0].must_equal true
      lockers.unassign(ticket)
      lockers.small[0].must_equal false
    end

    it 'small locker request is full and medium is available' do
      lockers.assign_locker('small', Array.new(1000, true))
      lockers.assign_from(:small).must_equal [ 0, :medium ]
    end

    it 'small locker request is full, medium is full, large is available' do
      lockers.assign_locker('small', Array.new(1000, true))
      lockers.assign_locker('medium', Array.new(1000, true))
      lockers.assign_from(:small).must_equal [ 0, :large ]
    end

    it 'medium locker request is full, large is available' do
      lockers.assign_locker('medium', Array.new(1000, true))
      lockers.assign_from(:medium).must_equal [ 0, :large ]
    end

    it 'all lockers are full' do
      lockers.assign_locker('small', Array.new(1000, true))
      lockers.assign_locker('medium', Array.new(1000, true))
      lockers.assign_locker('large', Array.new(1000, true))
      proc { lockers.assign_from(:small) }.must_raise Lockerz::Error::NoLockersAvailable
    end
  end
end

