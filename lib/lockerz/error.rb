module Lockerz
  module Error
    class Standard < StandardError
      # inherited customizations here
    end 

    class NoLockersAvailable < Standard
      def initialize
        super "There are no more lockers available. Sorry."
      end
    end
  end
end
