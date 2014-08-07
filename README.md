Coding Exercise
===============

# Setup

You are free to implement any mechanism for feeding input into your
solutions (for example, using hard coded data within a unit test). You
should provide sufficient evidence that your solution is complete by,
as a minimum, indicating that it works correctly against the supplied
test data.

We highly recommend using a unit testing framework such as RSpec
(Ruby) or Jasmine (JavaScript). Even if you have not used it before,
it is simple to learn and incredibly useful. The code you write should
be of production quality, and most importantly, it should be code you
are proud of.

# Lockerz

Write a program for managing locker reservations at a hotel concierge
desk. Customers leave bags with the concierge, who then uses your
program to determine in which locker to place the bag. The program
tells the concierge the number of the locker in which to place the
bag, and prints a ticket to give to the customer. Upon return, the
customer provides the ticket, and the concierge uses that to look up
the corresponding locker, retrieve the bag, and return it to the
customer.

There are 1000 small lockers, 1000 medium-­‐sized lockers, and 1000
large lockers (it’s a big Vegas hotel). You can assume that all
checked bags fit into one of these three sizes. The program should
always assign the smallest available locker that fits the bag.
