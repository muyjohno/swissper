module Swissper
  class Player
    attr_accessor :delta, :exclude

    def initialize
      @delta = 0
      @exclude = []
    end
  end
end
