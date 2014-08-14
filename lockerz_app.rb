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
      say "Ticket Reservations"
      say "-------------------"
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
      say "A locker has been reserved for you."
      say "Guest ticket information:"
      puts ticket 
      puts
    end

    menu.choice "Return guest bag(s) to them" do
      puts
      confirmation_number = ask("Enter confirmation number")
      ticket = reservations.lookup(confirmation_number) 
      if ticket
        reservations.remove_ticket(ticket)
        puts "Reservation has been found and we'll have bag(s) for you shortly."
      else
        say "No reservation ticket was found using the confirmation number: #{confirmation_number}"
      end
      puts
    end

    menu.choice "Admin" do
      puts
      choice = ""
      choose do |admin|
        admin.index = :number
        admin.index_suffix = ") "
        admin.header = "Populate locker rooms"
        admin.prompt = "Pick: "

        admin.choice("Populate all lockers in Small room")  { choice = 'small' }
        admin.choice("Populate all lockers in Medium room") { choice = 'medium' }
        admin.choice("Populate all lockers in Large room")  { choice = 'large' }
        admin.choice("Populate all lockers")  { choice = 'all' }
      end 

      reservations.fill_locker_room_for(choice)
      puts "#{choice.capitalize} locker room(s) are now full!"
      puts
    end

    menu.choice('Exit Lockerz', "Exit program.") do
      puts
      say "Bye Bye! Thanks for using Lockerz!"
      puts
      exit
    end
  end
end
