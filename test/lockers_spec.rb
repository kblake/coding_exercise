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
      lockers.assign_from(:small).must_equal 0
      lockers.assign_from(:small).must_equal 1
    end

    it 'locker is full' do
      lockers.assign_locker('small', Array.new(1000, true))

      proc { lockers.assign_from(:small) }.must_raise Lockerz::Error::NoLockersAvailable
    end
  end
end

