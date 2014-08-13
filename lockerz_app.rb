#!/usr/bin/env ruby

require 'highline/import'
require_relative 'lib/lockerz/ticket'
require_relative 'lib/lockerz/lockers'
require_relative 'lib/lockerz/reservations'

reservations = Lockerz::Reservations.new

puts
say "Welcome to Lockerz"
say "------------------"
say "Manage your guests bags easily!"
puts


loop do
  choose do |menu|
    menu.index        = :number
    menu.index_suffix = ") "

    menu.header = "Lockerz Menu"
    menu.prompt = "Choose an option:  "

    menu.choice "See reservations" do
      puts
      puts reservations
      puts
    end

    menu.choice "Store guest bag(s)" do
      puts
      choice = ""
      choose do |store|
        store.index = :number
        store.index_suffix = ") "
        store.header = "Bag size"
        store.prompt = "Pick: "

        store.choice("Small")  { choice = 'small' }
        store.choice("Medium") { choice = 'medium' }
        store.choice("Large")  { choice = 'large' }
      end 

      ticket = Lockerz::Ticket.new(choice)
      reservations.create(ticket)
      puts
      say "Guest ticket information:"
      puts ticket 
      puts
    end

    menu.choice "Return guest bag(s) to them" do
      puts
      confirmation_number = ask("Enter confirmation number")
      ticket = reservations.lookup(confirmation_number) 
      reservations.remove_ticket(ticket)
      puts "Reservation has been found and we'll have bag(s) for you shortly."
      puts
    end

    menu.choice('Exit Lockerz', "Exit program.") { exit }
  end
end
